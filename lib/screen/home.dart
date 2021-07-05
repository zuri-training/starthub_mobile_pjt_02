import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starthub_mobile_pjt/models/projectModel.dart';
import 'package:starthub_mobile_pjt/providers/projects.dart';
import 'package:starthub_mobile_pjt/screen/profile.dart';
import 'package:starthub_mobile_pjt/widget/project_grid.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Icon customIcon = Icon(Icons.search);
  TextEditingController _searchController = TextEditingController();
  final scaffoldState = GlobalKey<ScaffoldState>();
  Widget customText = Text('Welcome!',
      style: GoogleFonts.inter(
        fontSize: 18.0,
      ));
  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  // void toggleSearch() {
  //   setState(() {
  //     if (customIcon.icon == Icons.search) {
  //       customIcon = Icon(Icons.cancel);
  //       customText = Container(
  //         height: 40,
  //         child: Padding(
  //           padding: const EdgeInsets.only(
  //             left: 20,
  //             right: 10.0,
  //           ),
  //           child: TextField(
  //             decoration: InputDecoration(
  //                 focusedBorder: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(20.0),
  //                   borderSide: BorderSide(
  //                     color: Colors.grey,
  //                     width: 2.0,
  //                   ),
  //                 ),
  //                 hintText: 'Seacrh for project/intern',
  //                 hintStyle: TextStyle(fontSize: 17.0),
  //                 border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(20.0))),
  //             textAlign: TextAlign.center,
  //             autofocus: true,
  //             textInputAction: TextInputAction.go,
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontSize: 15.0,
  //             ),
  //           ),
  //         ),
  //       );
  //     } else {
  //       this.customIcon = Icon(Icons.search);
  //       this.customText = Text('Welcome!',
  //           style: GoogleFonts.inter(
  //             fontSize: 20,
  //             fontWeight: FontWeight.w400,
  //           ));
  //     }
  //   });
  // }
  List<ProjectModel> _searchProject = [];
  @override
  Widget build(BuildContext context) {
    final projectData = Provider.of<Projects>(context);
    Size size = MediaQuery.of(context).size;

    _showSearchBox() {
      scaffoldState.currentState.showBottomSheet<void>((BuildContext context) {
        return Container(
            color: Colors.white,
            width: size.width,
            height: size.height * 0.45,
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(12)),
            child: Container(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 10.0,
                ),
                child: TextField(
                  onChanged: (value) {
                    _searchController.text;
                    // setState(() {
                    //   _searchProject =
                    //       projectData.searchQuery(value);
                    // });
                  },
                  controller: _searchController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      hintText: 'Search for project/intern',
                      hintStyle: TextStyle(fontSize: 17.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                  textAlign: TextAlign.center,
                  autofocus: true,
                  textInputAction: TextInputAction.go,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ));
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 10, left: 30, right: 30.0),
                child: Row(children: [
                  Text('Welcome Intern!',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      )),
                ])),
            VerticalSpacing(),
            Expanded(
              child: ProjectGrid(projectData.items),
            ),
            // Expanded(

            //   child: _searchProject.isEmpty
            //       ? Center(
            //           child: Text(
            //             'No Records Found',
            //             style: GoogleFonts.inter(
            //               fontSize: 23,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         )
            //       : ProjectGrid(_searchProject),
            // )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  
  final Icon customIcon = Icon(Icons.search);
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        height: size.height * 0.055,
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NavItem(
                    icon: Icons.home,
                    title: 'Home',
                    press: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home())),
                  ),
                  NavItem(
                      icon: Icons.search,
                      title: 'Search',
                      press: () {
                        Scaffold.of(context).showBottomSheet(
                          (context) => Container(
                            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                            width: size.width,
                            height: size.height*0.35,
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                borderRadius: BorderRadiusDirectional.circular(12)),
                child: TextField(
                  
                  onChanged: (value) {
                    _searchController.text;
                    // setState(() {
                    //   _searchProject =
                    //       projectData.searchQuery(value);
                    // });
                  },
                  controller: _searchController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                          width: 2.0,
                        ),
                      ),
                      hintText: 'Search for project/intern',
                      hintStyle: TextStyle(fontSize: 17.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                  textAlign: TextAlign.start,
                  // autofocus: true,
                  //textInputAction: TextInputAction.go,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
      
                          ),
                        );
                      }),
                  NavItem(
                      icon: Icons.people_rounded,
                      title: 'Profile',
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      })
                ]),
          ),
        ));
  }
}

class NavItem extends StatelessWidget {
  const NavItem({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.press,
    this.isActive = false,
  }) : super(key: key);
  final String title;
  final GestureTapCallback press;
  final bool isActive;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: press,
      child: Container(
        padding: EdgeInsets.all(5),
        width: size.width * 0.2,
        height: size.height * 0.06,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [if (isActive) kDefaultShadow],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.black),
            Spacer(),
            Text(
              title,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
