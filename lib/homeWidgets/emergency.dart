import 'package:flutter/cupertino.dart';

import 'emergencies/ambulanceemergency.dart';
import 'emergencies/firebrigadeemergency.dart';
import 'emergencies/policeemergency.dart';
import 'emergencies/womenemergency.dart';

class Emergency extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 180,
        child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              PoliceEmergency(),
              AmbulanceEmergency(),
              FirebrigadeEmergency(),
              WomenEmergency()
            ]));
  }
}
