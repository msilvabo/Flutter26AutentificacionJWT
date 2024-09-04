import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static String apiURL = dotenv.env['API_URL'] ?? 'Variable no configurada';

  static initEnviroment() async {
    await dotenv.load(fileName: ".env");
  }
}
