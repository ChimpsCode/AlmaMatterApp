
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'gallery_page.dart'; // Import the new GalleryPage
import 'about_us_page.dart'; // Import the new AboutUsPage
import 'email_us_page.dart'; // Import the new EmailUsPage
// Import url_launcher
import 'drawer.dart'; // Import the new Drawer

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        isDarkMode: _isDarkMode,
        toggleDarkMode: _toggleDarkMode,
      ),
      debugShowCheckedModeBanner: false, // Remove the debug banner
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.isDarkMode,
    required this.toggleDarkMode,
  });

  final String title;
  final bool isDarkMode;
  final VoidCallback toggleDarkMode;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/school.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true); // Set the video to loop
        _controller.setVolume(0.0); // Mute the video
        _controller.play();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToFullScreenImage(BuildContext context, List<String> images, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImage(images: images, initialIndex: initialIndex),
      ),
    );
  }

  Widget _buildHome() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : const CircularProgressIndicator(), // Show a loading indicator while the video is initializing
          const SizedBox(height: 20),
          const Text(
            'CNHS',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'CNHS has a good environment for students and ... Carmen National High School is located at Sitio Macanhan, Barangay Carmen, Cagayan de Oro, 9000 Misamis Oriental, Philippines, near this place are: Macanhan Elementary School (178 m), Treasure House of God\'s Graces Early Childhood Center (449 m), GOOD SHEPHERD CHRISTIAN SCHOOL (565 m), Children\'s Progressive School (617 m), West City Central School (708 m).',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'CNHS Updates',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Image.asset('assets/images/registration.jpg', fit: BoxFit.cover, width: double.infinity),
        ],
      ),
    );
  }

  Widget _buildPrograms() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 0.0),
            child: Text(
              'Specialized Programs',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Core Subjects of the school',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            children: List.generate(8, (index) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/sub${index + 1}.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 100,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Extracurricular Programs',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sports Programs (Basketball, Sepak Takraw, Volleyball, etc.)'),
                Text('Music & Band'),
                Text('Theater & Drama Club'),
                Text('Debate & Public Speaking'),
                Text('School Newspaper & Journalism'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Special Education (SPED) & Inclusive Learning',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Support for Students with Special Needs', style: TextStyle(color: Colors.grey)),
                Text('Assistive Learning Programs', style: TextStyle(color: Colors.grey)),
                Text('Sign Language & Braille Education', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Community & Volunteer Programs',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(
              onTap: () {
                _navigateToFullScreenImage(
                  context,
                  [
                    'assets/images/d1.jpg',
                    'assets/images/d2.jpg',
                    'assets/images/d3.jpg',
                    'assets/images/d4.jpg',
                    'assets/images/d5.jpg',
                  ],
                  0,
                );
              },
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Image.asset('assets/images/d1.jpg', fit: BoxFit.cover, height: 140),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Image.asset('assets/images/d2.jpg', fit: BoxFit.cover, height: 70),
                            ),
                            Expanded(
                              child: Image.asset('assets/images/d3.jpg', fit: BoxFit.cover, height: 70),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Image.asset('assets/images/d4.jpg', fit: BoxFit.cover, height: 70),
                            ),
                            Expanded(
                              child: Image.asset('assets/images/d5.jpg', fit: BoxFit.cover, height: 70),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 115, 173), // Set the AppBar color to blue
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Carmen National High School',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Image.asset('assets/images/logo.png', height: 90),
            ),
          ],
        ),
      ),
      drawer: AppDrawer(
        isDarkMode: widget.isDarkMode,
        toggleDarkMode: widget.toggleDarkMode,
      ),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.2, // Adjust the drawer edge drag width
      drawerScrimColor: Colors.blue.withOpacity(0.5), // Set the scrim color with opacity
      body: Center(
        child: _selectedIndex == 0
            ? _buildHome()
            : _selectedIndex == 1
                ? _buildPrograms()
                : _selectedIndex == 2
                    ? GalleryPage() // Use the new GalleryPage widget
                    : _selectedIndex == 3
                        ? EmailUsPage() // Use the new EmailUsPage widget
                        : AboutUsPage(), // Use the new AboutUsPage widget
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 234, 229, 229),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color.fromARGB(255, 45, 115, 173)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school, color: Color.fromARGB(255, 45, 115, 173)),
            label: 'Programs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_album, color: Color.fromARGB(255, 45, 115, 173)),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.email, color: Color.fromARGB(255, 45, 115, 173)),
            label: 'Email Us',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info, color: Color.fromARGB(255, 45, 115, 173)),
            label: 'About Us',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
