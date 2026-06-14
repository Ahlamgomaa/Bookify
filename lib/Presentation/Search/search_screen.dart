import 'package:flutter/material.dart';
import '../../Core/constants.dart';
import 'widgets/search_bar.dart';
import 'widgets/search_result_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          "Search",
          style: TextStyle(color: AppColors.navyBlue, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.navyBlue),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const SearchBarWidget(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: 5,
              itemBuilder: (context, index) => const SearchResultCard(),
            ),
          ),
        ],
      ),
    );
  }
}