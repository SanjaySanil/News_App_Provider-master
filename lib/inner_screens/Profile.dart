import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              elevation: 1,
              backgroundColor: const Color.fromARGB(255, 60, 4, 106),
              title: const Text(
                'LogOut Confirmation',
                style: TextStyle(color: Colors.white),
              ),
              content: const Text(
                'Do you want to LogOut the App?',
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent),
                  //return false when click on "NO"
                  child: const Text('No'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent),
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child: const Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 60, 4, 106),
        title: Text("Account"),
        actions: [
          IconButton(
              onPressed: () {
                showExitPopup();
              },
              icon: Icon(
                Icons.logout_rounded,
                size: 30,
              ))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 251, 251, 249),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),
                child: Expanded(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/LOGO.png',
                        height: 100,
                        width: 250,
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              style: TextStyle(height: 1.5),
                              textAlign: TextAlign.justify,
                              'Stay informed with the latest news from around the world with our sleek and user-friendly news app. Get breaking news alerts and read articles from top sources across politics, business, sports, entertainment and more. Stay up to date on the go with offline reading and personalized news feeds tailored to your interests.',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Me Anand CB",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.mail_outline,
                            size: 15,
                            color: Color.fromARGB(255, 29, 38, 119),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "meanandcb98@gmail.com",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.mobile_screen_share_sharp,
                            size: 15,
                            color: Color.fromARGB(255, 29, 38, 119),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "+91 9074834662",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
