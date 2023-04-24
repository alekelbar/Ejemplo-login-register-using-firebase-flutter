import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/firebase_options.dart';
import 'package:login_firebase/models/auth_session_model.dart';
import 'package:login_firebase/widgets/auth/login.dart';
import 'package:login_firebase/widgets/auth/register_page.dart';
import 'package:login_firebase/widgets/list/list_of_students.dart';
import 'package:login_firebase/widgets/list/list_of_names.dart';
import 'package:login_firebase/widgets/list/list_of_random.dart';
import 'package:login_firebase/widgets/list/pokemon_api.dart';
import 'package:provider/provider.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AuthSessionModel(),
      ),
    ],
    child: Consumer<AuthSessionModel>(
      builder: (_, value, child) {
        return MyApp();
      },
    ),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Map<String, WidgetBuilder> routes = {
    '/': (BuildContext context) => const RegisterPage(title: 'Register'),
    '/login': (BuildContext context) => const LoginPage(),
    '/listOfNames': (context) => const ListOfNames(),
    '/listOfRandom': (context) => const ListOfRandom(),
    '/listOfStudents': (context) => const ListOfMortys(),
    '/listOfPokemon': (context) => const PokemonPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: routes,
    );
  }
}
