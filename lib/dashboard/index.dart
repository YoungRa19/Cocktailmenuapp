import 'package:flutter/material.dart';
import 'package:coktailmenuapp/models/drink.dart';
import 'package:coktailmenuapp/components/randomcards.dart'; // Asegúrate de que la ruta coincida

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  bool loading = false;
  List<Drink> drinks = [];
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getRandomDrinks();
    nameController.addListener(_handleSearchChange);
  }

  void _handleSearchChange() {
    final text = nameController.text.trim();
    if (text.isEmpty) {
      getRandomDrinks();
    } else {
      getDrinkByName(text);
    }
  }

  Future<void> getRandomDrinks() async {
    setState(() {
      loading = true;
      drinks = [];
    });

    List<Drink> randoms = [];
    for (var i = 0; i < 3; i++) {
      final drink = await Drink.getRandomDrink();
      if (drink != null) {
        randoms.add(drink);
      }
    }

    setState(() {
      drinks = randoms;
      loading = false;
    });
  }

  Future<void> getDrinkByName(String name) async {
    setState(() {
      loading = true;
      drinks = [];
    });

    final result = await Drink.getDrinkByName(name);

    setState(() {
      drinks = result;
      loading = false;
    });
  }

  void clearSearch() {
    nameController.clear();
    FocusScope.of(context).unfocus();
    getRandomDrinks();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Widget buildDrinkCard(Drink drink) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: SizedBox(
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.network(
                drink.strDrinkThumb ?? '',
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    drink.strDrink ?? 'Nombre no disponible',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    drink.strAlcoholic ?? '',
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSearching = nameController.text.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text("TheCocktailDB Menú", style: TextStyle(color: Colors.orange)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.black),  // <-- Aquí agregas esto
                decoration: InputDecoration(
                  labelText: "Buscar bebida",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: nameController.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: clearSearch,
                  )
                      : null,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              if (loading)
                const Expanded(child: Center(child: CircularProgressIndicator()))
              else if (drinks.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text("No se encontraron bebidas.", style: TextStyle(fontSize: 16)),
                  ),
                )
              else
                Expanded(
                  child: isSearching
                      ? ListView.builder(
                    itemCount: drinks.length,
                    itemBuilder: (context, index) => buildDrinkCard(drinks[index]),
                  )
                      : RandomDrinksList(drinks: drinks),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
