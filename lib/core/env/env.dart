import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  Env._();
  //TODO: create .env file and put this line OPENAI_API_KEY="your key"
  static String get openAiApiKey => dotenv.env['OPENAI_API_KEY'] ?? '';
}
