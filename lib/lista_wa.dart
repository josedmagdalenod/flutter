import 'package:flutter/material.dart';
import 'detalle.dart';
import 'filtro.dart';

class ListaChatsScreen extends StatefulWidget {
  const ListaChatsScreen({super.key});

  @override
  State<ListaChatsScreen> createState() => _ListaChatsScreenState();
}

class _ListaChatsScreenState extends State<ListaChatsScreen> {
  final List<Map<String, String>> _chatsOriginales = [
    {
      'name': 'Abu Ali Socio',
      'message': '¡Hola! ¿Cómo va el proyecto de Flutter?',
      'time': '12:45 PM',
      'avatar': 'https://via.placeholder.com/150',
      'leido': 'false',
    },
    {
      'name': 'Wagih',
      'message': '¡Hola! ¿Cómo va el proyecto de Flutter?',
      'time': '12:45 PM',
      'avatar': 'https://via.placeholder.com/150',
      'leido': 'false',
    },
    {
      'name': 'Rashid',
      'message': 'Mira este producto que te comenté',
      'time': '1:58pm',
      'avatar': 'https://via.placeholder.com/150',
      'leido': 'false',
    },
  ];

  List<Map<String, String>> _chatsFiltrados = [];
  String _ultimaBusqueda = '';

  @override
  void initState() {
    super.initState();
    _chatsFiltrados = _chatsOriginales;
  }

  void _filtrarBusqueda(String query) {
    _ultimaBusqueda = query;
    setState(() {
      _chatsFiltrados = FiltroChats.aplicar(_chatsOriginales, query);
    });
  }

  Widget buildChatList({bool onlyUnread = false}) {
    final List<Map<String, String>> mostrados = onlyUnread
        ? _chatsFiltrados.where((c) => c['leido'] == 'false').toList()
        : _chatsFiltrados;

    if (mostrados.isEmpty) {
      return const Center(child: Icon(Icons.mark_as_unread, color: Colors.white, size: 48));
    }

    return ListView.builder(
      itemCount: mostrados.length,
      itemBuilder: (context, index) {
        final chat = mostrados[index];
        final bool unread = chat['leido'] == 'false';

        return ListTile(
          leading: Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 94, 17, 201),
                child: Text(
                  chat['name']![0],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              if (unread)
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 59, 75, 226),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          title: Text(
            chat['name']!,
            style: TextStyle(
              color: Colors.white,
              fontWeight: unread ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          subtitle: Text(
            chat['message']!,
            style: TextStyle(
              color: unread ? Colors.white70 : Colors.grey,
              fontWeight: unread ? FontWeight.w600 : FontWeight.normal,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
            chat['time']!,
            style: TextStyle(
              color: unread ? Colors.white : Colors.grey,
              fontSize: 12,
              fontWeight: unread ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          onTap: () {
            // Marcar como leído en la lista original (por si _chatsFiltrados es copia)
            for (var orig in _chatsOriginales) {
              if (orig['name'] == chat['name']) {
                orig['leido'] = 'true';
              }
            }
            // Reaplicar filtro actual para actualizar vistas
            _filtrarBusqueda(_ultimaBusqueda);

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
  Widget build(BuildContext context) {
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                onChanged: _filtrarBusqueda,
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
                  buildChatList(onlyUnread: false), // todos los chats
                  buildChatList(onlyUnread: true),  // solo no leídos
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