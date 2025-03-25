// home_screen.dart
import 'package:flutter/material.dart';
import 'package:offers_app/sign_up.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  List<Offer> allOffers = [
    Offer(name: "20% Off Electronics", store: "TechMart", description: "Discount on all electronics"),
    Offer(name: "Buy 1 Get 1 Free", store: "FashionHub", description: "Clothing offer"),
    Offer(name: "Free Shipping", store: "BookStore", description: "On orders over 50\$"),
    Offer(
      name: "Free Shipping on Orders over 50\$",
      store: "Amazon",
      description: "Get free shipping on all orders over 50\$",
    ),
    Offer(
      name: "10% off on all Electronics",
      store: "Best Buy",
      description: "Get 10% off on all electronics",
    ),
    Offer(
      name: "Buy One Get One 50% off on Clothing",
      store: "Gap",
      description: "Buy one get one 50% off on all clothing",
    ),
    Offer(
      name: "20% off on all Home Decor",
      store: "West Elm",
      description: "Get 20% off on all home decor",
    ),
    Offer(
      name: "Free Gift with Purchase over 100\$",
      store: "Macy's",
      description: "Get a free gift with purchase over 100\$",
    ),
    Offer(
      name: "15% off on all Beauty Products",
      store: "Sephora",
      description: "Get 15% off on all beauty products",
    ),
    Offer(
      name: "Buy One Get One 25% off on Toys",
      store: "Toys R Us",
      description: "Buy one get one 25% off on all toys",
    ),
    Offer(
      name: "10% off on all Sports Equipment",
      store: "Dick's Sporting Goods",
      description: "Get 10% off on all sports equipment",
    ),
    Offer(
      name: "Free Shipping on all Orders",
      store: "Walmart",
      description: "Get free shipping on all orders",
    ),
    Offer(
      name: "20% off on all Outdoor Gear",
      store: "REI",
      description: "Get 20% off on all outdoor gear",
    ),
  ];
  List<Offer> filteredOffers = [];

  @override
  void initState() {
    super.initState();
    filteredOffers = allOffers;
    _searchController.addListener(_filterOffers);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterOffers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredOffers = allOffers.where((offer) {
        return offer.name.toLowerCase().contains(query) ||
            offer.store.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _getOffer(Offer offer) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Offer "${offer.name}" claimed!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offers'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search offers by name or store',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredOffers.length,
              itemBuilder: (context, index) {
                final offer = filteredOffers[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OfferDetailsScreen(offer: offer),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  offer.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  offer.store,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _getOffer(offer),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Get Offer'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Offer model (unchanged)
class Offer {
  final String name;
  final String store;
  final String description;

  Offer({required this.name, required this.store, required this.description});
}

// offer_details_screen.dart (unchanged)
class OfferDetailsScreen extends StatelessWidget {
  final Offer offer;

  const OfferDetailsScreen({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(offer.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              offer.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Store: ${offer.store}',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              'Description: ${offer.description}',
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SupportChatScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Contact Support'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// support_chat_screen.dart (unchanged)
class SupportChatScreen extends StatefulWidget {
  const SupportChatScreen({super.key});

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  final _messageController = TextEditingController();
  final List<String> messages = [];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.add(_messageController.text);
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(messages[index]),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Updated main.dart (unchanged)


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    routes: {
      '/login': (context) => const LoginScreen(),
      '/signup': (context) => const SignUpScreen(),
      '/home': (context) => const HomeScreen(),
    },
  ));
}