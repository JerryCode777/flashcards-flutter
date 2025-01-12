// lib/screens/register_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Registrarse')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: authProvider.isLoading
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Usuario'),
                      onSaved: (val) => _username = val!,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Ingresa un nombre de usuario';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      onSaved: (val) => _email = val!,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Ingresa tu email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Contraseña'),
                      obscureText: true,
                      onSaved: (val) => _password = val!,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Ingresa tu contraseña';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          try {
                            await authProvider.register(_username, _email, _password);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Registro exitoso, ahora inicia sesión'),
                            ));
                            Navigator.pop(context); // Vuelve a LoginScreen
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Error al registrar usuario'),
                            ));
                          }
                        }
                      },
                      child: Text('Registrarse'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
