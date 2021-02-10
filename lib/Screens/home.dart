import 'package:NewsApp/Models/article_model.dart';
import 'package:NewsApp/helper/news.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  List<String> newsCategoryList=["Business","Entertainment","General","Health","Science","Crypto"];

  List<ArticleModel> articles= new List<ArticleModel>();

  bool loading=true;

  Map<String,String> categoryMap= {
    "Business": "assets/business.jpg",
    "Entertainment": "assets/entertainment.jpg",
    "General": "assets/general.jpg",
    "Health": "assets/healthcare.jpg",
    "Science": "assets/science.png",
    "Crypto": "assets/crypto.jpg",
  };


  getNews() async{

    News newsClass = News();
    await newsClass.getNews();
    articles= newsClass.newsList;
    setState(() {
      loading=false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Column(

          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top
            ),

            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Flutter",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold,fontSize: 25)),
                    TextSpan(text: "News",style: TextStyle(color: Colors.blue,fontWeight:FontWeight.bold,fontSize: 25))
                  ]
                ),
              )
            ),

            _newsCategories(),
            loading?Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            ):Container(
              height: Get.height*.7659,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: articles.length,
                itemBuilder: (context,index){
                  return BlogTile(
                    imageUrl: articles[index].urlToImage,
                    title: articles[index].title,
                    desc: articles[index].description,
                  );
                },
                
              ),
            )

          ],
        ), 
    );
  }

  // Widget _containerCard(){
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Container(
  //       height: 400,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10),
  //         boxShadow: [
  //           BoxShadow(
  //             blurRadius: 5,
  //             spreadRadius: 1,
  //             color: Colors.grey,
  //             offset: Offset(
  //             0.7,0.7)
  //           )
  //         ],
  //         color: Colors.white
  //       ),
  //       width: Get.width*.8,
        
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //               ClipRRect(
  //             borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
  //             child: Image.network(
          
  //             "https://www.mercurynews.com/wp-content/uploads/2018/09/BNG-L-WARRIORS-0925-131.jpg",
  //         fit: BoxFit.cover,
          
  //         // height: 200,
  //         // width: Get.width*.8,
        
  //           ),
  //         ),
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Text("Nokia 8.2, Nokia 8.5, Nokia 1.3 Expected to Launch Today: How to Watch Live",
  //                 style: TextStyle(color: Colors.black87,fontSize: 18)
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Text("The event was slated to be held in london, but HMD Global cancelled it and converted into an online only",
  //                 style: TextStyle(color: Colors.grey,fontSize: 14)
  //                 ),
  //               ),  
  //           ],
  //         ),
  //       ),
      
  //   );
  // }



  Widget _newsCategories(){
    return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()
          ),
          child: Row(
        
           children: [

          for(var k in categoryMap.keys)

               GestureDetector(
                  onTap: (){
                    print("Tapped Category tile");
                  },
                  child: Padding(
                   padding: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black,
                      ),
                    height: 80,
                    width:150,
                    
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                            categoryMap[k],
                            fit: BoxFit.fill,
                            height: 80,
                            width: 150,
                          ),
                        ),
                        Center(child: Text(k,style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),
                        ))
                    ])),
                 ),
               ),
        ],
      ),
    );
  }

}

class BlogTile extends StatelessWidget {
  final String imageUrl,title,desc;
  BlogTile({@required this.imageUrl,@required this.title,@required this.desc});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 1,
              color: Colors.grey,
              offset: Offset(
              0.7,0.7)
            )
          ],
          color: Colors.white
        ),
        width: Get.width*.8,
        
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
              child: Image.network(
          
              imageUrl,
          fit: BoxFit.cover,
          
          // height: 200,
          // width: Get.width*.8,
        
            ),
          ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title,
                  style: TextStyle(color: Colors.black87,fontSize: 18)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(desc,
                  style: TextStyle(color: Colors.grey,fontSize: 14)
                  ),
                ),  
            ],
          ),
        ),
      
    );
  }
}