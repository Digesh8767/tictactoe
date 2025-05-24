import 'package:flutter/material.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/responsive/responsive.dart';
import 'package:tictactoe/widgets/custom_button.dart';
import 'package:tictactoe/widgets/custom_texfield.dart';
import 'package:tictactoe/widgets/custom_text.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccuredListender(context);
    _socketMethods.updatePlayersStateListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _idController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        child: ListView(children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  shadows: [
                    Shadow(
                      blurRadius: 40,
                      color: Colors.blue,
                    )
                  ],
                  text: "Join \nRoom",
                  fontSize: 70,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                CustomTexfield(
                  controller: _nameController,
                  hintText: "Enter your nickname",
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTexfield(
                  controller: _idController,
                  hintText: "Enter Game ID",
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onTap: () => _socketMethods.joinRoom(
                    _nameController.text,
                    _idController.text,
                  ),
                  text: 'Join',
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
