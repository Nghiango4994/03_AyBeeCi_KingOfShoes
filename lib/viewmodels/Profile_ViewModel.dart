import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kingofshoes/models/thong_tin.dart';
import 'package:kingofshoes/views/widgets/Provider.dart';

class ProfileViewModel {
  ThongTin? user;

  Future<void> loadUserData() async {
    final response = await http.get(Uri.parse('https://api.example.com/user'));
    if (response.statusCode == 200) {
      user = ThongTin.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user data');
    }
  }

  Future<void> updateUserData(ThongTin updatedUser) async {
    final response = await http.put(
      Uri.parse('https://api.example.com/user/${updatedUser.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedUser.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user data');
    }
  }
}
