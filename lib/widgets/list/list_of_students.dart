import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:login_firebase/models/auth_session_model.dart';
import 'package:login_firebase/models/student.dart';
import 'package:login_firebase/widgets/Layout/layout.dart';
import 'package:provider/provider.dart';

class ListOfMortys extends StatefulWidget {
  const ListOfMortys({Key? key}) : super(key: key);

  @override
  State<ListOfMortys> createState() => _ListOfMortysState();
}

class _ListOfMortysState extends State<ListOfMortys> {
  final db = FirebaseFirestore.instance;
  final List<Student> _students = [];

  Future<void> getStudents() async {
    final collection = db.collection('usuarios');
    final snapshot = await collection.get();

    snapshot.docs.forEach((doc) {
      final student = Student.fromJson(doc.data());
      _students.add(student);
    });

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStudents();
  }

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
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: _students.length,
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, .5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            Text(
                              '${_students[index].name}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontStyle: FontStyle.normal),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${_students[index].career}',
                              style: const TextStyle(
                                  color: Colors.white38,
                                  fontSize: 10,
                                  fontStyle: FontStyle.normal),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${_students[index].course}',
                              style: const TextStyle(
                                  color: Colors.white38,
                                  fontSize: 10,
                                  fontStyle: FontStyle.normal),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${_students[index].profesor}',
                              style: const TextStyle(
                                  color: Colors.white38,
                                  fontSize: 10,
                                  fontStyle: FontStyle.normal),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
