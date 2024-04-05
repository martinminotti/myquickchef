import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myquickchef/models/recipe.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:myquickchef/services/api_service.dart';

class RecipeCardScreen extends StatefulWidget {
  const RecipeCardScreen({required this.recipe, super.key});

  final Recipe recipe;

  @override
  State<RecipeCardScreen> createState() => _RecipeCardScreenState();
}

class _RecipeCardScreenState extends State<RecipeCardScreen> {
  var click = false;

  Future<Image> getImage() async {
    // final url =await ApiService().generateImage(recipeName: widget.recipe.name);
    final url =
        "https://oaidalleapiprodscus.blob.core.windows.net/private/org-kL8HhjzTITcoFzNeQyppAdGz/user-mFFMTQxy3gspgpyUKVUJLKB3/img-HoziPJm2jSP7bRyzar53s6r0.png?st=2024-04-05T20%3A31%3A05Z&se=2024-04-05T22%3A31%3A05Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-04-04T23%3A36%3A56Z&ske=2024-04-05T23%3A36%3A56Z&sks=b&skv=2021-08-06&sig=goRIeJCorbl8mXhE4GnBdpSxH93%2BLbU86Lba3y/A3qc%3D";
    final image = Image.network(url);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () async {
            await Navigator.maybePop(context);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: FutureBuilder(
        future: getImage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Image(
                        image: snapshot.data!.image,
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
                                click = !click;
                              });
                            },
                            icon: Image.asset((click == false)
                                ? 'lib/icons/like_off.png'
                                : 'lib/icons/like_on.png'),
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
}
