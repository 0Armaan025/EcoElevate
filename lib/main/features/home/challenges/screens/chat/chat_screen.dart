import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String roomId;

  ChatScreen({required this.roomId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> _messageStream;
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    _messageStream = _firestore
        .collection('rooms')
        .doc(widget.roomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    _firestore
        .collection('rooms')
        .doc(widget.roomId)
        .collection('messages')
        .add({
      'text': text,
      'senderEmail': _user.email,
      'timestamp': Timestamp.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _messageStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message =
                        messages[index].data() as Map<String, dynamic>;
                    final text = message['text'];
                    final senderEmail = message['senderEmail'];
                    final isMe = senderEmail == _user.email;
                    return _buildMessageBubble(
                      text: text,
                      senderEmail: senderEmail,
                      isMe: isMe,
                    );
                  },
                );
              },
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    InputDecoration.collapsed(hintText: 'Send a message'),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(
      {required String text, required String senderEmail, required bool isMe}) {
    final senderInitials = senderEmail.substring(0, 2).toUpperCase();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            child: Text(senderInitials),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    isMe ? 'You' : senderEmail,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.circular(12.0),
                  elevation: 4.0,
                  color: isMe ? Colors.blueAccent : Colors.white,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: isMe ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
