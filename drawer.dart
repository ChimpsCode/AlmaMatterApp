import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleDarkMode;

  const AppDrawer({
    super.key,
    required this.isDarkMode,
    required this.toggleDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: SizedBox(
                height: 150, // Adjust the height as needed
                child: Image.asset('assets/images/logo2.jpg'),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.how_to_reg),
            title: const Text('Admissions'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Admissions'),
                    content: const Text('Please click this to fill up the admission form.'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Click Here'),
                        onPressed: () async {
                          const url = 'https://docs.google.com/forms/d/e/1FAIpQLSfyRoaO6iMsAfCsbIpRwQAiJEfo3jHFpV9hUS3aPFNjiFQgbQ/viewform?usp=header';
                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
         ListTile(
  leading: const Icon(Icons.campaign),
  title: const Text('Announcements'),
  onTap: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Announcements'),
          content: SingleChildScrollView( // 🔹 Ensures content is scrollable
            child: Column(
              mainAxisSize: MainAxisSize.min, // 🔹 Prevents unnecessary expansion
              children: [
                SizedBox(
                  width: double.infinity, // 🔹 Ensures image takes full width
                  height: 250, // 🔹 Set a defined height for Web compatibility
                  child: Image.asset(
                    'assets/images/an.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
'📌JANUARY 25- FEBRUARY 15, 2025\nIn preparation for the opening of S.Y. 2025-2026, Carmen National High School will conduct Early Registration for GRADE 7, GRADE 11, BACK TO SCHOOL, & TRANSFEREE starting this January 25 to February 15, 2025.\n'
'𝘔𝘢𝘬𝘢𝘱𝘢𝘨-𝘢𝘳𝘢𝘭 𝘢𝘺 𝘒𝘢𝘳𝘢𝘱𝘢𝘵𝘢𝘯 𝘔𝘰! 𝘔𝘢𝘨𝘱𝘢𝘭𝘪𝘴𝘵𝘢!\n#R10earlyregistration2025\n#DepEdCDO #CarmenNHS\n#DepEdMATATAG',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  },
),




          ListTile(
            leading: const Icon(Icons.groups),
            title: const Text('Student Awardees'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Student Awardees'),
                    content: LoopingImages(),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          const Text('Student Awardees');
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                toggleDarkMode();
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text('Campus Map'),
            onTap: () async {
              const url = 'https://maps.app.goo.gl/W5DdxBxiSieyYuVK7';
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
        ],
      ),
    );
  }
}




class LoopingImages extends StatefulWidget {
  const LoopingImages({super.key});

  @override
  _LoopingImagesState createState() => _LoopingImagesState();
}

class _LoopingImagesState extends State<LoopingImages> {
  int _currentIndex = 0;
  final List<String> _images = [
    'assets/images/award1.jpg',
    'assets/images/award2.jpg',
    'assets/images/award3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _startImageLoop();
  }

  void _startImageLoop() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % _images.length;
        });
        _startImageLoop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200, // 🔹 Keeps size consistent (Prevents pop-in effect)
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AnimatedSwitcher( // 🔥 Smooth fade effect when switching images
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Image.asset(
            _images[_currentIndex],
            key: ValueKey<int>(_currentIndex), // 🔹 Ensures image refresh
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
