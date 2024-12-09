import 'package:flutter/material.dart';

class EntryLabel extends StatelessWidget {
  final String label;
  final double entry;
  const EntryLabel({
    super.key,
    required this.label,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCost = entry < 0;
    return Row(
      children: [
        Expanded(
          child: Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          child: Text(
            'R\$ ${entry.toStringAsFixed(2).replaceAll('.', ',')}',
            style: TextStyle(
              color: isCost ? Colors.red : Colors.green,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
