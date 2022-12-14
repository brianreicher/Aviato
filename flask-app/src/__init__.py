# Some set up for the application 

from flask import Flask
from flaskext.mysql import MySQL

# create a MySQL object that we will use in other parts of the API
db = MySQL()

def create_app():
    app = Flask(__name__)
    
    # secret key that will be used for securely signing the session 
    # cookie and can be used for any other security related needs by 
    # extensions or your application
    app.config['SECRET_KEY'] = 'someCrazyS3cR3T!Key.!'

    # these are for the DB object to be able to connect to MySQL. 
    app.config['MYSQL_DATABASE_USER'] = 'webapp'
    app.config['MYSQL_DATABASE_PASSWORD'] = open('/secrets/db_password.txt').readline()
    app.config['MYSQL_DATABASE_HOST'] = 'db'
    app.config['MYSQL_DATABASE_PORT'] = 3306
    app.config['MYSQL_DATABASE_DB'] = 'Aviato'  # Change this to your DB name

    # Initialize the database object with the settings above. 
    db.init_app(app)
    
    # Import the various routes
    from src.views import views
    from src.users.users  import users
    from src.flights.flights import flights
    from src.payments.payments import payments
    from src.admins.admin import admin

    # Register the routes that we just imported so they can be properly handled
    app.register_blueprint(views,       url_prefix='/classic')
    app.register_blueprint(users,   url_prefix='/usr')
    app.register_blueprint(flights, url_prefix='/fly')
    app.register_blueprint(payments,  url_prefix='/pay')
    app.register_blueprint(admin, url_prefix='/ad')
    return app