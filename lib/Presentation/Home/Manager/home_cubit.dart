import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Data/Models/event_model.dart';
import '../../../../Data/Models/category_model.dart';
import '../../../../Data/repository/events_repository.dart';
import '../../../../Data/data_source/events_data_source.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final EventsRepository repository;

  HomeCubit() : repository = EventsRepository(EventsDataSource()), super(HomeInitial());

  void loadHomeData() async {
    emit(HomeLoading());
    try {
      final results = await Future.wait([
        repository.getHomeEvents(),
        repository.getNearbyEvents("51.5074,-0.1278"),
        repository.getCategories(),
      ]);

      emit(HomeLoaded(
        homeEvents: results[0] as List<EventModel>,
        nearbyEvents: results[1] as List<EventModel>,
        categories: results[2] as List<CategoryModel>,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
