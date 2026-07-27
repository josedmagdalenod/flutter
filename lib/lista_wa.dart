import 'package:flutter/material.dart';
import 'detalle.dart';
import 'filtro.dart';

class ListaChatsScreen extends StatefulWidget {
  const ListaChatsScreen({super.key});

  @override
  State<ListaChatsScreen> createState() => _ListaChatsScreenState();
  }
  // Widget build(BuildContext context) {
    // Lista de datos de ejemplo para los chats
  class _ListaChatsScreenState extends State<ListaChatsScreen> {
    final List<Map<String, String>> _chatsOriginales = [
      {
        'name': 'Abu Ali Socio',
        'message': '¡Hola! ¿Cómo va el proyecto de Flutter?',
        'time': '12:45 PM',
        'avatar': 'https://via.placeholder.com/150',
      },
      {
        'name': 'Wagih',
        'message': '¡Hola! ¿Cómo va el proyecto de Flutter?',
        'time': '12:45 PM',
        'avatar': 'https://via.placeholder.com/150',
      },
      // Puedes descomentar o agregar más chats aquí
    ];
    // lista dinamica que cambia en el tiempo real al escribir
    List<Map<String, String>> _chatsFiltrados = [];
    @override
    void initState () {
      super.initState();
      _chatsFiltrados = _chatsOriginales; // al arrancar muestra todos
    }

    // Funcion que usa la clase FiltroChats para actualizar la vista
    void _filtrarBusqueda(String query){
      setState(() {
        _chatsFiltrados = FiltroChats.aplicar(_chatsOriginales, query);
      });
    }

    // Widget para construir la lista de chats usando _chatsFiltrados

    Widget buildChatList(){
      return ListView.builder(
        itemCount: _chatsFiltrados.length,
        itemBuilder: (context, index) {
         final chat = _chatsFiltrados[index];
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
            chat ['time']!,
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

    @override
    Widget build(BuildContext context){
      return DefaultTabController(
        length: 2, 
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          appBar:  AppBar(
            title: const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text('    Crypchange'),
            ),
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 30.0,
            ),
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Column(
            children: [
              //el buscador donde conectamos el evento onChanged
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  onChanged: _filtrarBusqueda,
                  decoration: InputDecoration(
                    hintText: 'Buscar',
                    hintStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(Icons.search, color: Colors.white,),
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
                    buildChatList(),
                    const Center(child: Icon(Icons.mark_as_unread, color: Colors.white, size: 50)),
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
    // Widget para la lista de chats de la primera pestaña
  //   Widget buildChatList() {
  //     return ListView.builder(
  //       itemCount: chats.length,
  //       itemBuilder: (context, index) {
  //         final chat = chats[index];
  //         return ListTile(
  //           leading: CircleAvatar(
  //             backgroundColor: const Color.fromARGB(255, 94, 17, 201),
  //             child: Text(
  //               chat['name']![0],
  //               style: const TextStyle(color: Colors.white),
  //             ),
  //           ),
  //           title: Text(
  //             chat['name']!,
  //             style: const TextStyle(
  //               color: Colors.white,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           subtitle: Text(
  //             chat['message']!,
  //             style: const TextStyle(color: Colors.grey),
  //             maxLines: 1,
  //             overflow: TextOverflow.ellipsis,
  //           ),
  //           trailing: Text(
  //             chat['time']!,
  //             style: const TextStyle(color: Colors.grey, fontSize: 12),
  //           ),
  //           onTap: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => ChatDetailScreen(
  //                   contactName: chat['name']!,
  //                 ),
  //               ),
  //             );
  //           },
  //         );
  //       },
  //     );
  //   }

  //   return DefaultTabController(
  //     length: 2,
  //     child: Scaffold(
  //       backgroundColor: const Color.fromARGB(255, 0, 0, 0),
  //       appBar: AppBar(
  //         title: const Padding(
  //           padding: EdgeInsets.only(top: 8.0), 
  //           child: Text('        Crypchange'),
  //         ), 
  //         titleTextStyle: const TextStyle(
  //           color: Colors.white,
  //           fontSize: 30.0,
  //         ),
  //         backgroundColor: const Color.fromARGB(255, 0, 0, 0),
  //         iconTheme: const IconThemeData(color: Colors.white),
  //       ),
  //       // Colocamos el buscador en el cuerpo principal para que sea fijo en todas las pestañas
  //       body: Column(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
  //              child: TextField(
  //               style: const TextStyle(color: Colors.white),
  //               decoration: InputDecoration(
  //                 hintText: 'Buscar',
  //                 hintStyle: const TextStyle(color: Colors.white),
  //                 prefixIcon: const Icon(Icons.search, color: Colors.white),
  //                 filled: true,
  //                 fillColor: const Color.fromARGB(255, 25, 25, 25),
  //                 contentPadding: const EdgeInsets.symmetric(vertical: 0.8000),
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(25.0),
  //                   borderSide: BorderSide.none,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Expanded(
  //             child: TabBarView(
  //               children: [
  //                 buildChatList(), // Pestaña 1: Lista de chats
  //                 const Center(child: Icon(Icons.mark_as_unread, color: Colors.white, size: 50)), // Pestaña 2
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //       bottomNavigationBar: Padding(
  //         padding: const EdgeInsets.all(26.0),
  //         child: Container(
  //           color: const Color.fromARGB(255, 0, 0, 0),
  //           child: const TabBar(
  //             tabs: [
  //               Tab(icon: Icon(Icons.all_inbox)),
  //               Tab(icon: Icon(Icons.mark_as_unread_outlined)),
  //             ],
  //             labelColor: Color.fromARGB(255, 59, 75, 226),
  //             unselectedLabelColor: Colors.white,
  //             indicatorColor: Color.fromARGB(255, 59, 75, 226),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
