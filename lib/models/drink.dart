import 'package:dio/dio.dart';

class Drink {
  String? strDrink;
  int? idDrink;
  String? strCategory;
  String? strAlcoholic;
  String? strGlass;
  String? strInstructionsES;
  String? strDrinkThumb;

  Drink({
    this.strDrink,
    this.idDrink,
    this.strCategory,
    this.strAlcoholic,
    this.strGlass,
    this.strInstructionsES,
    this.strDrinkThumb,
  });

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      strDrink: json["strDrink"],
      idDrink: int.tryParse(json["idDrink"]?.toString() ?? ''),
      strCategory: json["strCategory"],
      strAlcoholic: json["strAlcoholic"],
      strGlass: json["strGlass"],
      strInstructionsES: json["strInstructionsES"],
      strDrinkThumb: json["strDrinkThumb"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "strDrink": strDrink,
      "idDrink": idDrink,
      "strCategory": strCategory,
      "strAlcoholic": strAlcoholic,
      "strGlass": strGlass,
      "strInstructionsES": strInstructionsES,
      "strDrinkThumb": strDrinkThumb,
    };
  }

  /// Obtiene una lista de bebidas por nombre
  static Future<List<Drink>> getDrinkByName(String name) async {
    try {
      final response = await Dio().get(
        'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=$name',
      );
      final drinksJson = response.data["drinks"];
      if (drinksJson == null) return [];
      return List<Drink>.from(drinksJson.map((d) => Drink.fromJson(d)));
    } catch (e) {
      print("Error al obtener los datos por nombre: $e");
      return [];
    }
  }

  /// Obtiene una bebida aleatoria
  static Future<Drink?> getRandomDrink() async {
    try {
      final response = await Dio().get(
        'https://www.thecocktaildb.com/api/json/v1/1/random.php',
      );
      final drinksJson = response.data["drinks"];
      if (drinksJson == null || drinksJson.isEmpty) return null;
      return Drink.fromJson(drinksJson[0]);
    } catch (e) {
      print("Error al obtener bebida aleatoria: $e");
      return null;
    }
  }
}
