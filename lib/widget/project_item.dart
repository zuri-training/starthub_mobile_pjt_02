import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starthub_mobile_pjt/screen/project-detail.dart';

class ProjectItem extends StatelessWidget {
  final String productId;
  final String productTitle;
  final String imageUrl;
  final String projectOwner;
  final String stack;

  ProjectItem(
    this.productTitle,
    this.productId,
    this.imageUrl,
    this.projectOwner,
    this.stack,
  );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
      child: GridTile(
        footer: Container(
          height: 100,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productTitle,
                  style: GoogleFonts.inter(
                      fontSize: 17.0,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  projectOwner,
                  style: GoogleFonts.inter(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 7.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      stack,
                      style: GoogleFonts.inter(
                        fontSize: 13.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProjectDetailScreen.routeName,
              arguments: productId,
            );
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
