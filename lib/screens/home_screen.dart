import 'package:flutter/material.dart';
import 'package:ticket_app_v2/screens/book_ticket_screen.dart';
import 'package:ticket_app_v2/screens/notifications_sceen.dart';
import 'package:ticket_app_v2/screens/ticket_history_screen.dart';
import 'package:ticket_app_v2/screens/ticket_screen.dart';
import 'package:ticket_app_v2/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NotificationsScreen(),
                  ),
                );
              },
              tooltip: "Notifications",
              icon: const Icon(Icons.notifications_none_outlined),
            ),
            IconButton(
              onPressed: () async {
                await AuthService().signOut();
              },
              icon: const Icon(Icons.logout_outlined),
              tooltip: "Logout",
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: PageView(
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                _selectedIndex = page;
              });
            },
            children: [
              TicketsView(),
              BookTicketView(),
              TicketHistoryView(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 20.0,
          selectedItemColor: Colors.black,
          currentIndex: _selectedIndex,
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeIn,
            );
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Tickets",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.post_add_outlined,
              ),
              label: "Book Ticket",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history_outlined,
              ),
              label: "History",
            ),
          ],
        ),
      ),
    );
  }
}
