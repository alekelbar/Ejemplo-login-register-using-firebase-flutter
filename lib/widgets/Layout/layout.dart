import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Icon(Icons.app_registration),
                  Text(
                    ' registro',
                    style: TextStyle(color: Colors.pinkAccent, fontSize: 15),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).pushNamed("/");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Icon(Icons.login),
                  Text(
                    ' Login',
                    style: TextStyle(color: Colors.pinkAccent, fontSize: 15),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).pushNamed("/login");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Icon(Icons.list),
                  Text(
                    ' Nombres',
                    style: TextStyle(color: Colors.pinkAccent, fontSize: 15),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).pushNamed("/listOfNames");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Icon(Icons.list),
                  Text(
                    ' Random',
                    style: TextStyle(color: Colors.pinkAccent, fontSize: 15),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).pushNamed("/listOfRandom");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Icon(Icons.list),
                  Text(
                    ' students',
                    style: TextStyle(color: Colors.pinkAccent, fontSize: 15),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).pushNamed("/listOfStudents");
              },
            ),
          ),
        ],
      ),
    );
  }
}
