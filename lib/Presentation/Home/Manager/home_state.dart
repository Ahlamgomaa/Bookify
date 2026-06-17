part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<EventModel> homeEvents;
  final List<EventModel> nearbyEvents;
  final List<CategoryModel> categories;

  HomeLoaded({
    required this.homeEvents,
    required this.nearbyEvents,
    required this.categories,
  });
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
