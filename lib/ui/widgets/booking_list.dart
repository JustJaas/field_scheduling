import 'package:field_scheduling/ui/blocs/NewBookingBloc/new_booking_bloc.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingList extends StatefulWidget {
  const BookingList({super.key});

  @override
  State<BookingList> createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewBookingBloc, NewBookingState>(
      listener: (context, state) {
        if (state.isSaved) {
          context.read<NewBookingBloc>().add(ChangeSaved());
          showFlash(
            context: context,
            duration: const Duration(seconds: 5),
            builder: (context, controller) {
              return Flash.bar(
                barrierDismissible: false,
                controller: controller,
                backgroundColor: Colors.white,
                position: FlashPosition.top,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: FlashBar(
                  content: Text(
                    state.alertMessage,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
      builder: (context, state) {
        if (state.firstLoad) {
          context.read<NewBookingBloc>().add(GetBookings());
        }
        return ListView.builder(
          itemCount: state.bookings.length,
          itemBuilder: (context, index) {
            return Card(
              shadowColor: Colors.green,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Cancha: ${state.bookings[index].courtId}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text('Cliente: ${state.bookings[index].name}'),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text('Fecha: ${state.bookings[index].date}'),
                        const SizedBox(height: 4),
                        Text('Clima: ${state.bookings[index].weather}'),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {
                        showFlash(
                          context: context,
                          duration: const Duration(seconds: 5),
                          builder: (context, controller) {
                            return Flash.bar(
                              barrierDismissible: false,
                              controller: controller,
                              backgroundColor: Colors.white,
                              borderColor: Colors.green,
                              position: FlashPosition.bottom,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              child: FlashBar(
                                content: Column(
                                  children: [
                                    const Text(
                                      '¿Estas seguro que quieres eliminar este registro?',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          child: const Text(
                                            'Cancelar',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          onPressed: () {
                                            controller.dismiss();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text(
                                            'Confirmar',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          onPressed: () {
                                            context.read<NewBookingBloc>().add(
                                                DeleteBooking(
                                                    bookingId: state
                                                        .bookings[index].id));
                                            controller.dismiss();
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
