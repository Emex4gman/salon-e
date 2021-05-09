import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salon_e/componets/solan_stateful_widget.dart';
import 'package:salon_e/providers/auth_state.dart';
import 'package:salon_e/sevices/aws_service.dart';
import 'package:salon_e/sevices/navigation_service.dart';
import 'package:salon_e/ui/web_view/sample_profile.dart';
import 'package:salon_e/util/style/typography.dart';

class ProfileScreen extends SalonSatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends SalonSatefulWidgetState<ProfileScreen> {
  final _awsService = AwsService();
  final _authState = AuthState();
  String? _imageUrl;
  void _changeProfilePicture() async {
    isLoading = true;
    setState(() {});
    await _awsService.uploadImage(ImageSource.gallery, user!.userId);
    _getImage();
  }

  _getImage() async {
    isLoading = true;
    setState(() {});
    _imageUrl = await _awsService.getFileUrl(user!.userId);
    isLoading = false;
    setState(() {});
  }

  _logOut() async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout?', style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold)),
        content: SalonText.button(
          'Are you sure you want to Logout from Salon E ? Tap \'Yes\' to exit \'No\' to cancel.',
        ),
        actions: <Widget>[
          ElevatedButton(onPressed: () => Navigator.pop(context, false), child: Text("NO")),
          ElevatedButton(
              onPressed: () async {
                final res = await _awsService.logout();
                if (res.success) {
                  await _authState.setUser();
                  NavigationService.popToHome();
                  NavigationService.navigateTo('/');
                }
              },
              child: Text("YES")),
        ],
      ),
    );
  }

  Future<bool> _closeApp() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Exit?', style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold)),
            content: SalonText.button(
              'Are you sure you want to exit Salon E ? Tap \'Yes\' to exit \'No\' to cancel.',
            ),
            actions: <Widget>[
              ElevatedButton(onPressed: () => Navigator.pop(context, false), child: Text("NO")),
              ElevatedButton(
                  onPressed: () async {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: Text("YES")),
            ],
          ),
        ) ??
        false;
  }

  @override
  void initState() {
    super.initState();
    _getImage();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _closeApp,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Colors.redAccent[700],
          title: Text("Profile"),
          backwardsCompatibility: false,
          leading: null,
          actions: [
            InkWell(
              onTap: _logOut,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Icon(Icons.logout),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15),
                InkWell(
                  onTap: _changeProfilePicture,
                  child: CircleAvatar(
                    maxRadius: 100,
                    backgroundImage: _imageUrl == null ? null : NetworkImage(_imageUrl!),
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ))
                        : null,
                  ),
                ),
                Text("${user!.username ?? ""}"),
                ElevatedButton(
                  onPressed: () => NavigationService.navigateToWidget(SampleProfie()),
                  child: Text(
                    "Sample Profile Web View",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
