import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ticket_app_v2/custom_widgets/ticket_card_widget.dart';
import 'package:ticket_app_v2/models/ticket_model.dart';

class TicketsView extends StatefulWidget {
  TicketsView({Key? key}) : super(key: key);

  @override
  _TicketsViewState createState() => _TicketsViewState();
}

class _TicketsViewState extends State<TicketsView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(_auth.currentUser!.uid)
              .collection("tickets")
              .where("usedTicket" "==" "false")
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.0,
                ),
              );
            }

            return ListView.builder(
              itemBuilder: (context, index) => TicketCard(
                context: context,
                ticket: Ticket.fromSnap(snapshot.data!.docs[index]),
              ),
              itemCount: snapshot.data!.docs.length,
            );
          }),
    );
  }
}
