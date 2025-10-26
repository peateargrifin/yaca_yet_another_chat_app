import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yaca/authentications/auth_service.dart';
import 'package:yaca/services/chat/chatservice.dart';

import '../components/usertile.dart';
import '../themes/themepro.dart';
import 'chatpage.dart';

class chathome extends StatelessWidget {
  chathome({super.key});

  final authserv = authservice();

  void logout() {
    authserv.signout();
  }

  final Chatservice chatserv = Chatservice();

  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SafeArea(
  //       child: IconButton(
  //           onPressed: logout,
  //           icon: Icon(Icons.logout_outlined)
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
        title: Text(
          'Home.',
          style: GoogleFonts.lato(
            color: colorScheme.primary,
            fontWeight: FontWeight.w900,
            fontSize: 25,
          ),
        ),
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),
      drawer: _buildDrawer(context, colorScheme),
      body: _buildUserList(),
    );
  }

  Widget _buildDrawer(BuildContext context, ColorScheme colorScheme) {
    return Drawer(
      backgroundColor: colorScheme.background,
      child: Column(
        children: [
          // Drawer Header with Icon
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(color: colorScheme.tertiary),
            child: SafeArea(
              child: Column(
                children: [
                  Icon(
                    Icons.chat_bubble_rounded,
                    size: 60,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'YACA',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Drawer Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 10),

                // Go Home Button
                TextButton(
                  onPressed: () {
                    // Navigate to home
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.home_outlined, color: colorScheme.primary),
                      const SizedBox(width: 16),
                      Text(
                        'Go Home',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                // Settings Expansion Tile
                Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    leading: Icon(
                      Icons.settings_outlined,
                      color: colorScheme.primary,
                    ),
                    title: Text(
                      'Settings',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    iconColor: colorScheme.primary,
                    collapsedIconColor: colorScheme.primary,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Dark Mode',
                              style: GoogleFonts.lato(
                                fontSize: 15,
                                color: colorScheme.primary,
                              ),
                            ),
                            Switch(
                              value: Provider.of<themeprovider>(context).isDark,
                              onChanged: (value) {
                                Provider.of<themeprovider>(
                                  context,
                                  listen: false,
                                ).toggleTheme();
                              },
                              activeColor: colorScheme.secondary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Logout Button at Bottom
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: TextButton.icon(
              onPressed: logout,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: colorScheme.secondary.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: Icon(Icons.logout_rounded, color: colorScheme.secondary),
              label: Text(
                'Logout',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: chatserv.getuser(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No users found.'));
        }

        return ListView(
          children: snapshot.data!
              .map<Widget>((UserData) => _builduserlistitem(UserData, context))
              .toList(),
        );
      },
    );
  }

  Widget _builduserlistitem(
    Map<String, dynamic> userdata,
    BuildContext context,
  ) {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if ( //userdata['email'] != authserv.getuser()!.email
    currentUser != null && userdata['email'] != currentUser.email) {
      return Usertile(
        text: userdata['email'],
        ontap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => chatpage(
                recevid: userdata['uid'],
                recevemail: userdata['email'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
