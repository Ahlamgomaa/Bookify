import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import '../../../Core/constants.dart';
import '../../Search/search_screen.dart';
import '../../../Data/Models/category_model.dart';

class HomeHeader extends StatelessWidget {
  final AdvancedDrawerController controller;
  final Future<List<CategoryModel>>? categoriesFuture;

  const HomeHeader({super.key, required this.controller, this.categoriesFuture});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 60,
            left: 20,
            right: 20,
            bottom: 70,
          ),
          decoration: const BoxDecoration(
            color: AppColors.navyBlue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => controller.showDrawer(),
                    icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                  ),
                  const Column(
                    children: [
                      Text(
                        "Current Location",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      Text(
                        "New York, USA",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 28,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchScreen()),
                  );
                },
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.white, size: 28),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        "Search...",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.tune, color: Colors.white, size: 16),
                          SizedBox(width: 5),
                          Text("Filters", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(bottom: -20, left: 20, right: 20, child: _buildCategories(context)),
      ],
    );
  }

  Widget _buildCategories(BuildContext context) {
    return SizedBox(
      height: 45,
      child: categoriesFuture == null 
        ? const SizedBox() 
        : FutureBuilder<List<CategoryModel>>(
            future: categoriesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const SizedBox();
              }
              final categories = snapshot.data!;
              final colors = [const Color(0xFFFF8D5D), const Color(0xFF7D67FF), const Color(0xFF00C7BE)];
              
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return _categoryItem(
                    context, 
                    cat.name, 
                    Icons.category, // using generic icon
                    colors[index % colors.length]
                  );
                },
              );
            },
          ),
    );
  }

  Widget _categoryItem(BuildContext context, String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchScreen(initialQuery: title)),
        );
      },
      child: Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 5),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      ),
    );
  }
}