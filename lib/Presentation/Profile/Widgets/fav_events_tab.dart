import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Events/Widgets/event_cards.dart';
import '../Manager/profile_cubit.dart';

class FavEventsTab extends StatelessWidget {
  const FavEventsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..loadFavoriteEvents(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading || state is ProfileInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is ProfileLoaded) {
            if (state.favEvents.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bookmark_border, size: 60, color: Colors.grey),
                    SizedBox(height: 12),
                    Text(
                      "No favorite events yet",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              itemCount: state.favEvents.length,
              itemBuilder: (context, index) {
                return EventCards(event: state.favEvents[index]);
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
