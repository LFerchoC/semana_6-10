import 'package:flutter/material.dart';
import 'package:switch_theme_app/models/episodes_list_model.dart';

class EpView extends StatelessWidget {
  const EpView({super.key, required this.episode});
  final EpisodeModel episode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text(episode.name)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(
                          'https://cdn.thesimpsonsapi.com/200${episode.imagePath}',
                        ),
            Text(
              episode.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            Text('Temporada: ${episode.season}'),
            Text('Episodio: ${episode.episodeNumber}'),
            Text('Fecha de emisión: ${episode.airdate}'),

            Text(
              'Sinopsis',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(episode.synopsis),
          ],
        ),
      ),
    );
  }
}
