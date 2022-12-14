from flask import Blueprint, request, jsonify, make_response, render_template
import json
from src import db
import random
import datetime
from flaskext.mysql import MySQL


payments = Blueprint('payments', __name__)

# Get all customers from the DB
@payments.route('/payments', methods=['GET'])
def get_payments():
    cursor = db.get_db().cursor()
    cursor.execute('select * from payment ORDER BY paymentID ASC')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# Get all payments associated with a given user
@payments.route('/payments/<adminID>', methods=['GET'])
def get_user_payments(adminID):
    # get a cursor object from the database
    cursor = db.get_db().cursor()
    cursor.execute(f'SELECT paymentNum, bankaccount_ID, amount, types, sellerID, buyerID, bidID from payment where adminID ={adminID} ORDER BY adminID')

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    print(json_data)
    return jsonify(json_data)