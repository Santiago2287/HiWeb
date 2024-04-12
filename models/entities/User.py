from werkzeug.security import check_password_hash 
from flask_login import UserMixin

class User(UserMixin):
    def __init__(self, id, nombreu, correou, claveu, perfilu, edadu, profesionu) -> None:
        self.id         = id
        self.nombreu    = nombreu
        self.correou     = correou
        self.claveu     = claveu
        self.perfilu    = perfilu
        self.edadu     = edadu
        self.profesionu    = profesionu

    @classmethod
    def validar_clave(self, clavecifrada,claveu):
        
        return check_password_hash(clavecifrada, claveu)
        
