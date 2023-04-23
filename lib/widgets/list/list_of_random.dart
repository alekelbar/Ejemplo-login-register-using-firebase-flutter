import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/models/auth_session_model.dart';
import 'package:login_firebase/widgets/Layout/layout.dart';
import 'package:provider/provider.dart';

class ListOfRandom extends StatefulWidget {
  const ListOfRandom({Key? key}) : super(key: key);

  @override
  State<ListOfRandom> createState() => _ListOfRandomState();
}

class _ListOfRandomState extends State<ListOfRandom> {
  List<num> myList = [];
  final random = Random();

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
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        myList.add(random.nextInt(100));
                      });
                    },
                    child: const Icon(Icons.add)),
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
                        title: Text(myList[index].toString()),
                        style: ListTileStyle.list,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
