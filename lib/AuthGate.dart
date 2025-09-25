import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';
import 'loginpage.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool? isLoggedIn;
  String? nome;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final logged = prefs.getBool('isLoggedIn') ?? false;
    final savedName = prefs.getString('userName') ?? '';

    if (mounted) {
      setState(() {
        isLoggedIn = logged;
        nome = savedName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (isLoggedIn! && nome != null && nome!.isNotEmpty) {
      return HomePage(nome: nome!);
    }

    return const LoginPage(); // ❌ Removido SnackBar durante build
  }
}
