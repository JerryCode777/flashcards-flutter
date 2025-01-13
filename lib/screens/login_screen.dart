// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart'; // Para reproducir video
import '../providers/auth_provider.dart';
import '../screens/home_screen.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  late VideoPlayerController _videoController;
  bool _videoInitialized = false;

  @override
  void initState() {
    super.initState();
    // 1. Inicializamos el controlador para reproducir un video local
    _videoController = VideoPlayerController.asset('assets/videos/mi_video.mp4')
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {
          _videoInitialized = true; // Ya está inicializado
        });
        _videoController.play(); // Iniciamos la reproducción en loop
      });
  }
  //prueba commit

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Sesión')),
      body: authProvider.isLoading
          ? Center(child: CircularProgressIndicator())
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
                          decoration: InputDecoration(labelText: 'Email'),
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
                          decoration: InputDecoration(labelText: 'Contraseña'),
                          obscureText: true,
                          onSaved: (val) => _password = val!.trim(),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Ingresa tu contraseña';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),

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
                                  SnackBar(
                                    content:
                                        Text('Error al iniciar sesión'),
                                  ),
                                );
                              }
                            }
                          },
                          child: Text('Ingresar'),
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
                          child: Text('¿No tienes cuenta? Regístrate'),
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
                          child: Text('¿Olvidaste tu contraseña?'),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40),

                  // -------------------
                  // VIDEO ABAJO DEL FORMULARIO
                  // -------------------
                  Container(
                    height: 200,           // Ajusta la altura que desees
                    width: double.infinity,
                    color: Colors.black12, // Simple fondo gris claro
                    child: _videoInitialized
                        ? FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: _videoController.value.size.width,
                              height: _videoController.value.size.height,
                              child: VideoPlayer(_videoController),
                            ),
                          )
                        : Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
    );
  }
}
