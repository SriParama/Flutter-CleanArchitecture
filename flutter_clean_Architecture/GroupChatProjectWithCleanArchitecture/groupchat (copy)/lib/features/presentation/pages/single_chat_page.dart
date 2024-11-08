import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:groupchat/features/presentation/widgets/theme/style.dart';

class SingleChatPage extends StatefulWidget {
  const SingleChatPage({super.key});

  @override
  State<SingleChatPage> createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _messageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('group name'),
      ),
      body: Column(
        children: [
          Expanded(child: _listMessagesWidget()),
          _inputMessageTextField(),
        ],
      ),
    );
  }

  Widget _listMessagesWidget() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Text('');
      },
    );
  }

  Widget _inputMessageTextField() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(80),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.20),
                        spreadRadius: 1,
                        blurRadius: 1)
                  ]),
              child: Row(
                children: [
                  SizedBox(
                    width: 4,
                  ),
                  Icon(Icons.insert_emoticon),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Scrollbar(
                          child: TextField(
                    controller: _messageController,
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: 'Type a message', border: InputBorder.none),
                  ))),
                  Icon(Icons.link),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(Icons.camera_alt),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(45)),
            child: Icon(
              _messageController.text.isEmpty ? Icons.mic : Icons.send,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
