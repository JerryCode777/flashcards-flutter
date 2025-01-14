import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/flashcard.dart';
import '../providers/flashcard_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEditFlashcardScreen extends StatefulWidget {
  final Flashcard? flashcard;

  const AddEditFlashcardScreen({Key? key, this.flashcard}) : super(key: key);

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
        title: Text(
          _isEditing ? 'Editar Flashcard' : 'Añadir Flashcard',
          style: GoogleFonts.lobster(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 4, 8, 17),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Campo de Pregunta
              Text(
                'Pregunta:',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: _question,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Ingresa la pregunta...',
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
              const SizedBox(height: 20),
              // Campo de Respuesta
              Text(
                'Respuesta:',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: _answer,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Ingresa la respuesta...',
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
              const SizedBox(height: 30),
              // Botón Guardar
              Center(
                child: ElevatedButton(
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 4, 8, 17),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50.0,
                      vertical: 15.0,
                    ),
                  ),
                  child: Text(
                    'Guardar',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
