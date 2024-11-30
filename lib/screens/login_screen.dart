import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/api_client.dart';

final apiClient = ApiClient();

class LoginScreen extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginScreen({super.key});

  void login(BuildContext context) async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (kDebugMode) {
      print('>>> username: $username');
      print('>>> password: $password');
    }

    try {
      final response = await apiClient.dio.post('authenticate',
          data: {
            'username': username,
            'password': password,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
      final token = response.data['access_token'];

      if (kDebugMode) {
        print('>>> token: $token');
      }

      apiClient.setToken(token);
      context.go('/home');
    } catch (e) {
      if (kDebugMode) {
        print('>>> ERROR: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de autenticación')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Usuario'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () => login(context),
              child: Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
