import 'package:flutter/material.dart';
import 'detalle.dart';

class ListaChatsScreen extends StatelessWidget {
  const ListaChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de datos de ejemplo para los chats
    final List<Map<String, String>> chats = [
      {'name': 'Abu Ali Socio','message': '¡Hola! ¿Cómo va el proyecto de Flutter?',
        'time': '12:45 PM','avatar': 'https://via.placeholder.com/150',
      },
      {'name': 'Maikel Traki', 'message': 'Nos vemos mañana a las 10:00 AM.',
        'time': '11:20 AM','avatar': 'https://via.placeholder.com/150',
      },
      {'name': 'Wagih', 'message': 'Tu solicitud ha sido procesada con éxito.',
        'time': 'Ayer','avatar': 'https://via.placeholder.com/150',
      },
      {'name': 'Faisal Valencia', 'message': 'Me pasas el código por favor.', 'time': 'Ayer','avatar': 'https://via.placeholder.com/150',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text('        Crypchange'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 30.0,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
             style: const TextStyle(color: Colors.white),
             decoration: InputDecoration(
              hintText: 'Buscar',
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: const Icon(Icons.search, color: Colors.white),
              filled: true,
              fillColor: const Color.fromARGB(255, 25, 25, 25),
              contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide.none,
              ),
             ),
            //  onChanged: (value){
            //   },
            ), 
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ListTile(
                  // Avatar o foto de perfil circular a la izquierda
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade800,
                    child: Text(
                      chat['name']![0], // Muestra la inicial del contacto
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  // Nombre del contacto
                  title: Text(
                    chat['name']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Último mensaje
                  subtitle: Text(
                    chat['message']!,
                    style: const TextStyle(color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, // Corta el texto largo con puntos suspensivos
                  ),
                  // Hora del mensaje a la derecha
                  trailing: Text(
                    chat['time']!,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  // Acción al hacer clic en un chat específico
                  onTap: () {
                    Navigator.push(
                     context,
                     MaterialPageRoute(
                     builder: (context) => ChatDetailScreen(
                      contactName: chat['name']!,
                      ),
                     ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
