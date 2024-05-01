// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ictc_admin/pages/courses/courses_page.dart';
import 'package:ictc_admin/pages/dashboard/dashboard.dart';
import 'package:ictc_admin/pages/finance/finance_page.dart';
import 'package:ictc_admin/pages/programs/programs_page.dart';
import 'package:ictc_admin/pages/trainers/trainers_page.dart';
import 'package:ictc_admin/pages/trainees/trainees_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  void logout() async {
    await Supabase.instance.client.auth.signOut();
  }

  String getSearchName() {
    List<String> pageNames = const [
      "Dashboard",
      "Trainers",
      "Trainees",
      "Programs",
      "Courses",
    ];

    return pageNames[_selectedIndex];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> views = [
      const FinancePage(),
      const TrainersPage(),
      const TraineesPage(),
      const ProgramsPage(),
      const CoursesPage(),
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
          "Reports",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.person_outline_rounded,
          color: Colors.white,
          size: 30,
        ),
        selectedIcon: Icon(
          Icons.person_rounded,
          color: Colors.white,
          size: 30,
        ),
        label: Text(
          "Trainers",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
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
            fontWeight: FontWeight.w400,
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
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.book_outlined,
          color: Colors.white,
          size: 30,
        ),
        selectedIcon: Icon(
          Icons.book_rounded,
          color: Colors.white,
          size: 30,
        ),
        label: Text(
          "Courses",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (true) {
          return Scaffold(
            backgroundColor: const Color(0xfff1f5fb),
            body: Row(
              children: [
                Container(
                    // decoration: const BoxDecoration(
                    //     border: Border(bottom: BorderSide(width: 2))),
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

        return Scaffold(
          body: buildPageView(views),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Reports"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Trainers"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.group), label: "Students"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.grid_view), label: "Programs"),
              BottomNavigationBarItem(icon: Icon(Icons.book), label: "Courses"),
            ],
            onTap: onDestinationChanged,
          ),
        );
      },
    );
  }

  Container buildBar(BuildContext context) {
    return Container(
        color: const Color(0xfff1f5fb),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        height: 80,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          _selectedIndex != 0
              ? AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  transitionBuilder: (child, animation) => SlideTransition(
                      position: Tween<Offset>(
                              begin: const Offset(0.0, -3),
                              end: const Offset(0.0, 0.0))
                          .animate(animation),
                      child: child),
                  child: Row(
                    children: [
                      Text(
                        getSearchName(),
                        key: ValueKey<String>(getSearchName()),
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      buildCounter(context),
                      //TODO: need backend - FOR TOTAL# (remove it if page is on dashboard).
                    ],
                  ),
                )
              : AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  transitionBuilder: (child, animation) => SlideTransition(
                      position: Tween<Offset>(
                              begin: const Offset(0.0, -3),
                              end: const Offset(0.0, 0.0))
                          .animate(animation),
                      child: child),
                  child: const Row(
                    children: [
                      Text(
                        "Welcome, Admin",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      //TODO: need backend - FOR TOTAL# (remove it if page is on dashboard).
                    ],
                  ),
                ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildSearchBar(context),
              SizedBox(width: MediaQuery.of(context).size.width * 0.2),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                ),
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     FilledButton.icon(
                //       style: ButtonStyle(
                //         enableFeedback: false,
                //         splashFactory: NoSplash.splashFactory,
                //         iconSize: MaterialStateProperty.all(23),
                //         maximumSize: MaterialStateProperty.all(Size.fromWidth(
                //             MediaQuery.of(context).size.height * 1)),
                //         backgroundColor: MaterialStateProperty.all(
                //           Color(0xfff1f5fb),
                //         ),
                //         elevation: MaterialStateProperty.all(0.5),
                //       ),

                //       label: const Text(
                //         "Welcome, Admin",
                //         style: TextStyle(color: Colors.black, fontSize: 14),
                //       ),
                //       icon: Icon(
                //         CupertinoIcons.person_alt_circle,
                //         color: Color(0xff19306B),
                //       ),
                //       // child: ,
                //       onPressed:
                // () {}, //TODO: Add a dropdown for profile settings: to change admin pass and user
                //     ),
                //   ],
                // ),
              ),
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
              constraints: BoxConstraints(
                  minWidth: 80.0,
                  maxWidth: MediaQuery.of(context).size.width * 0.3,
                  maxHeight: 70,
                  minHeight: 60),
              controller: searchController,
              elevation: const MaterialStatePropertyAll(1),
              leading: const Icon(Icons.search),
              hintText: "Search ${getSearchName()}...",
              textStyle: MaterialStatePropertyAll(
                  Theme.of(context).textTheme.bodyMedium),
              trailing: [
                IconButton(
                    splashRadius: 15,
                    onPressed: () {
                      searchController.clear();
                    },
                    icon: const Icon(Icons.clear))
              ],
            )
          : Container(key: key),
    );
  }

  Widget buildCounter(BuildContext context) {
    const key = ValueKey("counter");
    return AnimatedSwitcher(
      key: key,
      duration: const Duration(milliseconds: 350),
      child: _selectedIndex != 0
          ? const Text(
              "15",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black26),
            )
          : Container(key: key),
    );
  }

  NavigationRail buildNavRail(List<NavigationRailDestination> destinations) {
    return NavigationRail(
      backgroundColor: const Color(0xff19306B),
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
          padding: EdgeInsets.only(top: 20.0, bottom: 20),
          child: Image(
              image: AssetImage("assets/images/logo_ictc.png"), height: 60),
        ),
        Padding(
            padding: EdgeInsets.only(left: 8, top: 0, bottom: 0),
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
            onPressed: logout,
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
