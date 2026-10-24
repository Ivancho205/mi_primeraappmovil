class Bata {
  final int id;
  final String talla;
  final String estado;
  final String ubicacion;
  final String correoEstudiante;
  final DateTime creadoEn;

  Bata({
    required this.id,
    required this.talla,
    required this.estado,
    required this.ubicacion,
    required this.correoEstudiante,
    required this.creadoEn,
  });

  // Convertir a Map para guardar en SharedPreferences
  Map<String, dynamic> toJson() => {
        'id': id,
        'talla': talla,
        'estado': estado,
        'ubicacion': ubicacion,
        'correoEstudiante': correoEstudiante,
        'creadoEn': creadoEn.toIso8601String(),
      };

  factory Bata.fromJson(Map<String, dynamic> json) => Bata(
        id: json['id'],
        talla: json['talla'],
        estado: json['estado'],
        ubicacion: json['ubicacion'],
        correoEstudiante: json['correoEstudiante'],
        creadoEn: DateTime.parse(json['creadoEn']),
      );
}