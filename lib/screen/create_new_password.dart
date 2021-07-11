// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:starthub_mobile_pjt/widget/presets.dart';

// import '../constants.dart';
// import 'forget_password.dart';


// class CreateNewPassword extends StatefulWidget {
  

//   @override
//   _CreateNewPasswordState createState() => _CreateNewPasswordState();
// }

// class _CreateNewPasswordState extends State<CreateNewPassword> {
//    final newPasswordController = TextEditingController();
//   final confirmNewPasswordController = TextEditingController();
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();

//    var spacing = SizedBox(height: 15);

//   Widget _password() {
//     return NewerTextField(
//       hintText: 'Enter new password',
//       controller: newPasswordController,
    
//     );
//   }

//   Widget _confirmpassword() {
//     return NewerTextField(
//       hintText: 'Confirm new password',
//       controller: confirmNewPasswordController,
      
//     );
//   }

//    Widget _submitButton(
      

//       ) {
//     return NewButton(
//       buttonText: 'Reset password',
//       // onTap: pressed,
//     );
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(child: 
//       Form(
//         key: formKey,
//         autovalidateMode: AutovalidateMode.disabled,
//         child: Column(children: [
//            Text(
//               'Create new password',
//               style: GoogleFonts.raleway(
//                 fontSize: 25,
//                 fontWeight: FontWeight.w600,
//                 color: kPrimaryColor,
//               ),
//             ),
//             spacing,
//             Wrap(
//               children:[ Text(
//                 'Your new password must be different from previous used passwords',
//                 style: GoogleFonts.openSans(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               ]
//             ),
//             spacing,
//           _password(),
//           spacing,
//           _confirmpassword(),
//           spacing,
//           _submitButton(),

//         ],))),
      
//     );
//   }
// }