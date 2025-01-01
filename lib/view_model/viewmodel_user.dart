import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/model_user.dart';

class UserViewModel {
  final _isLoading = BehaviorSubject<bool>.seeded(false);
  final _errorMessage = BehaviorSubject<String?>.seeded(null);
  final _detailedErrors = BehaviorSubject<Map<String, List<String>>?>.seeded(null);
  final _successMessage = BehaviorSubject<String?>.seeded(null);
  final _user = BehaviorSubject<User?>.seeded(null);
  final _token = BehaviorSubject<String?>.seeded(null);

  Stream<bool> get isLoading => _isLoading.stream;
  Stream<String?> get errorMessage => _errorMessage.stream;
  Stream<Map<String, List<String>>?> get detailedErrors => _detailedErrors.stream;
  Stream<String?> get successMessage => _successMessage.stream;
  Stream<User?> get user => _user.stream;
  Stream<String?> get token => _token.stream;

  // SIGN IN
  Future<void> signIn(String email, String password) async {
    _isLoading.add(true);
    _errorMessage.add(null);
    _successMessage.add(null);
    _detailedErrors.add(null);

    try {
      //final prefs = await SharedPreferences.getInstance();
      //final token = prefs.getString('token');

      final response = await http.post(
        Uri.parse('https://lolifashion.social/api/login'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      final data = jsonDecode(response.body);
      final authResponse = AuthResponse.fromJson(data);

      if (authResponse.success == true) {
        final user = User.fromJson(data['user']);
        final token = data['token'];

        _user.add(user);
        await saveCurrentUser(user, token);
        _successMessage.add(authResponse.message);

        print('Token retrieved: $token');
      } else {
        if (authResponse.errors != null) {
          final parsedErrors = authResponse.errors!.map(
                (key, value) => MapEntry(key, List<String>.from(value as List)),
          );
          _detailedErrors.add(Map<String, List<String>>.from(parsedErrors));
        }
        _errorMessage.add(authResponse.message);
      }
    } catch (e) {
      _errorMessage.add('An unexpected error occurred: $e');
    } finally {
      _isLoading.add(false);
    }
  }

  // SIGN UP
  Future<void> signUp(String username, String email, String password, String confirmPassword) async {
    _isLoading.add(true);
    _errorMessage.add(null);
    _successMessage.add(null);
    _detailedErrors.add(null);

    try {
      final response = await http.post(
        Uri.parse('https://lolifashion.social/api/register'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
        }),
      );

      final data = jsonDecode(response.body);
      final authResponse = AuthResponse.fromJson(data);

      if (authResponse.success == true) {
        final user = User.fromJson(data['user']);
        final token = data['token'];
        _user.add(user);
        _token.add(token);
        await saveCurrentUser(user, token);
        _successMessage.add(authResponse.message);
      } else {
        if (authResponse.errors != null) {
          final parsedErrors = authResponse.errors!.map(
                (key, value) => MapEntry(key, List<String>.from(value as List)),
          );
          _detailedErrors.add(Map<String, List<String>>.from(parsedErrors));
        }
      }
    } catch (e) {
      _errorMessage.add('An unexpected error occurred: $e');
    } finally {
      _isLoading.add(false);
    }
  }

  // UPDATE PROFILE
  Future<void> updateUserProfile({required String username, required String email, String? phone, String? picture,}) async {
    _isLoading.add(true);
    _errorMessage.add(null);
    _successMessage.add(null);
    _detailedErrors.add(null);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        _errorMessage.add("User is not authenticated.");
        return;
      }

      final response = await http.put(
        Uri.parse('https://lolifashion.social/api/userprofile'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'username': username,
          'email': email,
          'phone': phone,
          'picture': picture,
        }),
      );

      final data = jsonDecode(response.body);
      final authResponse = AuthResponse.fromJson(data);

      if (authResponse.success == true) {
        final user = User.fromJson(data['user']);
        _user.add(user);
        await saveCurrentUser(user, token);
        _successMessage.add(authResponse.message);
      } else {
        if (authResponse.errors != null) {
          final parsedErrors = authResponse.errors!.map(
                (key, value) => MapEntry(key, List<String>.from(value as List)),
          );
          _detailedErrors.add(Map<String, List<String>>.from(parsedErrors));
        }
      }
    } catch (e) {
      _errorMessage.add('An unexpected error occurred: $e');
    } finally {
      _isLoading.add(false);
    }
  }

  // CHANGE PASSWORD
  Future<void> changePassword({required String password, required String newPassword, required String newPasswordConfirmation}) async {
    _isLoading.add(true);
    _errorMessage.add(null);
    _successMessage.add(null);
    _detailedErrors.add(null);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        _errorMessage.add("User is not authenticated.");
        return;
      }

      final response = await http.post(
        Uri.parse('https://lolifashion.social/api/changepassword'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'old_password': password,
          'new_password': newPassword,
          'new_password_confirmation': newPasswordConfirmation,
        }),
      );

      final data = jsonDecode(response.body);
      final authResponse = AuthResponse.fromJson(data);

      if (authResponse.success == true) {
        if (data['user'] != null) {
          final user = User.fromJson(data['user']);
          _user.add(user);
          await saveCurrentUser(user, token);
        }
        _successMessage.add(authResponse.message);
      } else {
        if (authResponse.errors != null) {
          final parsedErrors = authResponse.errors!.map(
                (key, value) => MapEntry(key, List<String>.from(value as List)),
          );
          _detailedErrors.add(Map<String, List<String>>.from(parsedErrors));
        } else {
          _errorMessage.add(authResponse.message);
        }
      }
    } catch (e) {
      _errorMessage.add('An unexpected error occurred: $e');
    } finally {
      _isLoading.add(false);
    }
  }

  // FORGET PASSWORD
  // REQUEST EMAIL
  Future<void> requestEmail(String email) async {
    _isLoading.add(true);
    _errorMessage.add(null);
    _successMessage.add(null);
    _detailedErrors.add(null);

    try {
      final response = await http.post(
        Uri.parse('https://lolifashion.social/api/password/request-reset-code'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': email}),
      );

      final data = jsonDecode(response.body);
      final authResponse = AuthResponse.fromJson(data);

      if (authResponse.success == true) {
        _successMessage.add(authResponse.message);
      } else {
        if (authResponse.errors != null) {
          final parsedErrors = authResponse.errors!.map(
                (key, value) => MapEntry(key, List<String>.from(value as List)),
          );
          _detailedErrors.add(Map<String, List<String>>.from(parsedErrors));
        }
        _errorMessage.add(authResponse.message);
      }
    } catch (e) {
      _errorMessage.add('An unexpected error occurred: $e');
    } finally {
      _isLoading.add(false);
    }
  }

  Future<void> requestOTP(String email, int code) async {
    _isLoading.add(true);
    _errorMessage.add(null);
    _successMessage.add(null);
    _detailedErrors.add(null);

    try {
      final response = await http.post(
        Uri.parse('https://lolifashion.social/api/password/verify-reset-code'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'code': code,
        }),
      );

      final data = jsonDecode(response.body);
      final authResponse = AuthResponse.fromJson(data);

      if (authResponse.success == true) {
        _successMessage.add(authResponse.message);
      } else {
        if (authResponse.errors != null) {
          final parsedErrors = authResponse.errors!.map(
                (key, value) => MapEntry(key, List<String>.from(value as List)),
          );
          _detailedErrors.add(Map<String, List<String>>.from(parsedErrors));
        }
        _errorMessage.add(authResponse.message);
      }
    } catch (e) {
      _errorMessage.add('An unexpected error occurred: $e');
    } finally {
      _isLoading.add(false);
    }
  }

  Future<void> resetPassword(String email, int code, String newPassword, String confirmNewPassword) async {
    _isLoading.add(true);
    _errorMessage.add(null);
    _successMessage.add(null);
    _detailedErrors.add(null);

    try {
      final response = await http.post(
        Uri.parse('https://lolifashion.social/api/password/reset-password'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'code': code,
          'password': newPassword,
          'password_confirmation': confirmNewPassword
        }),
      );

      final data = jsonDecode(response.body);
      final authResponse = AuthResponse.fromJson(data);

      if (authResponse.success == true) {
        _successMessage.add(authResponse.message);
      } else {
        if (authResponse.errors != null) {
          final parsedErrors = authResponse.errors!.map(
                (key, value) => MapEntry(key, List<String>.from(value as List)),
          );
          _detailedErrors.add(Map<String, List<String>>.from(parsedErrors));
        }
        _errorMessage.add(authResponse.message);
      }
    } catch (e) {
      _errorMessage.add('An unexpected error occurred: $e');
    } finally {
      _isLoading.add(false);
    }
  }

  // LOGOUT
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentUser');
    await prefs.remove('token');
    _user.add(null);
    _token.add(null);
  }

  Future<void> saveCurrentUser(User user, String token) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString('currentUser', userJson);
    await prefs.setString('token', token);
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
    _successMessage.close();
    _user.close();
    _token.close();
  }
}
