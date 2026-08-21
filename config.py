class Config :
    SECRET_KEY = 'chamaquillocomecomemocos'
    MAIL_SERVER = 'smtp.gmail.com'
    MAIL_USERNAME = 'your email'
    MAIL_PASSWORD =  'qrdatxkzcthoxofm'
    MAIL_DEFAULT_SENDER = 'your email'
    MAIL_ASCII_ATTACHMENTS = True
    MAIL_PORT = 587
    MAIL_USE_TLS = True
    MAIL_SSL_USE = False
    

class DevelopmentConfig(Config):
    DEBUG          = True
    MYSQL_HOST     = 'localhost'
    MYSQL_USER     = 'root'
    MYSQL_PASSWORD = 'mysql'
    MYSQL_DB       = 'mental'

config = {
    'development' : DevelopmentConfig
}
