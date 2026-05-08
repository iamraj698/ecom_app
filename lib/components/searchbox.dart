import 'package:flutter/material.dart';
import '../utils/size_config.dart';

class SearchBox extends StatefulWidget {
  SearchBox({super.key, this.isenabled = true, this.searchController});
  bool isenabled;
  TextEditingController? searchController;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: height(50),
      // width: width(275),
      decoration: BoxDecoration(
          color: Color(0xffF5F6FA),
          borderRadius: BorderRadius.circular(width(15))),
      alignment: Alignment.center,
      child: TextField(
        controller: widget.searchController,
        textAlignVertical: TextAlignVertical.center,
        enabled: widget.isenabled,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search...",
          hintStyle: TextStyle(color: Color(0xff8F959E)),
          prefixIcon: Icon(Icons.search),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: height(14)),
        ),
      ),
    );
  }
}
