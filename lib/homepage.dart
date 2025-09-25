import 'package:flutter/material.dart';
import 'perfilpage.dart';
import 'controlepage.dart';
import 'codigopage.dart';
import 'configuracoespage.dart';

class HomePage extends StatelessWidget {
  final String nome;

  const HomePage({super.key, required this.nome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        title: const Text('FinanceControl'),
        backgroundColor: Colors.green[600],
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Perfil',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PerfilPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Olá, $nome 👋',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),

            _buildBotao(
              context,
              label: 'Controle de Gastos',
              icon: Icons.list,
              cor: Colors.green[600],
              destino: ControlePage(nome: nome),
            ),
            const SizedBox(height: 16),

            _buildBotao(
              context,
              label: 'Entrar com um código',
              icon: Icons.vpn_key,
              cor: Colors.blue[600],
              destino: const CodigoPage(),
            ),
            const SizedBox(height: 16),

            _buildBotao(
              context,
              label: 'Configurações',
              icon: Icons.settings,
              cor: Colors.grey[800],
              destino: const ConfiguracoesPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBotao(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color? cor,
    required Widget destino,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: cor,
        minimumSize: const Size.fromHeight(50),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => destino),
        );
      },
    );
  }
}
