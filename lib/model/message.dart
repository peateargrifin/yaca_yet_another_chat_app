import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderid;
  final String? senderemal;
  final String recevid;
  // final String recemail;
  final String msg;
  final Timestamp msgtime;

  Message({
    required this.senderid,
    required this.senderemal,
    required this.recevid,
    //required this.recemail,
    required this.msg,
    required this.msgtime,
  });

  Map<String, dynamic> tomap() {
    return {
      'senderid': senderid,
      'senderemal': senderemal,
      'recevid': recevid,
      //'recemail':recemail,
      'msg': msg,
      'msgtime': msgtime,
    };
  }
}
