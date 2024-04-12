from models.entities.User import User 

class ModelUser :
    @classmethod
    def login(self, db, usuario):
        try:
            selUsuario = db.connection.cursor()
            selUsuario.execute("SELECT * FROM usuario WHERE correou = %s", (usuario.correou,))
            u = selUsuario.fetchone()
            if u is not None:
                return User(u[0], u[1], u[2], User.validar_clave(u[3], usuario.claveu), u[4], u[5], u[6])
            else:
                return None
        except Exception as ex:
            raise Exception(ex)

    @classmethod 
    def get_by_id(self, db, id):
        try:
            selUsuario = db.connection.cursor()
            selUsuario.execute("SELECT * FROM usuario WHERE correou = %s", (id,))
            u = selUsuario.fetchone()
            if u is not None:
                return User(u[0], u[1], u[2], u[3], u[4], u[5], u[6])
            else:
                return None
        except Exception as ex:
            raise Exception(ex)
            