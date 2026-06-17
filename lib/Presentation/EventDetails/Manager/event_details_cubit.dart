import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Data/Models/event_model.dart';
import '../../../../Data/repository/events_repository.dart';
import '../../../../Data/data_source/events_data_source.dart';

part 'event_details_state.dart';

class EventDetailsCubit extends Cubit<EventDetailsState> {
  final EventsRepository repository;

  EventDetailsCubit() : repository = EventsRepository(EventsDataSource()), super(EventDetailsInitial());

  void loadEventDetails(String? eventId) async {
    emit(EventDetailsLoading());
    try {
      if (eventId != null) {
        final event = await repository.getEventDetails(eventId);
        emit(EventDetailsLoaded(event));
      } else {
        emit(EventDetailsLoaded(null));
      }
    } catch (e) {
      emit(EventDetailsError(e.toString()));
    }
  }
}
