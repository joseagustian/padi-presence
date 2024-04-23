import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/shared/presenters/maps/detail_attendance_maps_widget.dart';

import '../record_history_list/attendance_record_history_card.dart';

class RecordHistoryDetailWorkLocation extends StatelessWidget {
  final WorkType? workType;
  final String? workDuration;
  final String checkInLat;
  final String checkInLong;
  final String? checkOutLat;
  final String? checkOutLong;
  const RecordHistoryDetailWorkLocation({
    super.key,
    this.workType,
    this.workDuration,
    required this.checkInLat,
    required this.checkInLong,
    this.checkOutLat,
    this.checkOutLong,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.workFrom,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey.shade700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          workType == WorkType.wfo ? Strings.workFromOffice : Strings.workFromHome,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey.shade500,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                        workType == WorkType.wfo ? Bootstrap.building : Icons.home_work_outlined,
                          size: 16,
                          color: Colors.blueGrey.shade500,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.workDuration,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey.shade700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      workDuration ?? '--:--',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey.shade500
                      ),
                    ),
                  ],
                ),
              )
            ]
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.checkInLocation,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey.shade700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    DetailAttendanceMapsWidget(
                      height: MediaQuery.of(context).size.height * 0.2,
                      lat: double.parse(checkInLat),
                      long: double.parse(checkInLong),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.checkOutLocation,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey.shade700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    DetailAttendanceMapsWidget(
                      height: MediaQuery.of(context).size.height * 0.2,
                      lat: checkOutLat != null && checkOutLat!.isNotEmpty ? double.parse(checkOutLat!) : null,
                      long: checkOutLong != null && checkOutLong!.isNotEmpty ? double.parse(checkOutLong!) : null,
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
