import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home.c.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController _homeController = Get.put(HomeController());

  void optionSelected(String option) {
    switch (option) {
      case 'sair':
        _homeController.logout(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          elevation: 0,
          actions: [
            PopupMenuButton<String>(
              onSelected: this.optionSelected,
              itemBuilder: (_) => [
                const PopupMenuItem<String>(
                  value: "perfil",
                  child: Text('Perfil'),
                ),
                const PopupMenuItem<String>(
                  value: "sair",
                  child: Text('Sair'),
                ),
              ],
            )
          ],
        ),
        body: GetBuilder<HomeController>(
          init: Get.put(HomeController()),
          initState: (_) {
            HomeController.to.getQuestionarios();
          },
          builder: (ctr) => SingleChildScrollView(
            child: Column(children: [
              Stack(children: [
                Positioned(
                  child: Container(
                    decoration: BoxDecoration(color: Color(0xff3b7ce3)),
                    height: 220,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                  child: Positioned(
                      child: Container(
                          width: size.width,
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                          decoration:
                              BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(2)), boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 2,
                              color: Colors.black.withOpacity(0.3),
                            )
                          ]),
                          height: 400,
                          child: Material(
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Opacity(
                                  opacity: 0.82,
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    Text('Questionários', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                    Row(children: [
                                      Padding(
                                          padding: EdgeInsets.symmetric(vertical: 8),
                                          child: IconButton(
                                            icon: Icon(Icons.filter_list),
                                            onPressed: () {},
                                          )),
                                      Padding(
                                          padding: EdgeInsets.symmetric(vertical: 8),
                                          child: IconButton(
                                            icon: Icon(Icons.search),
                                            onPressed: () {},
                                          ))
                                    ]),
                                  ]),
                                ),
                              ],
                            ),
                          ))),
                ),
              ]),
              Stack(children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  child: Positioned(
                      child: Container(
                          width: size.width,
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                          decoration:
                              BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(2)), boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 2,
                              color: Colors.black.withOpacity(0.3),
                            )
                          ]),
                          height: 400,
                          child: Material(
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Opacity(
                                  opacity: 0.82,
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    Text(
                                      'Suas respostas',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(vertical: 8),
                                        child: IconButton(
                                          icon: Icon(Icons.search),
                                          onPressed: () {},
                                        ))
                                  ]),
                                ),
                              ],
                            ),
                          ))),
                ),
              ]),
              SizedBox(height: 40),
            ]),
          ),
        ));
  }
}
