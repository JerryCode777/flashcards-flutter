// lib/screens/add_edit_flashcard_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/flashcard.dart';
import '../providers/flashcard_provider.dart';

class AddEditFlashcardScreen extends StatefulWidget {
  final Flashcard? flashcard;

  AddEditFlashcardScreen({this.flashcard});

  @override
  _AddEditFlashcardScreenState createState() => _AddEditFlashcardScreenState();
}

class _AddEditFlashcardScreenState extends State<AddEditFlashcardScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _question;
  late String _answer;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.flashcard != null) {
      _isEditing = true;
      _question = widget.flashcard!.question;
      _answer = widget.flashcard!.answer;
    } else {
      _question = '';
      _answer = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final flashcardProvider =
        Provider.of<FlashcardProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Flashcard' : 'Añadir Flashcard'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Error Message
              Builder(
                builder: (context) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Los campos no pueden estar vacíos!',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              // Question Field
              TextFormField(
                initialValue: _question,
                decoration: InputDecoration(
                  labelText: 'Pregunta:',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
                onSaved: (value) {
                  _question = value!.trim();
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa una pregunta.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Answer Field
              TextFormField(
                initialValue: _answer,
                decoration: InputDecoration(
                  labelText: 'Respuesta:',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                onSaved: (value) {
                  _answer = value!.trim();
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa una respuesta.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Save Button
              // Después
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (_isEditing) {
                      // Actualizar flashcard
                      Flashcard updatedFlashcard = Flashcard(
                        id: widget.flashcard!.id,
                        question: _question,
                        answer: _answer,
                      );
                      await flashcardProvider.updateFlashcard(updatedFlashcard);
                    } else {
                      // Crear nueva flashcard
                      Flashcard newFlashcard = Flashcard(
                        question: _question,
                        answer: _answer,
                      );
                      await flashcardProvider.addFlashcard(newFlashcard);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text('Guardar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Corrección aquí
                  padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
