import 'package:flutter/material.dart';
import 'detalle.dart';
import 'http_service.dart';
// import 'filtro.dart';

class ListaChatsScreen extends StatefulWidget {
  const ListaChatsScreen({super.key});

  @override
  State<ListaChatsScreen> createState() => _ListaChatsScreenState();
}

class _ListaChatsScreenState extends State<ListaChatsScreen> {
  Future<List<dynamic>> _futureMensajes = HttpService.getMensajes();
  String _ultimaBusqueda = '';

  @override
  void initState() {
    super.initState();
    _futureMensajes = HttpService.getMensajes();
  }

  // Función para filtrar los datos reales traídos de Node.js
  List<dynamic> _aplicarFiltro(List<dynamic> mensajes, String query) {
    if (query.isEmpty) {
      return mensajes;
    }

    final busqueda = query.toLowerCase();
    return mensajes.where((chat) {
      final nameGroup = (chat['name_group'] ?? '').toString().toLowerCase();
      final contenido = (chat['contenido'] ?? '').toString().toLowerCase();
      return nameGroup.contains(busqueda) || contenido.contains(busqueda);
    }).toList();
  }

  void _filtrarBusqueda(String query) {
    setState(() {
      _ultimaBusqueda = query;
    });
  }

  // Widget encargado de armar la lista para las pestañas
  Widget buildChatList(List<dynamic> mensajes, {bool onlyUnread = false}) {
    final List<dynamic> mostrados = _aplicarFiltro(mensajes, _ultimaBusqueda);

    if (mostrados.isEmpty) {
      return const Center(
        child: Text(
          'No hay mensajes registrados',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: mostrados.length,
      itemBuilder: (context, index) {
        final chat = mostrados[index];

        // Mapeo exacto de las columnas de tu backend
        final String nameGroup = chat['name_group'] ?? 'Sin Grupo';
        final String contenido = chat['contenido'] ?? '';
        final String moneda = chat['moneda'] ?? '';
        final String fechaBruta = chat['fecha'] ?? '';
        final String hora = fechaBruta.length >= 16 ? fechaBruta.substring(11, 16) : fechaBruta;

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 94, 17, 201),
            child: Text(
              nameGroup.isNotEmpty ? nameGroup[0].toUpperCase() : '?',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  nameGroup,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  moneda.toUpperCase(),
                  style: const TextStyle(color: Colors.deepPurpleAccent, fontSize: 10),
                ),
              ),
            ],
          ),
          subtitle: Text(
            contenido,
            style: const TextStyle(color: Colors.grey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
            hora,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatDetailScreen(
                  contactName: nameGroup,
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
        body: FutureBuilder<List<dynamic>>(
          future: _futureMensajes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.deepPurpleAccent),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error al cargar mensajes: ${snapshot.error}',
                  style: const TextStyle(color: Colors.redAccent),
                  textAlign: TextAlign.center,
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No hay mensajes registrados',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    onChanged: _filtrarBusqueda,
                    decoration: InputDecoration(
                      hintText: 'Buscar',
                      hintStyle: const TextStyle(color: Colors.white70),
                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 25, 25, 25),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0.8),
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
                      buildChatList(snapshot.data!, onlyUnread: false),
                      buildChatList(snapshot.data!, onlyUnread: true),
                    ],
                  ),
                ),
              ],
            );
          },
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