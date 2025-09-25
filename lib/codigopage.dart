import 'package:flutter/material.dart';

class CodigoPage extends StatefulWidget {
  const CodigoPage({super.key});

  @override
  State<CodigoPage> createState() => _CodigoPageState();
}

class _CodigoPageState extends State<CodigoPage> {
  final TextEditingController codigoController = TextEditingController();

  void mostrarSnackBar(String mensagem, {Color cor = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: cor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void validarCodigo() {
    final codigo = codigoController.text.trim();

    if (codigo.isEmpty) {
      mostrarSnackBar('Por favor, insira um código.');
    } else if (codigo == 'FIN123') {
      mostrarSnackBar('Código válido! Acesso liberado 🎉', cor: Colors.green);
      // Exemplo de navegação:
      // Navigator.push(context, MaterialPageRoute(builder: (_) => const HomePage()));
    } else {
      mostrarSnackBar('Código inválido. Tente novamente.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        title: const Text('Entrar com Código'),
        backgroundColor: Colors.green[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: codigoController,
              decoration: InputDecoration(
                labelText: 'Digite o código de acesso',
                prefixIcon: const Icon(Icons.vpn_key),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: validarCodigo,
              icon: const Icon(Icons.check),
              label: const Text('Validar código'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
