import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ValidationScreen extends StatefulWidget {
  @override
  _ValidationScreenState createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  final _passwordController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;

  bool _isStrongPassword(String password) {
    final regex =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[-!@#\$&*~]).{8,}$');
    return regex.hasMatch(password);
  }

  Future<void> _validatePassword() async {
    final password = _passwordController.text;

    if (!_isStrongPassword(password)) {
      setState(() {
        _errorMessage = 'A senha não atende aos critérios de segurança.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final message = await ApiService.validatePassword(password);
      Navigator.pushNamed(context, '/success', arguments: message);
    } catch (e) {
      setState(
          () => _errorMessage = 'Erro ao validar a senha. Tente novamente.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Validação de Senha'),
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _passwordController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator(color: Colors.blue)
                : ElevatedButton(
                    onPressed: _validatePassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Text('Validar'),
                  ),
          ],
        ),
      ),
    );
  }
}
