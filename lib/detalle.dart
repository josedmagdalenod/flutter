import 'package:flutter/material.dart';

class ChatDetailScreen extends StatelessWidget {
  final String contactName;

  const ChatDetailScreen({super.key, required this.contactName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 25, 25),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade800,
              radius: 16,
              child: Text(
                contactName[0],
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              contactName,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Text(
                'Conversación abierta',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            color: const Color.fromARGB(255, 25, 25, 25),
          ),
        ],
      ),
    );
  }
}