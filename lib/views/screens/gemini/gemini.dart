import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';

class GeminiPage extends StatefulWidget {
  const GeminiPage({super.key});

  @override
  State<GeminiPage> createState() => _HomePageState();
}

class _HomePageState extends State<GeminiPage> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiuser = ChatUser(
      id: "1",
      firstName: "Gemini",
      profileImage:
          "https://studiovisual.com.br/wp-content/uploads/2024/04/Gemini-1.jpg");

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.purple,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text(
              "Gemini",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            elevation: 0,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        ChatMessage message = messages[index];
        return _buildMessageItem(message);
      },
    );
  }

  Widget _buildMessageItem(ChatMessage message) {
    bool isCurrentUser = message.user.id == currentUser.id;
    return Container(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (message.medias != null)
            Image.file(
              File(message.medias!.first.url),
              width: 150,
              height: 150,
            ),
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              color: isCurrentUser ? Colors.blue : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(12),
            child: Text(
              message.text,
              style:
                  TextStyle(color: isCurrentUser ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: Colors.grey.shade300,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: _sendMediaMessage,
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration.collapsed(
                hintText: "Type your message...",
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _sendTextMessage(_controller.text),
          ),
        ],
      ),
    );
  }

  void _sendTextMessage(String text) {
    if (text.isNotEmpty) {
      ChatMessage chatMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        text: text,
      );
      sendmessage(chatMessage);
      _controller.clear();
    }
  }

  void sendmessage(ChatMessage chatMessage) {
    setState(() {
      messages.insert(0, chatMessage);
    });
    try {
      String question = chatMessage.text;
      List<Uint8List>? images;
      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [File(chatMessage.medias!.first.url).readAsBytesSync()];
      }
      gemini.streamGenerateContent(question, images: images).listen((event) {
        String response = event.content?.parts?.fold(
                "", (previous, current) => "$previous ${current.text}") ??
            "";
        ChatMessage message = ChatMessage(
          user: geminiuser,
          createdAt: DateTime.now(),
          text: response,
        );
        setState(() {
          messages.insert(0, message);
        });
      });
    } catch (e) {
      print(e);
    }
  }

  void _sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        text: "Describe This picture",
        medias: [
          ChatMedia(url: file.path, fileName: "", type: MediaType.image)
        ],
      );
      sendmessage(chatMessage);
    }
  }
}

class ChatMessage {
  final ChatUser user;
  final DateTime createdAt;
  final String text;
  final List<ChatMedia>? medias;

  ChatMessage({
    required this.user,
    required this.createdAt,
    required this.text,
    this.medias,
  });
}

class ChatUser {
  final String id;
  final String firstName;
  final String? profileImage;

  ChatUser({required this.id, required this.firstName, this.profileImage});
}

class ChatMedia {
  final String url;
  final String fileName;
  final MediaType type;

  ChatMedia({required this.url, required this.fileName, required this.type});
}

enum MediaType { image }

// void main() {
//   Gemini.init(apiKey: GEMINI_API_KEY);
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//         useMaterial3: true,
//       ),
//       home: const HomePage(),
//     );
//   }
// }
