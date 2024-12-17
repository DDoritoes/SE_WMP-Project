import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> petInfo = [
    {'title': 'Pet Health Tips', 'description': 'How to keep your pet healthy'},
    {'title': 'Grooming Tips', 'description': 'Top 5 tips for grooming pets'},
    {'title': 'Nutrition Guide', 'description': 'What to feed your pet'},
    {'title': 'Training Tips', 'description': 'How to train your pet effectively'},
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section (Tetap statis)
            Container(
              padding: const EdgeInsets.all(20.0),
              color: Colors.grey[900],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "pawsistant",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                        onSelected: (value) {
                          switch (value) {
                            case 'Settings':
                              Navigator.pushNamed(context, '/set');
                              break;
                            case 'Profile':
                              Navigator.pushNamed(context, '/profile');
                              break;
                            case 'Logout':
                              Navigator.pushReplacementNamed(context, '/login');
                              break;
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            const PopupMenuItem(
                              value: 'Settings',
                              child: Text('Settings'),
                            ),
                            const PopupMenuItem(
                              value: 'Profile',
                              child: Text('Profile'),
                            ),
                            const PopupMenuItem(
                              value: 'Logout',
                              child: Text('Logout'),
                            ),
                          ];
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "\nNeed help? \nTry chatting with our chatbot, Petties!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'ask here...',
                        hintStyle: TextStyle(color: Colors.white70),
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Scrollable Paw Menu and Paw Bulletin
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Paw Menu
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Paw Menu',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(width: 12),
                            _menuItem('Booking', Icons.calendar_today, Colors.blue, () {
                              Navigator.pushNamed(context, '/book');
                            }),
                            SizedBox(width: 12),
                            const SizedBox(width: 14),
                            _menuItem('AI Chatbot', Icons.assistant_outlined, Colors.green, () {
                              Navigator.pushNamed(context, '/chat');
                            }),
                            SizedBox(width: 12),
                            const SizedBox(width: 14),
                            _menuItem('Shop', Icons.shopping_cart, Colors.orange, () {
                              Navigator.pushNamed(context, '/shop');
                            }),
                            SizedBox(width: 12),
                            const SizedBox(width: 14),
                            _menuItem('Activity', Icons.assignment_rounded, Colors.red, () {
                              Navigator.pushNamed(context, '/act');
                            }),
                            SizedBox(width: 12),
                            const SizedBox(width: 14),
                            _menuItem('Others', Icons.grid_view_rounded, const Color.fromARGB(255, 94, 92, 89), () {
                              Navigator.pushNamed(context, '/oth');
                            }),
                            SizedBox(width: 12),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Paw Bulletin
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Paw Bulletin',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: petInfo.map((info) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 4,
                            child: ListTile(
                              title: Text(
                                info['title']!,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(info['description']!),
                              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: "Profile",
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 1:
              Navigator.pushNamed(context, '/chat');
              break;
            case 2:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }

  Widget _menuItem(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}