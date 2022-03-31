import 'package:flutter/material.dart';

///This is a custom built widget for the search function.
class SearchWidget extends StatelessWidget {
  ///The constructor does not take any parameters.
  const SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 5,
            offset: const Offset(-1, 3),
          ),
        ],
      ),
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: 'Search for documents...',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
