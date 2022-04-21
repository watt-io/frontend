import 'package:flutter/material.dart';

abstract class SellDialog {
  static Future<void> open(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Em desenvolvimento'),
          content: const Text(
              'Em breve realizaremos a adição desta mais nova funcionalidade, para que o senhor possa vender toda a sua energia excedente de suas propriedades.'),
          actions: [
            OutlinedButton(
              child: const Text('Continuar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
