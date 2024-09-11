import 'package:flutter/material.dart';
import 'home_page.dart'; // Import the HomePage

void main() {
  runApp(ChatBotApp());
}

class ChatBotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [
    {
      'sender': 'bot',
      'text': 'Hello! How can I assist you with your studies today?',
      'actions': true
    }
  ];

  void _sendMessage(String message) {
    if (message.trim().isNotEmpty) {
      setState(() {
        messages.add({'sender': 'user', 'text': message, 'actions': false});
        messages.add({
          'sender': 'bot',
          'text':
              'Mitosis is a type of cell division that results in two genetically identical daughter cells from a single parent cell.',
          'actions': true
        });
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Chat with StudyBot',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Menu item selected
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'Search',
                  child: Text('Search'),
                ),
                PopupMenuItem(
                  value: 'Export Chat',
                  child: Text('Export Chat'),
                ),
                PopupMenuItem(
                  value: 'Clear Chat',
                  child: Text(
                    'Clear Chat',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isUserMessage = message['sender'] == 'user';
                  return _buildMessageBubble(
                    message['text'] ?? '',
                    isUserMessage,
                    message['actions'] ?? false,
                  );
                },
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(
      String message, bool isUserMessage, bool hasActions) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isUserMessage ? Colors.blue : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                color: isUserMessage ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
            if (hasActions)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.thumb_up_alt_outlined, size: 20),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.thumb_down_alt_outlined, size: 20),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.copy, size: 20),
                    onPressed: () {
                      // Kopyalama işlemi
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.share, size: 20),
                    onPressed: () {
                      // Paylaşma işlemi
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      color: Colors.white,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Ask me anything...',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.attach_file),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.send),
              color: Colors.blue,
              onPressed: () {
                _sendMessage(_controller.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
