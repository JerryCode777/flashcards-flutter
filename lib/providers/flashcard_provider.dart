// lib/providers/flashcard_provider.dart
import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../services/api_service.dart';

class FlashcardProvider with ChangeNotifier {
  List<Flashcard> _flashcards = [];
  bool isLoading = false;

  List<Flashcard> get flashcards => _flashcards;

  FlashcardProvider() {
    fetchFlashcards();
  }

  Future<void> fetchFlashcards() async {
    isLoading = true;
    notifyListeners();
    try {
      _flashcards = await ApiService.fetchFlashcards();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addFlashcard(Flashcard flashcard) async {
    try {
      Flashcard newFlashcard = await ApiService.createFlashcard(flashcard);
      _flashcards.add(newFlashcard);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateFlashcard(Flashcard flashcard) async {
    try {
      await ApiService.updateFlashcard(flashcard);
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
    try {
      await ApiService.deleteFlashcard(id);
      _flashcards.removeWhere((fc) => fc.id == id);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
