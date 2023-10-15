
class Nave{
	var velocidad
	var direccion
	var combustible
	
	method acelerar(cuanto){
		velocidad = 100000.min(velocidad + cuanto)
	} 
	method desacelerar(cuanto){
		velocidad = 0.max(velocidad - cuanto)
	} 
	method irHaciaElSol(){
		direccion = 10
	}
	method escaparDelSol(){
		direccion = -10
	}
	method ponerseParaleloAlSol(){
		direccion = 0
	}
	method acercarseUnPocoAlSol(){
		direccion = 10.min(direccion + 1)
	}
	method alegarseUnPocoDelSol() = -10.max(direccion - 1)
	method prepararViaje()
	method cargarCombustible(cuanto){
		combustible = combustible + cuanto
	}
	method descargarCombustible(cuanto){
		combustible = combustible - cuanto
	}
	method accionAdicional(){
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}
	method estaTranquila(){
		return combustible >= 4000 and
		velocidad <= 12000
	}
	method recibirAmenaza()
	method estaDeRelajo()
}

class NaveBaliza inherits Nave{
	var color
	var contCambiosDeColor
	
	method cambiarColorDeBaliza(colorNuevo){
		color = colorNuevo
		contCambiosDeColor += 1
	}
	override method prepararViaje(){
		self.cambiarColorDeBaliza("verde")
		self.ponerseParaleloAlSol()
		self.accionAdicional()
	}
	override method estaTranquila(){
		return super() and color != "rojo"
	}
	override method recibirAmenaza(){
		self.irHaciaElSol()
		self.cambiarColorDeBaliza("rojo")
	}
	override method estaDeRelajo(){
		return contCambiosDeColor == 0
	}
}

class NavePasajero inherits Nave{
	var pasajeros
	var bebidas
	var comidas
	var contComidasServidas
	
	method cargarComida(cuanto){
		comidas = comidas + cuanto
	}
	method descargarComida(cuanto){
		comidas = 0.max(comidas - cuanto)
	}
	method cargarBebida(cuanto){
		bebidas = bebidas + cuanto
	}
	method descargarBebida(cuanto){
		bebidas = 0.max(bebidas - cuanto)
	}
	override method prepararViaje(){
		bebidas = 6 * pasajeros
		comidas = 4 * pasajeros
		self.acercarseUnPocoAlSol()
	}
	override method recibirAmenaza(){
		self.acelerar(velocidad * 2)
		comidas = 0.max(comidas - pasajeros)
		contComidasServidas += pasajeros 
		bebidas = 0.max(bebidas - (2 * pasajeros))
	}
	override method estaDeRelajo(){
		return contComidasServidas <= 50
	}
}

class NaveHospital inherits NavePasajero{
	var quirofanosPreparados = true
	
	method prepararQuirofanos(){
		quirofanosPreparados = true
	}
	method despreocuparQuirofanos(){
		quirofanosPreparados = false
	}
	method losQuirofanosEstanPreparados() = quirofanosPreparados
	
	override method estaTranquila(){
		return not self.losQuirofanosEstanPreparados()
	}
	override method recibirAmenaza(){
		super()
		self.prepararQuirofanos()
	}
}

class NaveCombate inherits Nave{
	var esVisible = true
	var misilesDesplegados = true
	var mensajes = []
	
	method ponerseVisible(){
		esVisible = true
	}
	method ponerseInvisible(){
		esVisible = false
	}
	method estaInvisible() = not esVisible
	method desplegarMisiles(){
		misilesDesplegados = true
	}
	method replegarMisiles(){
		misilesDesplegados = false
	}
	method misilesDespleagos() = misilesDesplegados
	method emitirMensaje(mensaje){
		mensajes.add(mensaje)
	}
	method mensajesEmitidos() = mensajes
	method primerMensajeEmitido(){
		return mensajes.first()
	}
	method ultimoMensajeEmitido(){
		return mensajes.last()
	}
	method tieneMuchosCaracteres(mensaje){
		return mensaje.length() >= 30 
	}
	method esEscueta(){
		return not mensajes.any({m => self.tieneMuchosCaracteres(m)})
	}
	method emitioMensaje(mensaje){
		return mensajes.any({m => m == mensaje})
	}
	override method prepararViaje(){
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en Mision")
		self.accionAdicional()
	}
	override method estaTranquila(){
		return super() and not misilesDesplegados
	}
	override method recibirAmenaza(){
		self.acercarseUnPocoAlSol()
		self.acercarseUnPocoAlSol()
		self.emitirMensaje("Amenaza recibida")
	}
	override method estaDeRelajo(){
		return self.esEscueta()
	}
}

class NaveSigilosa inherits NaveCombate{
	override method estaTranquila(){
		return super() and not self.estaInvisible()
	}
	override method recibirAmenaza(){
		super()
		self.desplegarMisiles()
		self.ponerseInvisible()
	}
}






















