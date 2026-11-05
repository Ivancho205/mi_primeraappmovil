import 'package:flutter/material.dart';

class FirmaCanvasWidget extends StatefulWidget {
  final Function(bool) onSigned;
  const FirmaCanvasWidget({super.key, required this.onSigned});

  @override
  State<FirmaCanvasWidget> createState() => _FirmaCanvasWidgetState();
}

class _FirmaCanvasWidgetState extends State<FirmaCanvasWidget> {
  // Variable local para llevar el estado de si el checkbox está marcado o no
  bool _estaAceptado = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue.withOpacity(0.03), // Fondo sutil azulado para destacarlo
      ),
      child: Row(
        children: [
          Checkbox(
            value: _estaAceptado,
            onChanged: (bool? valor) {
              setState(() {
                _estaAceptado = valor ?? false;
              });
              // Notificamos a la pantalla principal si ya se aceptó (true o false)
              widget.onSigned(_estaAceptado);
            },
          ),
          const Expanded(
            child: Text(
              'Confirmo que los datos de la bata y la ubicación son correctos para el préstamo en el Pascual Bravo.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}