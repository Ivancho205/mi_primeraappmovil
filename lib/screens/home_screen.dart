import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../models/bata.dart';
import '../services/bata_service.dart';
import '../widgets/firma_canvas.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tallaController = TextEditingController();
  final _ubicacionController = TextEditingController();
  final _correoController = TextEditingController();
  final BataService _servicio = BataService();

  List<Bata> _batas = [];
  bool _cargandoLista = true;
  bool _enviando = false;
  bool _firmado = false;
  String? _mensajeError;

  final _validarRequerido = RequiredValidator(errorText: 'Este campo es obligatorio.');
  final _validarCorreo = MultiValidator([
    RequiredValidator(errorText: 'Escribe un correo.'),
    EmailValidator(errorText: 'Revisa el formato del correo.'),
  ]);

  @override
  void initState() {
    super.initState();
    _cargarBatas();
  }

  @override
  void dispose() {
    _tallaController.dispose();
    _ubicacionController.dispose();
    _correoController.dispose();
    super.dispose();
  }

  Future<void> _cargarBatas() async {
    try {
      final datos = await _servicio.listar();
      if (!mounted) return;
      setState(() => _batas = datos);
    } catch (e) {
      if (!mounted) return;
      setState(() => _mensajeError = 'No se pudo cargar la lista.');
    } finally {
      if (mounted) setState(() => _cargandoLista = false);
    }
  }

  Future<void> _guardarBata() async {
    if (_enviando) return;
    final valido = _formKey.currentState?.validate() ?? false;
    if (!valido) return;

    if (!_firmado) {
      setState(() => _mensajeError = 'Debes firmar en el recuadro de Canvas.');
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _enviando = true;
      _mensajeError = null;
    });

    try {
      final nuevaBata = await _servicio.crear(
        talla: _tallaController.text.trim(),
        estado: 'Excelente',
        ubicacion: _ubicacionController.text.trim(),
        correoEstudiante: _correoController.text.trim(),
      );

      if (!mounted) return;
      _tallaController.clear();
      _ubicacionController.clear();
      _correoController.clear();
      _formKey.currentState?.reset();

      setState(() {
        _batas = [nuevaBata, ..._batas];
        _firmado = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _mensajeError = 'Ocurrió un error al guardar.');
    } finally {
      if (mounted) setState(() => _enviando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TruequeU - Préstamo de Batas'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Registra o solicita tu bata de laboratorio en la I.U. Pascual Bravo',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  controller: _tallaController,
                  validator: _validarRequerido,
                  decoration: const InputDecoration(
                    labelText: 'Talla (S, M, L, XL)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _ubicacionController,
                  validator: _validarRequerido,
                  decoration: const InputDecoration(
                    labelText: 'Ubicación / Bloque (ej. Bloque 4)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _correoController,
                  validator: _validarCorreo,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Correo Institucional',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                FirmaCanvasWidget(
                  onSigned: (signed) {
                    setState(() => _firmado = signed);
                  },
                ),
                const SizedBox(height: 16),
                if (_mensajeError != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      _mensajeError!,
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _enviando ? null : _guardarBata,
                    icon: _enviando
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.science),
                    label: Text(_enviando ? 'Registrando...' : 'Publicar / Solicitar Bata'),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 40),
          Text(
            'Batas Disponibles (${_batas.length})',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          if (_cargandoLista)
            const Center(child: CircularProgressIndicator())
          else if (_batas.isEmpty)
            const Text('Todavía no hay batas registradas en el campus.')
          else
            for (final bata in _batas)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.checkroom, color: Colors.blueAccent),
                  title: Text('Talla: ${bata.talla} - ${bata.ubicacion}'),
                  subtitle: Text('Contacto: ${bata.correoEstudiante}'),
                  trailing: Text('#${bata.id}'),
                ),
              ),
        ],
      ),
    );
  }
}