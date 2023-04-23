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
        children: const [
          DrawerElement(
            title: '',
            route: '/',
            icon: Icon(Icons.app_registration),
          ),
          DrawerElement(
            title: 'Login',
            route: '/login',
            icon: Icon(Icons.login),
          ),
          DrawerElement(
            title: 'Nombres',
            route: '/listOfNames',
            icon: Icon(Icons.list),
          ),
          DrawerElement(
            title: 'Random',
            route: '/listOfRandom',
            icon: Icon(Icons.list),
          ),
          DrawerElement(
            title: 'students',
            route: '/listOfStudents',
            icon: Icon(Icons.list),
          ),
        ],
      ),
    );
  }
}

class DrawerElement extends StatelessWidget {
  const DrawerElement({
    super.key,
    required this.title,
    required this.route,
    required this.icon,
  });

  final Icon icon;
  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon,
            Text(
              ' $title',
              style: const TextStyle(color: Colors.pinkAccent, fontSize: 15),
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).pushNamed(route);
        },
      ),
    );
  }
}
