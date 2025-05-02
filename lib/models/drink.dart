import 'package:dio/dio.dart';

class Drink {
  String? strDrink;
  int? idDrink;
  String? strCategory;
  String? strAlcoholic;
  String? strGlass;
  String? strInstructionsES;

  Drink(
      {this.strDrink,
      this.idDrink,
      this.strCategory,
      this.strAlcoholic,
      this.strGlass,
      this.strInstructionsES});

  factory Drink.fromJson(json) {
    return Drink(
        strDrink: json["strDrink"],
        idDrink: json["idDrink"],
        strCategory: json["strCategory"],
        strAlcoholic: json["strAlcoholic"],
        strGlass: json["strGlass"],
        strInstructionsES: json["strInstructionsES"]);
  }

  static Future<List<Drink>> getDrink() async {
    try {
      List<Drink> strDrink = [];
      final response = await Dio().get(
        'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita?api-key=1',
      );
      final results = response.data["results"];
      for (var result in results) {
        strDrink.add(Drink.fromJson(result));
      }
      return strDrink;
    } catch (e) {
      print("Error al obtener las cocktails: $e");
      print("StackTrace: ${e.toString()}");
      return [];
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "strDrink": strDrink,
      "idDrink": idDrink,
      "strCategory": strCategory,
      "strAlcoholic": strAlcoholic,
      "strGlass": strGlass,
      "strInstructionsES": strInstructionsES
    };
  }
}
