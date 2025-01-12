// lib/widgets/flashcard_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/flashcard.dart';
import '../providers/flashcard_provider.dart';
import '../screens/add_edit_flashcard_screen.dart';
import 'package:flutter_tts/flutter_tts.dart';


class FlashcardWidget extends StatefulWidget {
  final Flashcard flashcard;

  FlashcardWidget({required this.flashcard});

  @override
  _FlashcardWidgetState createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends State<FlashcardWidget> {
  bool _showAnswer = false;
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void dispose() {
    _flutterTts.stop(); // Detener el TTS cuando el widget se destruya
    super.dispose();
  }

  void _speak(String text) async {
    await _flutterTts.speak(text); // Función para leer el texto
  }

  @override
  Widget build(BuildContext context) {
    final flashcardProvider =
        Provider.of<FlashcardProvider>(context, listen: false);

    return Card(
      elevation: 4,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Pregunta
            Text(
              widget.flashcard.question,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            // Respuesta
            if (_showAnswer)
              Text(
                widget.flashcard.answer,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.justify,
              ),
            Spacer(),
            // Botones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Mostrar/Ocultar Respuesta
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _showAnswer = !_showAnswer;
                    });
                  },
                  icon: Icon(
                    _showAnswer
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: const Color.fromARGB(255, 62, 191, 255),
                  ),
                  label: Text(
                    _showAnswer ? 'Ocultar' : 'Mostrar',
                    style: TextStyle(color: const Color.fromARGB(255, 62, 191, 255)),
                  ),
                ),
                //boton de audio
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.volumeUp,
                    color: const Color.fromARGB(255, 62, 191, 255),
                  ),
                  onPressed: () {
                    if (_showAnswer) {
                      _speak(widget.flashcard.answer);
                    } else {
                      _speak(widget.flashcard.question);
                    }
                  },
                ),
                // Editar y Eliminar
                Row(
                  children: [
                    // Editar
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.penToSquare,
                        color: const Color.fromARGB(255, 76, 152, 175),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditFlashcardScreen(
                              flashcard: widget.flashcard,
                            ),
                          ),
                        );
                      },
                    ),
                    // Eliminar
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.trashCan,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        // Confirmar eliminación
                        bool? confirm = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Confirmar Eliminación'),
                            content: Text(
                                '¿Estás seguro de que deseas eliminar esta flashcard?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: Text('Eliminar'),
                              ),
                            ],
                          ),
                        );
                        if (confirm != null && confirm) {
                          await flashcardProvider
                              .deleteFlashcard(widget.flashcard.id!);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
