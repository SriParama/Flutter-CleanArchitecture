import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:groupchat/const.dart';
import 'package:groupchat/features/presentation/widgets/single_item_group_widget.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, PageConst.createNewGroupPage);
        },
        child: Icon(Icons.group_add_outlined),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return SingleItemGroupWidget(onTap: () {
                      Navigator.pushNamed(context, PageConst.singleChatPage);
                    });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
