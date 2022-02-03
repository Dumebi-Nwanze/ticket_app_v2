import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticket_app_v2/custom_widgets/snackbar.dart';
import 'package:ticket_app_v2/models/ticket_model.dart';
import 'package:ticket_app_v2/services/ticket_service.dart';

Widget TicketCard({required BuildContext context, required Ticket ticket}) {
  if (ticket.usedTicket == "false") {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ticket.ticketCode,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text(
                  "Location: ${ticket.location}",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  width: 24,
                ),
                Text(
                  "Destination: ${ticket.destination}",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text(
                  "Issued: ${DateFormat("KK:mm a").format(ticket.timeBooked)}",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  width: 24,
                ),
                Text(
                  "Expires: ${DateFormat("KK:mm a").format(ticket.timeExpired)}",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    String res =
                        await TicketService().useTicket(ticket.ticket_id);
                    if (res == "success") {
                      snackBar(context, "Simulates a QR scan or something");
                    } else {
                      snackBar(context, res);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    primary: Colors.black,
                  ),
                  child: const Text(
                    "Use",
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
          ],
        ),
      ),
    );
  } else {
    return const SizedBox.shrink();
  }
}
