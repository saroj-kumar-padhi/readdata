import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:management/app/purohit_profile_mgmt/purohit_bank_details.dart';
import 'package:management/app/purohit_profile_mgmt/purohit_basic_details_form.dart';
import 'package:management/app/purohit_profile_mgmt/purohit_booking_details.dart';
import 'package:management/app/purohit_profile_mgmt/purohit_services_page.dart';
import 'package:management/app/purohit_profile_mgmt/purohit_uidai_details.dart';


class PurohitProfileLandingPage extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  const PurohitProfileLandingPage({
    Key? key,
    required this.documentSnapshot,
  }) : super(key: key);

  @override
  _PurohitProfileLandingPageState createState() =>
      _PurohitProfileLandingPageState();
}

class _PurohitProfileLandingPageState extends State<PurohitProfileLandingPage> {
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Purohit Dashboard"),
        ),
       // backgroundColor: Colors.white,
        drawer: Drawer(
          child: Column(
            children: [
              ListTile(
                title: const Text("Basic Details"),
                onTap: () {
                  setState(() {
                    currentPage = 1;
                  });
                },
              ),
              ListTile(
                title: const Text("Bank Details"),
                onTap: () {
                  setState(() {
                    currentPage = 2;
                  });
                },
              ),
              ListTile(
                title: const Text("UIDAI Details"),
                onTap: () {
                  setState(() {
                    currentPage = 3;
                  });
                },
              ),
              ListTile(
                title: const Text("Puja Ceremony Services Details"),
                onTap: () {
                  setState(() {
                    currentPage = 5;
                  });
                },
              ),
              ListTile(
                title: const Text("Booking Details"),
                onTap: () {
                  setState(() {
                    currentPage = 6;
                  });
                },
              ),
            ],
          ),
        ),
        body: currentPage == 1
            ? PurohitBasicDetailsForm(
                documentSnapshot: widget.documentSnapshot,
              )
            : currentPage == 2
                ? PurohitBankDetails(
                    uid: widget.documentSnapshot.id,
                  )
                : currentPage == 3
                    ? PurohitUidaiDetails(
                        uid: widget.documentSnapshot.id,
                      )
                    : currentPage == 5
                        ? PurohitServicesPage(
                            uid: widget.documentSnapshot.id,
                          )
                        : currentPage == 6
                            ? const PurohitBookingDetails()
                            : const Center(child: Text("Nothing here")));
  }
}
