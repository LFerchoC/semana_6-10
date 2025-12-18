import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:switch_theme_app/models/character_model.dart';

class HttpView extends StatefulWidget {
  const HttpView({super.key});

  @override
  State<HttpView> createState() => _HttpViewState();
}

class _HttpViewState extends State<HttpView> {
  int? characterId;

  final TextEditingController numCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future fetcData(int id) async {
    var url = Uri.https('thesimpsonsapi.com', '/api/characters/$id');
    var response = await http.get(url);
    return characterFromJson(response.body);
  }

  @override
  void dispose() {
    numCtrl.dispose();
    super.dispose();
  }

  void increment() {
    int value = int.tryParse(numCtrl.text) ?? 1;
    numCtrl.text = (value + 1).toString();
  }

  void decrement() {
    int value = int.tryParse(numCtrl.text) ?? 1;
    numCtrl.text = (value - 1).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Http view'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                controller: numCtrl,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: 'Número del personaje',
                  border: OutlineInputBorder(),
                  hintText: '1 Homer, 2 Marge, 3 Bart, 4 Lisa, 5 Maggie',
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obligatorio';
                  }

                  final id = int.tryParse(value);
                  if (id == null || id < 1 || id > 1182) {
                    return 'Ingresa un número entre 1 y 1182';
                  }
                  return null;
                },
                onChanged: (_) {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      characterId = int.parse(numCtrl.text);
                    });
                  } else {
                    setState(() {
                      characterId = null;
                    });
                  }
                },
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: decrement,
                ),
                IconButton(icon: const Icon(Icons.add), onPressed: increment),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: characterId == null ? null : fetcData(characterId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://cdn.thesimpsonsapi.com/500${snapshot.data.portraitPath}',
                        ),
                        Text(snapshot.data.name),
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text('Ingresa un número válido'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
