# Some set up for the application 

from flask import Flask
from flaskext.mysql import MySQL
from flask_login import LoginManager


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
    login_manager = LoginManager()
    login_manager.login_view = 'auth.login'
    login_manager.init_app(app)

    from ..models import User

    @login_manager.user_loader
    def load_user(user_id):
        # since the user_id is just the primary key of our user table, use it in the query for the user
        return User.query.get(int(user_id))
    
    # Import the various routes
    from src.views import views
    from src.users.users  import users
    from src.departures.departures import departures
    from src.returns.returns import returns
    from src.auth.auth import auth

    # Register the routes that we just imported so they can be properly handled
    app.register_blueprint(views,       url_prefix='/')
    app.register_blueprint(users,   url_prefix='/usr')
    app.register_blueprint(departures,    url_prefix='/dep')
    app.register_blueprint(returns,    url_prefix='/ret')

    return app