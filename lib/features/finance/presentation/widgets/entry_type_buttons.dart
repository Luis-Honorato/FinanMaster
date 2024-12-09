import 'package:flutter/material.dart';

class EntryTypeButtons extends StatelessWidget {
  const EntryTypeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.blue.shade300,
            side: BorderSide.none,
          ),
          child: const Row(
            children: [
              Icon(
                Icons.attach_money,
                color: Colors.black,
              ),
              Text(
                'Salário',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(width: 20),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
              )
            ],
          ),
        ),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.red.shade300,
            side: BorderSide.none,
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/images/despesa.png',
                width: 30,
                height: 30,
              ),
              const Text(
                'Despesa',
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(width: 20),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
              )
            ],
          ),
        )
      ],
    );
  }
}
