import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController ganhoController = TextEditingController();
  final TextEditingController empregoController = TextEditingController();

  String frequenciaSelecionada = 'Mensal';
  final List<String> frequencias = ['Mensal', 'Semanal', 'Diário'];

  @override
  void initState() {
    super.initState();
    carregarPerfil();
  }

  Future<void> carregarPerfil() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nomeController.text = prefs.getString('perfilNome') ?? '';
      ganhoController.text = prefs.getString('perfilGanho') ?? '';
      empregoController.text = prefs.getString('perfilEmprego') ?? '';
      frequenciaSelecionada = prefs.getString('perfilFrequencia') ?? 'Mensal';
    });
  }

  void mostrarSnackBar(String mensagem, {Color cor = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: cor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> salvarPerfil() async {
    final nome = nomeController.text.trim();
    final ganho = ganhoController.text.trim();
    final emprego = empregoController.text.trim();

    if (nome.isEmpty || ganho.isEmpty || emprego.isEmpty) {
      mostrarSnackBar('Preencha todos os campos corretamente.', cor: Colors.red);
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('perfilNome', nome);
    await prefs.setString('perfilGanho', ganho);
    await prefs.setString('perfilEmprego', emprego);
    await prefs.setString('perfilFrequencia', frequenciaSelecionada);

    mostrarSnackBar('Perfil salvo com sucesso!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        title: const Text('Seu Perfil'),
        backgroundColor: Colors.green[600],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Avatar com botão de edição
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 48, color: Colors.grey[700]),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green[600],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt, color: Colors.white),
                    onPressed: () {
                      mostrarSnackBar('Função de imagem ainda não implementada.', cor: Colors.orange);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Seu nome',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: ganhoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ganho mensal',
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: empregoController,
              decoration: const InputDecoration(
                labelText: 'Emprego',
                prefixIcon: Icon(Icons.work),
              ),
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: frequenciaSelecionada,
              items: frequencias.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Frequência',
                prefixIcon: Icon(Icons.calendar_today),
              ),
              onChanged: (newValue) {
                setState(() {
                  frequenciaSelecionada = newValue!;
                });
              },
            ),
            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: salvarPerfil,
              icon: const Icon(Icons.check),
              label: const Text('Salvar alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
