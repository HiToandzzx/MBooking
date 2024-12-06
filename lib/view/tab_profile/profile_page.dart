import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app_ttcn/widgets/build_list_title.dart';
import 'package:movies_app_ttcn/widgets/basic_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser;
  final List<String> entries = <String>['A', 'B', 'C'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 16, right: 16),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // IMAGE
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: Image.network(
                          '${user?.photoURL}',
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 24),

                  // INFO
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // NAME
                      Row(
                        children: [
                          Text(
                            user?.displayName ?? 'No Name',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // SĐT
                      Row(
                        children: [
                          const Icon(
                              Icons.phone_outlined,
                              size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                              user?.phoneNumber ?? 'Not add phone yet'
                          )
                        ],
                      ),

                      const SizedBox(height: 4),

                      // EMAIL
                      Row(
                        children: [
                          const Icon(
                              Icons.mail_outlined,
                              size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            user?.email ?? 'No Email',
                            style: const TextStyle(
                              fontSize: 15
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                  // BUTTON EDIT PROFILE
                  IconButton(
                    icon: const Icon(
                      Icons.edit_note,
                      color: Colors.white,
                      size: 25,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // MAIN CONTENT
            Expanded(
              child: ListView(
                children: [
                  buildListTile(
                    icon: Icons.confirmation_number_outlined,
                    text: 'My ticket',
                    isLastItem: false,
                    onTap: () {

                    },
                  ),
                  buildListTile(
                    icon: Icons.shopping_cart_outlined,
                    text: 'Payment history',
                    isLastItem: false,
                    onTap: () {

                    },
                  ),
                  buildListTile(
                    icon: Icons.lock_outline,
                    text: 'Change password',
                    isLastItem: true,
                    onTap: () {

                    },
                  ),

                  const SizedBox(height: 40),

                  BasicAppButton(
                      onPressed: () async {
                        // Sign out from Firebase
                        await FirebaseAuth.instance.signOut();
                        // Sign out from Google
                        await GoogleSignIn().signOut();
                      },
                      title: 'Log out'
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
