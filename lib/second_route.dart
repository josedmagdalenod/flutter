import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Esto te regresa a la pantalla anterior
            Navigator.pop(context);
          },
          child: const Text('Regresar'),
        ),
      ),
    );
  }
}