class Config :
    SECRET_KEY = 'chamaquillocomecomemocos'
    MAIL_SERVER = 'smtp.gmail.com'
    MAIL_USERNAME = 'adrian.martinez1621@alumnos.udg.mx'
    MAIL_PASSWORD =  'qrdatxkzcthoxofm'
    MAIL_DEFAULT_SENDER = 'adrian.martinez1621@alumnos.udg.mx'
    MAIL_ASCII_ATTACHMENTS = True
    MAIL_PORT = 587
    MAIL_USE_TLS = True
    MAIL_SSL_USE = False
    

class DevelopmentConfig(Config):
    DEBUG          = True
    MYSQL_HOST     = 'localhost'
    MYSQL_USER     = 'root'
    MYSQL_PASSWORD = ''
    MYSQL_DB       = 'mental'

config = {
    'development' : DevelopmentConfig
}
