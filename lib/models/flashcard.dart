// lib/models/flashcard.dart
class Flashcard {
  final int? id;
  final String question;
  final String answer;

  Flashcard({
    this.id,
    required this.question,
    required this.answer,
  });

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      id: json['id'],                // Asegurarnos de leer "id"
      question: json['question'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
      // 'id': id, // Normalmente no mandas id en POST, a menos que tu backend lo requiera
    };
  }
}
