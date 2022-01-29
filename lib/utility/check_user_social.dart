import 'package:cloud_firestore/cloud_firestore.dart';


class CheckUserSocial {
  final String uidChecked;
  CheckUserSocial({
    required this.uidChecked,
  });

  Future<bool> processCheckUserSocial() async {
    
    

    var result = await FirebaseFirestore.instance
        .collection('social')
        .doc(uidChecked)
        .get();

    if (result.data() != null) {
      return true;
    } else {
      return false;
    }
  }
}
