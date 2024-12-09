import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];
  bool isDropdownVisible = false;

  // This function simulates a response after the user inputs a message
  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        // Add the user's message (prompt)
        messages.add({"type": "user", "text": _controller.text});
        // Simulate a bot response (could be an API call)
        messages.add({"type": "bot", "text": "Response to: ${_controller.text}"});
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat Interface")),
      body: Column(
        children: [
          // TextField at the top
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              onChanged: (text) {
                setState(() {
                  isDropdownVisible = text.isNotEmpty;
                });
              },
              decoration: InputDecoration(
                labelText: "Type a message...",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ),
            ),
          ),
          
          // Chat bubbles displaying messages
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                bool isUserMessage = message['type'] == 'user';
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                  child: Align(
                    alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isUserMessage ? Colors.blueAccent : Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        message['text']!,
                        style: TextStyle(
                          color: isUserMessage ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Bottom Navigation Bar
          BottomNavigationBar(
            currentIndex: 1,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: "Chat",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
           onTap: (index) {
          switch (index) {
            case 0:
              // Navigate to the ChatPage when the Chat button is tapped
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              //Already on page
              break;
            case 2:
              // Cart - You can add navigation for Cart here
              break;
          }
        },
          ),
        ],
      ),
    );
  }
}