// lib/screens/forgot_password_screen.dart
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  bool _isLoading = false;
  String? _message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recuperar Contraseña')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  if (_message != null) 
                    Text(
                      _message!,
                      style: TextStyle(color: Colors.green),
                      textAlign: TextAlign.center,
                    ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      onSaved: (val) => _email = val!.trim(),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Ingresa tu email';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        setState(() => _isLoading = true);

                        // 1. Llamamos a un método que haga la petición POST /forgot-password
                        try {
                          // Por ejemplo:
                          // await ApiService.forgotPassword(_email);
                          await Future.delayed(Duration(seconds: 2)); // Simular HTTP

                          // 2. Mostramos mensaje de éxito
                          setState(() {
                            _message =
                                'Si el email está registrado, recibirás un enlace de recuperación.';
                          });
                        } catch (e) {
                          // 3. Manejar error
                          setState(() {
                            _message = 'Error al solicitar recuperación de contraseña.';
                          });
                        } finally {
                          setState(() => _isLoading = false);
                        }
                      }
                    },
                    child: Text('Enviar Instrucciones'),
                  ),
                ],
              ),
      ),
    );
  }
}
