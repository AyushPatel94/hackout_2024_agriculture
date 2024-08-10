import 'package:flutter/material.dart';

class SupplyChainOptimizationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supply Chain Optimization',style: TextStyle(
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
                    'Supply chain optimization involves streamlining the process from farm to market, ensuring that agricultural products are delivered in the most efficient, cost-effective, and timely manner. This includes the use of technology, logistics management, and collaboration across the supply chain to reduce waste and improve profitability.',
                    style: TextStyle(fontSize: 16.0, color: Colors.black87),
                  ),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'Key Technologies'),
                  SizedBox(height: 10.0),
                  TechnologyCard(
                    icon: Icons.local_shipping,
                    title: 'Logistics Management',
                    description: 'Optimizes the transportation and distribution of goods to reduce delays and costs.',
                  ),
                  TechnologyCard(
                    icon: Icons.cloud,
                    title: 'Cloud-based Platforms',
                    description: 'Provides real-time tracking and data analysis to improve decision-making.',
                  ),
                  TechnologyCard(
                    icon: Icons.sync,
                    title: 'Blockchain Technology',
                    description: 'Ensures transparency and traceability across the supply chain.',
                  ),
                  TechnologyCard(
                    icon: Icons.network_check,
                    title: 'IoT and Sensors',
                    description: 'Monitors conditions during transportation to maintain product quality.',
                  ),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'Benefits'),
                  SizedBox(height: 10.0),
                  BulletPoint(text: 'Reduced waste and spoilage through better logistics.'),
                  BulletPoint(text: 'Improved product quality and safety.'),
                  BulletPoint(text: 'Lower transportation and operational costs.'),
                  BulletPoint(text: 'Enhanced collaboration across the supply chain.'),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'Challenges'),
                  SizedBox(height: 10.0),
                  BulletPoint(text: 'Integration of new technologies into existing systems.'),
                  BulletPoint(text: 'High initial costs for implementing technology solutions.'),
                  BulletPoint(text: 'Data privacy and security concerns.'),
                  BulletPoint(text: 'Need for skilled labor to manage advanced systems.'),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'How to Implement'),
                  SizedBox(height: 10.0),
                  BulletPoint(text: 'Invest in logistics management software to optimize routes and reduce costs.'),
                  BulletPoint(text: 'Use cloud-based platforms for real-time tracking and data analysis.'),
                  BulletPoint(text: 'Implement blockchain technology to ensure transparency and traceability.'),
                  BulletPoint(text: 'Adopt IoT sensors to monitor product conditions during transportation.'),
                  BulletPoint(text: 'Train staff on the use of new technologies to maximize benefits.'),
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
          Icons.sync,
          size: 80.0,
          color: Colors.green.shade700,
        ),
        SizedBox(width: 20.0),
        Expanded(
          child: Text(
            'Supply Chain Optimization',
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