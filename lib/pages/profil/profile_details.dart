import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileDetails extends StatelessWidget {
  //
  var box = GetStorage();
  //
  @override
  Widget build(BuildContext context) {
    //
    Map user = box.read("user") ?? {};
    //
    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   title: const Text(
      //     "Profile",
      //     style: TextStyle(
      //       fontSize: 30,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // ListTile(
            //   title: Text(
            //     "Profile",
            //     style: TextStyle(
            //
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            //   //trailing: Icon(Icons.person),
            // ),
            ListTile(
              onTap: () {
                //
              },
              title: const Text(
                "Noms",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "${user['nom']} ${user['postnom']} ${user['prenom']}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              //trailing: const Icon(Icons.edit),
            ),
            // ListTile(
            //   onTap: () {
            //     //
            //   },
            //   title: const Text(
            //     "Genre",
            //     style: TextStyle(
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            //   subtitle: Text(
            //     "${user['nom']}",
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       color: Colors.indigo,
            //     ),
            //   ),
            //   trailing: const Icon(Icons.edit),
            // ),
            ListTile(
              onTap: () {
                //
              },
              title: const Text(
                "Mot de passe",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "************",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              trailing: const Icon(Icons.edit),
            ),
            ListTile(
              onTap: () {
                //
              },
              title: const Text(
                "Téléphone",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "${user['telephone']}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              //trailing: const Icon(Icons.edit),
            ),
            ListTile(
              onTap: () {
                //
              },
              title: const Text(
                "Role",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "${user['role']}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              //trailing: const Icon(Icons.edit),
            ),
            ListTile(
              onTap: () {
                //
              },
              title: const Text(
                "Adresse",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "${user['adresse']}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              //trailing: const Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }
}
