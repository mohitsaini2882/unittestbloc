import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserRepository {
  Future<User> fetchUser(int id) async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users/$id'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      User user = User.fromJson(json['data']);
      print("User: ${user.toString()}");
      return User.fromJson(json['data']);
    } else {
      throw Exception('Failed to load user');
    }
  }
}
