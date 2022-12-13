from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db
import random


flights = Blueprint('flights', __name__)

# Get all the products from the database
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


# Add a new flight
@flights.route('/flights/add-flight,<user_ID>', methods=['POST'])
def add_flight(user_ID):
    current_app.logger.info(request.form)
    cursor = db.get_db().cursor()

    date_purchased: str = request.form['date_purchased']
    airline = request.form['airline']
    arrive_airport = request.form['arrive_airport']
    depart_airport = request.form['depart_airport']

    country = request.form['country']
    continent = request.form['continent']
    is_layover = request.form['is_layover']
    airport_code = request.form['airport_code']
    purchased_price = request.form['purchased_price']
    current_price = request.form['current_price']
    asking_price = request.form['asking_price']
    for_sale = request.form['for_sale']
    takeoff = request.form['takeoff']
    land = request.form['land']

    special_requests = request.form['special_requests']
    """
        # "adminID": "60",

        # "bidID": "83",
        # "buyerID": "63",
        # "datePosted": "Sun, 09 Jan 2022 18:37:43 GMT",
        # "portfolioID": "93",
        # "trade_ID": "47",
        # "tripID": "22"
    """

    idNum: int =random.randint(100,10000)

    insert_stmt: str = (
                        f" INSERT INTO flights (date_purchased, airline, country, continent, is_layover, airport_code, purchased_price, current_price, asking_price, for_sale) "
                        "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
                        )
    data: tuple = (idNum, date_purchased, airline, country, continent, is_layover, airport_code, purchased_price, current_price, asking_price, for_sale)
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

    print(json_data)
    return jsonify(json_data)


# Get all flights associated with a given user
@flights.route('/flights/airlines', methods=['GET'])
def get_airlines():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    cursor.execute('select distinct airline as value, airline as label from flights')

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)
