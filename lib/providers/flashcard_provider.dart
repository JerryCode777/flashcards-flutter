// lib/providers/flashcard_provider.dart
import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../services/api_service.dart';
import 'auth_provider.dart';

class FlashcardProvider with ChangeNotifier {
  List<Flashcard> _flashcards = [];
  bool isLoading = false;

  final AuthProvider authProvider; // Recibe instancia de AuthProvider

  FlashcardProvider(this.authProvider);

  List<Flashcard> get flashcards => _flashcards;

  Future<void> fetchFlashcards() async {
    // Si no hay usuario, salimos
    if (authProvider.user == null) return;

    final token = authProvider.user!.token;
    isLoading = true;
    notifyListeners(); 

    try {
      _flashcards = await ApiService.fetchFlashcards(token: token);
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addFlashcard(Flashcard flashcard) async {
    if (authProvider.user == null) return;
    final token = authProvider.user!.token;
    try {
      Flashcard newFlashcard =
          await ApiService.createFlashcard(flashcard, token: token);
      _flashcards.add(newFlashcard);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateFlashcard(Flashcard flashcard) async {
    if (authProvider.user == null) return;
    final token = authProvider.user!.token;
    try {
      await ApiService.updateFlashcard(flashcard, token: token);
      int index = _flashcards.indexWhere((fc) => fc.id == flashcard.id);
      if (index != -1) {
        _flashcards[index] = flashcard;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteFlashcard(int id) async {
    if (authProvider.user == null) return;
    final token = authProvider.user!.token;
    try {
      await ApiService.deleteFlashcard(id, token: token);
      _flashcards.removeWhere((fc) => fc.id == id);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
