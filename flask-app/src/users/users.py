from flask import Blueprint, request, jsonify, make_response, render_template
import json
from src import db
import random
import datetime
from flaskext.mysql import MySQL


users = Blueprint('users', __name__)

# Get all customers from the DB
@users.route('/users', methods=['GET'])
def get_customers():
    cursor = db.get_db().cursor()
    cursor.execute('select * from user')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get customer detail for customer with particular userID
@users.route('/users/<userID>', methods=['GET'])
def get_customer(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from user where userID = {0}'.format(userID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# new user form
@users.route('/users/add-user')
def add_form():
    return render_template('add_user.html')


# Add a new user
@users.route('/users/add-user', methods=['POST'])
def add_customer():
    cursor = db.get_db().cursor()
    gender: str = request.form['gender']
    firstName: str = request.form['first']
    lastName: str = request.form['last']
    phone: str = request.form['phone']
    email: str = request.form['email']
    birthdate: str = request.form['bdate']
    permissions: str = 'base_user'
    userID = buyerID= sellerID = 100 + random.randint(100,10000)
    cursor.execute(f'insert into buyer (buyerID) values ({buyerID})')
    cursor.execute(f'insert into seller (sellerID) values ({sellerID})')
    insert_stmt: str = (
                        " INSERT INTO user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) "
                        "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
                        )
    data = (int(userID), gender, birthdate, firstName, lastName, phone, email, permissions, int(buyerID), int(sellerID))
    cursor.execute(insert_stmt, data)
    db.get_db().commit()
    return (f'<h1>Added new user {firstName} {lastName}: userID {userID}')