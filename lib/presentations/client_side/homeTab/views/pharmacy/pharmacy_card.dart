import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

import '../../../../../constants/colors.dart';
import '../../../../../models/pharmacy.dart';

class PharmacyCard extends StatelessWidget {
  const PharmacyCard({Key? key, required this.pharmacy}) : super(key: key);

  final PharmacyModel pharmacy;

  @override
  Widget build(BuildContext context) {
    _callNumber() async {
      final number = pharmacy.pharmacyPhone; // set the number here
      await FlutterPhoneDirectCaller.callNumber(number.toString());
    }

    _openMap() async {
      final String pharmacyName = pharmacy.pharmacyName.toString();
      final String encodedPharmacyName = Uri.encodeComponent(pharmacyName);
      final String googleMapsUrl =
          'https://www.google.com/maps/search/?api=1&query=$encodedPharmacyName';

      await launcher.launchUrl(Uri.parse(googleMapsUrl));
    }

    final Size size = MediaQuery.of(context).size;
    final double maxWidth = size.width;
    final double iconSize = maxWidth * 0.15;
    final double textWidth = maxWidth - iconSize - 16;

    return Container(
      height: size.height * .15,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.local_pharmacy,
                  size: iconSize, color: AppColor.primaryColor),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: textWidth,
                      child: Text(
                        pharmacy.pharmacyName.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      pharmacy.pharmacyEmail.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 12),
                    ),
                    Text(pharmacy.pharmacyLocation.toString()),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: _callNumber,
                    child: CircleAvatar(
                        radius: iconSize / 3,
                        backgroundColor: AppColor.primaryColor,
                        child: Icon(Icons.call,
                            size: iconSize * 0.35, color: Colors.white)),
                  ),
                  InkWell(
                    //open map with the pharmacy location
                    onTap: _openMap,
                    child: CircleAvatar(
                        radius: iconSize / 3,
                        backgroundColor: AppColor.primaryColor,
                        child: Icon(Icons.map,
                            size: iconSize * 0.35, color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
