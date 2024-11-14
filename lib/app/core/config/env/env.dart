// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_dotenv/flutter_dotenv.dart';

sealed class Env {
  static Future<void> load() => dotenv.load();
  static get baseII => dotenv.get('backend_base_url');
  String? operator [](String key) => dotenv.env[key];
}
