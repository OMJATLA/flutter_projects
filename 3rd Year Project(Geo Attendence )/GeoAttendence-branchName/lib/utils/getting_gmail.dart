import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseAuth auth = FirebaseAuth.instance;

Future<bool> getlist(gmail) async {
  dynamic gmails = [];
  await FirebaseDatabase.instance.ref().child('admins').once().then((value) {
    dynamic length = value.snapshot.children.length;
    for (int i = 1; i <= length; i++) {
      var data = value.snapshot.child(i.toString()).child('gmail').value;
      gmails.add(data);
    }
  });
  return gmails.contains(gmail) ? true : false;
}

Future<int> getid() async {
  dynamic stugmails = [];
  await FirebaseDatabase.instance.ref('Students').once().then((value) async {
    dynamic length = value.snapshot.children.length;
    for (int i = 1; i <= length; i++) {
      stugmails.add(value.snapshot.child(i.toString()).child('gmail').value);
    }
  });
  return (stugmails.indexOf(auth.currentUser!.email.toString()) + 1);
}

Future<int> getadid() async {
  dynamic adgmails = [];
  await FirebaseDatabase.instance.ref('admins').once().then((value) async {
    dynamic length = value.snapshot.children.length;
    for (int i = 1; i <= length; i++) {
      adgmails.add(value.snapshot.child(i.toString()).child('gmail').value);
    }
  });
  return (adgmails.indexOf(auth.currentUser!.email.toString()) + 1);
}

Future getadloc() async {
  dynamic lat;
  dynamic log;
  await FirebaseDatabase.instance.ref('admins').once().then((value) async {
    lat = value.snapshot.child('1').child('latitute').value;
    log = value.snapshot.child('1').child('longitude').value;
  });
  List li = [lat, log];
  return li;
}

Future? resetStudentData() async {
  DatabaseReference databaseref = FirebaseDatabase.instance.ref('Students');
  await FirebaseDatabase.instance.ref('Students').once().then((value) async {
    dynamic length = value.snapshot.children.length;
    for (int i = 1; i <= length; i++) {
      databaseref
          .child(i.toString())
          .update({'latitute': 0, 'longitude': 0, 'status': 'absent'});
    }
  });
  return null;
}
