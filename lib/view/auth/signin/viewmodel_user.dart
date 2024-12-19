import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model_user.dart';

/*class SignInViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<LoginResponse?> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final response = await http.post(
      Uri.parse('https://lolifashion.social/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    _isLoading = false;
    notifyListeners();

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return LoginResponse.fromJson(data);
    } else {
      throw Exception('Failed to login');
    }
  }
}*/

class SignInViewModel {
  final _isLoading = BehaviorSubject<bool>.seeded(false);
  final _errorMessage = BehaviorSubject<String?>.seeded(null);
  final _user = BehaviorSubject<User?>.seeded(null);

  Stream<bool> get isLoading => _isLoading.stream;
  Stream<String?> get errorMessage => _errorMessage.stream;
  Stream<User?> get user => _user.stream;

  Future<void> signIn(String email, String password) async {
    _isLoading.add(true);
    _errorMessage.add(null);

    try {
      final response = await http.post(
        Uri.parse('https://lolifashion.social/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          final user = User.fromJson(responseData['user']);
          _user.add(user);
          await saveCurrentUser(user);
        } else {
          _errorMessage.add(responseData['message'] ?? 'Unknown error occurred.');
        }
      } else {
        _errorMessage.add('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      _errorMessage.add('An unexpected error occurred: $e');
    } finally {
      _isLoading.add(false);
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentUser');
    _user.add(null);
  }

  Future<void> saveCurrentUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString('currentUser', userJson);
  }

  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('currentUser');
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  void dispose() {
    _isLoading.close();
    _errorMessage.close();
    _user.close();
  }
}