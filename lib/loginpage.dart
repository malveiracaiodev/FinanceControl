import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController nomeController = TextEditingController();

  void mostrarSnackBar(String mensagem, {Color cor = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: cor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> login() async {
    final nome = nomeController.text.trim();

    if (nome.isEmpty) {
      mostrarSnackBar('Por favor, insira seu nome.');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userName', nome);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomePage(nome: nome)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.green[600],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 48),
            const Text(
              'Bem-vindo ao FinanceControl!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Seu nome',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.login),
              label: const Text('Entrar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: login,
            ),
          ],
        ),
      ),
    );
  }
}
