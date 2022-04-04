import 'dart:io';

import 'package:document_review/app/features/DocumentReview/presentation/cubit/documentreview_cubit.dart';
import 'package:document_review/app/features/DocumentReview/presentation/pages/home.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: BlocConsumer<DocumentreviewCubit, DocumentreviewState>(
        listener: ((context, state) {
          if (state is DocumentUploaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Document stored successfully'),
                duration: Duration(seconds: 1),
              ),
            );
            setState(() {
              downloadUrl = state.url;
            });
          } else if (state is DocumentSuccessful) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Document uploaded successfully'),
                duration: Duration(seconds: 1),
              ),
            );
            Navigator.pop(context);
            BlocProvider.of<DocumentreviewCubit>(context).getDocuments();
          }
        }),
        builder: (context, state) {
          if (state is DocumentLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return _buildBody();
        },
      ),
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
            const SizedBox(height: 20),
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
                      final file = await uploadDocument();
                      BlocProvider.of<DocumentreviewCubit>(context)
                          .storeDocument(file!, documentName!);
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
                    BlocProvider.of<DocumentreviewCubit>(context)
                        .uploadDocument(
                      username: widget.user.name,
                      title: titleController.text,
                      description: descriptionController.text,
                      category: category,
                      document: downloadUrl!,
                    );
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
