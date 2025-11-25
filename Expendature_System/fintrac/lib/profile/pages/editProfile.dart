import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fintrac/utils/providers/profile_provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // controllers live in State
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController companyController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = context.read<UserProvider>();

      nameController.text = user.userName;
      emailController.text = user.emailId;
      phoneController.text = user.phoneNumber;
      locationController.text = user.location;
      companyController.text = user.company;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    companyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double headerHeight = 100;
    const double avatarRadius = 70;

    final user = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 198, 245, 199),
        elevation: 0,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black54),
        ),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: headerHeight,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 198, 245, 199),
            ),
          ),

          /// Profile Avatar
          Positioned(
            top: headerHeight - avatarRadius,
            left: 0,
            right: 0,
            child: Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: avatarRadius,
                    backgroundColor: const Color.fromARGB(255, 180, 231, 175),
                    backgroundImage:
                        const AssetImage('lib/assets/home_icons/person.png'),
                  ),

                  /// Camera Button
                  Positioned(
                    right: -4,
                    bottom: -4,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.camera_alt,
                          size: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// Form Fields
          Padding(
            padding: EdgeInsets.only(top: headerHeight + avatarRadius + 10),
            child: AnimatedPadding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                duration: const Duration(milliseconds: 200),

              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 22),
                children: [
                  const SizedBox(height: 12),
              
                  /// Full Name
                  const Text("Full Name"),
                  const SizedBox(height: 8),
                  userProfileField(
                    nameController,
                    r'[a-zA-Z\s]',
                    TextInputType.name,
                    user.userName,
                  ),
              
                  const SizedBox(height: 22),
              
                  /// Email (no inputFormatter — allow free typing; validate on save)
                  const Text("Email Address"),
                  const SizedBox(height: 8),
                  userProfileField(
                    emailController,
                    null,
                    TextInputType.emailAddress,
                    user.emailId ,
                  ),
              
                  const SizedBox(height: 22),
              
                  /// Phone Number
                  const Text("Phone Number"),
                  const SizedBox(height: 8),
                  userProfileField(
                    phoneController,
                    r'[0-9]',
                    TextInputType.phone,
                    user.phoneNumber,
                  ),
              
                  const SizedBox(height: 22),
              
                  /// Location
                  const Text("Location"),
                  const SizedBox(height: 8),
                  userProfileField(
                    locationController,
                    r'[a-zA-Z0-9\s,.-]',
                    TextInputType.streetAddress,
                    user.location ,
                  ),
              
                  const SizedBox(height: 22),
              
                  /// Company
                  const Text("Company"),
                  const SizedBox(height: 8),
                  userProfileField(
                    companyController,
                    r'[a-zA-Z0-9\s&.-]',
                    TextInputType.text,
                    user.company,
                  ),
              
                  const SizedBox(height: 40),
              
                  TextButton(
                    onPressed: () {
                      final name = nameController.text.trim();
                      final email = emailController.text.trim();
                      final phone = phoneController.text.trim();
                      final location = locationController.text.trim();
                      final company = companyController.text.trim();
              
                      final userProvider = context.read<UserProvider>();
                      userProvider.userName = name;
                      userProvider.emailId = email;
                      userProvider.phoneNumber = phone;
                      userProvider.company = company;
                      userProvider.location = location;
              
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile saved',style: TextStyle(color: Color.fromARGB(255, 3, 85, 7)),textAlign: TextAlign.center,),duration: Duration(seconds: 1),backgroundColor: Color.fromARGB(255, 204, 235, 194),),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 169, 230, 171),
                      foregroundColor: Colors.green.shade800,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                            color: Color.fromARGB(1, 176, 231, 231), width: 1),
                      ),
                    ),
                    child: const Text(
                      'Save Profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget userProfileField(
  TextEditingController controller,
  String? regexString,
  TextInputType keyboardType,
  String hintOrPreloaded,
) {
  return TextField(
    controller: controller,
    keyboardType: keyboardType,
    inputFormatters: regexString != null && regexString.isNotEmpty
        ? [
            FilteringTextInputFormatter.allow(RegExp(regexString)),
          ]
        : [],
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      hintText: hintOrPreloaded,
    ),
  );
}
