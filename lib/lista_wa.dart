import 'package:flutter/material.dart';
import 'detalle.dart';

class ListaChatsScreen extends StatelessWidget {
  const ListaChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de datos de ejemplo para los chats
    final List<Map<String, String>> chats = [
      {
        'name': 'Abu Ali Socio',
        'message': '¡Hola! ¿Cómo va el proyecto de Flutter?',
        'time': '12:45 PM',
        'avatar': 'https://via.placeholder.com/150',
      },
      {
        'name': 'Abu Ali Socio',
        'message': '¡Hola! ¿Cómo va el proyecto de Flutter?',
        'time': '12:45 PM',
        'avatar': 'https://via.placeholder.com/150',
      },
      // Puedes descomentar o agregar más chats aquí
    ];

    // Widget para la lista de chats de la primera pestaña
    Widget buildChatList() {
      return ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 94, 17, 201),
              child: Text(
                chat['name']![0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              chat['name']!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              chat['message']!,
              style: const TextStyle(color: Colors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(
              chat['time']!,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
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
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(top: 8.0), 
            child: Text('        Crypchange'),
          ), 
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        // Colocamos el buscador en el cuerpo principal para que sea fijo en todas las pestañas
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
               child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Buscar',
                  hintStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 25, 25, 25),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0.8000),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  buildChatList(), // Pestaña 1: Lista de chats
                  const Center(child: Icon(Icons.mark_as_unread, color: Colors.white, size: 50)), // Pestaña 2
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Container(
            color: const Color.fromARGB(255, 0, 0, 0),
            child: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.all_inbox)),
                Tab(icon: Icon(Icons.mark_as_unread_outlined)),
              ],
              labelColor: Color.fromARGB(255, 59, 75, 226),
              unselectedLabelColor: Colors.white,
              indicatorColor: Color.fromARGB(255, 59, 75, 226),
            ),
          ),
        ),
      ),
    );
  }
}
