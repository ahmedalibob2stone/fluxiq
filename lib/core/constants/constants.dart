import 'package:flutter_dotenv/flutter_dotenv.dart';
class AppConstants {
  final String apiKey = dotenv.env['NEWS_API_KEY'] ?? '';
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  static const List<String> publishCategories = [
    'World',
    'Technology',
    'Business',
    'Sports',
    'Science',
    'Health',
  ];
}