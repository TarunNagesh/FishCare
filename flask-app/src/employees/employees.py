from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

employees = Blueprint('employees', __name__)

@employees.route('/employees', methods=['GET'])
def get_employees():
    """ Get all the employees from the database """
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
@employees.route('/employees/<id>', methods=['GET'])
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

# Add a new employee
@employees.route('/employees', methods=['POST'])
def add_new_employee():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    employee_id = the_data['empid']
    manager_id = the_data['managerid']
    first = the_data['firstname']
    mi = the_data['middleinitial']
    last = the_data['lastname']
    hours = the_data['hours']
    address = the_data['address']

    # Constructing the query
    query = 'INSERT INTO prescriptions (empid, managerid, firstname, middleinitial, lastname, hours, address) VALUES ("'
    query += employee_id + '", "'
    query += manager_id + '", "'
    query += first + '", "'
    query += mi + '", "'
    query += last + '", "'
    query += hours + '", "'
    query += address + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# Update the details of an employee
@employees.route('/employees', methods=['PUT'])
def update_employee():
    the_data = request.json
    # current_app.logger.info(cust_info)
    employee_id = the_data['empid']
    manager_id = the_data['managerid']
    first = the_data['firstname']
    mi = the_data['middleinitial']
    last = the_data['lastname']
    hours = the_data['hours']
    address = the_data['address']

    query = 'UPDATE prescriptions SET managerid = %s, firstname = %s, middleinitial = %s, lastname = %s, hours = %s, address = %s WHERE empid = %s'
    data = (manager_id, first, mi, last, hours, address, employee_id)

    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'Employee updated!'

# Delete employees where hours = 0
@employees.route('/employees', methods = ['DELETE'])
def delete_employee_no_hours():
    the_data = request.json
    current_app.logger.info(the_data) 

    query = 'DELETE FROM employees WHERE hours == 0'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Employee fired!'

# Delete employee given id
@employees.route('/employees/<id>', methods = ['DELETE'])
def delete_employee(id):
    the_data = request.json
    current_app.logger.info(the_data) 
    id = the_data['EmpId']

    query = 'DELETE FROM employees WHERE EmpId == ' + str(id)
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Employee fired!'