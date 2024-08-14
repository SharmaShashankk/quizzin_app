class QuizQuestionModel {
  final int questionId;
  final String questionImage;
  final String text;
  final String difficultyLevel;
  final List<dynamic> options;
  final String correctAnswer;
  final int correctAnswerIndex;
  final String quizLevel;
  final int quizCoin;
  final int questionCorrectAccuracy;
  final int chapterId;
  bool isSelected;

  QuizQuestionModel({
    required this.questionId,
    required this.questionImage,
    required this.text,
    required this.difficultyLevel,
    required this.options,
    required this.correctAnswer,
    required this.correctAnswerIndex,
    required this.quizLevel,
    required this.quizCoin,
    required this.questionCorrectAccuracy,
    required this.chapterId,
    required this.isSelected,
  });
  dynamic operator [](String key) {
    switch (key) {
      case 'questionId':
        return questionId;
      case 'question_image':
        return questionImage;
      case 'text':
        return text;
      case 'difficulty_level':
        return difficultyLevel;
      case 'options':
        return options;
      case 'correctAnswer':
        return correctAnswer;
      case 'correctAnswerIndex':
        return correctAnswerIndex;
      case 'quiz_level':
        return quizLevel;
      case 'quiz_coin':
        return quizCoin;
      case 'question_correct_accuracy':
        return questionCorrectAccuracy;
      case 'chapter_id':
        return chapterId;
      case 'isSelected':
        return isSelected;
      default:
        throw ArgumentError('Invalid property key: $key');
    }
  }
}

