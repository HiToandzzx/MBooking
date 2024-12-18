import 'package:flutter/material.dart';
import 'package:movies_app_ttcn/view/welcome/view_welcome.dart';
import 'package:movies_app_ttcn/widgets/build_list_title_profile_tab.dart';
import 'package:movies_app_ttcn/widgets/basic_button.dart';
import '../auth/signin/viewmodel_signin.dart';
import '../auth/signin/model_signin.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInViewModel signInViewModel = SignInViewModel();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 16, right: 16),
        child: FutureBuilder<User?>(
          future: signInViewModel.getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.amber,)
              );
            }
            if (snapshot.hasData && snapshot.data != null) {
              final user = snapshot.data!;

              return Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // USER IMAGE
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(45),
                              child: Image.network(
                                user.picture,
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        ),

                        // USER INFO
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // USER NAME
                            Row(
                              children: [
                                Text(
                                  user.username,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // PHONE
                            Row(
                              children: [
                                const Icon(
                                  Icons.phone_outlined,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(user.phone),
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
                                  user.email,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // EDIT PROFILE BUTTON
                        IconButton(
                          icon: const Icon(
                            Icons.edit_note,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            // Handle edit profile
                          },
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
                            // Handle onTap
                          },
                        ),
                        buildListTile(
                          icon: Icons.shopping_cart_outlined,
                          text: 'Payment history',
                          isLastItem: false,
                          onTap: () {
                            // Handle onTap
                          },
                        ),
                        buildListTile(
                          icon: Icons.lock_outline,
                          text: 'Change password',
                          isLastItem: false,
                          onTap: () {
                            // Handle onTap
                          },
                        ),
                        buildListTile(
                          icon: Icons.no_accounts,
                          text: 'Delete account',
                          isLastItem: true,
                          onTap: () {
                            // Handle onTap
                          },
                        ),

                        const SizedBox(height: 40),

                        MainButton(
                            onPressed: () async {
                              await signInViewModel.logout();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const WelcomePage(),
                                  )
                              );
                            },
                            title: const Text('Logout')
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('User not found.'));
            }
          },
        ),
      ),
    );
  }
}
