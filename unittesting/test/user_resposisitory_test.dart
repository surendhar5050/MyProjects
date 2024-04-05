import 'package:counterapp_unittesting/user.dart';
import 'package:counterapp_unittesting/user_resposisitory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockTailaHttp extends Mock implements Client {}

void main() {
  late USerReposistory userResposisitory;
  late MockTailaHttp mockTailaHttp;

  setUp(() {
    mockTailaHttp = MockTailaHttp();
    userResposisitory = USerReposistory(mockTailaHttp);
  });

  group("User reposistory", () {
    group("get user Fiunction", () {
      test(
        'given UserRepository class when getUser function is called and status code is 200 then a usermodel should be returned',
        () async {
          // Arrange
          when(() => mockTailaHttp.get(
                Uri.parse('https://jsonplaceholder.typicode.com/users/1'),
              )).thenAnswer((invocation) async {
            return Response('''
         {
  "id": 1,
  "name": "Leanne Graham",
  "username": "Bret",
  "email": "Sincere@april.biz",
  "address": {
    "street": "Kulas Light",
    "suite": "Apt. 556",
    "city": "Gwenborough",
    "zipcode": "92998-3874",
    "geo": {
      "lat": "-37.3159",
      "lng": "81.1496"
    }
  },
  "phone": "1-770-736-8031 x56442",
  "website": "hildegard.org",
  "company": {
    "name": "Romaguera-Crona",
    "catchPhrase": "Multi-layered client-server neural-net",
    "bs": "harness real-time e-markets"
  }
}
            ''', 200);
          });
          // Act
          final user = await userResposisitory.getUSer();
          // Assert
          expect(user, isA<User>());
        },
      );

      test("when the user is fetched or not", () async {
        when(() => mockTailaHttp.get(
              Uri.parse('https://jsonplaceholder.typicode.com/users/1'),
            )).thenAnswer((invocation) async => Response("{}", 500));
        final user = userResposisitory.getUSer();

        expect(user, throwsException);
      });
    });
  });
}
