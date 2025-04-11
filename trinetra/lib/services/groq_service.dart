import 'dart:convert';
import 'package:http/http.dart' as http;

class GroqService {
  final String apiKey = "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"; // Replace with your API key
  final String apiUrl = "https://api.groq.com/openai/v1/chat/completions";

  Future<String> askAI(String message) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "model": "llama3-8b-8192", // Free AI model from Groq
          "messages": [
            {"role": "system", "content": "You are a fitness and diet expert."},
            {"role": "user", "content": message},
          ],
          "temperature": 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse["choices"][0]["message"]["content"].trim();
      } else {
        return "Error: ${response.statusCode} - ${response.body}";
      }
    } catch (e) {
      return "Error connecting to AI.";
    }
  }
}
