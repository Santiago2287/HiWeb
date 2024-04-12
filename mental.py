from flask import Flask, render_template, url_for, request, redirect, flash, session
from flask_mysqldb import MySQL
from flask_login import LoginManager, login_user, logout_user
from config import config
from werkzeug.security import generate_password_hash
from models.ModelUser import ModelUser
from models.entities.User import User
from flask_mail import Mail, Message
from datetime import datetime

mentalApp = Flask(__name__)
db = MySQL(mentalApp)
lmMental = LoginManager(mentalApp)
mail = Mail(mentalApp)

@lmMental.user_loader 
def loader_user(id):
    return ModelUser.get_by_id(db, id)


@mentalApp.route('/')
def home():
    return render_template('home.html')

@mentalApp.context_processor
def time_now():
    current_time = datetime.utcnow()
    formatted_time = current_time.strftime("%d:%m:%y %H:%M:%S")
    return {
        'hora': formatted_time
    }

@mentalApp.route('/home')
def home2():
    return render_template('home.html')


@mentalApp.route('/about-us')
def aboutUs():
    return render_template('about-us.html')


@mentalApp.route('/categorias')
def categorias():
    return render_template('categorias.html')


@mentalApp.route('/destacado')
def destacado():
    return render_template('destacado.html')

@mentalApp.route('/sigin', methods=['GET', 'POST'])
def sigin(): 
    if request.method == 'POST':
        regUsuario = db.connection.cursor()
        nombreu = request.form['nombreu']
        correou =  request.form['correou']
        claveu = request.form['claveu']
        claveCifrada = generate_password_hash(claveu)
        edadu = request.form['edadu']
        profesionu = request.form['profesionu']
        regUsuario.execute("INSERT INTO usuario (nombreu, correou,claveu, edadu, profesionu) VALUES (%s,%s,%s, %s,%s)",(nombreu, correou, claveCifrada, edadu, profesionu))
        db.connection.commit()
        msg = Message(subject='Mental', recipients=[correou])
        msg.html = render_template("user_mail.html", nombrem = nombreu)
        mail.send(msg)
        return redirect(url_for('home'))
    else:
        return render_template('home.html')
    
@mentalApp.route('/login', methods=['GET', 'POST'] )
def login():
    if request.method == 'POST':
        usuario = User(0, None, request.form['correou'], request.form['claveu'], None, 0, None)
        usuarioAut = ModelUser.login(db, usuario)
        if usuarioAut is not None:
            if usuarioAut.claveu: 
                login_user(usuarioAut)
                if usuarioAut.perfilu == 'A':
                    return render_template('admin.html')
                else:
                    SelWeb = db.connection.cursor()
                    SelWeb.execute("SELECT * FROM web")
                    w = SelWeb.fetchall()
                    session['id_user'] = usuarioAut.id
                    session['perfilu'] = w[4]
                    return render_template('usuario.html', webs = w)
                
                    
            else:
                flash('Contaseña incorrecta')
                return redirect(request.url)
        else:
            flash('Correo incorrecto')
            return redirect(request.url)
    else:
        return render_template('home.html')
    
@mentalApp.route('/logout', methods=['GET', 'POST'])
def logout():
    logout_user()
    return redirect(url_for('home'))

@mentalApp.route('/sUsuario', methods=['GET', 'POST'])
def sUsuario():
    SelUsuario = db.connection.cursor()
    SelUsuario.execute("SELECT * FROM usuario")
    u = SelUsuario.fetchall()
    return render_template('profiles.html', usuarios = u)

@mentalApp.route('/uUsuario/<string:id>', methods=['GET', 'POST'])
def uUsuario(id):
    if request.method == 'POST':
        upUsuario = db.connection.cursor()
        nombreu = request.form['nombreu']
        correou = request.form['correou']
        claveu = request.form['claveu']
        claveCifrada = generate_password_hash(claveu)
        perfilu = request.form['perfilu']
        edadu = request.form['edadu']
        profesionu = request.form['profesionu']
        upUsuario.execute("UPDATE usuario SET nombreu=%s, correou=%s, claveu=%s, perfilu=%s, edadu=%s, profesionu=%s WHERE id=%s", (nombreu, correou, claveCifrada, perfilu, edadu, profesionu, id))
        db.connection.commit()
        flash('Usuario Actulizado')
        return redirect(url_for('sUsuario'))
    else:
        redirect(request.url)

@mentalApp.route('/dUsuario/<string:id>', methods=['GET', 'POST'])
def dUsuario(id):
    if request.method == 'POST':
        DelUsuario = db.connection.cursor()
        DelUsuario.execute("DELETE FROM usuario WHERE id=%s", (id,)) 
        db.connection.commit()
        flash('Usuario Eliminado')
        return redirect(url_for('sUsuario'))
    else:
        return redirect(request.url)
    
@mentalApp.route('/aUsuario', methods=['GET', 'POST'])
def aUsuario(): 
    if request.method == 'POST':
        regUsuario = db.connection.cursor()
        nombreu = request.form['nombreu']
        correou =  request.form['correou']
        claveu = request.form['claveu']
        claveCifrada = generate_password_hash(claveu)
        profesionu = request.form['profesionu']
        perfilu = request.form['perfilu']
        regUsuario.execute("INSERT INTO usuario (nombreu, correou,claveu, profesionu, perfilu) VALUES (%s,%s, %s,%s, %s)",(nombreu, correou, claveCifrada, profesionu, perfilu))
        db.connection.commit()
        flash('Usuario agregado')
        return redirect(url_for('sUsuario'))
    else:
        return render_template(request.url)

@mentalApp.route('/sWeb', methods=['GET', 'POST'])
def sWeb():
    SelWeb = db.connection.cursor()
    SelWeb.execute("SELECT * FROM web")
    w = SelWeb.fetchall()
    return render_template('webs.html', webs = w)

@mentalApp.route('/uWeb/<string:id>', methods=['GET', 'POST'])
def uWeb(id):
    if request.method == 'POST':
        upWeb = db.connection.cursor()
        nombrew = request.form['nombrew']
        descripcionw = request.form['descripcionw']
        categoriaw = request.form['categoriaw']
        urlw = request.form['urlw']
        upWeb.execute("UPDATE web SET nombre=%s, descripcion=%s, categoria=%s, url=%s WHERE idweb=%s", (nombrew, descripcionw, categoriaw, urlw, id))
        flash('Web Eliminada')
        db.connection.commit()
        return redirect(url_for('sWeb'))
    else:
        return render_template(request.url)
    

@mentalApp.route('/dWeb/<string:id>', methods=['GET', 'POST'])
def delWeb(id):
    if request.method == 'POST':
        delWeb = db.connection.cursor()
        delWeb.execute("DELETE FROM web WHERE idweb=%s", (id,)) 
        db.connection.commit()
        flash('Sitio Eliminado')
        return redirect(url_for('sWeb'))
    else:
        return redirect(request.url)
    
@mentalApp.route('/aWeb', methods=['GET', 'POST'])
def aWeb():
    if request.method == 'POST':
        addWeb = db.connection.cursor()
        nombrew = request.form['nombrew']
        descripcionw = request.form['descripcionw']
        categoriaw = request.form['categoriaw'] 
        urlw = request.form['urlw']                                
        addWeb.execute("INSERT INTO web (nombre, descripcion, categoria, url ) VALUES (%s, %s, %s, %s)", (nombrew, descripcionw, categoriaw, urlw))
        db.connection.commit()
        flash('Sitio Agregado')
        return redirect(url_for('sWeb'))
    else:
        return redirect(request.url)
    

@mentalApp.route('/upUsuario/<string:id>', methods=['GET', 'POST'])
def upUsuario(id):
    if request.method == 'POST':
        upUsuario = db.connection.cursor()
        nombreu = request.form['nombreu']
        correou = request.form['correou']
        claveu = request.form['claveu']
        claveCifrada = generate_password_hash(claveu)
        fotou = request.form['fotou']
        edadu = request.form['edadu']
        profesionu = request.form['profesionu']
        upUsuario.execute("UPDATE usuario SET nombreu=%s, correou=%s, claveu=%s, fotou=%s, edadu=%s, profesionu=%s WHERE id=%s", (nombreu, correou, claveCifrada, fotou, edadu, profesionu, id))
        db.connection.commit()
        flash('Usuario Actulizado')
        return redirect(url_for('sUsuario'))
    else:
        redirect(request.url)

@mentalApp.route('/sWebHome', methods=['GET', 'POST'])
def sWebHome():
    SelWeb = db.connection.cursor()
    SelWeb.execute("SELECT * FROM web")
    w = SelWeb.fetchall()
    return render_template('webshome.html', webs = w)

@mentalApp.route('/sWebHomeUser', methods=['GET', 'POST'])
def sWebHomeUser():
    SelWeb = db.connection.cursor()
    SelWeb.execute("SELECT * FROM web")
    w = SelWeb.fetchall()
    return render_template('webshomeuser.html', webs = w)



@mentalApp.route('/eUsuario/<string:id>', methods=['GET', 'POST'])
def eUsuario(id):
    if request.method == 'POST':
        upUsuario = db.connection.cursor()
        nombreu = request.form['nombreu']
        correou = request.form['correou']
        claveu = request.form['claveu']
        claveCifrada = generate_password_hash(claveu)
        edadu = request.form['edadu']
        profesionu = request.form['profesionu']
        upUsuario.execute("UPDATE usuario SET nombreu=%s, correou=%s, claveu=%s, edadu=%s, profesionu=%s WHERE id=%s", (nombreu, correou, claveCifrada, edadu, profesionu, id))
        db.connection.commit()
        flash('Usuario Actulizado')
        return redirect(url_for('login'))
    else:
        redirect(request.url)

@mentalApp.route('/addFav/<string:idweb>', methods=['GET', 'POST'])
def addFav(idweb):
        horas=time_now()
        try:
            if 'id_user' in session:
                selFavoritos = db.connection.cursor()
                selFavoritos.execute("SELECT * FROM favoritos WHERE idweb=%s AND iduser=%s", (idweb, session['id_user'],))
                favoritos = selFavoritos.fetchone()
                selFavoritos.close()
                print(session["_user_id"])
                print("Cosas del carrito:", favoritos )
                if favoritos is not None:
                    flash('Ya has añadido este sitio web a favoritos')
                else:
                    regFavoritos = db.connection.cursor()
                    regFavoritos.execute("INSERT INTO favoritos (idweb, iduser, fechaad) VALUES (%s, %s, %s)", (idweb, session['id_user'], horas))
                    regFavoritos.close()
                    db.connection.commit()
            else:
                print("NO se encontro usuario")
                flash('Usuario no autenticado')
        except Exception as e:
            flash(f"Error al procesar la solicitud: {str(e)}")
        finally:
            return redirect(url_for('sUsuario'))



if __name__ == '__main__':
    mentalApp.config.from_object(config['development'])
    mail = Mail(mentalApp)
    mentalApp.run(debug=True, port=3300)
    

