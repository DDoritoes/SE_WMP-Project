import 'package:flutter/material.dart';

class ShoppingPage extends StatelessWidget {
  final List<Product> products = [
    Product(
      brand: 'Cat&Dog Necklace',
      name: 'Reflective Dog Cat Necklace Bells Pet Cat Collar Animal Accessories',
      price: 'IDR 15,000',
      oldPrice: 'IDR 20,000',
      imagePath: 'assets/img/aksesoris.jpg',
    ),
    Product(
      brand: 'Muffins Favorite',
      name: 'Favorite 1Kg Dry Dog Food',
      price: 'IDR 39,500',
      oldPrice: '',
      imagePath: 'assets/img/favorite.png',
    ),
    Product(
      brand: 'Himalaya Pet Food',
      name: 'Himalaya Healthy Pet Food Chicken & Rice 5Kg',
      price: 'IDR 578,000',
      oldPrice: 'IDR 897,000',
      imagePath: 'assets/img/himalaya.jpg',
    ),
    Product(
      brand: 'Animal Cage',
      name: '| CAT CAGE | DOG CAGE | RABBIT CAGE | 60CM |',
      price: 'IDR 200,000',
      oldPrice: '',
      imagePath: 'assets/img/kandang.jpg',
    ),
    Product(
      brand: 'Rabbit Food',
      name: 'VITAL RABBIT FOOD FEED PELLETS 1 KG CITRAFEED VITAL RABBIT 1KG',
      price: 'IDR 1,550,000',
      oldPrice: 'IDR 2,199,000',
      imagePath: 'assets/img/rabbit.jpg',
    ),
    Product(
      brand: 'Cat Scratcher',
      name: 'Cat Scratcher Black Edition',
      price: 'IDR 120,000',
      oldPrice: 'IDR 138,000',
      imagePath: 'assets/img/scartcher.jpg',
    ),
    Product(
      brand: 'Takari Fish',
      name: 'Takari Fish Food Organic Healthy',
      price: 'IDR 78,000',
      oldPrice: '',
      imagePath: 'assets/img/takari.jpg',
    ),
    Product(
      brand: 'Whiskas',
      name: 'Whiskas Cat Food 1,5kg',
      price: 'IDR 135,000',
      oldPrice: 'IDR 153,000',
      imagePath: 'assets/img/whiskas.jpg',
    ),
    Product(
      brand: 'Winpet',
      name: 'Winpet Cat Climbing Premium',
      price: 'IDR 242,000',
      oldPrice: 'IDR 300,000',
      imagePath: 'assets/img/winpet.jpg',
    ),
  ];

  ShoppingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.7,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(product: product);
          },
        ),
      ),
    );
  }
}

class Product {
  final String brand;
  final String name;
  final String price;
  final String oldPrice;
  final String imagePath;

  Product({
    required this.brand,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.imagePath,
  });
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              product.imagePath,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.brand,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 6),
                Text(
                  product.price,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
                if (product.oldPrice.isNotEmpty)
                  Text(
                    product.oldPrice,
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
