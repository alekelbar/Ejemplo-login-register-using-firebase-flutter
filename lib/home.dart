import 'package:flutter/material.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key, required this.component}) : super(key: key);

  final Widget component;

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  late final Widget component;

  @override
  void initState() {
    super.initState();
    component = widget.component;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejemplo de firebase')),
      drawer: Drawer(
        elevation: 10,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: const Text(
                  'ir a la ventana de login',
                  style: TextStyle(color: Colors.pinkAccent, fontSize: 15),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed("/login");
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: const Text(
                  'ir a la ventana de registro',
                  style: TextStyle(color: Colors.pinkAccent, fontSize: 15),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed("/");
                },
              ),
            ),
          ],
        ),
      ),
      body: component,
    );
  }
}
