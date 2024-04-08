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
    //final url =await ApiService().generateImage(recipeName: widget.recipe.name);
    final url ="https://oaidalleapiprodscus.blob.core.windows.net/private/org-kL8HhjzTITcoFzNeQyppAdGz/user-mFFMTQxy3gspgpyUKVUJLKB3/img-5hQ3Lr4TODxNjudAB0bgzO1n.png?st=2024-04-08T14%3A00%3A30Z&se=2024-04-08T16%3A00%3A30Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-04-08T00%3A14%3A17Z&ske=2024-04-09T00%3A14%3A17Z&sks=b&skv=2021-08-06&sig=wDPoExieV7yU0RTTikDMH5ezV4rZZDpWPOfmm1nkC0A%3D";
    final image = Image.network(url);
    widget.recipe.image = image;
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: widget.recipe.image != null
          ? showRecipeDetails2()
          : FutureBuilder(
        future: getImage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return showRecipeDetails2();
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

  Scaffold showRecipeDetails2() {
    return Scaffold(
            body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () async {
                    await Navigator.maybePop(context);
                  },
                ),
                expandedHeight: 300.0,
                floating: false,
                pinned: false,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    collapseMode: CollapseMode.parallax,
                    background: ClipRRect(
                        borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(36.0),
                        bottomRight: Radius.circular(36.0),
                      ),
                      child: Image(
                        image: widget.recipe.image!.image,
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
            ];
          },
          body: Container(
            margin: const EdgeInsets.only(top: 0), // Margin negativo per far sormontare la card sull'immagine
            child: showRecipeDetails(),
          )
      ),
    );
  }

  Container showRecipeDetails() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      // decoration: BoxDecoration(
      //     color: Colors.transparent,
      //     border: Border.all(
      //       color: Colors.red,
      //     ),
      //     borderRadius: BorderRadius.all(Radius.circular(36))
      // ),

      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                color: Colors.white,
                height: 30,
                thickness: 4,
                indent: 1,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(widget.recipe.name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)),
              
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