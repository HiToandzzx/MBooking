import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app_ttcn/view/tab_profile/view_change_pass_page.dart';
import 'package:movies_app_ttcn/view/tab_profile/view_edit_profile_page.dart';
import 'package:movies_app_ttcn/view/welcome/view_welcome.dart';
import 'package:movies_app_ttcn/widgets/app_vector.dart';
import 'package:movies_app_ttcn/widgets/build_list_title_profile_tab.dart';
import 'package:movies_app_ttcn/widgets/basic_button.dart';
import '../../view_model/viewmodel_user.dart';
import '../../model/model_user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late UserViewModel userViewModel;

  @override
  void initState() {
    super.initState();
    userViewModel = UserViewModel();
  }

  void _refreshUserData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 16, right: 16),
        child: FutureBuilder<User?>(
          future: userViewModel.getCurrentUser(),
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
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(45),
                            child: user.picture != null
                                ? Image.network(
                                    user.picture!,
                                    width: 90,
                                    height: 90,
                                  )
                                : SvgPicture.asset(
                                    AppVector.userNull,
                                    width: 90,
                                    height: 90,
                                  ),
                          ),
                        ),

                        const SizedBox(width: 20),

                        // USER INFO
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // USER NAME
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      user.username,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                                  Text('${user.phone}'),
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
                                  Expanded(
                                    child: Text(
                                      user.email,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // EDIT PROFILE BUTTON
                        Expanded(
                          child: IconButton(
                            icon: const Icon(
                              Icons.edit_note,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfilePage(
                                      user: user,
                                      onProfileUpdated: _refreshUserData,
                                    ),
                                  )
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ChangePasswordPage(),
                                )
                            );
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
                            await userViewModel.logout();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const WelcomePage(),
                              ),
                            );
                          },
                          title: const Text('Logout'),
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
