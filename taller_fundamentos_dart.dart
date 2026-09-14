String verificarAprobacion(double nota) {
  if (nota >= 3.0) {
    return 'Aprueba';
  } else {
    return 'No Aprueba';
  }
}

double calcularPromedio(List<double> notas) {
  if (notas.isEmpty) {
    return 0;
  }
  double suma = 0;
  for (double nota in notas) {
    suma += nota;
  }
  return suma / notas.length;
}
//Parte 6 
class Estudiante{
  String nombre;
  int edad;
  String carrera;
  List<double> notas;
  
  Estudiante(
    this.nombre,
    this.edad,
    this.carrera,
    this.notas,
  
  );
  bool estaAlDiaConNotas(){
    if (notas.isEmpty){
      return false;
    }
    double suma = 0;
    for(double nota in notas){
      suma += nota;
    }
    double promedio = suma / notas.length;
    return promedio >= 3.0;
  }
}

void main() {
  String nombre = 'Carlos';
  int edad = 22;
  String carrera = 'Arquitecto';
  String correo = 'carlos@gmail.com';
  double promedio = 4.2;
  String estadoMatricula = 'Activa';
  int semestre = 5;
  String? apodo = null;
  //El apodo debe ser nulable por que no todos tendría un apodo registrado.

  print(' Ficha del estudiante ');
  print('Nombre: $nombre');
  print('Edad: $edad años');
  print('Carrera: $carrera');
  print('Correo: $correo');
  print('Promedio: $promedio');
  print('Estado de matrícula: $estadoMatricula');
  print('Semestre: $semestre');

  if (apodo != null) {
    print('Apodo : $apodo');
  } else {
    print('Apodo: No registrado');
  }

  String resultado = verificarAprobacion(4.5);
  print('resultado: $resultado');

  List<double> notas = [3.5, 4.0, 4.5, 3.8];
  double promedioSemestre = calcularPromedio(notas);
  print('Promedio del semestre: $promedioSemestre');

  //parte 4
  //Aquí use List por que permite elementos repetidos y mantiene el orden.

  List<String> asistentes = ['Carlos', 'Ana', 'Carlos', 'Luis'];
  //Aquí use set por que no permite elementos repetidos cada lenguaje aparece 1 vez
  Set<String> lenguajes = {'Dart', 'Java', 'Python'};
  //Aquí use map por que permite relacionar una clave con un valor
  //En nuestro ejemplo, el nombre el la clave y la nota el valor
  Map<String, double> notaEstudiantes = {
    'Carlos': 4.5,
    'Ana': 3.8,
    'Luis': 2.9,
  };

  print(' PARTE 4 ');
  print('Asistentes: $asistentes');
  print('Lenguajes: $lenguajes');
  print('Notas: $notaEstudiantes');
  
  //parte 5
  List<double> notasCurso=[4.5, 2.5, 3.8, 1.9, 4.8, 3.2];
  int reprobados = 0;
  int aprobados =0;
  int sobresalientes = 0;
  
  for (double nota in notasCurso){
    if (nota < 3.0){
      reprobados++;
    }else if (nota < 4.5){
      aprobados++;
    }else{
      sobresalientes++;
    }
  }
  print (' PARTE 5 ');
  print ('Reprobados: $reprobados');
  print ('Aprobados: $aprobados');
  print ('Sobresaliente : $sobresalientes');
  
  int intentos = 0;
  int maxIntentos = 3;
  String contrasenaCorrecta = '1234';
  
  List<String>contrasenasIncorrectas = [
    '1111',
    '2222',
    '1234'
  ];
  
  while (intentos < maxIntentos){
    if (contrasenasIncorrectas[intentos] == contrasenaCorrecta){
      print('Acceso Permitido');
      break;
    }else{
      print('Contraseña Incorrecta');
      intentos++;
    }
  }
  if(intentos == maxIntentos){
    print('Acabas de ser hackeado o eres muy buñuelo y se te olvido tu cantraseña');
  }
  // El problema A se resuelve mejor con un for porque necesitamos
  // recorrer todas las notas de la lista y clasificar cada estudiante.
  // El problema B se resuelve mejor con un while porque necesitamos
  // repetir el proceso mientras todavía haya intentos disponibles.
  
  //PARTE 6
  Estudiante estudiante1 = Estudiante(
  'Jose',
    22,
    'Arquitectura',
    [4.2, 3.9, 4.0],
  );
  Estudiante estudiante2 = Estudiante(
  'Daniela',
    22,
    'Comunicacion',
    [4.2, 4.0, 4.5],  
  );
  Estudiante estudiante3 = Estudiante(
  'Mariana',
    23,
    'Mercadeo',
    [2.5, 2.8, 2.9],
  );
print(' PARTE 6 ');
print('${estudiante1.nombre}: ${estudiante1.estaAlDiaConNotas()}');
print('${estudiante2.nombre}: ${estudiante2.estaAlDiaConNotas()}');
print('${estudiante3.nombre}: ${estudiante3.estaAlDiaConNotas()}');
  
}
