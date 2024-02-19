// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ictc_admin/pages/auth/login_page.dart';
import 'package:ictc_admin/pages/courses_page.dart';
import 'package:ictc_admin/pages/dashboard.dart';
import 'package:ictc_admin/pages/programs_page.dart';
import 'package:ictc_admin/pages/trainers_page.dart';
import 'package:ictc_admin/pages/trainees_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;
  PageController pageController = PageController(
    keepPage: true,
  );
  SearchController searchController = SearchController();

  void onDestinationChanged(int value) {
    setState(() {
      _selectedIndex = value;
      pageController.animateToPage(value,
          duration: const Duration(milliseconds: 400), curve: Curves.ease);
    });
  }

  // void logout() async {
  //   await FirebaseAuth.instance.signOut();
  // }

  String getSearchName() {
    List<String> pageNames = const [
      "Dashboard",
      "Trainers",
      "Trainees",
      "Programs"
    ];

    return pageNames[_selectedIndex];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> views = [
      const DashboardPage(),
      TrainersPage(),
      const TraineesPage(),
      const ProgramsPage(),
    ];

    List<NavigationRailDestination> destinations = const [
      NavigationRailDestination(
        icon: Icon(
          Icons.home_outlined,
          color: Colors.white,
          size: 30,
        ),
        selectedIcon: Icon(
          Icons.home_rounded,
          color: Colors.white,
          size: 30,
        ),
        label: Text(
          "Dashboard",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.person_outline,
          color: Colors.white,
          size: 30,
        ),
        selectedIcon: Icon(
          Icons.person,
          color: Colors.white,
          size: 30,
        ),
        label: Text(
          "Trainers",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.group_outlined,
          color: Colors.white,
          size: 30,
        ),
        selectedIcon: Icon(
          Icons.group,
          color: Colors.white,
          size: 30,
        ),
        label: Text(
          "Trainees",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.grid_view_outlined,
          color: Colors.white,
          size: 30,
        ),
        selectedIcon: Icon(
          Icons.grid_view_rounded,
          color: Colors.white,
          size: 30,
        ),
        label: Text(
          "Programs",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Color(0xfff1f5fb),
      body: Row(
        children: [
          Container(
              decoration: const BoxDecoration(
                  border: Border(right: BorderSide(width: 0.5))),
              child: buildNavRail(destinations)),
          Expanded(
            child: Column(
              children: [
                buildBar(context),
                buildPageView(views),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container buildBar(BuildContext context) {
    return Container(
        color: const Color(0xfff1f5fb),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 64,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            transitionBuilder: (child, animation) => SlideTransition(
                position: Tween<Offset>(
                        begin: const Offset(0.0, -3),
                        end: const Offset(0.0, 0.0))
                    .animate(animation),
                child: child),
            child: Text(
              getSearchName(),
              key: ValueKey<String>(getSearchName()),
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildSearchBar(context),
              const SizedBox(width: 0),
              // ProfileDropdown(
              //   onSettingsTap: state.openSettings,
              // )
            ],
          )
        ]));
  }

  Widget buildSearchBar(BuildContext context) {
    const key = ValueKey("searchbar");
    return AnimatedSwitcher(
      key: key,
      duration: const Duration(milliseconds: 350),
      child: _selectedIndex != 0
          ? SearchBar(
              constraints: const BoxConstraints(
                  minWidth: 80.0,
                  maxWidth: 250,
                  maxHeight: 100,
                  minHeight: 100),
              controller: searchController,
              elevation: const MaterialStatePropertyAll(1),
              leading: const Icon(Icons.search),
              hintText: "Search ${getSearchName()}...",
              textStyle: MaterialStatePropertyAll(
                  Theme.of(context).textTheme.bodyMedium),
              trailing: [
                IconButton(
                    onPressed: () {
                      searchController.clear();
                    },
                    icon: const Icon(Icons.clear))
              ],
            )
          : Container(key: key),
    );
  }

  NavigationRail buildNavRail(List<NavigationRailDestination> destinations) {
    return NavigationRail(
      backgroundColor: Color(0xff19306B),
      destinations: destinations,
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int value) {
        setState(() {
          _selectedIndex = value;
          pageController.animateToPage(value,
              duration: const Duration(milliseconds: 400), curve: Curves.ease);
        });
      },
      useIndicator: false,
      extended: true,
      leading: buildLeading(),
      trailing: buildTrailing(context),
    );
  }

  Row buildLeading() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 40.0, bottom: 30),
          child: Image(
              image: AssetImage("assets/images/logo_ictc.png"), height: 60),
        ),
        Padding(
            padding: EdgeInsets.only(left: 10, top: 30, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ateneo ICTC",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Text("Web Admin",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffffc947)))
              ],
            ))
      ],
    );
  }

  Expanded buildTrailing(context) {
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 256,
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.only(bottom: 24, left: 16),
          child: TextButton.icon(
            icon: const Icon(
              Icons.logout_outlined,
              size: 25,
              color: Colors.white,
            ),
            label: const Text(
              "Log out",
              style: TextStyle(
                letterSpacing: 0,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            // onPressed: state.logout,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
          ),
        ),
      ],
    ));
  }

  Expanded buildPageView(List<Widget> views) {
    return Expanded(
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: views,
      ),
    );
  }
}

class ProfileDropdown extends StatefulWidget {
  const ProfileDropdown({
    super.key,
    required this.onSettingsTap,
  });

  final Function()? onSettingsTap;

  @override
  State<ProfileDropdown> createState() => _ProfileDropdownState();
}

class _ProfileDropdownState extends State<ProfileDropdown> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          PopupMenuButton<String>(
            offset: Offset.zero,
            position: PopupMenuPosition.under,
            icon: const Icon(Icons.arrow_drop_down, size: 25),
            tooltip: 'Profile',
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  onTap: widget.onSettingsTap,
                  child: const Text(
                    "Settings",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                  ),
                ),
              ];
            },
          ),
        ]);
  }
}
