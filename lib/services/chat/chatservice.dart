import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yaca/model/message.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Chatservice {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getuser() {
    return firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //messaging core
  Future<void> sendmesg(String recevid, msg) async {
    final String currid = auth.currentUser!.uid;

    final String? curremail = auth.currentUser!.email;

    final Timestamp msgtime = Timestamp.now();

    Message newmsg = Message(
      senderid: currid,
      senderemal: curremail,
      recevid: recevid,
      //recemail: recemail,
      msg: msg,
      msgtime: msgtime,
    );

    List<String> ids = [currid, recevid];
    ids.sort();
    String chatroomid = ids.join('_');

    await firestore
        .collection('chatrooms')
        .doc(chatroomid)
        .collection('messages')
        .add(newmsg.tomap());


    // DocumentSnapshot receiverDoc = await firestore
    //     .collection('users')
    //     .doc(recevid)
    //     .get();
    //
    // if (receiverDoc.exists) {
    //   String? receiverToken = receiverDoc.get('fcmToken');
    //   if (receiverToken != null) {
    //     // Send notification
    //     await sendnotif(
    //       receivtoken: receiverToken,
    //       sendermail: curremail ?? '',
    //       msg: msg,
    //     );
    //   }
    // }
  }

  Stream<QuerySnapshot> getmsg(String userid, String otherid) {
    List<String> ids = [userid, otherid];
    ids.sort();
    String chatroomid = ids.join('_');
    return firestore
        .collection('chatrooms')
        .doc(chatroomid)
        .collection('messages')
        .orderBy('msgtime', descending: false)
        .snapshots();

  }

  //
  // Future<void> sendnotif({
  //   required String receivtoken,
  //   required String sendermail,
  //   required String msg,
  // }) async {
  //   try {
  //     final String key = 'my api key'; // Get from Firebase Console
  //
  //     await http.post(
  //       Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'key=$key',
  //       },
  //       body: jsonEncode({
  //         'to': receivtoken,
  //         'notification': {
  //           'title': 'New message from $sendermail',
  //           'body': msg,
  //           'sound': 'default',
  //         },
  //         'data': {
  //           'type': 'chat',
  //           'senderId': sendermail,
  //         },
  //         'priority': 'high',
  //       }),
  //     );
  //   } catch (e) {
  //     print('Error sending notification: $e');
  //   }
  }









