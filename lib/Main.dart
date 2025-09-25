import 'package:flutter/material.dart';
import 'authgate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Necessário para inicializar plugins antes do runApp
  runApp(const FinanceControlApp());
}

class FinanceControlApp extends StatelessWidget {
  const FinanceControlApp({super.key}); // super parâmetro aplicado

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinanceControl',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      home: const AuthGate(),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      primarySwatch: Colors.green,
      scaffoldBackgroundColor: const Color(0xFFE3F2FD),
      fontFamily: 'Poppins',
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[600],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(double.infinity, 48),
        ),
      ),
    );
  }
}
