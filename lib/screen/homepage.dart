import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:starthub_mobile_pjt/models/home_view_model.dart';
import 'package:starthub_mobile_pjt/models/projectModel.dart';
import 'package:starthub_mobile_pjt/providers/projects.dart';
import 'package:starthub_mobile_pjt/widget/project_grid.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Icon customIcon = Icon(Icons.search);
  TextEditingController _searchController = TextEditingController();

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
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () =>HomeViewModel(),
        onModelReady: (model) => model.listenToProject(),
        builder: (context, model, child) {
          return Scaffold(
              body: SafeArea(
            child: Column(
              children: <Widget>[
                VerticalSpacing(),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 30, right: 30.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: customText),
                          IconButton(
                              icon: customIcon,
                              onPressed: () {
                                setState(() {
                                  if (customIcon.icon == Icons.search) {
                                    customIcon = Icon(Icons.cancel);
                                    customText = Container(
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 10.0,
                                        ),
                                        child: TextField(
                                          onChanged: (value) {
                                            _searchController.text;
                                            setState(() {
                                              _searchProject = projectData
                                                  .searchQuery(value);
                                            });
                                          },
                                          controller: _searchController,
                                          decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 2.0,
                                                ),
                                              ),
                                              hintText:
                                                  'Search for project/intern',
                                              hintStyle:
                                                  TextStyle(fontSize: 17.0),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0))),
                                          textAlign: TextAlign.center,
                                          autofocus: true,
                                          textInputAction: TextInputAction.go,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    this.customIcon = Icon(Icons.search);
                                    this.customText = Text('Welcome!',
                                        style: GoogleFonts.inter(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                        ));
                                  }
                                });
                              }),
                        ])),
                Expanded(
                  child: ProjectGrid(projectData.items),
                ),
                Expanded(
                  
                  child: _searchProject.isEmpty
                      ? Center(
                          child: Text(
                            'No Records Found',
                            style: GoogleFonts.inter(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : ProjectGrid(_searchProject),
                )
              ],
            ),
          ));
        });
  }
}
