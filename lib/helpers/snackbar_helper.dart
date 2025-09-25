import 'package:flutter/material.dart';

void mostrarSnackBar(BuildContext context, String mensagem, {Color cor = Colors.green}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(mensagem),
      backgroundColor: cor,
      duration: const Duration(seconds: 2),
    ),
  );
}