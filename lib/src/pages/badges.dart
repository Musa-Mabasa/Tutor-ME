import 'package:flutter/material.dart';
import 'package:tutor_me/src/colorpallete.dart';

class Badges extends StatefulWidget {
  const Badges({Key? key}) : super(key: key);

  @override
  State<Badges> createState() => _PageState();
}

class _PageState extends State<Badges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        topDesign(),
        buildBody(),
        // buildBody(),
      ],
    ));
  }

  Widget topDesign() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
            margin: const EdgeInsets.only(bottom: 78),
            child: buildCoverImage()),
        Positioned(
          top: 100,
          child: buildProfileImage(),
        ),
      ],
    );
  }

  Widget buildProfileImage() => CircleAvatar(
        // radius: MediaQuery.of(context).size.width * 0.127,
        // child: widget.imageExists
        //     ? ClipOval(
        //         child: Image.memory(
        //           widget.image,
        //           fit: BoxFit.cover,
        //           width: MediaQuery.of(context).size.width * 0.253,
        //           height: MediaQuery.of(context).size.width * 0.253,
        //         ),
        //       )
        //     : ClipOval(
        //         child: Image.asset(
        //         "assets/Pictures/penguin.png",
        //         fit: BoxFit.cover,
        //         width: MediaQuery.of(context).size.width * 0.253,
        //         height: MediaQuery.of(context).size.width * 0.253,
        //       )),
        radius: MediaQuery.of(context).size.width * 0.139,
        backgroundColor: colorBlueTeal,
        child: ClipOval(
          child: Image.asset(
            "assets/Pictures/student.jpg",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 0.268,
            height: MediaQuery.of(context).size.width * 0.268,
          ),
        ),
      );

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image(
          image: const AssetImage('assets/Pictures/badges.jpg'),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.22,
          fit: BoxFit.cover,
        ),
      );

  Widget buildBody() {
    final screenHeightSize = MediaQuery.of(context).size.height;
    final screenWidthSize = MediaQuery.of(context).size.width;

    final titles = [
      "Registered",
      "Groups",
      "Badges",
      "Calendar",
    ];
    // final numberStats = [
    //   "4",
    //   "4",
    //   "2",
    //   "more info",
    // ];
    return Column(children: <Widget>[
      Container(
        // height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(screenWidthSize * 0.1),
            bottomRight: Radius.circular(screenWidthSize * 0.1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: screenWidthSize * 0.05),
              child: Text(
                'My Badges',
                style: TextStyle(
                    fontSize: screenWidthSize * 0.06,
                    fontWeight: FontWeight.bold,
                    color: colorOrange),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: screenWidthSize * 0.05),
              child: Text(
                'See all',
                style: TextStyle(
                    fontSize: screenWidthSize * 0.05,
                    fontWeight: FontWeight.bold,
                    color: colorBlueTeal),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
        child: SizedBox(
          height: screenHeightSize * 1,
          width: screenWidthSize * 1,
          child: GridView.count(
            childAspectRatio: 1,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            children: List<Widget>.generate(1, (index) {
              return GridTile(
                child: GestureDetector(
                  onTap: () {
                    if (index == 0) {
                      //render Tutees Page
                    } else if (index == 1) {
                      //render Groups Page
                    } else if (index == 2) {
                      //render Badges Page
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => const Badges()));
                    } else if (index == 3) {
                      //render Calendar Page
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.015),
                    child: Card(
                        margin: EdgeInsets.symmetric(
                            vertical: screenHeightSize * 0,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.02),
                        color: colorWhite,
                        child: Center(
                          child: Container(
                            width: screenWidthSize * 0.4,
                            height: screenHeightSize * 0.3,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(50, 193, 193, 193),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: screenHeightSize * 0.1,
                                  width: screenWidthSize * 0.4,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/Pictures/reg.png",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: screenWidthSize * 0.02),
                                  child: Text(
                                    titles[index],
                                    style: TextStyle(
                                        fontSize: screenWidthSize * 0.05,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    ]);
  }
}
