import 'package:flutter/material.dart';
import 'package:coktailmenuapp/models/drink.dart';

class RandomDrinksList extends StatelessWidget {
  final List<Drink> drinks;

  const RandomDrinksList({super.key, required this.drinks});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180, // Limita la altura total del contenedor horizontal
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: drinks.length,
        itemBuilder: (context, index) {
          final drink = drinks[index];
          return _buildDrinkCard(drink);
        },
      ),
    );
  }

  Widget _buildDrinkCard(Drink drink) {
    return Container(
        width: 160,
        height: 50,
        margin: const EdgeInsets.only(right: 10),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Imagen con altura fija
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(
                    drink.strDrinkThumb ?? '',
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Texto: nombre y tipo
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        drink.strDrink ?? 'Nombre no disponible',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        drink.strAlcoholic ?? '',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
