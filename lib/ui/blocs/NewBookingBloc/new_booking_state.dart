part of 'new_booking_bloc.dart';

class NewBookingState extends Equatable {
  final bool firstLoad;
  final bool isSaved;
  final bool isError;
  final String alertMessage;
  final String name;
  final String date;
  final String weather;
  final List courts;
  final String courtId;
  final List<Booking> bookings;

  const NewBookingState({
    required this.firstLoad,
    required this.isSaved,
    required this.isError,
    required this.alertMessage,
    required this.name,
    required this.date,
    required this.weather,
    required this.courts,
    required this.courtId,
    required this.bookings,
  });

  NewBookingState copyWith({
    bool? isLoading,
    bool? firstLoad,
    bool? isSaved,
    bool? isError,
    String? alertMessage,
    String? name,
    String? date,
    String? weather,
    List? courts,
    String? courtId,
    List<Booking>? bookings,
  }) {
    return NewBookingState(
      firstLoad: firstLoad ?? this.firstLoad,
      isSaved: isSaved ?? this.isSaved,
      isError: isError ?? this.isError,
      alertMessage: alertMessage ?? this.alertMessage,
      name: name ?? this.name,
      date: date ?? this.date,
      weather: weather ?? this.weather,
      courts: courts ?? this.courts,
      courtId: courtId ?? this.courtId,
      bookings: bookings ?? this.bookings,
    );
  }

  @override
  List<Object> get props => [
        firstLoad,
        isSaved,
        isError,
        alertMessage,
        name,
        date,
        weather,
        courts,
        courtId,
        bookings,
      ];
}
