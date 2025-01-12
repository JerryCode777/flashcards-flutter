// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/flashcard_provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(FlashcardApp());
}

class FlashcardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, FlashcardProvider>(
          create: (_) => FlashcardProvider(Provider.of<AuthProvider>(_, listen: false)),
          update: (ctx, authProvider, previousFlashcardProvider) =>
              FlashcardProvider(authProvider),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flashcard App',
        home: AuthOrHomeScreen(),
      ),
    );
  }
}

// Esta pantalla decide si muestra HomeScreen o LoginScreen
class AuthOrHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.isLoggedIn) {
      return HomeScreen();
    } else {
      return LoginScreen();
    }
  }
}
