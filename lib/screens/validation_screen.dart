import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ValidationScreen extends StatefulWidget {
  @override
  _ValidationScreenState createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
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
      // Simulei a API, substitua com sua lógica real
      await Future.delayed(Duration(seconds: 2));
      Navigator.pushNamed(context, '/success', arguments: "Senha Válida!");
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
      body: Stack(
        children: [
          // GIF como fundo
          Positioned.fill(
            child: Image.asset(
              'assets/gifs/chuva.gif',
              fit: BoxFit.cover, // Cobre toda a tela
            ),
          ),
          // Conteúdo centralizado
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Título
                  Text(
                    'Desafio Flutter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  // Campo para Nome
                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: _nameController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Campo para Senha
                  SizedBox(
                    width: 250,
                    child: TextField(
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
                  ),
                  SizedBox(height: 20),
                  // Botão de Validação
                  if (_isLoading)
                    CircularProgressIndicator(color: Colors.blue)
                  else
                    ElevatedButton(
                      onPressed: _validatePassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text('Validar'),
                    ),
                  SizedBox(height: 20),
                  // Mensagem de Erro
                  if (_errorMessage != null)
                    Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  SizedBox(height: 20),
                  // Rodapé
                  Text(
                    'Feito por Raphael Goettenauer - 2024',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
