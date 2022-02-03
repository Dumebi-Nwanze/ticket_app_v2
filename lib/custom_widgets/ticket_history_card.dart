import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticket_app_v2/models/ticket_model.dart';

Widget TicketHistoryCard({required Ticket ticket}) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ticket.usedTicket == "true" ? "Used" : "Not Used",
                style: TextStyle(
                  color:
                      ticket.usedTicket == "true" ? Colors.green : Colors.red,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
