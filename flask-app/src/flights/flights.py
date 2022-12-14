from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db
import random
import datetime

flights = Blueprint('flights', __name__)

# view all flights
@flights.route('/flights', methods=['GET'])
def get_products():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('select * from flights')

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# view filtered specific flights
@flights.route('/flights/specific/<airline_name>/<dep_airport>/<arrive_airport>', methods=['GET'])
def get_specific_flight(airline_name, dep_airport, arrive_airport):
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    if airline_name == 'HawaiianAirlines':
        airline_name = 'Hawaiian Airlines'
    if airline_name == 'AlaskanAirlines':
        airline_name = 'Alaskan Airlines'
    
    if dep_airport.lower() == 'all' and arrive_airport.lower() != 'all':
        cursor.execute(f'select * from flights where airline=\'{airline_name}\' and arrive_airport=\'{arrive_airport}\'')

    elif arrive_airport.lower() == 'all' and dep_airport.lower() != 'all':
        cursor.execute(f'select * from flights where airline=\'{airline_name}\' and depart_airport=\'{dep_airport}\'')

    elif arrive_airport.lower() == 'all' and dep_airport.lower() == 'all':
        cursor.execute(f'select * from flights where airline=\'{airline_name}\'')

    else: #arrive_airport.lower() != 'all' and dep_airport.lower() != 'all':
        cursor.execute(f'select * from flights where airline=\'{airline_name}\' and depart_airport=\'{dep_airport}\' and arrive_airport=\'{arrive_airport}\'')

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


# Add a new flight to a specified user and portfolio
@flights.route('/flights/add-flight/<user_ID>/<portfolioID>', methods=['POST'])
def add_flight(user_ID, portfolioID):
    current_app.logger.info(request.form)
    cursor = db.get_db().cursor()

    date_purchased = str(request.form['date_purchased'])
    airline = request.form['airline']
    arrive_airport = request.form['arrive_airport']
    depart_airport = request.form['depart_airport']

    is_layover = request.form['is_layover']
    if is_layover == 'true' or is_layover:
        is_layover=1
    else:
        is_layover=0
    purchased_price = '$' + request.form['purchased_price']
    current_price = '$' + request.form['current_price']
    asking_price = '$' + request.form['asking_price']
    for_sale = request.form['for_sale']
    if for_sale == 'true' or for_sale:
        for_sale=1
    else:
        for_sale=0
    takeoff = request.form['takeoff']
    land = request.form['land']
    date_posted = datetime.date.today()

    airline_message = request.form['airline_message']

    special_requests = request.form['special_requests']

    idNum: int = random.randint(101,100000)
    # trade add
    insert_stmt_trade = (f" INSERT INTO trade (trade_ID, date, price, buyerID, sellerID)"
                        "VALUES (%s, %s, %s, %s, %s)"
    )
    tradeID = random.randint(101,100000)
    trade_data: tuple = (tradeID, datetime.date.today(), asking_price, user_ID, user_ID)
    cursor.execute(insert_stmt_trade, trade_data)
    db.get_db().commit()

    # bid add
    insert_stmt_bid= (f" INSERT INTO bid (bidID, submit, expirationDate, status, buyerID, trade_ID)"
                        "VALUES (%s, %s, %s, %s, %s, %s)"
    )
    exp_date = datetime.date.today().year + 1
    bid_id = random.randint(101,100000)
    bid_data: tuple = (bid_id, 0, exp_date, 0, user_ID, tradeID)
    cursor.execute(insert_stmt_bid, bid_data)
    db.get_db().commit()

    # flight add
    cursor.execute(f'select adminID from flight_portfolio where portfolioID={portfolioID}')
    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    adminID = json_data[0]['adminID']

    insert_stmt: str = (
                        f" INSERT INTO flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land)"
                        "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
                        )
    data: tuple = (idNum, for_sale, date_posted,  airline_message, special_requests, bid_id, tradeID, user_ID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land)
    cursor.execute(insert_stmt, data)
    db.get_db().commit()
    return (f'<h1>Added new flight: {airline} {depart_airport} -> {arrive_airport}: id={idNum}')


# Get all flights associated with a given user
@flights.route('/flights/user/<buyer_ID>', methods=['GET'])
def get_user_flights(buyer_ID):
    # get a cursor object from the database
    cursor = db.get_db().cursor()
    cursor.execute(f'select * from flights where buyerID={buyer_ID}')

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


# Get all airlines accesible for dropdown labels
@flights.route('/flights/airlines', methods=['GET'])
def get_airlines():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    cursor.execute('select distinct airline as value, airline as label from flights')

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    stripped_rows = []
    count=0
    for row in theData:
        stripped_rows.append(row[1].replace(' ', ''))
        json_data.append(dict(zip(column_headers, (stripped_rows[count], row[0], ))))
        count+=1
    return jsonify(json_data)
