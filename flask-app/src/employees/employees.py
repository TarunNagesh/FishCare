from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

Employees = Blueprint('Employees', __name__)

# Get all the employees from the database
@Employees.route('/Employees', methods=['GET'])
def get_employees():
    """ get all the employees from the database """
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    # cursor.execute('SELECT id, product_code, product_name, list_price FROM products')
    cursor.execute('SELECT * from Employees')

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
@Employees.route('/Employees/<id>', methods=['GET'])
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
@Employees.route('/Employees', methods=['POST'])
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
    query = 'INSERT INTO prescriptions (EmpID, ManagerID, FirstName, MiddleInitial, LastName, Hours, Address) VALUES ("'
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
@Employees.route('/Employees', methods=['PUT'])
def update_employee():
    the_data = request.json
    # current_app.logger.info(cust_info)
    employee_id = the_data['EmpID']
    manager_id = the_data['ManagerID']
    first = the_data['FirstName']
    mi = the_data['MiddleInitial']
    last = the_data['LastName']
    hours = the_data['Hours']
    address = the_data['Address']

    query = 'UPDATE Prescriptions SET ManagerID = %s, FirstName = %s, MiddleInitial = %s, LastName = %s, Hours = %s, Address = %s WHERE EmpID = %s'
    data = (manager_id, first, mi, last, hours, address, employee_id)

    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'Employee updated!'

# Delete employees where hours = 0
@Employees.route('/Employees', methods = ['DELETE'])
def delete_employee_no_hours():
    the_data = request.json
    current_app.logger.info(the_data) 
    employee_id = the_data['EmpID']

    query = 'DELETE FROM Employees WHERE EmpID = %s'
    data = (employee_id)
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'Employee fired!'

# Delete employee given id
@Employees.route('/Employees/<id>', methods = ['DELETE'])
def delete_employee(id):
    the_data = request.json
    current_app.logger.info(the_data) 
    id = the_data['EmpId']

    query = 'DELETE FROM Employees WHERE EmpID == ' + str(id)
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Employee fired!'
