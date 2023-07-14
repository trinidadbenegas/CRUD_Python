#importamos modulo mysql
import mysql.connector

class Conexion:
    def __init__(self):
        try:
            self.conexion= mysql.connector.connect(
                host= 'localhost',
                port= 3306,
                user= 'root',
                password= 'TRINI1234',
                db= 'cabanias_db'
            )
            
            if self.conexion.is_connected:
                print('conectados a la base de datos')
        
        except mysql.connector.Error as descriptionError:
            print('NO hay conexión', descriptionError)

    def AgregarCliente (self, nombre, apellido, email, provincia_id_pk, perfil_id_pk, password):
        if self.conexion.is_connected():
            try:
                cursor= self.conexion.cursor()
                #si en la db hay un campo autoincremental,
                #especificar los campos que se añaden con omisión de este campo
                sentencia= 'INSERT INTO cliente (nombre, apellido, email, provincia_id_pk, perfil_id_pk, password ) VALUES (%s, %s, %s, %s,%s, %s)'
                data= (nombre, apellido, email, provincia_id_pk, perfil_id_pk, password)
                cursor.execute(sentencia, data)
                self.conexion.commit()
                self.conexion.close()
            except Exception as e: 
                print('no se pudo insertar cliente', str(e))

    def ActualizarCliente(self, cliente_id, nombre, apellido, provincia_id_pk, perfil_id_pk):
        if self.conexion.is_connected():
            try:
                cursor= self.conexion.cursor()
                sentencia= 'UPDATE cliente SET nombre = %s, apellido = %s, provincia_id_pk= %s, perfil_id_pk= %s  WHERE cliente_id = %s'
                #el orden de los datos en la tupla debe coincidir con los marcadores de posición en la sentencia sql
                data= (nombre, apellido, provincia_id_pk, perfil_id_pk, cliente_id)
                cursor.execute(sentencia, data)
                self.conexion.commit()
                self.conexion.close()

            except Exception as e:
                print('no se pudo insertar cliente', str(e))

    def EliminarCliente(self, cliente_id):
        if self.conexion.is_connected():
            try:
                cursor= self.conexion.cursor()
                sentencia= 'DELETE FROM cliente WHERE cliente_id = %s'
                
                cursor.execute(sentencia, (cliente_id,))
                self.conexion.commit()
                self.conexion.close()
            
            except Exception as e:
                print('No se pudo eliminar el cliente', str(e))
    
    def SeleccionarClientes(self):
        if self.conexion.is_connected():
            try:
                cursor= self.conexion.cursor()
                sentencia= 'SELECT * FROM cliente'
                cursor.execute(sentencia)
                datos= cursor.fetchall() #trae todos los datos de la consulta y los guarda en la variable
                self.conexion.close()
                return datos
                
            
            except Exception as e:
                print('no se pueden leer los datos')

                



#Agregar cliente
#nuevoCliente= Conexion()
#nuevoCliente.AgregarCliente('Bartolome', 'Ocampo', 'bart@gmail.com', 2, 3, 'bart222')

#Actualizar datos del cliente por ID
#ActualizarCliente= Conexion()
#ActualizarCliente.ActualizarCliente(6, 'Albert', 'Miró', 3, 4 )

#Borrar cliente por ID
#BorrarCliente= Conexion()
#BorrarCliente.EliminarCliente(5)

#Seleccionar todos los datos de una tabla
#todosClientes= Conexion()
#print(todosClientes.SeleccionarClientes())
