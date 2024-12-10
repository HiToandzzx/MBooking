import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies_app_ttcn/helper/nav_mess_profile.dart';
import 'package:movies_app_ttcn/widgets/basic_button.dart';
import 'package:movies_app_ttcn/widgets/basic_text_field.dart';

class EditProfilePage extends StatefulWidget {
  final VoidCallback refreshProfile;

  const EditProfilePage({super.key, required this.refreshProfile});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _emailController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _photoUrlController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (user != null) {
      _emailController.text = user!.email ?? '';
      _displayNameController.text = user!.displayName ?? '';
      _photoUrlController.text = user!.photoURL ?? '';
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _photoUrlController.text = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // IMG
                Expanded(
                  flex: 6,
                  child: CustomTextField(
                    controller: _photoUrlController,
                    labelText: 'Photo URL',
                  ),
                ),

                const SizedBox(width: 5),

                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: _pickImage,
                    icon: const Icon(
                        Icons.drive_folder_upload_rounded,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // TÊN
            CustomTextField(
              controller: _displayNameController,
              labelText: 'Display Name',
            ),

            const SizedBox(height: 20),

            // EMAIL
            CustomTextField(
              controller: _emailController,
              labelText: 'Email',
            ),

            const SizedBox(height: 20),

            BasicAppButton(
              onPressed: () async {
                try {
                  if (user != null) {
                    bool isUpdated = false;

                    if (_photoUrlController.text.isNotEmpty && _photoUrlController.text != user!.photoURL) {
                      await user!.updatePhotoURL(_photoUrlController.text);
                      isUpdated = true;
                    }

                    if (_displayNameController.text.isNotEmpty && _displayNameController.text != user!.displayName) {
                      await user!.updateDisplayName(_displayNameController.text);
                      isUpdated = true;
                    }

                    if (_emailController.text.isNotEmpty && _emailController.text != user!.email) {
                      await user!.verifyBeforeUpdateEmail(_emailController.text);
                      isUpdated = true;
                    }

                    if (!isUpdated) {
                      showFalseSnackBar(context, 'No changes to update');
                    } else {
                      await user!.reload();
                      showTrueSnackBar(context, 'Updated successfully');
                      widget.refreshProfile();
                    }
                  } else {
                    showTrueSnackBar(context, 'No user signed in');
                  }
                } catch (e) {
                  showFalseSnackBar(context, 'Failed to update profile: $e');
                }
              },
              title: 'Update',
            ),
          ],
        ),
      ),
    );
  }
}
