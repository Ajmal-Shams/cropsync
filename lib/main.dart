import 'package:flutter/material.dart';
import 'ai.dart';
import 'services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageController _pageController = PageController();
  int _currentIndex = 0; // For the bottom navigation bar
  int _pageIndex = 0; // For the PageView

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _pageIndex = _pageController.page!.round();
      });
    });
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
      // We don't change the page here to avoid moving the boxes
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            'CropSync',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white), // Settings button
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.menu, color: Colors.white), // Hamburger button
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.login, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Weather and Image Section
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey.shade900,
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'assets/farm.png', // Path to your local image
                              fit: BoxFit.cover,
                              height: 300,
                              width: double.infinity,
                            ),
                          ),
                          Positioned(
                            top: 16,
                            left: 16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.wb_cloudy, color: Colors.white),
                                Text('Cloudy', style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('11:00 AM', style: TextStyle(color: Colors.white, fontSize: 20)),
                                Text('Kanjirapally', style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                // Data Boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 80,
                      child: buildDataBox('36°', Icons.thermostat, Colors.red),
                    ),
                    SizedBox(
                      width: 80,
                      child: buildDataBox('40%', Icons.water_drop, Colors.blue),
                    ),
                    SizedBox(
                      width: 80,
                      child: buildDataBox('30%', Icons.cloud, Colors.grey),
                    ),
                    SizedBox(
                      width: 80,
                      child: buildDataBox('3.5 kmph', Icons.air, Colors.green),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                // Scrollable Circular Indicator Boxes
                Container(
                  height: 200, // Height for the circular indicator boxes
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    children: [
                      buildIndicatorBox([50, 70, 90], [Colors.red, Colors.green, Colors.blue]), // Example values for first box
                      buildIndicatorBox([30, 60, 80], [Colors.yellow, Colors.orange, Colors.purple]), // Example values for second box
                      buildIndicatorBox([20, 40, 70], [Colors.cyan, Colors.teal, Colors.lime]), // Example values for third box
                    ],
                  ),
                ),
                SizedBox(height: 8),
                // Dots Indicator (Only one set)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildClickableDot(0),
                    SizedBox(width: 8),
                    buildClickableDot(1),
                    SizedBox(width: 8),
                    buildClickableDot(2),
                  ],
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
bottomNavigationBar: BottomAppBar(
  color: Colors.black,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(
        icon: Icon(Icons.home, color: _currentIndex == 0 ? Colors.white : Colors.grey),
        onPressed: () {
          // Navigate to Home Page
       
        },
      ),
      // Land image button
      IconButton(
        icon: Image.asset(
          'assets/land.png', // Path to your local land image
          width: 30,
          height: 30,
          color: Colors.white,
        ),
        onPressed: () {
          // Navigate to Services Page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ServicesPage()), // Navigate to ServicesPage
          );
        },
      ),
      IconButton(
        icon: Icon(Icons.support_agent, color: _currentIndex == 2 ? Colors.white : Colors.grey),
        onPressed: () {
          // Navigate to AI Page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AIPage()), // Navigate to AIPage
          );
        },
      ),
    ],
  ),
),

      ),
    );
  }

  // Widget to create each data box
  Widget buildDataBox(String value, IconData icon, Color iconColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 110, // Increased height for data box
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 30), // Icon color passed as parameter
              SizedBox(height: 4),
              Text(value, style: TextStyle(color: Colors.white, fontSize: 18)),
            ],
          ),
        ),
      ],
    );
  }

  // Widget to create each indicator box with three percentage values in circular indicators
  Widget buildIndicatorBox(List<double> percentages, List<Color> colors) {
    return Container(
      margin: EdgeInsets.all(8), // Margin around the box
      padding: EdgeInsets.all(16), // Padding inside the box
      decoration: BoxDecoration(
        color: Colors.grey.shade800, // Background color for the box
        borderRadius: BorderRadius.circular(16), // Rounded corners
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(percentages.length, (index) {
          return buildCircularIndicator(percentages[index], colors[index]);
        }),
      ),
    );
  }

  // Widget to build a circular indicator with percentage value
  Widget buildCircularIndicator(double percentage, Color color) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(
            value: percentage / 100,
            strokeWidth: 8,
            backgroundColor: Colors.grey.shade600,
            valueColor: AlwaysStoppedAnimation<Color>(color), // Color for the circular indicator
          ),
        ),
        Text(
          '${percentage.toInt()}%', // Displaying the percentage
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Widget to build the dot indicators
  Widget buildClickableDot(int index) {
    return GestureDetector(
      onTap: () {
        // Animate to the selected page with duration and curve
        _pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 300), // Duration of the animation
          curve: Curves.easeInOut, // Animation curve
        );
      },
      child: Container(
        height: 12,
        width: 12,
        decoration: BoxDecoration(
          color: _pageIndex == index ? Colors.white : Colors.grey.shade600, // Change color for visibility
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
