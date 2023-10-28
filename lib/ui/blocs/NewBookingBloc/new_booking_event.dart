part of 'new_booking_bloc.dart';

abstract class NewBookingEvent {}

class FirstLoad extends NewBookingEvent {
  final bool firstLoad;
  FirstLoad({required this.firstLoad});
}

class EditCourt extends NewBookingEvent {
  final String courtId;
  EditCourt({required this.courtId});
}

class EditDate extends NewBookingEvent {
  final String date;
  EditDate({required this.date});
}

class EditName extends NewBookingEvent {
  final String name;
  EditName({required this.name});
}

class SaveBooking extends NewBookingEvent {
  SaveBooking();
}

class GetBookings extends NewBookingEvent {
  GetBookings();
}

class DeleteBooking extends NewBookingEvent {
  final int bookingId;
  DeleteBooking({required this.bookingId});
}

class ChangeError extends NewBookingEvent {
  final bool isError;
  ChangeError({required this.isError});
}

class ChangeSaved extends NewBookingEvent {
  ChangeSaved();
}
