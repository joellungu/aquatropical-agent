import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
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
                "Nom complet",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Mokpongbo Lungu Joel",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              trailing: const Icon(Icons.edit),
            ),
            ListTile(
              onTap: () {
                //
              },
              title: const Text(
                "Genre",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Homme",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              trailing: const Icon(Icons.edit),
            ),
            ListTile(
              onTap: () {
                //
              },
              title: const Text(
                "Age",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "18 à 30 ans",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
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
                "+243 815 381 693",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              trailing: const Icon(Icons.edit),
            ),
            ListTile(
              onTap: () {
                //
              },
              title: const Text(
                "Email",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "lungujoel138@gmail.com",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              trailing: const Icon(Icons.edit),
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
                "Kinshasa, C/Selembao, Q/Masangambila, Av: Bikolo N°12",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              trailing: const Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }
}
