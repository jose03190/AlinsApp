import 'package:flutter/material.dart';
import 'package:domicilios_uno/screens/business/parrilla_artesanal_screen.dart';
import 'package:domicilios_uno/screens/auth/userregistrationscreen.dart';

class BusinessCard extends StatefulWidget {
  const BusinessCard({super.key});

  @override
  _BusinessCardState createState() => _BusinessCardState();
}

class _BusinessCardState extends State<BusinessCard> {
  int _selectedIndex = 1;

  final List<Widget> _screens = [const UserRegistrationScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
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
}

class BusinessCardHome extends StatelessWidget {
  const BusinessCardHome({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> businesses = [
      'Parrilla Artesanal',
      'Kike’s Pizza',
      'Sandra Comidas',
      'Hierros Palestina',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Negocios Aliados'),
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: businesses.length,
          itemBuilder: (context, index) {
            return _BusinessCardItem(
              key: ValueKey(businesses[index]),
              businessName: businesses[index],
            );
          },
        ),
      ),
    );
  }
}

class _BusinessCardItem extends StatelessWidget {
  final String businessName;
  const _BusinessCardItem({super.key, required this.businessName});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              businessName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6.0),
            ElevatedButton(
              onPressed: () {
                if (businessName == 'Parrilla Artesanal') {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ParrillaArtesanalScreen(),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Ver menú'),
            ),
          ],
        ),
      ),
    );
  }
}
