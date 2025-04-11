import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  final String apiKey = "AIzaSyC14pG0_aDN9jzqyJOVJyzKvBW2ensyk7I"; // 🔴 Replace with your API Key
  final String apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=";

  Future<String> askGemini(String query) async {
    final Uri url = Uri.parse(apiUrl + apiKey);

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "prompt": {"text": query},
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['candidates'][0]['output']; // Extract response text
    } else {
      return "Sorry, I couldn't fetch a response.";
    }
  }
}
