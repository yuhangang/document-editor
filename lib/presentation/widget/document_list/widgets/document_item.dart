import 'package:flutter/material.dart';

class DocumentItem extends StatelessWidget {
  const DocumentItem({
    Key? key,
    required this.title,
    required this.timeStamp,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  final String title;
  final String timeStamp;
  final void Function() onTap;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.grey[50],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(timeStamp)
                ],
              ),
            ),
            if (onDelete != null)
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == DocumentMenuItemAction.delete.name) {
                    onDelete!.call();
                  } // else if (value == DocumentMenuItemAction.clone.name) {
                  // onClone.call();
                  // }
                },
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context) {
                  return DocumentMenuItemAction.values
                      .map((e) => e.name)
                      .map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
          ],
        ),
      ),
    );
  }
}

enum DocumentMenuItemAction {
  delete,
  // TODO: implement clone document feature
  clone
}
