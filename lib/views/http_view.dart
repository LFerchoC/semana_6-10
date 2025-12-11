import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:switch_theme_app/models/character_model.dart';

class HttpView extends StatefulWidget {
  const HttpView({super.key});

  @override
  State<HttpView> createState() => _HttpViewState();
}

class _HttpViewState extends State<HttpView> {
  int? characterId;
  final numctrl = TextEditingController();
  fetcData(int id) async {
    //https://thesimpsonsapi.com/api/characters/3
    //var url = Uri.https('DOMINIO', 'ENDPOINT');
    var url = Uri.https('thesimpsonsapi.com', '/api/characters/$id');
    var response = await http.get(url);
    return characterFromJson(response.body);
  }

  @override
  Widget build(BuildContext context) {
    final numCtrl = TextEditingController();
    return Center(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Http view'),
        ),

        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: numCtrl,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text('Numero del personaje'),
                      border: OutlineInputBorder(),
                      focusColor: Theme.of(context).colorScheme.inversePrimary,
                      hintText:
                          '1-> Homer, 2->Marge, 3->Bart, 4->Lisa, 5->Magie',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (numCtrl.text.isEmpty) return;

                    setState(() {
                      characterId = int.tryParse(numCtrl.text);
                    });
                  },
                  child: Text("Buscar personaje"),
                ),

                FutureBuilder(
                  future: characterId == null ? null : fetcData(characterId!),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text(
                        "Error: ${snapshot.error},${snapshot.toString()}",
                      );
                    } else if (snapshot.hasData) {
                      return Image(
                        image: NetworkImage(
                          'https://cdn.thesimpsonsapi.com/500${snapshot.data.portraitPath}',
                        ),
                      );
                    } else {
                      return Text("Ingresa un número y presiona buscar");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
