import 'package:flutter/material.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animationRightToLeft;
  late Animation<Offset> _animationLeftToRight;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animationRightToLeft = Tween<Offset>(
      begin: const Offset(3.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationLeftToRight = Tween<Offset>(
      begin: const Offset(-3.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _navigateToGallery(BuildContext context, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryDetailPage(category: category),
      ),
    );
  }

  Widget _buildGalleryItem(String imagePath, String text, {bool animateRightToLeft = false, bool animateLeftToRight = false}) {
    return Stack(
      children: [
        animateRightToLeft
            ? AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: _animationRightToLeft.value * 100,
                    child: child,
                  );
                },
                child: Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity, height: 150),
              )
            : animateLeftToRight
                ? AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: _animationLeftToRight.value * 100,
                        child: child,
                      );
                    },
                    child: Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity, height: 150),
                  )
                : Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity, height: 150),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'School Gallery',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => _navigateToGallery(context, 'Teachers'),
              child: _buildGalleryItem('assets/images/teachers.jpg', 'Teachers', animateRightToLeft: true),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _navigateToGallery(context, 'Sports'),
              child: _buildGalleryItem('assets/images/sport3.jpg', 'Sports Programs', animateLeftToRight: true),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _navigateToGallery(context, 'Intramurals 2K24'),
              child: _buildGalleryItem('assets/images/beauty_contest.jpg', 'Intramurals 2K24', animateRightToLeft: true),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _navigateToGallery(context, 'School Newspaper'),
              child: _buildGalleryItem('assets/images/newspaper.jpg', 'School Newspaper', animateLeftToRight: true),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _navigateToGallery(context, 'Buildings'),
              child: _buildGalleryItem('assets/images/building.jpg', 'Buildings', animateRightToLeft: true),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _navigateToGallery(context, 'Student Officers'),
              child: _buildGalleryItem('assets/images/yeso.jpg', 'Student Officers', animateLeftToRight: true),
            ),
          ],
        ),
      ),
    );
  }
}

class GalleryDetailPage extends StatelessWidget {
  final String category;

  const GalleryDetailPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    List<String> images;
    switch (category) {
      case 'Teachers':
        images = List.generate(15, (index) => 'assets/images/t${index + 1}.png');
        break;
      case 'Sports':
        images = List.generate(11, (index) => 'assets/images/sport${index + 1}.jpg');
        break;
      case 'Intramurals 2K24':
        images = List.generate(17, (index) => 'assets/images/bb${index + 1}.jpg');
        break;
      case 'School Newspaper':
        images = List.generate(8, (index) => 'assets/images/n${index + 1}.jpg');
        break;
      case 'Buildings':
        images = List.generate(5, (index) => 'assets/images/b${index + 1}.jpg');
        break;
      case 'Student Officers':
        images = List.generate(15, (index) => 'assets/images/s${index + 1}.jpg');
        break;
      default:
        images = [];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        backgroundColor: const Color.fromARGB(255, 45, 115, 173),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        children: images.map((image) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenImage(images: images, initialIndex: images.indexOf(image)),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class FullScreenImage extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const FullScreenImage({super.key, required this.images, required this.initialIndex});

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  late int currentIndex;
  bool _hoveringLeft = false;
  bool _hoveringRight = false;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  void _nextImage() {
    setState(() {
      currentIndex = (currentIndex + 1) % widget.images.length;
    });
  }

  void _previousImage() {
    setState(() {
      currentIndex = (currentIndex - 1 + widget.images.length) % widget.images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white), // Set back button color to white
      ),
      body: Container(
        color: Colors.black, // Set background color to black
        child: Stack(
          children: [
            Center(
              child: Image.asset(widget.images[currentIndex], fit: BoxFit.contain),
            ),
            Positioned(
              left: 20,
              top: MediaQuery.of(context).size.height / 2 - 20,
              child: GestureDetector(
                onTap: _previousImage,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) => setState(() {
                    _hoveringLeft = true;
                  }),
                  onExit: (_) => setState(() {
                    _hoveringLeft = false;
                  }),
                  child: AnimatedOpacity(
                    opacity: _hoveringLeft ? 1.0 : 0.5,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(Icons.chevron_left, color: Colors.white, size: 40),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: MediaQuery.of(context).size.height / 2 - 20,
              child: GestureDetector(
                onTap: _nextImage,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) => setState(() {
                    _hoveringRight = true;
                  }),
                  onExit: (_) => setState(() {
                    _hoveringRight = false;
                  }),
                  child: AnimatedOpacity(
                    opacity: _hoveringRight ? 1.0 : 0.5,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(Icons.chevron_right, color: Colors.white, size: 40),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
