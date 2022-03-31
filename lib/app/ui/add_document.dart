import 'package:document_review/app/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///[AddDocumentScreen] allows a user to add a new document.
class AddDocumentScreen extends StatefulWidget {
  ///The constructor does not take any parameters.
  // ignore: sort_constructors_first
  const AddDocumentScreen({Key? key}) : super(key: key);

  @override
  State<AddDocumentScreen> createState() => _AddDocumentScreenState();
}

class _AddDocumentScreenState extends State<AddDocumentScreen> {
  ///Controller for the title.
  final TextEditingController titleController = TextEditingController();

  ///Controller for the description.
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ///List of strings for the dropdown button widget.
    final categories = <String>[
      'Category...',
      'Story',
      'Article',
      'Report',
      'Others'
    ];

    ///Initial value of the dropdown button.
    var category = 'Category...';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        title: const Text(
          'ADD DOCUMENT',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFieldWidget(controller: titleController, label: 'Title'),
            const SizedBox(height: 15),
            TextFieldWidget(
              controller: descriptionController,
              label: 'Brief Description',
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 7),
              decoration: const BoxDecoration(color: Colors.white),
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                      ),
                    ),
                  ),
                  value: category,
                  isExpanded: true,
                  items:
                      categories.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      category = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Upload (PDF Only)',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () {
                      ///Implement file picker.
                    },
                    child: const Text('Browse'),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: CircleAvatar(
                radius: 30,
                child: IconButton(
                  onPressed: () {
                    context.go('/home');
                  },
                  icon: const Icon(
                    Icons.upload,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
