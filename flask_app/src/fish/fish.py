from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


tanks = Blueprint('fish', __name__)

@fish.route('/fish', methods=['GET'])
def get_fish():

    query = 'SELECT * FROM fish' 
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)


@fish.route('/fish/<id>', methods=['GET'])
def get_fish():

    query = 'SELECT * FROM fish WHERE FishID =' + str(id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)



@products.route('/fish/<id>', methods=['POST'])
def add_new_fish():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    fishID = the_data['FishID']
    housed= the_data['HousedIn']
    kept = the_data['KeptBy']
    notes = the_data['Notes'] 
    sex = the_data['Sex']
    species = the_data['Species']
    status = the_data['Status']

    # Constructing the query
    query = 'INSERT INTO fish VALUES ("'
    query += fishID + '", "'
    query += housed + '", "'
    query += kept + '", '
    query += notes + '", '
    query += sex + '", '
    query += species + '", '
    query += status + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

@fish.route('/fish/<if>', methods =['PUT']) 
def update_fish(): 

    the_data = request.json 

    id = the_data['Fishid']
    housed= the_data['HousedIn']
    kept = the_data['KeptBy']
    notes = the_data['Notes'] 
    sex = the_data['Sex']
    species = the_data['Species']
    status = the_data['Status']
    

    query = ' UPDATE customers SET fishid = %s, housedin = %s, keptby = %s, notes = %s, sex = %s, species = %s, status = %s WHERE fishid = %s'
    data = (id, housed, kept, notes, sex, species, status)

    cursor = db.get_db().cursor() 
    cursor.execute(query, data)
    db.get_db().commit()

    return 'Success!'





