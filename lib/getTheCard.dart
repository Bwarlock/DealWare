import 'package:flutter/material.dart';


class GetTheCard extends StatelessWidget {
  var url1;
  String title;
  var price_old;
  var price_new;
  var price_cut;
  String shop;
  bool isDLC;
  bool isPackage;
  bool isEarlyAccess;
  bool isTradingCards;
  bool isAchievements;
  GetTheCard(this.url1,this.title,this.price_old,this.price_new,this.price_cut,this.shop,this.isDLC,this.isPackage,this.isEarlyAccess,this.isTradingCards,this.isAchievements, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (url1 != "") ...[
                    Expanded(
                      flex: 2,
                      child: FadeInImage(
                        image: NetworkImage(url1),
                        placeholder: const AssetImage("assets/default.jpg"),
                        imageErrorBuilder: (context , e , s){
                          return Image.asset("assets/default.jpg");
                        },
                      ),
                    ),],

                  if (url1 == "") ...[
                    Expanded(
                      flex: 2,
                      child: Image.asset("assets/default.jpg"),
                    ),],



                  const SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      if (isAchievements) ...[Container(
                                        padding: const EdgeInsets.all(1),
                                        decoration: const BoxDecoration(
                                          color: Colors.lightGreen,
                                        ),
                                        child: const Center(
                                            child: Text("Achievements")),
                                      ),
                                        const SizedBox(
                                          height: 3,
                                        ),],
                                      if(isTradingCards) ...[Container(
                                        padding: const EdgeInsets.all(1),
                                        decoration: const BoxDecoration(
                                          color: Colors.lightGreen,
                                        ),
                                        child: const Center(
                                            child: Text("TradingCards")),
                                      ),],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.all(1),
                                width: 50,
                                height: 30,
                                decoration: const BoxDecoration(
                                  color: Colors.lightGreen,
                                ),
                                child: Center(child: Text("-$price_cut%")),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$$price_old",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      decoration:
                                      TextDecoration.lineThrough,
                                      decorationThickness: 1.5,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    "\$$price_new",
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.lightGreen,
                      ),
                      child: Center(
                          child: Text(
                            shop,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if(isDLC) ...[
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.lightGreen,
                            ),
                            child: const Center(child: Text("DLC")),
                          ),
                          const SizedBox(
                            width: 6,
                          ),],
                        if(isPackage) ...[
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.lightGreen,
                            ),
                            child: const Center(child: Text("Package")),
                          ),
                          const SizedBox(
                            width: 6,
                          ),],
                        if(isEarlyAccess) ...[
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.lightGreen,
                            ),
                            child: const Center(child: Text("EarlyAccess")),
                          ),],
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /*
  static Widget theTile(String url1,String title,price_old,price_new,price_cut,String shop,bool isDLC, bool isPackage, bool isEarlyAccess,bool isTradingCards, bool isAchievements){

    return Card(
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (url1 != "") ...[
                  Expanded(
                    flex: 2,
                    child: FadeInImage(
                      image: NetworkImage(url1),
                      placeholder: const AssetImage("assets/default.jpg"),
                      imageErrorBuilder: (context , e , s){
                        return Image.asset("assets/default.jpg");
                      },
                    ),
                  ),],

                  if (url1 == "") ...[
                    Expanded(
                      flex: 2,
                      child: Image.asset("assets/default.jpg"),
                    ),],



                  const SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      if (isAchievements) ...[Container(
                                        padding: const EdgeInsets.all(1),
                                        decoration: const BoxDecoration(
                                          color: Colors.lightGreen,
                                        ),
                                        child: const Center(
                                            child: Text("Achievements")),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),],
                                      if(isTradingCards) ...[Container(
                                        padding: const EdgeInsets.all(1),
                                        decoration: const BoxDecoration(
                                          color: Colors.lightGreen,
                                        ),
                                        child: const Center(
                                            child: Text("TradingCards")),
                                      ),],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.all(1),
                                width: 50,
                                height: 30,
                                decoration: const BoxDecoration(
                                  color: Colors.lightGreen,
                                ),
                                child: Center(child: Text("-$price_cut%")),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$$price_old",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      decoration:
                                      TextDecoration.lineThrough,
                                      decorationThickness: 1.5,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    "\$$price_new",
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.lightGreen,
                      ),
                      child: Center(
                          child: Text(
                            shop,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if(isDLC) ...[
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.lightGreen,
                          ),
                          child: const Center(child: Text("DLC")),
                        ),
                        const SizedBox(
                          width: 6,
                        ),],
                        if(isPackage) ...[
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.lightGreen,
                          ),
                          child: const Center(child: Text("Package")),
                        ),
                        const SizedBox(
                          width: 6,
                        ),],
                        if(isEarlyAccess) ...[
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.lightGreen,
                          ),
                          child: const Center(child: Text("EarlyAccess")),
                        ),],
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );


  }*/
}
