import 'package:flutter/material.dart';

class MetasPage extends StatefulWidget {
  const MetasPage({Key? key}) : super(key: key);

  @override
  State<MetasPage> createState() => _MetasPageState();
}

class _MetasPageState extends State<MetasPage> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController valorController = TextEditingController();

  final List<Map<String, dynamic>> metas = [];

  void mostrarSnackBar(String mensagem, {Color cor = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: cor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void adicionarMeta() {
    final titulo = tituloController.text.trim();
    final valor = double.tryParse(valorController.text.trim());

    if (titulo.isEmpty || valor == null || valor <= 0) {
      mostrarSnackBar('Preencha os campos corretamente.');
      return;
    }

    setState(() {
      metas.add({'titulo': titulo, 'valor': valor});
      tituloController.clear();
      valorController.clear();
    });

    mostrarSnackBar('Meta adicionada com sucesso!', cor: Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        title: const Text('Metas Financeiras'),
        backgroundColor: Colors.green[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'Defina suas metas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            TextField(
              controller: tituloController,
              decoration: const InputDecoration(
                labelText: 'Título da meta',
                prefixIcon: Icon(Icons.flag),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: valorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor desejado (R\$)',
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: adicionarMeta,
              icon: const Icon(Icons.add),
              label: const Text('Adicionar meta'),
            ),
            const SizedBox(height: 24),

            Expanded(
              child: metas.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhuma meta definida ainda.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.separated(
                      itemCount: metas.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final meta = metas[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          child: ListTile(
                            leading: const Icon(Icons.star, color: Colors.orange),
                            title: Text(meta['titulo']),
                            trailing: Text('R\$ ${meta['valor'].toStringAsFixed(2)}'),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
