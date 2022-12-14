from flask import Blueprint, request, jsonify, make_response, render_template
import json
from src import db


admin = Blueprint('admins', __name__)

# Get all customers from the DB
@admin.route('/admins', methods=['GET'])
def get_admins():
    cursor = db.get_db().cursor()
    cursor.execute('select adminID as value, adminID as label from admin ORDER BY adminID ASC')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


