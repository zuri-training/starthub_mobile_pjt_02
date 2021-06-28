import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:starthub_mobile_pjt/authentication/sign_up.dart';
import 'package:starthub_mobile_pjt/models/startup_view_model.dart';
import 'package:starthub_mobile_pjt/widget/project_grid.dart';

import '../constants.dart';

class ProjectScreen extends StatefulWidget {
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  Icon customIcon = Icon(Icons.search);

  Widget customText = Text(
    'Welcome!',
    style: GoogleFonts.inter(
      fontSize: 18.0,
      
    )
  );

  void toggleSearch() {
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
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                  hintText: 'Seacrh for project/intern',
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
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      viewModelBuilder: ()=>StartUpViewModel(),
      onModelReady: (model) =>model.handleStartUpLogic() ,
      builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 30, right: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: customText),
                      IconButton(icon: customIcon, onPressed: toggleSearch)
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: Text('Signup to showcase your project!',
                          style: GoogleFonts.inter(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: kPrimaryColor,
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: ProjectGrid(),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
