import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app_ttcn/helper/snack_bar.dart';
import 'package:movies_app_ttcn/widgets/basic_button.dart';
import 'package:movies_app_ttcn/widgets/basic_text_field.dart';
import '../../view_model/viewmodel_user.dart';
import '../../model/model_user.dart';
import '../../widgets/app_vector.dart';

class EditProfilePage extends StatefulWidget {
  final User user;
  final VoidCallback onProfileUpdated;

  const EditProfilePage({
    super.key,
    required this.user,
    required this.onProfileUpdated,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _pictureController;
  final UserViewModel _userViewModel = UserViewModel();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user.username);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone ?? '');
    _pictureController = TextEditingController(text: widget.user.picture ?? '');
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _pictureController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      await _userViewModel.updateUserProfile(
        username: _usernameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        picture: _pictureController.text,
      );

      if (mounted) {
        final successMessage = await _userViewModel.successMessage.first;
        final errorMessage = await _userViewModel.errorMessage.first;

        if (successMessage != null) {
          successSnackBar(
              context: context,
              message: successMessage
          );
          widget.onProfileUpdated();
          Navigator.pop(context);
        } else if (errorMessage != null) {
          failedSnackBar(
              context: context,
              message: errorMessage
          );
        }
      }
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: _pictureController.text.isNotEmpty
                        ? Image.network(
                            _pictureController.text,
                            width: 130,
                            height: 130,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error, size: 100);
                            },
                          )
                        : SvgPicture.asset(
                            AppVector.userNull,
                            width: 130,
                            height: 130,
                          ),
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  controller: _usernameController,
                  labelText: 'Username',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _emailController,
                  labelText: 'Email',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _phoneController,
                  labelText: 'Phone',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _pictureController,
                  labelText: 'Photo URL',
                ),
                const SizedBox(height: 32),
                MainButton(
                  onPressed: _updateProfile,
                  title: const Text('Update Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
