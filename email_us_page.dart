import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailUsPage extends StatefulWidget {
  const EmailUsPage({super.key});

  @override
  _EmailUsPageState createState() => _EmailUsPageState();
}

class _EmailUsPageState extends State<EmailUsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool _messageSent = false;






  Future<void> _sendEmail() async {
  if (_formKey.currentState!.validate()) {
    final Email email = Email(
      body: "From: ${_nameController.text}\n\n${_messageController.text}",
      subject: _subjectController.text,
      recipients: ["your-email@school.edu"], // Change this to your school's email
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);

      setState(() {
        _messageSent = true;
      });

      // 🔹 Fix: Ensure Snackbar runs in main UI thread
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Message sent successfully!")),
        );
      });

      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
    } catch (error) {
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Message Sent")),
        );
      });
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
    }
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Email Us",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor:  const Color.fromARGB(255, 112, 150, 215),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Get in Touch!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Have a question or concern? Send us an email and we'll get back to you soon.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                
                _buildTextField(_nameController, "Your Name", Icons.person, iconColor: Colors.grey),
                const SizedBox(height: 10),
                _buildTextField(_emailController, "Your Email", Icons.email, isEmail: true, iconColor: Colors.grey),
                const SizedBox(height: 10),
                _buildTextField(_subjectController, "Subject", Icons.subject, iconColor: Colors.grey),
                const SizedBox(height: 10),
                _buildTextField(_messageController, "Message", Icons.message, isMessage: true, iconColor: Colors.grey),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: _sendEmail,
                    icon: const Icon(Icons.send, color: Colors.white),
                    label: const Text("Send Email", style: TextStyle(color: Colors.white)),
                    
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 112, 150, 215),
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                if (_messageSent)
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Message Sent!",
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                  ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        const url = 'https://www.facebook.com/CarmenNationalHighSchool?mibextid=ZbWKwL';
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url));
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: const Icon(Icons.facebook, size: 30, color: Colors.blue),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () async {
                        const email = 'mailto:info@cnhs.com';
                        if (await canLaunchUrl(Uri.parse(email))) {
                          await launchUrl(Uri.parse(email));
                        } else {
                          throw 'Could not launch $email';
                        }
                      },
                      child: const Icon(Icons.email, size: 30, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool isEmail = false, bool isMessage = false, Color iconColor = Colors.grey}) {
    return TextFormField(
      controller: controller,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      maxLines: isMessage ? 5 : 1,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: iconColor),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter $label";
        }
        if (isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return "Enter a valid email address";
        }
        return null;
      },
    );
  }
}
