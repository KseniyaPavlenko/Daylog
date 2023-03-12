// TODO(Kseniya): Удали файл

// import 'package:daylog/widgets/text_fields/common_text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class DateSelector extends StatelessWidget {
//    DateSelector({Key? key}) : super(key: key);

//   final TextEditingController Enddateinput = TextEditingController();
  
//   @override
//   Widget build(BuildContext context) {
//     return CommonTextField(
//       controller: Enddateinput,
//                       hintText: "Choose End Date",
//                       icon: const Icon(Icons.edit_calendar_outlined),
//                       onTap: () async {
//     DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2000),
//         lastDate: DateTime(2101));

//     if (pickedDate != null) {
//       print(pickedDate);
//       String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//       print(formattedDate);

//       // setState(() {
//       //   Enddateinput.text = formattedDate;
//       // });
//     } else {
//       print("Date is not selected");
//     }
//   },
//     );
//   }
// }
