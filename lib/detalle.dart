import 'package:flutter/material.dart';

class ChatDetailScreen extends StatelessWidget {
  final String contactName;

  const ChatDetailScreen({super.key, required this.contactName});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> messages = [
      {
        'text': 'Como van los cobros y pagos de wagih ?',
        'isMe': false,
        'time': '12:45pm'
      },
      {
        'text': 'Ya esta al dia con sus cuentas pendientes?',
        'isMe': false,
        'time': '12:45pm'
      },
    ];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 25, 25),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 94, 17, 201),
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
      body: ListView.builder(
        reverse: true, //esto para mantener el orden
        itemCount: messages.length,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        itemBuilder: (context, index) {
          final message = messages[index];
          final bool isMe = message['isMe'];

          return Align( 
            alignment: isMe ? Alignment.centerRight: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: isMe ? const Color(0xFF005C4B) : const Color.fromARGB(255, 94, 17, 201),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message['text'],
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message['time'],
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  )
                ],
              ),
            ),
          );
        },
      )







      // body: Column(
      //   children: [
      //     const Expanded(
      //       child: Center(
      //         child: Text(
      //           'Conversación abierta',
      //           style: TextStyle(color: Colors.grey),
      //         ),
      //       ),
      //     ),
      //     Container(
      //       padding: const EdgeInsets.all(8.0),
      //       color: const Color.fromARGB(255, 25, 25, 25),
      //     ),
      //   ],
      // ),
    );
  }
}