// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flashcard_provider.dart';
import '../providers/auth_provider.dart';  // <-- Importamos el AuthProvider
import '../widgets/flashcard_widget.dart';
import 'add_edit_flashcard_screen.dart';
import 'login_screen.dart';  // <-- Importa tu pantalla de login (o la que quieras redirigir)
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // Llamar a fetchFlashcards después de que se monte el widget (post-frame callback):
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final flashcardProvider =
          Provider.of<FlashcardProvider>(context, listen: false);
      flashcardProvider.fetchFlashcards();
    });
  }

  @override
  Widget build(BuildContext context) {
    final flashcardProvider = Provider.of<FlashcardProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'English FlashCards',
          style: GoogleFonts.lobster(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 4, 8, 17),

        // Botón de Cerrar Sesión
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar Sesión',
            onPressed: () async {
              // Mostramos un diálogo de confirmación antes de cerrar sesión
              bool? confirm = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Confirmar Cierre de Sesión'),
                  content: const Text(
                      '¿Estás seguro de que deseas cerrar tu sesión?'),
                  actions: [
                    TextButton(
                      child: const Text('Cancelar'),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                    TextButton(
                      child: const Text('Cerrar Sesión'),
                      onPressed: () => Navigator.pop(context, true),
                    ),
                  ],
                ),
              );

              // Si el usuario confirmó, hacemos logout
              if (confirm == true) {
                authProvider.logout();
                // Navegamos a la pantalla de login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                );
              }
            },
          ),
        ],
      ),
      body: flashcardProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : flashcardProvider.flashcards.isEmpty
              ? const Center(child: Text('No hay flashcards disponibles.'))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: flashcardProvider.flashcards.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 800
                              ? 3
                              : MediaQuery.of(context).size.width > 450
                                  ? 2
                                  : 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3 / 2,
                    ),
                    itemBuilder: (context, index) {
                      final flashcard = flashcardProvider.flashcards[index];
                      return FlashcardWidget(flashcard: flashcard);
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la pantalla de añadir flashcard
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditFlashcardScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 4, 8, 17),
      ),
    );
  }
}
