// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/flashcard.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:3000/flashcards';

  // Obtener todas las flashcards
  static Future<List<Flashcard>> fetchFlashcards() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((json) => Flashcard.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar las flashcards');
    }
  }

  // Crear una nueva flashcard
  static Future<Flashcard> createFlashcard(Flashcard flashcard) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(flashcard.toJson()),
    );
    if (response.statusCode == 201) {
      return Flashcard.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al crear la flashcard');
    }
  }

  // Actualizar una flashcard existente
  static Future<void> updateFlashcard(Flashcard flashcard) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${flashcard.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(flashcard.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar la flashcard');
    }
  }

  // Eliminar una flashcard
  static Future<void> deleteFlashcard(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar la flashcard');
    }
  }
}
