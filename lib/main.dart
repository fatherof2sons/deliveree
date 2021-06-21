import 'package:delivaree/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: Colors.black54,
        primaryColor: Colors.deepOrange[900],
      ),
      home: Home(),
    );
  }
}







/*
Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 120.0),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 58.0, bottom: 24.0, top: 20.0),
                  child: HomeMainText(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    onTap: () {
                      showSearch(context: context, delegate: ShopSearch());
                    },
                    cursorColor: Colors.white,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.2,
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0XFF077598),
                        hintText: 'Enter shop name',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.2,
                          color: Colors.white70,
                          fontSize: 20.0,
                        ),
                        helperText: 'Just write the name of any shop',
                        helperStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Color(0XFF005376),
                          fontSize: 17.0,
                        ),
                        prefix: SizedBox(width: 12.0),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.search,
                            size: 30.0,
                            color: Colors.white70,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)))),
                  ),
                ),
              ],
            ),
 */
