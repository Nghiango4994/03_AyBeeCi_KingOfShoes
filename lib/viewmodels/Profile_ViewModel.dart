import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:kingofshoes/models/thong_tin.dart';
import 'package:kingofshoes/views/widgets/Provider.dart';
import 'package:provider/provider.dart';

class ProfileViewModel {
  ThongTin? user;

  Future<void> updateUserData(ThongTin updatedUser) async {
    final response = await http.put(
      Uri.parse('${Providers.Url}/thong-tin/${updatedUser.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedUser.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user data');
    }
  }
}
