import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yaca/authentications/auth_service.dart';
import 'package:yaca/services/chat/chatservice.dart';

class chatpage extends StatelessWidget {
  final String recevemail;
  final String recevid;

  chatpage({super.key, required this.recevemail, required this.recevid});

  final TextEditingController msgcontroller = TextEditingController();

  final Chatservice chatservice = Chatservice();
  final authservice authserv = authservice();

  void sendmsg() {
    if (msgcontroller.text.isNotEmpty) {
      chatservice.sendmesg(recevid, msgcontroller.text);
      msgcontroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.15),
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.primary.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.person_outline,
                color: colorScheme.primary,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                recevemail,
                style: GoogleFonts.poppins(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(child: buildmsglist()),
          buildinput(colorScheme),
        ],
      ),
    );
  }

  Widget buildmsglist() {
    String senderid = authserv.getuser()!.uid;
    return StreamBuilder(
      stream: chatservice.getmsg(senderid, recevid),
      builder: (context, snapshot) {
        final colorScheme = Theme.of(context).colorScheme;

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: GoogleFonts.lato(color: colorScheme.primary, fontSize: 14),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: colorScheme.secondary),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'No messages yet. Say hi! 👋',
              style: GoogleFonts.lato(
                color: colorScheme.primary.withOpacity(0.6),
                fontSize: 16,
              ),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          children: snapshot.data!.docs
              .map((doc) => buildmsgitem(doc, context))
              .toList(),
        );
      },
    );
  }

  Widget buildmsgitem(DocumentSnapshot doc, BuildContext context) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final colorScheme = Theme.of(context).colorScheme;

    bool isCurrentUser = data['senderid'] == authserv.getuser()!.uid;

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: isCurrentUser
              ? colorScheme.secondary
              : colorScheme.surface.withOpacity(0.8),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: isCurrentUser
                ? const Radius.circular(18)
                : const Radius.circular(4),
            bottomRight: isCurrentUser
                ? const Radius.circular(4)
                : const Radius.circular(18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          data['msg'].toString(),
          style: GoogleFonts.lato(
            color: isCurrentUser ? Colors.white : colorScheme.primary,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget buildinput(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme.surface.withOpacity(0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: colorScheme.primary.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: msgcontroller,
                  style: GoogleFonts.lato(
                    color: colorScheme.primary,
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: GoogleFonts.lato(
                      color: colorScheme.primary.withOpacity(0.4),
                      fontSize: 15,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: colorScheme.secondary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.secondary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: sendmsg,
                icon: const Icon(Icons.send_rounded),
                color: Colors.white,
                iconSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// class chatpage extends StatelessWidget {
//   final String recevemail;
//   final String recevid;
//
//
//
//    chatpage({super.key , required this.recevemail, required this.recevid ,});
//
//
//    final TextEditingController msgcontroller=TextEditingController();
//
//    final Chatservice chatservice = Chatservice();
//    final authservice authserv = authservice();
//
//    void sendmsg(){
//      if(msgcontroller.text.isNotEmpty){
//
//
//        chatservice.sendmesg(recevid, msgcontroller.text);
//        msgcontroller.clear();
//      }
//    }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      body: Column(
//        children: [
//          Expanded(child: buildmsglist()),
//          buildinput(),
//
//
//
//
//
//
//        ],
//
//
//
//
//
//      ),
//     );
//   }
//
//   Widget buildmsglist(){
//      String senderid = authserv.getuser()!.uid;
//      return StreamBuilder(
//        stream: chatservice.getmsg(senderid, recevid),
//        builder: (context,snapshot){
//          if(snapshot.hasError){
//            return Text('Error ${snapshot.error}');
//          }
//          if(snapshot.connectionState == ConnectionState.waiting){
//            return Center(child: CircularProgressIndicator());
//          }
//
//          return ListView(
//            children: snapshot.data!.docs.map((doc) => buildmsgitem(doc)).toList(),
//          );
//        }
//      );
//   }
//
//   Widget buildmsgitem(DocumentSnapshot doc){
//      Map<String,dynamic> data = doc.data() as Map<String,dynamic>;
//      return Text(data['msg'].toString());
//
//   }
//
//   Widget buildinput(){
//      return Row(
//
//
//
//        children: [
//          Expanded(
//            child: TextField(controller: msgcontroller)
//          ),
//
//          IconButton(onPressed: sendmsg, icon: Icon(Icons.send))
//        ],
//      );
//   }
//
//
//
//
// }
