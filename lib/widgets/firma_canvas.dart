import 'package:flutter/material.dart';
//depues de que hice algunas prubas aquí me di cuenta de que tal vez tengamos algun problemita con lo de las firmas 
//porque no todo el mundo tiene esas herramientas para poner la firma pero lo voy mas adelante para tratar
//de hacerlo mas usable bueno almenos que todos puedan tener usarlo con confianza pero de otra manera jejeje.
class FirmaCanvasWidget extends StatefulWidget {
  final Function(bool) onSigned;
  const FirmaCanvasWidget({super.key, required this.onSigned});

  @override
  State<FirmaCanvasWidget> createState() => _FirmaCanvasWidgetState();
}

class _FirmaCanvasWidgetState extends State<FirmaCanvasWidget> {
  final List<Offset?> puntos = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Firma de conformidad (Uso de Canvas):',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Container(
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[100],
          ),
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                RenderBox renderBox = context.findRenderObject() as RenderBox;
                puntos.add(renderBox.globalToLocal(details.globalPosition));
              });
              widget.onSigned(puntos.isNotEmpty);
            },
            onPanEnd: (details) {
              setState(() {
                puntos.add(null);
              });
            },
            child: CustomPaint(
              painter: FirmaPainter(puntos),
              size: Size.infinite,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              puntos.clear();
            });
            widget.onSigned(false);
          },
          child: const Text('Limpiar firma'),
        ),
      ],
    );
  }
}

class FirmaPainter extends CustomPainter {
  final List<Offset?> puntos;
  FirmaPainter(this.puntos);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blueAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;

    for (int i = 0; i < puntos.length - 1; i++) {
      if (puntos[i] != null && puntos[i + 1] != null) {
        canvas.drawLine(puntos[i]!, puntos[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}