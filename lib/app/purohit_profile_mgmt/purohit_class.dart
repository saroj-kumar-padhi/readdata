import 'package:cloud_firestore/cloud_firestore.dart';

class Purohit {
  final DocumentSnapshot snapshot;

  Purohit(this.snapshot);

  dynamic get name => snapshot.get("pandit_name");

  dynamic get bio => snapshot.get("pandit_bio");

  dynamic get age => snapshot.get("pandit_age");

  dynamic get mobile => snapshot.get("pandit_mobile_number");

  dynamic get city => snapshot.get("pandit_city");

  dynamic get state => snapshot.get("pandit_state");

  dynamic get expertise => snapshot.get("pandit_expertise");

  dynamic get experience => snapshot.get("pandit_experience");

  dynamic get qualification => snapshot.get("pandit_qualification");

  bool get verification => snapshot.get("pandit_verification_status");

  dynamic get swastik => snapshot.get("pandit_swastik");

  dynamic get profileUrl => snapshot.get("pandit_display_profile") ?? "https://lanecdr.org/wp-content/uploads/2019/08/placeholder.png";

  dynamic get coverUrl => snapshot.get("pandit_cover_profile");

  dynamic get pictures => snapshot.get("pandit_pictures") ?? [null, null, null, null];

  dynamic get type => snapshot.get("pandit_type");

  dynamic get joining => snapshot.get("pandit_joining_date");

  dynamic get update => snapshot.get("pandit_profile_update_date");

  dynamic get language => snapshot.get("pandit_language");

  dynamic get appLanguage => snapshot.get("pandit_app_language_code");

  dynamic get email => snapshot.get("pandit_email");

  dynamic get id => snapshot.get("pandit_id");

  dynamic get uid => snapshot.id;
}
