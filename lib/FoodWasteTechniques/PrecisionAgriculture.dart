import 'package:flutter/material.dart';

class PrecisionAgriculturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Precision Agriculture',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green.shade700,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderSection(),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView(
                children: [
                  SectionTitle(title: 'Overview'),
                  SizedBox(height: 10.0),
                  Text(
                    'Precision agriculture, also known as precision farming, uses advanced technology to optimize field-level management. This includes the use of sensors, drones, GPS, and IoT for efficient resource utilization and reduced waste.',
                    style: TextStyle(fontSize: 16.0, color: Colors.black87),
                  ),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'Key Technologies'),
                  SizedBox(height: 10.0),
                  TechnologyCard(
                    icon: Icons.airplanemode_active,
                    title: 'Drones',
                    description:
                        'Used for aerial surveillance, crop monitoring, and applying inputs.',
                  ),
                  TechnologyCard(
                    icon: Icons.agriculture,
                    title: 'GPS-guided Tractors',
                    description:
                        'For precise planting, fertilizing, and harvesting.',
                  ),
                  TechnologyCard(
                    icon: Icons.sensors,
                    title: 'IoT Sensors',
                    description:
                        'Monitor soil conditions, weather, and crop health in real-time.',
                  ),
                  TechnologyCard(
                    icon: Icons.bar_chart,
                    title: 'Data Analytics',
                    description: 'Analyzes data for better decision-making.',
                  ),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'Benefits'),
                  SizedBox(height: 10.0),
                  BulletPoint(
                      text: 'Reduced waste through precise input application.'),
                  BulletPoint(text: 'Improved crop yield and quality.'),
                  BulletPoint(text: 'Lower environmental impact.'),
                  BulletPoint(text: 'Cost savings for farmers.'),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'Challenges'),
                  SizedBox(height: 10.0),
                  BulletPoint(text: 'High initial investment cost.'),
                  BulletPoint(
                      text: 'Requires technical knowledge and training.'),
                  BulletPoint(
                      text: 'Data management and analysis complexities.'),
                  BulletPoint(
                      text: 'Limited access to technology in some regions.'),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'How to Implement'),
                  SizedBox(height: 10.0),
                  BulletPoint(
                    text:
                        'Conduct a soil analysis to understand the variability in your fields.',
                  ),
                  BulletPoint(
                      text:
                          'Invest in GPS-guided equipment for accurate planting and harvesting.'),
                  BulletPoint(
                      text:
                          'Use drones for regular crop monitoring and to detect issues early.'),
                  BulletPoint(
                      text:
                          'Install IoT sensors to monitor soil moisture and weather conditions.'),
                  BulletPoint(
                      text:
                          'Collect and analyze data to make informed decisions about input application.'),
                  BulletPoint(
                      text:
                          'Consider partnering with technology providers or consultants for expert advice.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.agriculture,
          size: 80.0,
          color: Colors.green.shade700,
        ),
        SizedBox(width: 20.0),
        Expanded(
          child: Text(
            'Precision Agriculture',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: Colors.green.shade700,
      ),
    );
  }
}

class TechnologyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  TechnologyCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 40.0,
              color: Colors.green.shade700,
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    description,
                    style: TextStyle(fontSize: 16.0, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green.shade700,
            size: 18.0,
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16.0, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
