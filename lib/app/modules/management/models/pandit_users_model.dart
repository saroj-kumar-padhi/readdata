import 'package:cloud_firestore/cloud_firestore.dart';

class Purohit {
  final DocumentSnapshot snapshot;

  Purohit(this.snapshot);

  dynamic get name => snapshot["pandit_name"];

  dynamic get bio => snapshot["pandit_bio"];

  dynamic get age => snapshot["pandit_age"];

  dynamic get mobile => snapshot["pandit_mobile_number"];

  dynamic get city => snapshot["pandit_city"];

  dynamic get state => snapshot["pandit_state"];

  dynamic get expertise => snapshot["pandit_expertise"];

  dynamic get experience => snapshot["pandit_experience"];

  dynamic get qualification => snapshot["pandit_qualification"];

  bool get verification => snapshot["pandit_verification_status"];

  dynamic get swastik => snapshot["pandit_swastik"];

  dynamic get profileUrl => snapshot["pandit_display_profile"] == null
      ? "https://lanecdr.org/wp-content/uploads/2019/08/placeholder.png"
      : snapshot["pandit_display_profile"];

  dynamic get coverUrl => snapshot["pandit_cover_profile"];

  dynamic get pictures => snapshot["pandit_pictures"] == null
      ? [null, null, null, null]
      : snapshot["pandit_pictures"];

  dynamic get type => snapshot["pandit_type"];

  dynamic get joining => snapshot["pandit_joining_date"];

  dynamic get update => snapshot["pandit_profile_update_date"];

  dynamic get language => snapshot["pandit_language"];

  dynamic get appLanguage => snapshot["pandit_app_language_code"];

  dynamic get email => snapshot["pandit_email"];

  dynamic get id => snapshot["pandit_id"];

  dynamic get uid => snapshot.id;
}