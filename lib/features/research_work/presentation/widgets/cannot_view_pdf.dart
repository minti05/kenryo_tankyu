import 'package:flutter/material.dart';
import "package:kenryo_tankyu/core/constants/work/info_value.dart";

class CannotViewPdf extends StatefulWidget {
  const CannotViewPdf({super.key});

  @override
  State<CannotViewPdf> createState() => _CannotViewPdfState();
}

class _CannotViewPdfState extends State<CannotViewPdf> {
  List<bool> _selectedCannotViewPdf =
      List.generate(DocumentType.values.length, (index) => false);
  TextEditingController _freeDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('問題のあるPDFを選択してください',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: DocumentType.values.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(DocumentType.values[index].displayName),
          value: _selectedCannotViewPdf[index],
          onChanged: (bool? value) {
            setState(() {
              _selectedCannotViewPdf[index] = value!;
            });
          },
              );
            }),
        TextFormField(
          controller: _freeDescriptionController,
          maxLines: 3,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '自由記述',
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            print(_freeDescriptionController.text);
          },
          child: const Text('送信'),
        ),
      ],
    );
  }
}
