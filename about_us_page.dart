import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/email_us.png', height: 150, ),
            const SizedBox(height: 20),
            const Text(
              'Founded in year 2000, Carmen National High School',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'has been serving students from Sitio Macanhan, Barangay Carmen, Cagayan de Oro, and nearby areas. Over the years, CNHS has expanded its academic programs and facilities to accommodate a growing student population and maintain excellence in education.',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Carmen National High School (CNHS)',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'is a leading educational institution dedicated to providing high-quality education and fostering excellence among students. We aim to shape responsible, innovative, and lifelong learners ready for future challenges.',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Mission:',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'To provide quality education that nurtures critical thinking, creativity, and character development in a safe and inclusive learning environment.',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Vision:',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'To be a model institution that empowers students with knowledge, skills, and values for lifelong success.',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
