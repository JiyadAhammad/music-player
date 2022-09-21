import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music/controller/getx/music_controller.dart';
import 'package:music/view/splashscreen/splashscreen.dart';
import 'package:music/view/widget/ratemyapp.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class Navdrawer extends StatelessWidget {
  const Navdrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundColordrawer(),
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Text(
                  'ΜΟΥΣΙΚΗ',
                  style: TextStyle(color: Colors.white, fontSize: 50.sp),
                ),
              ),
            ),
            ListTile(
              onTap: (() {
                Share.share(
                  'https://play.google.com/store/apps/details?id=in.brototype.music',
                );
              }),
              leading: const Icon(
                Icons.share,
                color: Colors.white,
              ),
              title: const Text(
                'Share',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
            GetBuilder<MusicController>(
              init: MusicController(),
              builder: (switchController) {
                return ListTile(
                  leading: const Icon(
                    Icons.notification_add,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Notification',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Switch(
                    value: switchController.isSwitched,
                    onChanged: (value) {
                      switchController.isSwitchedToggle(value);
                      audioPlayer.showNotification = value;
                      // setState(
                      //   () {
                      //     isSwitched = value;
                      //     audioPlayer.showNotification = value;
                      //   },
                      // );
                    },
                    activeTrackColor: Colors.white,
                    activeColor: const Color(0xFF911BEE),
                  ),
                );
              },
            ),
            ListTile(
              onTap: (() {
                // rateMyApp(context);
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return const RatemyApp();
                  },
                );
              }),
              leading: const Icon(
                Icons.star_border_rounded,
                color: Colors.white,
              ),
              title: const Text(
                'Rate us',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      backgroundColor: Colors.black,
                      title: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.sp,
                        ),
                      ),
                      content: const SingleChildScrollView(
                        child: Text(
                          '''       Jiyad Ahammad built the ΜΟΥΣΙΚΗ app as a Free app. This SERVICE is provided by Jiyad Ahammad at no cost and is intended for use as is.

                This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.

                If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.

                The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at ΜΟΥΣΙΚΗ unless otherwise defined in this Privacy Policy.

                Information Collection and Use

                For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to Flutter Developer. The information that I request will be retained on your device and is not collected by me in any way.

                The app does use third-party services that may collect information used to identify you.

                Link to the privacy policy of third-party service providers used by the app

                Google Play Services
                Log Data

                I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.

                Cookies

                Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.

                This Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.

                Service Providers

                I may employ third-party companies and individuals due to the following reasons:

                To facilitate our Service;
                To provide the Service on our behalf;
                To perform Service-related services; or
                To assist us in analyzing how our Service is used.
                I want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.

                Security

                I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.

                Links to Other Sites

                This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.

                Children’s Privacy

                These Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13 years of age. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do the necessary actions.

                Changes to This Privacy Policy

                I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.

                This policy is effective as of 2022-08-18

                Contact Us

                If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at jiyadahammad99@gmail.com.

                                ''',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () => Get.back(),
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              leading: const Icon(
                Icons.lock,
                color: Colors.white,
              ),
              title: const Text(
                'Privacy policy',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
            ListTile(
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationIcon: const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    backgroundImage:
                        // Image.file("music/assets/img/luncher icon.png")
                        AssetImage('assets/img/lunchericon.png'),
                  ),
                  applicationName: "ΜΟΥΣΙΚΗ",
                  applicationVersion: "1.0.0+1",
                  children: [
                    Text(
                      'ΜΟΥΣΙΚΗ is an Offline Music Player created by JIYAD AHAMMAD',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ],
                );
              },
              leading: const Icon(
                Icons.info,
                color: Colors.white,
              ),
              title: const Text(
                'About',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              title: const Text(
                'Exit',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18.sp,
              ),
              onTap: () => exitApp(context),
            ),
            SizedBox(
              height: 140.h,
            ),
            const ListTile(
              title: Text(
                ' version',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                '1.0.0+1',
                style: TextStyle(
                  color: Color.fromARGB(255, 159, 209, 203),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void exitApp(context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Do you want to exit'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
