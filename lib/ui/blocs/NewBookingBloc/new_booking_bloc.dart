import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:field_scheduling/data/database/booking_db.dart';
import 'package:field_scheduling/data/database/booking_model.dart';
import 'package:field_scheduling/data/services/weather_service.dart';
import 'package:intl/intl.dart';

part 'new_booking_event.dart';
part 'new_booking_state.dart';

class NewBookingBloc extends Bloc<NewBookingEvent, NewBookingState> {
  NewBookingBloc()
      : super(const NewBookingState(
          firstLoad: true,
          isSaved: false,
          isError: false,
          alertMessage: '',
          name: '',
          date: '',
          weather: '',
          courts: ['A', 'B', 'C'],
          courtId: 'A',
          bookings: [],
        )) {
    on<NewBookingEvent>((event, emit) async {
      // final data = await WeatherService().getData(courtId);
    });

    on<GetBookings>((event, emit) async {
      final bookingDB = BookingDB();
      await bookingDB
          .fetchAll()
          .then((value) => emit(state.copyWith(bookings: value)));
    });

    on<DeleteBooking>((event, emit) async {
      final bookingDB = BookingDB();
      await bookingDB.delete(event.bookingId);
      add(GetBookings());
    });

    on<ChangeError>((event, emit) {
      emit(state.copyWith(isError: !state.isError));
    });

    on<ChangeSaved>((event, emit) {
      emit(state.copyWith(isSaved: false));
    });

    on<EditCourt>((event, emit) async {
      print(event.courtId);
      print(state.date);
      emit(state.copyWith(courtId: event.courtId));
      final data = await WeatherService().getData(event.courtId);

      for (var element in data.list!) {
        String date = DateFormat('dd/MM/yyyy').format(element.dtTxt!);
        if (date == state.date) {
          emit(state.copyWith(weather: element.weather![0].description));
          break;
        }
      }
    });

    on<EditDate>((event, emit) {
      emit(state.copyWith(date: event.date));
      add(EditCourt(courtId: state.courtId));
    });

    on<EditName>((event, emit) => emit(state.copyWith(name: event.name)));

    on<SaveBooking>((event, emit) async {
      final bookingDB = BookingDB();

      await bookingDB
          .fetchByCourt(state.courtId, state.date)
          .then((value) async {
        if (value <= 2) {
          await bookingDB.create(
            name: state.name,
            date: state.date,
            weather: state.weather,
            courtId: state.courtId,
          );
          add(GetBookings());
          emit(state.copyWith(
            isSaved: true,
            alertMessage: 'Se registró con éxito!',
          ));
        } else {
          add(ChangeError(isError: true));
          emit(state.copyWith(
            alertMessage:
                'La cancha ${state.courtId} ha alcanzado su límite para la fecha ${state.date}',
          ));
        }
      });
    });
  }
}
