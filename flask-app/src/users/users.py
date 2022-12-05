from flask import Blueprint, request, jsonify, make_response, render_template
from flask_login import login_required, current_user
import json
from src import db


users = Blueprint('users', __name__)

# Get all customers from the DB
@users.route('/', methods=['GET'])
def index():
    # cursor = db.get_db().cursor()
    # cursor.execute('select userID, firstName,\
    #     lastName from user')
    # row_headers = [x[0] for x in cursor.description]
    # json_data = []
    # theData = cursor.fetchall()
    # for row in theData:
    #     json_data.append(dict(zip(row_headers, row)))
    # the_response = make_response(jsonify(json_data))
    # the_response.status_code = 200
    # the_response.mimetype = 'application/json'
    # return the_response
    return render_template('index.html')

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

@users.route('/profile')
@login_required
def profile():
    # TODO: handle
    return render_template('profile.html', name=current_user.name)