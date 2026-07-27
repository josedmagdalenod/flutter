import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'http_service.dart';
// import 'second_route.dart';
import 'lista_wa.dart';


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
  // 1. Agregamos los controladores para capturar el texto de los inputs
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  MyHomePage({super.key});
   
   Future<void> _manejarLogin(BuildContext context) async {
    final resultado = await HttpService.loginN8n(
      _usuarioController.text.trim(),
      _passwordController.text.trim(),
    );
    if (!context.mounted) return;
    if (resultado != null) {
      // Si n8n responde bien (200), navegamos a la lista de chats
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => const ListaChatsScreen(),
        ),
      );
    } else {
      // Si las credenciales fallan o hay error de red
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario o contraseña incorrectos')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
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
                  controller: _usuarioController,
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
                  controller: _passwordController,
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
                onPressed: () {
                  if (_formKey.currentState!.validate()){
                    _manejarLogin(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute<void>(
                    //     builder: (context) => const ListaChatsScreen(),
                    //   )
                    // );
                  }
                },
                style: ElevatedButton.styleFrom( 
                  backgroundColor: const Color.fromARGB(255, 57, 17, 201),
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
              Password(),
            ],
          ),
        ),
      ),
    );
  }
}

class Password extends StatelessWidget {
  const Password({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Olvide Contraseña",
      style: TextStyle(color: Color.fromARGB(255, 66, 64, 64)),
    );
  }
}