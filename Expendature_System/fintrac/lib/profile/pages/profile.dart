import 'package:fintrac/profile/widgets/profile_card.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pop(context); 
      },
      child: DraggableScrollableSheet(
        initialChildSize: 0.5, // 50% of screen
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return GestureDetector(
            onTap: () {
              
            },
            child: Container(
              decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )
              ),
              child: ProfileCard()),
          );
        }),
    );
  }
}