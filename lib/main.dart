import 'package:flutter/material.dart';
import 'dart:convert';
// imports only the rootBundle from Flutter's services library, which allows access to the asset bundle
//(used for loading assets like images, config files, and in this case, the JSON file).
import 'package:flutter/services.dart' show rootBundle;
import 'restaurant.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //returns a Future<List<Restaurant>>. It reads the JSON file from the assets
  //('assets/restaurants.json'), decodes it into a list of dynamic objects,
  //and then maps each object to a Restaurant instance using the fromJson method.
  Future<List<Restaurant>> _loadRestaurants() async {
    final jsonString = await rootBundle.loadString('assets/restaurants.json');
    final jsonResponse = json.decode(jsonString) as List;
    return jsonResponse
        .map((restaurant) => Restaurant.fromJson(restaurant))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Local Restaurants'),
        ),
        body: FutureBuilder<List<Restaurant>>(
          future: _loadRestaurants(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final restaurant = snapshot.data![index];
                  return ListTile(
                    title: Text(restaurant.name),
                    subtitle: Text(
                        '${restaurant.cuisine} - ${restaurant.rating} stars'),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
