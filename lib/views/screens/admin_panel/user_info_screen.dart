import 'package:flutter/material.dart';
import 'package:imtihon3_clon/controllers/user_controller.dart';
import 'package:imtihon3_clon/models/user.dart';

import 'admin_panel.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final UserController _userController = UserController();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User info"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [Text("Menu")],
            )),
            ListTile(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminPanel(),
                  ),
                );
              },
              title: const Text("Admin Panel"),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>const UserInfoScreen(),
                  ),
                );
              },
              title: const Text("User Info"),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: _userController.getUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: Text("No Users"),
              );
            }
            final List<User>? data = snapshot.data;
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.blue),
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: ListTile(
                      title: Text(data[index].name),
                      subtitle:
                          Text(data[index].birthday.toString().split(" ")[0]),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
