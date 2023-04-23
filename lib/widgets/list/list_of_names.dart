import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/models/auth_session_model.dart';
import 'package:login_firebase/widgets/Layout/layout.dart';
import 'package:provider/provider.dart';

class ListOfNames extends StatefulWidget {
  const ListOfNames({Key? key}) : super(key: key);

  @override
  State<ListOfNames> createState() => _ListOfNamesState();
}

class _ListOfNamesState extends State<ListOfNames> {
  final List<String> myList = ['Pan', 'Con', 'Jamon', 'Y', 'Queso'];

  @override
  Widget build(BuildContext context) {
    User? user = context.read<AuthSessionModel>().getUser();
    String? userEmail;

    if (user != null) {
      userEmail = user.email!;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Ejemplo de firebase')),
      drawer: const MyDrawer(),
      body: userEmail == null
          ? const Center(
              child: Text(
                'Inicie sesión',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.green,
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    userEmail,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.green,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: myList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(myList[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
