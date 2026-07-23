import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Comunicaciones Crypchange',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 230, 228, 233)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {}

class MyHomePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 60.0),
              
              // === IMAGEN COMENTADA TEMPORALMENTE PARA EVITAR EL CRASH ===
              Image.asset("assets/logologo.jpeg"),
              
              const SizedBox(height: 0.0),
              SizedBox(
                width: 300.0,
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 0.0,
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Usuario',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu usuario';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: 300.0,
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 0.0,
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu contraseña';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 59, 75, 226),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    // Corregido de BorderRadiusGeometry a BorderRadius:
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(300, 50),
                ),
                child: const Text('Iniciar sesión'),
              ),
              const SizedBox(height: 8),
              const Text(
                "Olvide Contraseña",
                style: TextStyle(color: Color.fromARGB(255, 66, 64, 64)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}