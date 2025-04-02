import 'package:domicilios_uno/screens/auth/userregistrationscreen.dart';
import 'package:domicilios_uno/screens/business/businesscard.dart';
import 'package:flutter/material.dart';

class ParrillaArtesanalScreen extends StatefulWidget {
  const ParrillaArtesanalScreen({super.key});

  @override
  _ParrillaArtesanalScreenState createState() =>
      _ParrillaArtesanalScreenState();
}

class _ParrillaArtesanalScreenState extends State<ParrillaArtesanalScreen> {
  final List<Map<String, int>> _cart = [];
  int _selectedIndex = 1;

  void _addToCart(String name, int price) {
    setState(() {
      final index = _cart.indexWhere((item) => item['name'] == name.hashCode);
      if (index != -1) {
        _cart[index]['quantity'] = (_cart[index]['quantity']! + 1);
      } else {
        _cart.add({'name': name.hashCode, 'price': price, 'quantity': 1});
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserRegistrationScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BusinessCard()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parrilla Artesanal'),
        backgroundColor: Colors.grey[900],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ENTRADAS',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildMenuItem('Empanadas', '5 empanadas con pique', 10000),
              _buildMenuItem(
                'Marranitas',
                '5 bolitas de plátano con chicharrón',
                12000,
              ),
              _buildMenuItem(
                'Nuggets de pollo',
                '5 nuggets con papas fritas',
                10000,
              ),
              _buildMenuItem(
                'Paracones',
                '4 patacones con guiso o guacamole',
                10000,
              ),
              _buildMenuItem('Salchipapa Especial', '', 14000),
              const SizedBox(height: 20),
              const Text(
                'HAMBURGUESAS',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildMenuItem(
                'Hamburguesa Tropical',
                'Pan artesanal, carne de res, queso, vegetales, piña asada y papas fritas',
                16000,
              ),
              _buildMenuItem('Hamburguesa Mediterránea', '', 20000),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildMenuItem(String name, String description, int price) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: description.isNotEmpty ? Text(description) : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '\$$price',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.green),
              onPressed: () => _addToCart(name, price),
            ),
          ],
        ),
      ),
    );
  }
}
