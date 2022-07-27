import 'package:finger_on_app/views/admin_homepage.dart';
import 'package:finger_on_app/views/login_page.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Dashboard'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  tileColor: Colors.green.shade100,
                  iconColor: Colors.green,
                  title: const Text('Competitions'),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AdminsHomePage(),
                    ));
                  },
                  tileColor: Colors.green.shade100,
                  iconColor: Colors.green,
                  title: const Text('All User'),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  tileColor: Colors.green.shade100,
                  iconColor: Colors.green,
                  title: const Text('Pending Users'),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded)),
            )
          ],
        ),
      ),
    );
  }
}
