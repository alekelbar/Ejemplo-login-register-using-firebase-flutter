import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/models/auth_session_model.dart';
import 'package:login_firebase/widgets/Layout/layout.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email =
      TextEditingController(text: 'alekelbar@gmail.com');
  final TextEditingController _password =
      TextEditingController(text: 'alex1234');

  String? _loginState;

  final fireAuth = FirebaseAuth.instance;

  void showAlert(String text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(text),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.check))
            ],
          );
        });
  }

  void setUser(UserCredential user) {
    context.read<AuthSessionModel>().setUser(user);
    User? myUser = context.read<AuthSessionModel>().getUser();
    if (myUser != null) {
      _loginState = myUser.email!;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AuthSessionModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Ejemplo de firebase')),
      drawer: const MyDrawer(),
      body: Center(
        child: Form(
          key: _formKey,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El campo es requerido';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Correo',
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _password,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El campo es requerido';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              try {
                                UserCredential userCredentials =
                                    await fireAuth.signInWithEmailAndPassword(
                                        email: _email.text,
                                        password: _password.text);

                                setState(() {
                                  _loginState =
                                      userCredentials.user!.displayName ??
                                          'Logeado';
                                });

                                setUser(userCredentials);
                              } on FirebaseException catch (_) {
                                setState(() {
                                  _loginState =
                                      'Sus credenciales no son correctas';
                                });
                              }
                              showAlert(_loginState ?? "");
                              return;
                            }
                          },
                          child: const Icon(
                            Icons.app_registration_rounded,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
