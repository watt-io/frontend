import 'package:flutter/material.dart';

class MessageInfo {
  final BuildContext context;

  // ignore: unused_element
  MessageInfo._(this.context);
  MessageInfo.of(this.context);

  /// Envia uma mensagem de Alerta\
  /// Texto preto e fundo vermelho
  void alert(String texto, [int segundos = 5]) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(texto),
        backgroundColor: Colors.red,
        duration: Duration(seconds: segundos),
      ),
    );
  }

  /// Envia uma mensagem de aviso positivo
  /// Texto preto e fundo verde
  void ok(String texto, [int segundos = 5]) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(texto),
        backgroundColor: Colors.green,
        duration: Duration(seconds: segundos),
      ),
    );
  }

  /// Envia uma mensagem personalizada
  void custom(Text text, Color colors, [int segundos = 5]) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: text,
        backgroundColor: colors,
        duration: Duration(seconds: segundos),
      ),
    );
  }

  /// Remove qualquer mensagem ativa
  void remove() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }
}
