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

  InputDecoration _buildInputDecoration(String labelText) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 15.0,
      ),
      border: const OutlineInputBorder(),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white70),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2.0),
      ),
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.white),
      floatingLabelStyle: const TextStyle(color: Color.fromARGB(255, 245, 241, 241)),
      errorStyle: const TextStyle(color: Color.fromARGB(255, 247, 245, 244)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logologo.jpeg",
                    ),
                    const SizedBox(height: 0.0),
                    SizedBox(
                      width: 300.0,
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: _buildInputDecoration('Usuario'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu usuario';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    SizedBox(
                      width: 300.0,
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        enableSuggestions: false,
                        autocorrect: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: _buildInputDecoration('Contraseña'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu contraseña';
                          }
                          return null;
                        },
                        obscureText: true,
                        obscuringCharacter: '*',
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        _formKey.currentState?.validate();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 59, 75, 226),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(300, 50),
                      ),
                      child: const Text('Iniciar sesión'),
                    ),
                    const SizedBox(height: 175)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}