import 'dart:io';

import 'package:document_review/app/features/DocumentReview/presentation/pages/home.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddDocumentScreen extends StatefulWidget {
  final Userm user;
  const AddDocumentScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<AddDocumentScreen> createState() => _AddDocumentScreenState();
}

class _AddDocumentScreenState extends State<AddDocumentScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String category = 'Category...';
  final categories = <String>[
    'Category...',
    'Story',
    'Article',
    'Report',
    'Others'
  ];
  String? documentName;
  String? downloadUrl;
  Future<File?> uploadDocument() async {
    //Use the file picker to upload a document.
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        documentName = result.files.single.name;
      });
      return File(result.files.single.path!);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        title: const Text(
          'ADD DOCUMENT',
        ),
      ),
      body: Container(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                labelText: 'Title',
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                  ),
                ),
              ),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                labelText: 'Brief description',
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                  ),
                ),
              ),
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
                  child: Container(
                    height: 49,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blueGrey.shade700,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.attach_file),
                        Flexible(
                          child: Text(
                            documentName ?? 'Upload (PDF Only)',
                          ),
                        ),
                      ],
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
                    onPressed: () async {
                      // await uploadDocument().then(
                      //   (value) async {
                      //     downloadUrl = await documentService
                      //         .addDocument(value!, documentName!)
                      //         .whenComplete(
                      //           () =>
                      //               ScaffoldMessenger.of(context).showSnackBar(
                      //             const SnackBar(
                      //               content:
                      //                   Text('Document uploaded successfully'),
                      //             ),
                      //           ),
                      //         );
                      //   },
                      // );
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
                    // Upload document to backend.
                    // documentService.uploadDocument(
                    //   username: widget.userm.toString(),
                    //   title: titleController.text,
                    //   description: descriptionController.text,
                    //   category: category,
                    //   document: downloadUrl!,
                    // );
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
