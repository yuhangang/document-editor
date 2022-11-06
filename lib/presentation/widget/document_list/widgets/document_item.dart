import 'package:core/core/model/document.dart';
import 'package:documenteditor/presentation/bloc/document_list/document_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:documenteditor/app/path/app_path.dart' as app_path;

class DocumentItem extends StatelessWidget {
  const DocumentItem({
    Key? key,
    required this.context,
    required this.document,
    required this.state,
    //required this.onClone,
    required this.onDelete,
  }) : super(key: key);

  final BuildContext context;
  final DocumentFile document;
  final DocumentListLoaded state;
  //final void Function() onClone;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(app_path.editorPage, extra: document);
      },
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
                    document.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(getUpdateTimeDescription(state.loadedAt, document))
                ],
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == DocumentMenuItemAction.delete.name) {
                  onDelete.call();
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

  String getUpdateTimeDescription(
      DateTime timeToCompare, DocumentFile document) {
    final difference = timeToCompare.difference(document.updatedAt);
    if (difference.inDays > 364) {
      return "${(difference.inDays / 365).floor()} years ago";
    } else if (difference.inDays > 27) {
      return "${(difference.inDays / 28).floor()} months ago";
    } else if (difference.inDays > 6) {
      return "${(difference.inDays / 7).floor()} weeks ago";
    } else if (difference.inDays > 0) {
      return "${difference.inDays} days ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} hours ago";
    } else if (difference.inMinutes > 1) {
      return "${difference.inMinutes} minutes ago";
    }
    return "just now";
  }
}

enum DocumentMenuItemAction {
  delete,
  // TODO: implement clone document feature
  clone
}
