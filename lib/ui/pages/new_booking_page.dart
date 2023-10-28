import 'package:field_scheduling/ui/blocs/NewBookingBloc/new_booking_bloc.dart';
import 'package:flash/flash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewBookingPage extends StatefulWidget {
  const NewBookingPage({super.key});

  @override
  State<NewBookingPage> createState() => _NewBookingPageState();
}

class _NewBookingPageState extends State<NewBookingPage> {
  TextEditingController dateField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewBookingBloc, NewBookingState>(
      listener: (context, state) {
        if (state.isSaved) {
          Navigator.pop(context);
        }
        if (state.isError) {
          showFlash(
            context: context,
            duration: const Duration(seconds: 5),
            builder: (context, controller) {
              return Flash.bar(
                barrierDismissible: false,
                controller: controller,
                backgroundColor: Colors.red,
                position: FlashPosition.top,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: FlashBar(
                  content: Text(
                    state.alertMessage,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          );
          context.read<NewBookingBloc>().add(ChangeError(isError: false));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Agendar",
              style: TextStyle(
                letterSpacing: 6,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    shadowColor: Colors.green,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: 60,
                        child: InkWell(
                          onTap: () {
                            DatePicker.showDatePicker(
                              context,
                              currentTime: DateTime.now(),
                              locale: LocaleType.es,
                              showTitleActions: true,
                              minTime:
                                  DateTime.now().add(const Duration(days: 1)),
                              maxTime:
                                  DateTime.now().add(const Duration(days: 5)),
                              onConfirm: (date) {
                                context.read<NewBookingBloc>().add(EditDate(
                                    date: DateFormat('dd/MM/yyyy')
                                        .format(date)
                                        .toString()));
                                dateField.text = DateFormat('dd/MM/yyyy')
                                    .format(date)
                                    .toString();
                              },
                            );
                          },
                          child: TextFormField(
                            controller: dateField,
                            keyboardType: TextInputType.text,
                            enabled: false,
                            decoration: const InputDecoration(
                                labelText: 'Fecha',
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Colors.black54,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    shadowColor: Colors.green,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: "Cancha",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                        ),
                        child: SizedBox(
                          height: 30,
                          child: DropdownButton(
                            underline: const SizedBox(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                            isExpanded: true,
                            hint: Text(
                              state.courts
                                  .where((element) =>
                                      element.toString() == state.courtId)
                                  .first,
                              style: const TextStyle(color: Colors.black),
                            ),
                            items: state.courts.map((item) {
                              return DropdownMenuItem(
                                value: item.toString(),
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (value) {
                              context
                                  .read<NewBookingBloc>()
                                  .add(EditCourt(courtId: value.toString()));
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    shadowColor: Colors.green,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                        ),
                        child: SizedBox(
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Clima: ",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              Text(
                                state.weather,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    shadowColor: Colors.green,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        onChanged: (String value) {
                          context
                              .read<NewBookingBloc>()
                              .add(EditName(name: value));
                        },
                        decoration: const InputDecoration(
                          labelText: "Usuario",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(5),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    onPressed: () {
                      context.read<NewBookingBloc>().add(SaveBooking());
                    },
                    child: const Text(
                      "Registrar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
