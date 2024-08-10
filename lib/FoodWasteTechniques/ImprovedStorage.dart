import 'package:flutter/material.dart';

class ImprovedStoragePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Improved Storage',
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
                    'Improved storage techniques are essential to minimize post-harvest losses and ensure that crops remain fresh for longer periods. These techniques often involve better storage facilities, controlled environments, and the use of advanced materials to prevent spoilage.',
                    style: TextStyle(fontSize: 16.0, color: Colors.black87),
                  ),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'Key Technologies'),
                  SizedBox(height: 10.0),
                  TechnologyCard(
                    icon: Icons.ac_unit,
                    title: 'Cold Storage',
                    description:
                        'Maintains optimal temperature to preserve perishable goods.',
                  ),
                  TechnologyCard(
                    icon: Icons.opacity,
                    title: 'Humidity Control',
                    description:
                        'Regulates moisture levels to prevent mold and spoilage.',
                  ),
                  TechnologyCard(
                    icon: Icons.all_inclusive,
                    title: 'Modified Atmosphere Packaging',
                    description:
                        'Uses gases to extend the shelf life of products.',
                  ),
                  TechnologyCard(
                    icon: Icons.sanitizer,
                    title: 'Sanitation & Hygiene',
                    description:
                        'Ensures cleanliness to prevent contamination.',
                  ),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'Benefits'),
                  SizedBox(height: 10.0),
                  BulletPoint(text: 'Reduced post-harvest losses.'),
                  BulletPoint(text: 'Extended shelf life of crops.'),
                  BulletPoint(text: 'Improved food safety and quality.'),
                  BulletPoint(text: 'Higher profits for farmers.'),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'Challenges'),
                  SizedBox(height: 10.0),
                  BulletPoint(
                      text: 'High cost of advanced storage facilities.'),
                  BulletPoint(text: 'Energy requirements for cold storage.'),
                  BulletPoint(
                      text: 'Need for technical knowledge to operate systems.'),
                  BulletPoint(
                      text: 'Access to these technologies in remote areas.'),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'How to Implement'),
                  SizedBox(height: 10.0),
                  BulletPoint(
                      text:
                          'Invest in quality storage facilities that suit the type of crop.'),
                  BulletPoint(
                      text:
                          'Use temperature and humidity control systems to maintain optimal conditions.'),
                  BulletPoint(
                      text:
                          'Adopt modified atmosphere packaging for longer shelf life.'),
                  BulletPoint(
                      text:
                          'Maintain high standards of hygiene to prevent contamination.'),
                  BulletPoint(
                      text:
                          'Train staff on the proper use of storage technologies.'),
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
          Icons.store_mall_directory,
          size: 80.0,
          color: Colors.green.shade700,
        ),
        SizedBox(width: 20.0),
        Expanded(
          child: Text(
            'Improved Storage',
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
