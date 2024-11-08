import 'package:flutter/material.dart';

import '../widgets/container_button_widget.dart';
import '../widgets/text_container_widget.dart';
import '../widgets/theme/style.dart';

class CreateNewGroupPage extends StatefulWidget {
  const CreateNewGroupPage({super.key});

  @override
  State<CreateNewGroupPage> createState() => _CreateNewGroupPageState();
}

class _CreateNewGroupPageState extends State<CreateNewGroupPage> {
  TextEditingController _groupnameController = TextEditingController();
  TextEditingController _usersController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _groupnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create New Group'),
          leading: Icon(Icons.arrow_back),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                height: 62,
                width: 62,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(62)),
                child: Image.asset('assets/profile_default.png'),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Add Group image',
                style: TextStyle(
                    color: greenColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              TextFieldContainer(
                controller: _groupnameController,
                hintText: 'group name',
                prefixIcon: Icons.group_add_rounded,
              ),
              SizedBox(
                height: 10,
              ),
              TextFieldContainer(
                hintText: 'number of users join group',
                prefixIcon: Icons.menu,
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1.50,
              ),
              SizedBox(
                height: 10,
              ),
              ContainerButtonWidget(
                  title: 'Create New Group',
                  onTap: () {
                    print('Create New Group');
                  }),
              SizedBox(
                height: 10,
              ),
              _rowDataWidget(),
            ],
          ),
        ));
  }

  Widget _rowDataWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'By clicking Create New Group, you agree to the',
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w700, color: colorC1C1C1),
        ),
        Text(
          'Privacy Policy',
          style: TextStyle(
              color: greenColor, fontSize: 12, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
