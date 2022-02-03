import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ticket_app_v2/custom_widgets/code_generator.dart';
import 'package:ticket_app_v2/custom_widgets/snackbar.dart';
import 'package:ticket_app_v2/models/ticket_model.dart';
import 'package:ticket_app_v2/services/ticket_service.dart';

class BookTicketView extends StatefulWidget {
  BookTicketView({Key? key}) : super(key: key);

  @override
  State<BookTicketView> createState() => _BookTicketViewState();
}

class _BookTicketViewState extends State<BookTicketView> {
  bool _isLoading = false;
  List<String> locations = [
    "Lefke",
    "Guzelyurt",
    "Lefkosa",
    "Girne",
    "Magusa",
    "Iskele",
  ];
  String? locationValue, destinationValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: const Text("Choose Location"),
                  value: locationValue,
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      locationValue = value;
                    });
                  },
                  items: locations.map(buildDropdown).toList(),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: const Text("Choose Destination"),
                  value: destinationValue,
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      destinationValue = value;
                    });
                  },
                  items: locations.map(buildDropdown).toList(),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                if (destinationValue != null &&
                    locationValue != null &&
                    destinationValue != locationValue) {
                  setState(() {
                    _isLoading = true;
                  });
                  String res = await TicketService().bookTicket(
                    locationValue: locationValue!,
                    destinationValue: destinationValue!,
                  );
                  if (res == "success") {
                    setState(() {
                      _isLoading = false;
                    });
                    snackBar(context, "Your ticket has been booked");
                  } else {
                    snackBar(context, res);
                  }
                } else if (destinationValue != null && locationValue == null) {
                  snackBar(context, "Select a location");
                } else if (destinationValue == null && locationValue != null) {
                  snackBar(context, "Select a destination");
                } else if (destinationValue == locationValue &&
                    destinationValue != null &&
                    locationValue != null) {
                  snackBar(context,
                      "Oops...it seems you're going to the same place");
                } else {
                  snackBar(context, "Select a location and destination");
                }
                setState(() {
                  _isLoading = false;
                });
                destinationValue = null;
                locationValue = null;
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
                primary: Colors.black,
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.0,
                    )
                  : const Text(
                      "Book Ticket",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildDropdown(String item) {
    return DropdownMenuItem<String>(
      value: item,
      child: Text(item),
    );
  }
}
