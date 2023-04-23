import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_firebase/widgets/Layout/layout.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title});
  final String title;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email =
      TextEditingController(text: 'alekelbar@gmail.com');
  final TextEditingController _password =
      TextEditingController(text: 'alex1234');
  final TextEditingController _confirmPassword =
      TextEditingController(text: 'alex1234');

  String _loginState = "Registrarse";

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

  @override
  Widget build(BuildContext context) {
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
                Card(
                  elevation: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _confirmPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El campo es requerido';
                        }

                        if (value != _password.text) {
                          return 'Las contraseñas no coinciden';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'confirm password',
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
                                UserCredential userCredentials = await fireAuth
                                    .createUserWithEmailAndPassword(
                                        email: _email.text,
                                        password: _password.text);

                                setState(() {
                                  _loginState =
                                      userCredentials.user!.displayName ??
                                          'Registrado';
                                });
                              } on FirebaseException catch (e) {
                                if (e.code == 'weak-password') {
                                  // Contraseña débil
                                  setState(() {
                                    _loginState = 'contraseña muy debil';
                                  });
                                } else if (e.code == 'email-already-in-use') {
                                  setState(() {
                                    _loginState = 'Ya se encuentra registrado';
                                  });
                                }
                              }
                              showAlert(_loginState);

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
