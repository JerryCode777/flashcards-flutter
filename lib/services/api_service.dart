// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/flashcard.dart';
import '../models/user.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:3000';

  // -----------------------------
  // Autenticación (igual que antes)
  // -----------------------------
  static Future<User> register(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "username": username,
        "email": email,
        "password": password
      }),
    );
    if (response.statusCode == 201) {
      return User(
        username: username,
        email: email,
        token: '', // tu backend no envía token al registrarse
      );
    } else {
      throw Exception('Error al registrar usuario: ${response.body}');
    }
  }

  static Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Suponiendo que tu backend devuelve un JSON con: { "token": "...", "username": "...", ... }
      return User(
        username: data['username'] ?? '',
        email: email,
        token: data['token'] ?? '',
      );
    } else {
      throw Exception('Error al iniciar sesión: ${response.body}');
    }
  }

  // -----------------------------
  // Flashcards
  // -----------------------------

  // 1) Obtener flashcards
  static Future<List<Flashcard>> fetchFlashcards({required String token}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/flashcards'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as List;
      // Asegúrate que Flashcard.fromJson asigne id: json['id'] 
      return body.map((jsonItem) => Flashcard.fromJson(jsonItem)).toList();
    } else {
      throw Exception('Error al cargar las flashcards: ${response.body}');
    }
  }

  // 2) Crear flashcard
  static Future<Flashcard> createFlashcard(
    Flashcard flashcard, {
    required String token,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/flashcards'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(flashcard.toJson()), 
    );

    if (response.statusCode == 201) {
      // Tu backend (en Go) devuelve algo así:
      // {
      //   "message": "Flashcard creada correctamente",
      //   "flashcard": {
      //     "id": 123,
      //     "question": "...",
      //     "answer": "...",
      //   }
      // }
      final data = jsonDecode(response.body);
      final created = data['flashcard'];
      return Flashcard(
        id: created['id'],             // <---- ASIGNAMOS id
        question: created['question'],
        answer: created['answer'],
      );
    } else {
      throw Exception('Error al crear la flashcard: ${response.body}');
    }
  }

  // 3) Actualizar flashcard
  static Future<void> updateFlashcard(
    Flashcard flashcard, {
    required String token,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/flashcards/${flashcard.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(flashcard.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar la flashcard: ${response.body}');
    }
  }

  // 4) Eliminar flashcard
  static Future<void> deleteFlashcard(
    int id, {
    required String token,
  }) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/flashcards/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar la flashcard: ${response.body}');
    }
  }
}
