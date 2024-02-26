import 'package:flutter/material.dart';
import 'personal_info_screen.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('path/to/your/image.jpg'), // Replace with your image asset
            ),
            title: Text('User Details'),
            subtitle: Text('@username'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // Edit profile logic
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Manage Account'),
            onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PersonalInformationScreen()),
                  );
            },
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('Billing Information'),
            onTap: () {
              // Billing information logic
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Privacy Settings'),
            onTap: () {
              // Privacy settings logic
            },
          ),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Support Center'),
            onTap: () {
              // Support center logic
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                // Sign out logic
              },
              child: Text('Sign out'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // set the background color
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Reminders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Transactions',
          ),
        ],
      ),
    );
  }
}
