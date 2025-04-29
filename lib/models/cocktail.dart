import 'package:dio/dio.dart';

class Cocktail {
  String? cocktail;

  Cocktail({this.cocktail});

  factory Cocktail.fromJson(json) {
    return Cocktail(cocktail: json["cocktail"]);
  }

  static Future<List<Cocktail>> getCocktail() async{
    try {
      List<Cocktail> cocktail = [];
      final response = await Dio().get(
        'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=$cocktail?api-key=1',
      );
      final results = response.data["results"];
      for (var result in results) {
        cocktail.add(Cocktail.fromJson(result));
      }
      return cocktail;

    } catch (e) {
      print("Error al obtener las cocktails: $e");
      print("StackTrace: ${e.toString()}");
      return [];
    }
  }

  Map<String,dynamic> toMap(){
    return{"cocktail":cocktail};
  }
}
