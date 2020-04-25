import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:practica_tres/models/barcode_item.dart';
import 'package:practica_tres/models/image_label_item.dart';

class Details extends StatefulWidget {
  final BarcodeItem barcode;
  final ImageLabelItem imageLabeled;
  Details({
    Key key,
    this.barcode,
    this.imageLabeled,
  }) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Uint8List imageBytes;
  bool bandera = false;
  @override
  Widget build(BuildContext context) {
    // convierte la string base 64 a bytes para poder pintar Image.memory(Uint8List)
    if (widget.barcode != null) {
      imageBytes = base64Decode(widget.barcode.imagenBase64);
    } else {
      imageBytes = base64Decode(widget.imageLabeled.imagenBase64);
      bandera = true;
    }

    return Scaffold(
      appBar: AppBar(title: Text("Detalles")),
      body: Center(
          child: bandera
              ? Column(
                  children: <Widget>[
                    CustomPaint(
                      foregroundPainter: RectPainter(
                          pointsList: widget.barcode.puntosEsquinas),
                      child: Image.memory(imageBytes),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(">id: ${widget.imageLabeled.identificador}"),
                    SizedBox(
                      height: 10,
                    ),
                    Text(">Label: ${widget.imageLabeled.texto}"),
                    SizedBox(
                      height: 10,
                    ),
                    Text(">Certeza: ${widget.imageLabeled.similitud}"),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              : Column(
                  children: <Widget>[
                    Image.memory(imageBytes),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Codigo: ${widget.barcode.codigo}"),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Formato: ${widget.barcode.tipoCodigo}"),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Titulo de URL: ${widget.barcode.tituloUrl}"),
                    SizedBox(
                      height: 10,
                    ),
                    Text("URL: ${widget.barcode.url}"),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Area de codigo: ${widget.barcode.areaDeCodigo}"),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Esquinas: ${widget.barcode.puntosEsquinas}")
                  ],
                )),
    );
  }
}

class RectPainter extends CustomPainter {
  final List<Offset> pointsList;

  RectPainter({@required this.pointsList});

  @override
  bool shouldRepaint(CustomPainter old) => false;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromPoints(pointsList[0], pointsList[2]);
    final line = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawRect(rect, line);
  }
}
