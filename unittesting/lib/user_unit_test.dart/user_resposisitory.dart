import 'package:counterapp_unittesting/user.dart';
import 'package:http/http.dart' as http;

class USerReposistory {
  final http.Client client;

  USerReposistory(this.client);

  Future<User> getUSer() async {
    final response = await client
        .get(Uri.parse("https://jsonplaceholder.typicode.com/users/1"));

    if (response.statusCode == 200) {
      return userFromJson(response.body);
    } else {
      throw Exception("user not found");
    }
  }
}
