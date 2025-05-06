import 'package:flutter/material.dart';
import 'package:coktailmenuapp/models/drink.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  bool loading = false;
  String? drinknsearch;
  int? drinkid;
  String? ingredientsearch;
  int? ingredientid;
  List<Drink> drinks = [];
  bool notFound = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController ingredientNameController = TextEditingController();
  final TextEditingController ingredientIdController = TextEditingController();

  Future<void> getDrinkByName(String name) async {
    setState(() {
      loading = true;
      notFound = false;
    });
    final result = await Drink.getDrinkByName(name);
    setState(() {
      drinks = result;
      loading = false;
      notFound = result.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TheCocktailDB",
          style: TextStyle(color: Colors.orangeAccent),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Botón 1: Búsqueda por nombre de cóctel
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Introduzca nombre del cóctel",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                drinknsearch = value;
                getDrinkByName(value);
                nameController.clear();
              },
            ),
            const SizedBox(height: 10),
            // Botón 2: Búsqueda por ID de cóctel
            TextField(
              controller: idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Introduzca ID del cóctel",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Botón 3: Búsqueda por nombre de ingrediente
            TextField(
              controller: ingredientNameController,
              decoration: const InputDecoration(
                labelText: "Introduzca nombre del ingrediente",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Botón 4: Búsqueda por ID de ingrediente
            TextField(
              controller: ingredientIdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Introduzca ID del ingrediente",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            loading
                ? const CircularProgressIndicator()
                : notFound
                ? const Expanded(
              child: Center(
                child: Text("No encontrado", style: TextStyle(fontSize: 20)),
              ),
            )
                : Expanded(
              child: ListView.builder(
                itemCount: drinks.length,
                itemBuilder: (context, index) {
                  final drink = drinks[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    color: Colors.orange,
                    child: ListTile(
                      title: Text("Nombre: ${drink.strDrink ?? ''}", style: TextStyle(color: Colors.black)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Categoría: ${drink.strCategory ?? ''}", style: TextStyle(color: Colors.black)),
                          Text("Alcohol: ${drink.strAlcoholic ?? ''}", style: TextStyle(color: Colors.black)),
                          Text("Copa: ${drink.strGlass ?? ''}", style: TextStyle(color: Colors.black)),
                          Text("Instrucciones: ${drink.strInstructionsES ?? ''}", style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
