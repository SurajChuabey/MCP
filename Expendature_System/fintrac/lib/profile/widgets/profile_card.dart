import 'package:fintrac/profile/pages/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fintrac/utils/providers/profile_provider.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _MyProfileState();
}

class _MyProfileState extends State<ProfileCard> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<UserProvider>().fetchUserInfo());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();

    return Card(
      elevation: 6,
      surfaceTintColor: Colors.amberAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias, 
      child: Stack(
        alignment: AlignmentGeometry.topRight,
        children: [Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xFFA8E6CF), Color(0xFFDCEDC1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 6),
                CircleAvatar(
                  radius: 58,
                  backgroundColor: Color.fromARGB(255, 236, 208, 129),
                  child: Text(user.userName[0].toUpperCase(),style: TextStyle(fontSize: 90,color: const Color.fromARGB(255, 228, 126, 9)),)
                ),
                const SizedBox(height: 8),
                Text(
                  user.userName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
            
                // Spacing between tiles
                _infoCard(
                  icon: Icons.mail,
                  title: 'Mail',
                  subtitle: user.emailId,
                ),
                const SizedBox(height: 8),
                _infoCard(
                  icon: Icons.phone,
                  title: 'Phone',
                  subtitle: "${user.countryCode}${user.phoneNumber}",
                ),
                const SizedBox(height: 8),
                _infoCard(
                  icon: Icons.location_on,
                  title: 'Location',
                  subtitle: user.location,
                ),
                const SizedBox(height: 8),
                _infoCard(
                  icon: Icons.domain,
                  title: 'Company',
                  subtitle: user.company,
                ),
            
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfile()));
          }, icon: Icon(Icons.edit),iconSize: 20,color: Colors.blueAccent),
        )

        ],
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        tileColor: const Color.fromARGB(255, 236, 235, 231),
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
