import 'package:flutter/material.dart';

class InvoiceCategory extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sublabel;

  const InvoiceCategory({
    Key? key,
    required this.icon,
    required this.label,
    required this.sublabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          Text(label),
          Text(sublabel),
        ],
      ),
    );
  }
}
