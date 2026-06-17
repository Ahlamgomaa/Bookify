import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Data/Models/event_model.dart';
import '../../../../Data/repository/local_repository.dart';
import '../../../../Data/repository/events_repository.dart';
import '../../../../Data/data_source/events_data_source.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final LocalRepository localRepo;
  final EventsRepository eventsRepo;

  ProfileCubit() : 
    localRepo = LocalRepository(), 
    eventsRepo = EventsRepository(EventsDataSource()), 
    super(ProfileInitial());

  void loadFavoriteEvents() async {
    emit(ProfileLoading());
    try {
      final userId = await localRepo.getUserId();
      if (userId == null) {
        emit(ProfileLoaded(const []));
        return;
      }

      final favRows = await localRepo.getUserFavorites(userId);
      final List<EventModel> events = [];

      for (final row in favRows) {
        final eventId = row['event_id'].toString();
        try {
          final event = await eventsRepo.getEventDetails(eventId);
          if (event != null) events.add(event);
        } catch (_) {
          // Skip if fail
        }
      }

      emit(ProfileLoaded(events));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
