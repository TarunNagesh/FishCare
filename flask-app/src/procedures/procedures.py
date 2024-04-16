from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

Procedures = Blueprint('Procedures', __name__)

@Procedures.route('/Procedures', methods=['GET'])
def get_procedures():
    """ Get all the procedures from the database """ 
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of procedures
    # cursor.execute('SELECT id, product_code, product_name, list_price FROM products')
    cursor.execute('SELECT * FROM Procedures')

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

@Procedures.route('/Procedures/<id>', methods=['GET'])
def get_proc_detail (id):
    """ Get details of a specific procedure """
    query = 'SELECT * FROM procedures WHERE ProcID = ' + str(id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@Procedures.route('/Procedures', methods=['POST'])
def add_new_procedure():
    """ Add a new procedure""" 
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    surgeon = the_data['Surgeon']
    procid = the_data['ProcID']
    fishid = the_data['Fish']
    description = the_data['Description']
    proctype = the_data['Type']
    result = the_data['Result']

    # Constructing the query
    query = 'INSERT INTO Procedures VALUES (%s, %s, %s, %s, %s, %s)'

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query, (surgeon, procid, fishid, description, proctype, result))
    db.get_db().commit()
    
    return 'Success!'

@Procedures.route('/Procedures', methods=['PUT'])
def update_procedure():
    """ Update the details of a procedure """
    proc_info = request.json
    # current_app.logger.info(cust_info)
    procid = proc_info['ProcID']
    description = proc_info['Description']
    result = proc_info['Result']


    query = 'UPDATE Procedures SET Description = %s, Result = %s WHERE ProcID = %s'
    data = (description,result, procid)

    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'Procedure updated!'

@Procedures.route('/procedures', methods = ['DELETE'])
def delete_procedure():
    """ Delete a procedure """
    the_data = request.json
    current_app.logger.info(the_data) 

    id = the_data['ProcID']

    query = 'DELETE FROM Procedures WHERE ProcID = ' + id
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Procedure deleted!'

@Procedures.route('/Procedures/<type>', methods = ['GET'])
def get_all_procedure_types():
    """ Return all procedure types""" 

    query = '''
        SELECT DISTINCT Type AS Label
        FROM Procedures
        WHERE Type IS NOT NULL
        ORDER BY Type
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