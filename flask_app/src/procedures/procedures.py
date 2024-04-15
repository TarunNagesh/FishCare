from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


procedures = Blueprint('procedures', __name__)

# Get all the procedures from the database
@procedures.route('/procedures', methods=['GET'])
def procedures():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of procedures
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

# Get details of a specific procedure
@procedures.route('/procedures/<id>', methods=['GET'])
def get_proc_detail (id):

    query = 'SELECT * FROM procedures WHERE procid = ' + str(id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# Add a new procedure
@procedures.route('/procedures', methods=['POST'])
def add_new_procedure():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    surgeon = the_data['surgeon']
    procid = the_data['procid']
    fishid = the_data['fish']
    description = the_data['description']
    proctype = the_data['type']
    result = the_data['result']

    # Constructing the query
    query = 'INSERT INTO procedures (surgeon, procid, fish, description, type, result) VALUES ("'
    query += surgeon + '", "'
    query += procid + '", "'
    query += fishid + '", "'
    query += description + '", "'
    query += proctype + '", "'
    query += result + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# Update the details of a procedure
@procedures.route('/procedures', methods=['PUT'])
def update_procedure():
    proc_info = request.json
    # current_app.logger.info(cust_info)
    surgeon = proc_info['surgeon']
    procid = proc_info['procid']
    fishid = proc_info['fish']
    description = proc_info['description']
    proctype = proc_info['type']
    result = proc_info['result']

    query = 'UPDATE procedures SET surgeon = %s, fish = %s, description = %s, type = %s, result = %s WHERE id = %s'
    data = (surgeon, fishid, description, proctype, result, procid)

    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'Procedure updated!'

# Delete a procedure
@procedures.route('/procedures', methods = ['DELETE'])
def delete_procedure():
    the_data = request.json
    current_app.logger.info(the_data) 

    id = the_data['procid']

    query = 'DELETE FROM procedures WHERE id = ' + id
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Procedure deleted!'

# Return all procedure types
@procedures.route('/procedures_type', methods = ['GET'])
def get_all_procedure_types():
    query = '''
        SELECT DISTINCT type AS label, type as value
        FROM procedures
        WHERE type IS NOT NULL
        ORDER BY type
    '''

    cursor = db.get_db().cursor()
    cursor.execute(query)

    json_data = []
    # fetch all the column headers and then all the data from the cursor
    column_headers = [x[0] for x in cursor.description]
    theData = cursor.fetchall()
    # zip headers and data together into dictionary and then append to json data dict.
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    
    return jsonify(json_data)