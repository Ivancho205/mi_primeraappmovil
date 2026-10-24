import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/bata.dart';
//ESta parte es nueva que investigue para que los datos persistan incluso si cierran o vuelvemoss abrir la app
//esto es nuevo esto no lo sabía hacer 
class BataService {
  static const String _keyBatas = 'inventario_batas_pascual';

  // Listar batas guardadas
  Future<List<Bata>> listar() async {
    final prefs = await SharedPreferences.getInstance();
    final String? dataString = prefs.getString(_keyBatas);
    if (dataString == null) return [];

    List<dynamic> jsonList = jsonDecode(dataString);
    return jsonList.map((json) => Bata.fromJson(json)).toList();
  }

  // Crear y guardar nueva bata
  Future<Bata> crear({
    required String talla,
    required String estado,
    required String ubicacion,
    required String correoEstudiante,
  }) async {
    // Simulamos un retraso de red con Future.delayed
    await Future.delayed(const Duration(milliseconds: 600));

    final prefs = await SharedPreferences.getInstance();
    List<Bata> actualList = await listar();

    final nuevoId = actualList.isEmpty ? 1 : actualList.first.id + 1;

    final nuevaBata = Bata(
      id: nuevoId,
      talla: talla,
      estado: estado,
      ubicacion: ubicacion,
      correoEstudiante: correoEstudiante.trim().toLowerCase(),
      creadoEn: DateTime.now(),
    );

    actualList.insert(0, nuevaBata);

    // Guardar lista actualizada en formato JSON string
    List<Map<String, dynamic>> jsonList =
        actualList.map((b) => b.toJson()).toList();
    await prefs.setString(_keyBatas, jsonEncode(jsonList));

    return nuevaBata;
  }
}