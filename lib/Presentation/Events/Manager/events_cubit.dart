import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Data/Models/event_model.dart';
import '../../../../Data/repository/events_repository.dart';
import '../../../../Data/data_source/events_data_source.dart';

part 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  final EventsRepository repository;

  EventsCubit() : repository = EventsRepository(EventsDataSource()), super(EventsInitial());

  void loadEvents() async {
    emit(EventsLoading());
    try {
      final events = await repository.getHomeEvents();
      emit(EventsLoaded(events));
    } catch (e) {
      emit(EventsError(e.toString()));
    }
  }
}
