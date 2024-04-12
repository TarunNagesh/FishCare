from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


employees = Blueprint('employees', __name__)

# Get all the employees from the database
@employees.route('/employees', methods=['GET'])
def employees():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    # cursor.execute('SELECT id, product_code, product_name, list_price FROM products')
    cursor.execute('')

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

# Gets the manager's ID and name from a specific employee
@employees.route('/employees/<ManagerID>', methods=['GET'])
def get_manager (id):

    query = 'SELECT ManagerID, FirstName, LastName FROM Employees WHERE EmpID = ' + str(id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

