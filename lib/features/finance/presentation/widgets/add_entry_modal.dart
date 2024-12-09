import 'package:flutter/material.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/date_form_field.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/entry_type_buttons.dart';

class AddEntryModal extends StatelessWidget {
  const AddEntryModal({super.key});

  @override
  Widget build(BuildContext context) {
    final _dateController = TextEditingController();

    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        const SizedBox(height: 22),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: EntryTypeButtons(),
        ),
        const SizedBox(height: 22),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 34.0),
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
            controller: _dateController,
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
            'Salvar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
