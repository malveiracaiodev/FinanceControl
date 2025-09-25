import 'package:flutter/material.dart';
import 'perfilpage.dart';
import 'controlepage.dart';
import 'codigopage.dart';
import 'configuracoespage.dart';

class HomePage extends StatelessWidget {
  final String nome;

  const HomePage({Key? key, required this.nome}) : super(key: key);

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
                MaterialPageRoute(builder: (_) => PerfilPage()), // ❌ Removido const
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

            ElevatedButton.icon(
              icon: const Icon(Icons.list),
              label: const Text('Controle de Gastos'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ControlePage(nome: nome)),
                );
              },
            ),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              icon: const Icon(Icons.vpn_key),
              label: const Text('Entrar com um código'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CodigoPage()), // ❌ Removido const
                );
              },
            ),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              icon: const Icon(Icons.settings),
              label: const Text('Configurações'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ConfiguracoesPage()), // ❌ Removido const
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
