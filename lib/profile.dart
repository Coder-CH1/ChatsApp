import 'package:chatsapp/model/profile_user.dart';
import 'package:chatsapp/resusable_widgets/custom_color.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF00F0FF),
        title: Text('Profile', style: TextStyle(
          fontFamily: 'Caros',
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        )),
      ),
      body: FutureBuilder<ProfileUser?>(
        future: fetchProfileUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('$snapshot.error'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('no user found'));
          }
        //},
        final profileUser = snapshot.data;
        return Container(
          decoration: BoxDecoration(
            gradient: CustomColor.multiColors2,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 30,
                ),
                SizedBox(height: 10),
                Text('Name: ${profileUser?.displayName}', style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                )),
                SizedBox(height: 10),
            Text('Name: ${profileUser?.phoneNumber}', style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            )),
              ],
            ),
          ),
            );
  },
        ),
      );
  }
}

