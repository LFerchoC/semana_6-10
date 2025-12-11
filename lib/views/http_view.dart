import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:switch_theme_app/models/character_model.dart';

class HttpView extends StatelessWidget {
  const HttpView({super.key});

  fetcData() async {
    //https://thesimpsonsapi.com/api/characters/3
    //var url = Uri.https('DOMINIO', 'ENDPOINT');
    var url = Uri.https('thesimpsonsapi.com', '/api/characters/15');
    var response = await http.get(url);
    return characterFromJson(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: fetcData(),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error ${snapshot.error}');
              } else if (snapshot.hasData) {
                //return Text('has data ${snapshot.data.age}');
                return Column(
                  children: [
                    Image(
                      image: NetworkImage(
                        'https://cdn.thesimpsonsapi.com/500${snapshot.data?.portraitPath}',
                      ),
                    ),
                  ],
                );
              } else {
                return Text('No data');
              }
            },
          ),
        ),
      ),
    );
  }
}
