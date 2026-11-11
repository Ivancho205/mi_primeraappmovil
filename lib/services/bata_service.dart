import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/bata.dart';

class BataService {
  static const String _keyBatas = 'inventario_batas_pascual';

  // Colección en memoria compartida (Simulación de API/Backend)
  static final List<Bata> _batasEnMemoria = [];
  static bool _cargadoDesdeStorage = false;

  // 1. Listar batas (simula respuesta de red con Future.delayed)
  Future<List<Bata>> listar() async {
    // Simula retraso de respuesta de API (500ms)
    await Future.delayed(const Duration(milliseconds: 500));

    // Si es la primera vez, cargamos lo que haya persistido en SharedPreferences
    if (!_cargadoDesdeStorage) {
      final prefs = await SharedPreferences.getInstance();
      final String? dataString = prefs.getString(_keyBatas);
      if (dataString != null) {
        List<dynamic> jsonList = jsonDecode(dataString);
        _batasEnMemoria.clear();
        _batasEnMemoria.addAll(jsonList.map((json) => Bata.fromJson(json)));
      }
      _cargadoDesdeStorage = true;
    }

    // Devuelve una lista inmutable para proteger la colección interna
    return List<Bata>.unmodifiable(_batasEnMemoria);
  }

  // 2. Crear nueva bata (con regla de negocio y simulación asíncrona)
  Future<Bata> crear({
    required String talla,
    required String estado,
    required String ubicacion,
    required String correoEstudiante,
    required String tipoOperacion,
  }) async {
    // Simula retraso de escritura de red (800ms)
    await Future.delayed(const Duration(milliseconds: 800));

    final correoNormalizado = correoEstudiante.trim().toLowerCase();
    final tallaNormalizada = talla.trim().toUpperCase();
    final ubicacionNormalizada = ubicacion.trim();

    
    // Impide duplicados si el mismo estudiante ya tiene una bata publicada con la misma talla y ubicación.
    final yaExisteDuplicado = _batasEnMemoria.any((bata) =>
        bata.correoEstudiante == correoNormalizado &&
        bata.talla == tallaNormalizada &&
        bata.ubicacion.toLowerCase() == ubicacionNormalizada.toLowerCase());

    if (yaExisteDuplicado) {
      throw StateError(
          'Ya registraste una bata talla $tallaNormalizada en $ubicacionNormalizada con este correo.');
    }

    // Generar nuevo ID
    final nuevoId = _batasEnMemoria.isEmpty ? 1 : _batasEnMemoria.first.id + 1;

    final nuevaBata = Bata(
      id: nuevoId,
      talla: tallaNormalizada,
      estado: estado,
      ubicacion: ubicacionNormalizada,
      correoEstudiante: correoNormalizado,
      creadoEn: DateTime.now(),
      tipoOperacion: tipoOperacion,
    );

    // Insertar al inicio de la colección en memoria
    _batasEnMemoria.insert(0, nuevaBata);
    //await _guardarEnStorage(); por ahora es mejor dejarla así

    // Sincronizar con SharedPreferences (sin tipos complejos para evitar errores de copiado)
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _keyBatas,
      jsonEncode(_batasEnMemoria.map((b) => b.toJson()).toList()),
    );

    return nuevaBata;
  }
}