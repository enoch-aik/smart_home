import 'package:auto_route/annotations.dart';
import 'package:doctor_booking_flutter/lib.dart';

///TODO: Create pagination example for Eniola
@RoutePage(name: 'signup')
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  List<int> results = [];
  int lastIndex = 0;
  bool hasMore = false;
  bool isLoading = true;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    apiCall();
  }

  void apiCall() async {
    List<int> queryResult = await getNumbers(
      lastIndex: lastIndex,
    );
    if (queryResult.isNotEmpty) {
      results.addAll(queryResult);
      lastIndex += 10;

      if (mounted) {
        setState(() {
          hasMore = lastIndex < 100 ? true : false;
          isLoading = hasMore == true ? true : false;

        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        onNotification: (ScrollNotification notification) {
          //if user has gotten to the bottom of the screen
          if (notification is ScrollEndNotification &&
              scrollController.offset >=
                  (scrollController.position.maxScrollExtent)) {
            apiCall();
          }
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(

                itemCount: results.length,
                controller: scrollController,shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                  height: 100,
                  width: double.infinity,
                  color: index % 2 == 0 ? Colors.yellow : Colors.purpleAccent,
                  alignment: Alignment.center,
                  child: Text('Item No.${index+1}'),
                );
                },
              ),
           if(hasMore)   SizedBox(height: 100,child: Center(child: CircularProgressIndicator()),)
            ],
          ),
        ),
      ),
    );
  }
}

Future<List<int>> getNumbers({required int lastIndex, int limit = 10}) async {
  return await Future<List<int>>.delayed(const Duration(seconds: 3), () {
    return queryInt(lastIndex: lastIndex, limit: limit);
  });
}

//act as API
List<int> queryInt({required int lastIndex, required limit}) {
  return numberDb.sublist(lastIndex, (lastIndex + limit) as int);
}

//act as database
List<int> numberDb = List.generate(150, (index) => index + 1);


class PagReqModel {
  //current batch
  final int page;
  //limit
  final int perPage;
  //total number of users
  final int total;

  final int totalResult;

  //total number of pages
  final int? totalPages;

  PagReqModel({
    required this.page,
    required this.perPage,
    required this.total,required this.totalResult,
    required this.totalPages,
  });
}


class UserData {
  final int id;

  UserData({required this.id});
}



