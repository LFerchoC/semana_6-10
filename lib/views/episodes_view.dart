import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:switch_theme_app/models/episodes_list_model.dart';

class EpisodesView extends StatefulWidget {
  const EpisodesView({super.key});

  @override
  State<EpisodesView> createState() => _EpisodesViewState();
}

Future<EpisodesListModel> fetcData() async {
  var url = Uri.https('thesimpsonsapi.com', '/api/episodes?page=1');
  var response = await http.get(url);
  return episodesListModelFromJson(response.body);
}

class _EpisodesViewState extends State<EpisodesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Episodes')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('lista de episodios'),
            FutureBuilder<EpisodesListModel>(
              future: fetcData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return Column(
                    children: [
                      ...data.results
                          .map((ep) => ListTile(title: Text(ep.name)))
                          .toList(),
                    ],
                  );
                  /*return Column(
                    children: [
                      Text('Total: ${data.count}'),
                      Text('Páginas: ${data.pages}'),
                      Text('Next: ${data.next}'),
                      Text('Prev: ${data.prev}'),

                      ...data.results
                          .map((episode) => ListTile(title: Text(episode.name)))
                          .toList(),
                    ],
                  );*/
                }

                return const Text('No hay episodios');
              },
            ),
          ],
        ),
      ),
    );
  }
}
