import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class SfDatePickerDialog extends StatelessWidget {
  final TextEditingController controller;
  const SfDatePickerDialog({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return AlertDialog(
      title: Text(
          'Pilih Tanggal',
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
      ),
      backgroundColor: Colors.white,
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width,
        child: SfDateRangePicker(
          view: DateRangePickerView.month,
          monthViewSettings: DateRangePickerMonthViewSettings(
            firstDayOfWeek: 7,
            viewHeaderStyle: DateRangePickerViewHeaderStyle(
              textStyle: TextStyle(
                color: Colors.blueGrey[900],
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          headerStyle: DateRangePickerHeaderStyle(
            textStyle: TextStyle(
              color: Colors.blueGrey[900],
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          selectionMode: DateRangePickerSelectionMode.single,
          initialDisplayDate: controller.text.isNotEmpty
              ? formatter.parse(controller.text)
              : DateTime.now(),
          showNavigationArrow: true,
          todayHighlightColor: Colors.blueGrey[700],
          selectionColor: Colors.blueGrey[700],
          onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
            controller.text = formatter.format(args.value);
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            controller.text = '';
            Navigator.of(context).pop();
          },
          child: Text(
            'Batal',
            style: TextStyle(
              color: Colors.blueGrey[900],
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Pilih',
            style: TextStyle(
              color: Colors.blueGrey[900],
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
