// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../screens/home_screen.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';
import 'privacy_policy_screen.dart'; // Asegúrate de importar la pantalla de política de privacidad
import 'terms_conditions_screen.dart'; // Asegúrate de importar la pantalla de términos y condiciones

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      body: authProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // -------------------
                  // FORMULARIO
                  // -------------------
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Email
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Email'),
                          onSaved: (val) => _email = val!.trim(),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Ingresa tu email';
                            }
                            return null;
                          },
                        ),
                        // Contraseña
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Contraseña'),
                          obscureText: true,
                          onSaved: (val) => _password = val!.trim(),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Ingresa tu contraseña';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Botón Ingresar
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              try {
                                await authProvider.login(_email, _password);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => HomeScreen(),
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Error al iniciar sesión'),
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text('Ingresar'),
                        ),

                        // Opción de registro
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RegisterScreen(),
                              ),
                            );
                          },
                          child: const Text('¿No tienes cuenta? Regístrate'),
                        ),

                        // ¿Olvidaste tu contraseña?
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ForgotPasswordScreen(),
                              ),
                            );
                          },
                          child: const Text('¿Olvidaste tu contraseña?'),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // -------------------
                  // POLÍTICA DE PRIVACIDAD Y TÉRMINOS
                  // -------------------
                  ListTile(
                    title: const Text("Política de Privacidad"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text("Términos y Condiciones"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TermsConditionsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
