part of 'event_details_cubit.dart';

abstract class EventDetailsState {}

class EventDetailsInitial extends EventDetailsState {}

class EventDetailsLoading extends EventDetailsState {}

class EventDetailsLoaded extends EventDetailsState {
  final EventModel? event;

  EventDetailsLoaded(this.event);
}

class EventDetailsError extends EventDetailsState {
  final String message;

  EventDetailsError(this.message);
}
