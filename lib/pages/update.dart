import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notes/model/product_model.dart';
import 'package:notes/services/api.dart';

class Update extends StatefulWidget {
  final Note Data;
  const Update({super.key, required this.Data});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  TextEditingController _editData = TextEditingController();
  TextEditingController _editDate = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _editData.text = widget.Data.data.toString();
      _editDate.text = widget.Data.date.toString();
    });
    super.initState();
  }

  void _refreshNotes() {
    setState(() {
      API.get_product();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        backgroundColor: Colors.grey[900],
        child: Container(
            margin: EdgeInsets.fromLTRB(10, 80, 10, 0),
            width: 800,
            height: 500,
            child: Body()));
  }

  //DatePicker
  Future<void> _Date() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (picked != null) {
      setState(() {
        _editDate.text = picked.toString().split(" ")[0];
      });
    } else {
      setState(() {
        _editDate.text = "No Date Selected";
      });
    }
  }

  Widget Body() {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Text1(),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          width: 240,
          height: 3,
          color: Colors.yellow,
        ),
        SizedBox(
          height: 20,
        ),
        SearchField(),
        SizedBox(
          height: 20,
        ),
        DateCalender(),
        SizedBox(
          height: 20,
        ),
        RowButtons(),
      ],
    );
  }

  Widget Text1() {
    return Text(
      "Edit You Note",
      style: TextStyle(
        color: Colors.white,
        fontSize: 36,
        fontFamily: 'Radio',
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget SearchField() {
    return Container(
      child: TextField(
        maxLength: 200,
        style: TextStyle(color: Colors.white),
        controller: _editData,
        decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.orange[400]!, width: 2.0)),
          filled: true,
          fillColor: Colors.grey[850],
          labelText: "Text",
          labelStyle: TextStyle(fontSize: 18, color: Colors.white),
          prefixIcon: Icon(
            Icons.wrap_text,
            color: Colors.white,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }

  Widget DateCalender() {
    return Container(
      child: TextField(
        style: TextStyle(color: Colors.white),
        readOnly: true,
        onTap: () {
          _Date();
        },
        controller: _editDate,
        decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.orange[400]!, width: 2.0)),
          filled: true,
          fillColor: Colors.grey[850],
          labelText: "Select Date",
          labelStyle: TextStyle(fontSize: 18, color: Colors.white),
          prefixIcon: Icon(
            Icons.date_range,
            color: Colors.white,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }

  Widget RowButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () async {
            Map data = {
              "data": _editData.text,
              "date": _editDate.text,
              "id": widget.Data.id
            };

            //  API.add_product(data);
            await API.update_product(widget.Data.id, data);
            _refreshNotes();

            Navigator.of(context).pop();
          },
          child: Text(
            'Edit',
            style: TextStyle(color: Colors.yellow[400]),
          ),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.black),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            _editData.text = "";
            _editDate.text = "";
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.yellow[400]),
          ),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.black),
          ),
        ),
      ],
    );
  }
}
