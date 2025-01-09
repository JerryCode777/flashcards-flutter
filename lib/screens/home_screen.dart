// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../providers/flashcard_provider.dart';
import '../widgets/flashcard_widget.dart';
import 'add_edit_flashcard_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final flashcardProvider = Provider.of<FlashcardProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcard App'),
        backgroundColor: Colors.green,
      ),
      body: flashcardProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : flashcardProvider.flashcards.isEmpty
              ? Center(child: Text('No hay flashcards disponibles.'))
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
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
