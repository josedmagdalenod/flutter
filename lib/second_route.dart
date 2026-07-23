import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3, 
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        appBar: AppBar(
          // bottom: const TabBar(
          //   tabs: [
          //     Tab(icon: Icon(Icons.all_inbox)),
          //     Tab(icon: Icon(Icons.pending)),
          //     Tab(icon: Icon(Icons.read_more)),
          //   ], 
          // ),
          title: const Text('  Chats'),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 35.0,
            ),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
        body: const TabBarView(
          children: [
              Icon(Icons.all_inbox, color: Colors.white),
              Icon(Icons.check, color: Colors.white),
              Icon(Icons.mark_as_unread, color: Colors.white),
          ]),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Container(
              color: const Color.fromARGB(255, 0, 0, 0),
              child: const TabBar(
                tabs:[
                  Tab(icon: Icon(Icons.all_inbox)),
                  Tab(icon: Icon(Icons.check)),
                  Tab(icon: Icon(Icons.mark_as_unread_outlined)),
                ],
                labelColor: Color.fromARGB(255, 59, 75, 226),
                unselectedLabelColor: Colors.white ,
                indicatorColor: Color.fromARGB(255, 59, 75, 226),
                )
            ),
          ),

      ))
    );
      // appBar: AppBar(
      //   title: const Text('SecondRoute'),
      // ),
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       // Esto te regresa a la pantalla anterior
      //       Navigator.pop(context);
      //     },
      //     child: const Text('Regresar'),
      //   ),
      // ),
    // );
  }
}