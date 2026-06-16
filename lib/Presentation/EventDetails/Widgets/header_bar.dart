import 'package:flutter/material.dart';
import '../../../Data/Local/database_helper.dart';
import '../../../Data/Local/shared_prefs_helper.dart';

class HeaderBar extends StatefulWidget {
  final String? eventId;
  const HeaderBar({super.key, this.eventId});

  @override
  State<HeaderBar> createState() => _HeaderBarState();
}

class _HeaderBarState extends State<HeaderBar> {
  bool _isFavorite = false;
  int? _userId;

  @override
  void initState() {
    super.initState();
    _loadFavoriteState();
  }

  Future<void> _loadFavoriteState() async {
    final userId = await SharedPrefsHelper.getUserId();
    if (userId == null || widget.eventId == null) return;

    final isFav = await DatabaseHelper.instance.isFavorite(userId, widget.eventId!);
    if (mounted) {
      setState(() {
        _userId = userId;
        _isFavorite = isFav;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    if (_userId == null || widget.eventId == null) return;

    if (_isFavorite) {
      await DatabaseHelper.instance.removeFavorite(_userId!, widget.eventId!);
    } else {
      await DatabaseHelper.instance.insertFavorite(_userId!, widget.eventId!);
    }
    if (mounted) {
      setState(() { _isFavorite = !_isFavorite; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40, left: 20, right: 20,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 5),
          const Text("Event Details", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const Spacer(),
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.bookmark : Icons.bookmark_border,
              color: _isFavorite ? Colors.red : Colors.grey[300],
              size: 28,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
    );
  }
}