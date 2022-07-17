import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Navdrawer extends StatefulWidget {
  const Navdrawer({Key? key}) : super(key: key);

  @override
  State<Navdrawer> createState() => _NavdrawerState();
}

class _NavdrawerState extends State<Navdrawer> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Color(0xFF911BEE),
            Color(0xFF4D0089),
          ],
        ),
      ),
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Text(
                  'Music',
                  style: TextStyle(color: Colors.white, fontSize: 50),
                ),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.share,
                color: Colors.white,
              ),
              title: Text(
                'Share',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.notification_add,
                color: Colors.white,
              ),
              title: const Text(
                'Notification',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(
                    () {
                      isSwitched = value;
                    },
                  );
                },
                activeTrackColor: Colors.white,
                activeColor: const Color(0xFF911BEE),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.star_border_rounded,
                color: Colors.white,
              ),
              title: Text(
                'Rate us',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18,
              ),
            ),
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AlertDialog(
                            title: const Text(
                              'Privacy policy',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: const Text(
                              '''
                               Jiyad Ahammad built the MusicPlayer app as a Free app. This SERVICE is provided by Jiyad Ahammad at no cost and is intended for use as is.
                               This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.
                               If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.
                               The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at MusicPlayer unless otherwise defined in this Privacy Policy.
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
                               By downloading or using the app, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app. You’re not allowed to copy or modify the app, any part of the app, or our trademarks in any way. You’re not allowed to attempt to extract the source code of the app, and you also shouldn’t try to translate the app into other languages or make derivative versions. The app itself, and all the trademarks, copyright, database rights, and other intellectual property rights related to it, still belong to Jiyad Ahammad A O.
                               Jiyad Ahammadis committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you’re paying for.
                               The MusicPlayer app stores and processes personal data that you have provided to us, to provide my Service. It’s your responsibility to keep your phone and access to the app secure. We therefore recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and limitations imposed by the official operating system of your device. It could make your phone vulnerable to malware/viruses/malicious programs, compromise your phone’s security features and it could mean that the MusicPlayer app won’t work properly or at all.
                               The app does use third-party services that declare their Terms and Conditions.
                               Link to Terms and Conditions of third-party service providers used by the app
                               Google Play Services
                               You should be aware that there are certain things that Jiyad Ahammad A O will not take responsibility for. Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi or provided by your mobile network provider, but Jiyad Ahammad A O cannot take responsibility for the app not working at full functionality if you don’t have access to Wi-Fi, and you don’t have any of your data allowance left.
                               If you’re using the app outside of an area with Wi-Fi, you should remember that the terms of the agreement with your mobile network provider will still apply. As a result, you may be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third-party charges. In using the app, you’re accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you’re using the app, please be aware that we assume that you have received permission from the bill payer for using the app.
                               Along the same lines, Jiyad Ahammad A O cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged – if it runs out of battery and you can’t turn it on to avail the Service, Jiyad Ahammad A O cannot accept responsibility.
                               With respect to Jiyad Ahammad A O’s responsibility for your use of the app, when you’re using the app, it’s important to bear in mind that although we endeavor to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. Jiyad Ahammad A O accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app.
                               At some point, we may wish to update the app. The app is currently available on Android – the requirements for the system(and for any additional systems we decide to extend the availability of the app to) may change, and you’ll need to download the updates if you want to keep using the app. Jiyad Ahammad A O does not promise that it will always update the app so that it is relevant to you and/or works with the Android version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, We may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device.
                               Changes to This Terms and Conditions
                               I may update our Terms and Conditions from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Terms and Conditions on this page.
                               These terms and conditions are effective as of 2022-06-29
                               Contact Us
                               If you have any questions or suggestions about my Terms and Conditions, do not hesitate to contact me at abinjohn8089@gmail.com.
                               I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.
                               This policy is effective as of 2022-06-29
                               Contact Us
                               If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at abinjohn8089@gmail.com.''',
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('I Accept'),
                              )
                            ],
                          ),
                        ],
                      ),
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
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18,
              ),
            ),
            ListTile(
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationIcon: const Icon(Icons.music_note),
                  applicationName: "jmusic",
                  applicationVersion: "2.4.2",
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
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18,
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
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18,
              ),
              onTap: () => exitApp(),
            ),
            const SizedBox(
              height: 140,
            ),
            const ListTile(
              title: Text(
                ' version',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                '2.4.2',
                style: TextStyle(color: Color.fromARGB(255, 159, 209, 203)),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void exitApp() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Do you want to exit'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
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
