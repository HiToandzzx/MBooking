import 'package:flutter/material.dart';
import 'package:movies_app_ttcn/view/tab_home/view_home_page.dart';
import 'package:movies_app_ttcn/view/tab_movie/view_movie_page.dart';
import 'package:movies_app_ttcn/view/tab_profile/view_profile_page.dart';
import 'package:movies_app_ttcn/view/tab_ticket/view_ticket_page.dart';

class BotNav extends StatefulWidget {
  const BotNav({super.key});

  @override
  State<BotNav> createState() => _BotNavState();
}

class _BotNavState extends State<BotNav> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: IndexedStack(
          index: index,
          children:  const [
            HomePage(),
            TicketPage(),
             MoviePage(
              initialTabIndex: 0,
            ),
            ProfilePage()
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(top: 15),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey,
                width: 0.2,
              ),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: index,
            items: const [
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.home_filled, color: Colors.amber, size: 30),
                icon: Icon(Icons.home_filled, color: Colors.white, size: 30),
                label: "Home",
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.confirmation_num, color: Colors.amber, size: 30),
                icon: Icon(Icons.confirmation_num_outlined, color: Colors.white, size: 30),
                label: "Ticket",
              ),
              BottomNavigationBarItem(
                  activeIcon: Icon(Icons.movie_rounded, color: Colors.amber, size: 30),
                  icon: Icon(Icons.movie_outlined, color: Colors.white, size: 30),
                  label: "Movie"
              ),
              BottomNavigationBarItem(
                  activeIcon: Icon(Icons.person, color: Colors.amber, size: 30),
                  icon: Icon(Icons.perm_identity, color: Colors.white, size: 30),
                  label: "Profile"
              )
            ],

            selectedItemColor: Colors.amber,

            onTap: (value) {
              setState(() {
                index = value;
              });
            },

            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold
            ),

            selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.bold
            ),

            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}

/*Widget _buildBody(BuildContext context, int index){
  switch (index) {
    case 0:
      return const HomePage();
    case 1:
      return const TicketPage();
    case 2:
      return const MoviePage();
    case 3:
      return const ProfilePage();
    default:
      return const HomePage();
  }
}*/


