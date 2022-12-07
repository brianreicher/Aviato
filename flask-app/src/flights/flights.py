from flask import Blueprint, request, jsonify, make_response
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

"""
# Add a new user
@flights.route('/flights/add-flight', methods=['POST'])
def add_flight():
    cursor = db.get_db().cursor()

    date_purchased: str = request.form['date_purchased']
    airline = request.form['airline']
    country = request.form['country']
    continent = request.form['continent']
    is_layover = request.form['is_layover']
    airport_code = request.form['airport_code']
    purchased_price = request.form['purchased_price']
    current_price = request.form['current_price']
    asking_price = request.form['asking_price']
    for_sale = request.form['for_sale']

    dep_ret: str = request.form['dep_ret'].lower()
    
    id_tag = 'r_num'

    if dep_ret == 'departures':
        id_tag = 'd_num'


    idNum: int =random.randint(100,10000)

    insert_stmt: str = (
                        f" INSERT INTO {dep_ret} ({id_tag}, date_purchased, airline, country, continent, is_layover, airport_code, purchased_price, current_price, asking_price, for_sale) "
                        "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
                        )
    data: tuple = (idNum, date_purchased, airline, country, continent, is_layover, airport_code, purchased_price, current_price, asking_price, for_sale)
    cursor.execute(insert_stmt, data)
    db.get_db().commit()
    return (f'<h1>Added new flight {airline} {airport_code}: id={idNum}')
"""