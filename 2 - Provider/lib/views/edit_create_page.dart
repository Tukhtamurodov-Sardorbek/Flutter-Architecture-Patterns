import 'package:flutter/material.dart';
import 'package:patternprovider/view_models/edit_view_model.dart';
import 'package:patternprovider/models/post_model.dart';
import 'package:provider/provider.dart';

class EditCreatePage extends StatefulWidget {
  static const String id = '/edit_create_page';
  Post? post;

  EditCreatePage({Key? key, this.post}) : super(key: key);

  @override
  _EditCreatePageState createState() => _EditCreatePageState();
}

class _EditCreatePageState extends State<EditCreatePage> {
  AddOrEditController controller = AddOrEditController();

  @override
  void initState() {
    controller.post = widget.post;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => controller,
      child: Consumer<AddOrEditController>(
        builder: (ctx, model, index){
          return Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              elevation: 4.0,
              title: Text(widget.post!.title != null && widget.post!.body != null
                  ? "Edit post"
                  : "Create post"),
              centerTitle: true,
              actions: [
                TextButton(
                    onPressed: () {
                      controller.saveAndExit(context);
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(fontSize: 18),
                    ))
              ],
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          controller: controller.titleController
                            ..text = widget.post!.title?.toUpperCase() ??
                                controller.titleController.text,
                          maxLines: null,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 10, top: 10),
                              hintText: "Title"),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: controller.bodyController
                            ..text =
                                widget.post!.body ?? controller.bodyController.text,
                          maxLines: null,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintText: "Body",
                              border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                        ),
                      ],
                    ),
                  ),
                ),
                controller.isLoading
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : Container(),
              ],
            ),
          );
        },
      )
    );
  }
}
