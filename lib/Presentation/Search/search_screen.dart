import 'package:flutter/material.dart';
import '../../Core/constants.dart';
import 'Widgets/search_result_card.dart';
import '../../Data/data_source/events_data_source.dart';
import '../../Data/repository/events_repository.dart';
import '../../../Data/Models/event_model.dart';

class SearchScreen extends StatefulWidget {
  final String? initialQuery;
  const SearchScreen({super.key, this.initialQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late EventsRepository repository;
  Future<List<EventModel>>? searchResultsFuture;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    repository = EventsRepository(EventsDataSource());
    if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
      _searchController.text = widget.initialQuery!;
      _performSearch(widget.initialQuery!);
    }
  }

  void _performSearch(String query) {
    if (query.isNotEmpty) {
      setState(() {
        searchResultsFuture = repository.searchEvents(query);
      });
    }
  }

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search events...",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _performSearch(_searchController.text),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onSubmitted: _performSearch,
            ),
          ),
          Expanded(
            child: searchResultsFuture == null
                ? const Center(child: Text("Enter a keyword to search"))
                : FutureBuilder<List<EventModel>>(
                    future: searchResultsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(child: Text('Error loading search results'));
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No results found'));
                      }
                      final events = snapshot.data!;
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          return SearchResultCard(event: events[index]);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}