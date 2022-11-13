import 'package:flutter/material.dart';
import 'package:geeruh/screens/board/board_store.dart';
import 'package:geeruh/utils/state_with_lifecycle.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends StateWithLifecycle<BoardScreen> {
  final BoardStore _boardStore = BoardStore();

  @override
  void preFirstBuildInit() {
    _boardStore.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Board Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Table(
          border: TableBorder.all(borderRadius: BorderRadius.circular(20)),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: <TableRow>[titleTableRow(), tableRow()],
        ),
      ),
    );
  }
}

TableRow titleTableRow() {
  return TableRow(
    children: <Widget>[
      titleTableRowTextField("Backlog"),
      titleTableRowTextField("Selected for development"),
      titleTableRowTextField("In progress"),
      titleTableRowTextField("Awaiting review"),
      titleTableRowTextField("Done"),
    ],
  );
}

Widget titleTableRowTextField(String columnName) {
  return Flexible(
    child: Container(
      padding: const EdgeInsets.only(left: 13, top: 4, bottom: 4),
      child: Text(
        columnName,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 20),
      ),
    ),
  );
}

TableRow tableRow() {
  return TableRow(
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 228, 228, 228),
    ),
    children: <Widget>[
      taskColumn(),
      taskColumn(),
      taskColumn(),
      taskColumn(),
      taskColumn()
    ],
  );
}

Widget taskColumn() {
  return Column(children: [taskContainer(), taskContainer(), taskContainer()]);
}

Widget taskContainer() {
  return Container(
    margin: const EdgeInsets.all(15.0),
    padding: const EdgeInsets.all(3.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: const [Text("123")],
    ),
  );
}
