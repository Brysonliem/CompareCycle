import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              CustomPage(imagePath: 'assets/land1.png'),
              CustomPage(imagePath: 'assets/land2.png'),
              CustomPage(imagePath: 'assets/land3.png', isLastPage: true),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: _currentPage == 2
                ? ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Berikutnya'),
            )
                : Container(),
          ),
        ],
      ),
    );
  }
}

class CustomPage extends StatelessWidget {
  final String imagePath;
  final bool isLastPage;

  const CustomPage({required this.imagePath, this.isLastPage = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (isLastPage)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Berikutnya'),
            ),
        ],
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: usernameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (usernameController.text == 'BryanDadi' &&
                      passwordController.text == 'ayamgegeb12') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainMenuPage()),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Login Gagal'),
                          content: Text('Username atau password tidak valid.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLargeButton(context, 'Yamaha XSR 155', 'assets/yamaha.png'),
            _buildLargeButton(context, 'TVS Ronin 225', 'assets/tvs.png'),
            _buildLargeButton(context, 'Kawasaki W175', 'assets/w175.png'),
            _buildLargeButton(context, 'Compare', 'assets/back.png'),
          ],
        ),
      ),
    );
  }

  Widget _buildLargeButton(
      BuildContext context, String motorName, String motorImage) {
    return Container(
      width: 200,
      height: 60,
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          if (motorImage != null && motorName != 'Compare') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MotorDetailPage(
                  motorName: motorName,
                  motorImage: motorImage,
                ),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ComparingPage(),
              ),
            );
          }
        },
        child: Text(
          motorName,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  bool isComparingPageFilled() {
    return true; // Implementasikan logika sesuai kebutuhan
  }
}

class MotorDetailPage extends StatelessWidget {
  final String motorName;
  final String motorImage;

  const MotorDetailPage({
    required this.motorName,
    required this.motorImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(motorName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              motorImage,
              width: 1280, // Resolusi lebar sesuai ukuran standar
              height: 720, // Resolusi tinggi sesuai ukuran standar
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}

class ComparingPage extends StatelessWidget {
  final TextEditingController motor1Controller = TextEditingController();
  final TextEditingController motor2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comparing Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: motor1Controller,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Motor 1',
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            TextField(
              controller: motor2Controller,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Motor 2',
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String motor1 = motor1Controller.text;
                String motor2 = motor2Controller.text;

                String result = chooseBestMotor(motor1, motor2);

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Motor Pilihan'),
                      content: Text(result),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Cek Hasil'),
            ),
          ],
        ),
      ),
    );
  }

  String chooseBestMotor(String motor1, String motor2) {
    Map<String, Map<String, dynamic>> motorData = {
      'Yamaha XSR 155': {
        'Harga OTR': 37780000,
      },
      'TVS Ronin 225': {
        'Harga OTR': 38900000,
      },
      'Kawasaki W175': {
        'Harga OTR': 34600000,
      },
    };

    Map<String, dynamic>? dataMotor1 = motorData[motor1];
    Map<String, dynamic>? dataMotor2 = motorData[motor2];

    if (dataMotor1 != null && dataMotor2 != null) {
      int budget = 40000000;

      if (dataMotor1['Harga OTR'] <= budget && dataMotor2['Harga OTR'] <= budget) {
        if (dataMotor1['Harga OTR'] < dataMotor2['Harga OTR']) {
          return 'Pilih ${motor1}!';
        } else if (dataMotor1['Harga OTR'] > dataMotor2['Harga OTR']) {
          return 'Pilih ${motor2}!';
        } else {
          return 'Harga keduanya sama. Pilih sesuai selera Anda.';
        }
      } else if (dataMotor1['Harga OTR'] <= budget) {
        return 'Pilih ${motor1}!';
      } else if (dataMotor2['Harga OTR'] <= budget) {
        return 'Pilih ${motor2}!';
      } else {
        return 'Kedua motor melebihi budget Anda.';
      }
    } else {
      return 'Motor tidak valid.';
    }
  }
}
