import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class Newlist extends StatefulWidget {
  const Newlist({Key? key}) : super(key: key);

  @override
  State<Newlist> createState() => _NewlistState();
}

class _NewlistState extends State<Newlist> {
  List names = [];
  String temp = "";
  TextEditingController inputtext = TextEditingController();
  TextEditingController updatename = TextEditingController();

  addnames() {
    names.add(temp);
  }

  cleartext() {
    inputtext.clear();
  }

  deleteitem(index) {
    setState(() {
      names.removeAt(index);
    });
  }

  updateitem(index) {
    setState(() {
      names.replaceRange(index, index + 1, {updatename.text});
      updatename.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text("TODO LIST"),
      )
          //   title: Center(
          // child: RaisedButton(
          //   child: Text("add"),
          //   onPressed: () {

          // },
          ),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(12.0),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    //borderSide: BorderSide(color: Colors.black, width: 5, style: )
                    ),
                hintText: "enter name",
                suffixIcon: IconButton(
                  onPressed: () {
                    inputtext.clear();
                    //const Icon(Icons.clear);
                  },
                  icon: const Icon(Icons.clear),
                )),
            onChanged: (inputtext) {
              temp = inputtext;
            },
            controller: inputtext,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: RaisedButton(
            onPressed: () {
              setState(() {
                addnames();
                cleartext();
              });
            },
            child: Text("ADD"),
            color: Colors.blue,
          ),
        ),
        Expanded(
            child: ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: names.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              tileColor: Colors.grey,
              title: Text(names[index]),
              trailing: SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Expanded(
                  child: Row(
                    children: [
                      //color: Color.fromARGB(255, 102, 101, 101),
                      //OverflowBox()
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("update new label"),
                                  content: TextField(
                                    controller: updatename,
                                  ),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop;
                                          updateitem(index);
                                          //updatename.clear();
                                        },
                                        child: Text("update"))
                                  ],
                                );
                              });
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          deleteitem(index);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )),
      ]),
    );
  }
}
