import 'package:flutter/material.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/date_form_field.dart';

class EditEntrydialog extends StatelessWidget {
  const EditEntrydialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 380,
        height: 380,
        child: Column(
          children: [
            const Text(
              'Editar Lançamento',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 34.0,
              ),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(
                      top: 13.0,
                      left: 26,
                    ),
                    child: Text(
                      'R\$',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  hintText: "10,00",
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.black45,
                  ),
                  labelStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: DateFormField(
                label: 'Data Movimentação',
                controller: TextEditingController(),
              ),
            ),
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Comentário'),
              ),
            ),
            const SizedBox(height: 44),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: const Size(200, 50),
              ),
              child: const Text(
                'Editar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
