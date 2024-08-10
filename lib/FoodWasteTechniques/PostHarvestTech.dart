import 'package:flutter/material.dart';

class PostHarvestTechPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post-Harvest Technology',style: TextStyle(
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
                    'Post-harvest technology focuses on preserving the quality and extending the shelf life of crops after they are harvested. It involves various processes such as drying, cooling, cleaning, sorting, and packaging to prevent spoilage and loss.',
                    style: TextStyle(fontSize: 16.0, color: Colors.black87),
                  ),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'Key Technologies'),
                  SizedBox(height: 10.0),
                  TechnologyCard(
                    icon: Icons.dry,
                    title: 'Drying Technology',
                    description: 'Reduces moisture content to prevent mold and spoilage.',
                  ),
                  TechnologyCard(
                    icon: Icons.ac_unit,
                    title: 'Cooling Systems',
                    description: 'Lowers temperature to slow down decay and maintain freshness.',
                  ),
                  TechnologyCard(
                    icon: Icons.sort,
                    title: 'Sorting & Grading Machines',
                    description: 'Automates the process of sorting crops by size, weight, and quality.',
                  ),
                  TechnologyCard(
                    icon: Icons.local_shipping,
                    title: 'Packaging Solutions',
                    description: 'Protects products during transportation and storage.',
                  ),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'Benefits'),
                  SizedBox(height: 10.0),
                  BulletPoint(text: 'Minimized post-harvest losses.'),
                  BulletPoint(text: 'Extended shelf life of produce.'),
                  BulletPoint(text: 'Maintained nutritional value of crops.'),
                  BulletPoint(text: 'Increased market value and profits.'),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'Challenges'),
                  SizedBox(height: 10.0),
                  BulletPoint(text: 'High cost of post-harvest technologies.'),
                  BulletPoint(text: 'Energy consumption for drying and cooling.'),
                  BulletPoint(text: 'Need for skilled labor to operate machines.'),
                  BulletPoint(text: 'Infrastructure limitations in rural areas.'),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'How to Implement'),
                  SizedBox(height: 10.0),
                  BulletPoint(text: 'Invest in appropriate drying and cooling technologies based on crop type.'),
                  BulletPoint(text: 'Use sorting and grading machines to improve quality control.'),
                  BulletPoint(text: 'Adopt packaging solutions that suit the transportation and storage needs.'),
                  BulletPoint(text: 'Train workers on the proper use and maintenance of post-harvest technologies.'),
                  BulletPoint(text: 'Consider energy-efficient technologies to reduce operational costs.'),
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
          Icons.build,
          size: 80.0,
          color: Colors.green.shade700,
        ),
        SizedBox(width: 20.0),
        Expanded(
          child: Text(
            'Post-Harvest Technology',
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