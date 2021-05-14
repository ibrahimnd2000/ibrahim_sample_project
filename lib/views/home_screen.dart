import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrahim_sample_project/model/user.dart' as UserModel;
import 'package:ibrahim_sample_project/services/auth_service.dart';
import 'package:ibrahim_sample_project/services/db_service.dart';
import 'package:ibrahim_sample_project/views/widgets/sample_app_button.dart';
import 'package:ibrahim_sample_project/views/widgets/sample_app_list_item.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F4FB),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "User",
                style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              StreamBuilder(
                stream: context.read<DBService>().getUsers(),
                builder:
                    (context, AsyncSnapshot<List<UserModel.User>> snapshot) {
                  if (!snapshot.hasData) return Container();

                  return SizedBox(
                    height: .75.sh,
                    child: ListView.separated(
                        separatorBuilder: (context, index) => Container(
                              height: 1,
                              color: Colors.grey.shade300,
                            ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          UserModel.User user = snapshot.data[index];

                          return SampleAppListItem(
                            name: user.name,
                          );
                        }),
                  );
                },
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SampleAppButton(
                    text: 'Sign Out',
                    action: () async {
                      await context.read<AuthService>().signOut();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
