import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myquickchef/models/recipe.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:myquickchef/services/api_service.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({required this.recipe, super.key});

  final Recipe recipe;

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  var click = false;

  Future<Image> getImage() async {
    // final url =await ApiService().generateImage(recipeName: widget.recipe.name);
    final url =
        "https://oaidalleapiprodscus.blob.core.windows.net/private/org-kL8HhjzTITcoFzNeQyppAdGz/user-mFFMTQxy3gspgpyUKVUJLKB3/img-iL6NsTV56qlIv4IPEsyygNki.png?st=2024-04-07T19%3A59%3A23Z&se=2024-04-07T21%3A59%3A23Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-04-07T00%3A00%3A18Z&ske=2024-04-08T00%3A00%3A18Z&sks=b&skv=2021-08-06&sig=R7bqRs5x/Xc9kB6CbG/%2BAyh/tSeN/b5FNCJnv/E0u1I%3D";
    final image = Image.network(url);
    widget.recipe.image = image;
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () async {
            await Navigator.maybePop(context);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: widget.recipe.image != null
          ? showRecipeDetails()
          : FutureBuilder(
              future: getImage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  return showRecipeDetails();
                } else {
                  return const Center(
                      child: Text(
                    "Image Error",
                    textAlign: TextAlign.center,
                  ));
                }
              },
            ),
    );
  }

  Container showRecipeDetails() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image(
                image: widget.recipe.image!.image,
              )),
              const Divider(
                color: Colors.grey,
                height: 30,
                thickness: 4,
                indent: 1,
              ),
              Text(widget.recipe.name),
              Text(
                  "${widget.recipe.category} • ${widget.recipe.preparationTime}"),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.recipe.favorite = !widget.recipe.favorite;
                      });
                    },
                    icon: Image.asset((widget.recipe.favorite)
                        ? 'lib/icons/like_on.png'
                        : 'lib/icons/like_off.png'),
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
                height: 30,
                thickness: 4,
                indent: 1,
              ),
              const Text("Ingredienti"),
              BulletedList(
                crossAxisAlignment: CrossAxisAlignment.start,
                bulletColor: Colors.black87,
                listItems: widget.recipe.ingredients,
                bulletType: BulletType.conventional,
              ),
              const Divider(
                color: Colors.grey,
                height: 30,
                thickness: 4,
                indent: 1,
              ),
              const Text("Ricetta"),
              BulletedList(
                crossAxisAlignment: CrossAxisAlignment.start,
                bulletColor: Colors.black87,
                listItems: widget.recipe.steps,
                bulletType: BulletType.numbered,
              )
            ],
          ),
        ],
      ),
    );
  }
}
