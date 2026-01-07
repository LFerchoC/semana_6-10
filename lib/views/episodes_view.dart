import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:switch_theme_app/models/episodes_list_model.dart';
import 'package:switch_theme_app/views/ep_view.dart';

class EpisodesView extends StatefulWidget {
  const EpisodesView({super.key});

  @override
  State<EpisodesView> createState() => _EpisodesViewState();
}

// 🔹 Función que obtiene episodios por página
Future<EpisodesListModel> fetcData(int page) async {
  final url = Uri.https('thesimpsonsapi.com', '/api/episodes', {
    'page': page.toString(),
  });

  final response = await http.get(url);
  return episodesListModelFromJson(response.body);
}

class _EpisodesViewState extends State<EpisodesView> {
  int currentPage = 1;
  Future<EpisodesListModel>? futureEpisodes;

  @override
  void initState() {
    super.initState();
    futureEpisodes = fetcData(currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Episodes'), centerTitle: true),
      body: FutureBuilder<EpisodesListModel>(
        future: futureEpisodes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No hay episodios'));
          }

          final data = snapshot.data!;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: data.results.length,
                  itemBuilder: (context, index) {
                    final ep = data.results[index];
                    return ListTile(
                      title: Text(ep.name),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EpView(episode: ep),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              // 🔽 CONTROLES DE PAGINACIÓN
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (currentPage > 1) {
                          setState(() {
                            currentPage--;
                            futureEpisodes = fetcData(currentPage);
                          });
                        }
                      },
                      child: const Text('Anterior'),
                    ),

                    Text('Página $currentPage de ${data.pages}'),

                    ElevatedButton(
                      onPressed: () {
                        if (currentPage < data.pages) {
                          setState(() {
                          currentPage++;
                          futureEpisodes = fetcData(currentPage);
                        });
                        }
                                              },
                      child: Text('Siguiente'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
