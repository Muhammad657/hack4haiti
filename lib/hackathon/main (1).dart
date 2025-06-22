import 'dart:io';
import 'package:ecoeats/hackathon/bloc/language_bloc.dart';
import 'package:ecoeats/hackathon/home_offline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

String selectedNeed = '';
String selectedLocation = '';
String result1 = '', result2 = '', result3 = '', result4 = '', result5 = '';
String address1 = '',
    address2 = '',
    address3 = '',
    address4 = '',
    address5 = '';
String description1 = '',
    description2 = '',
    description3 = '',
    description4 = '',
    description5 = '';
String nearbyLandmark1 = '',
    nearbyLandmark2 = '',
    nearbyLandmark3 = '',
    nearbyLandmark4 = '',
    nearbyLandmark5 = '';

void main() {
  runApp(MaterialApp(home: Question1()));
}

class WelcomeOffline extends StatelessWidget {
  String selectedLang = "English";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        if (state is SelectedLanguageState) {
          selectedLang = state.selectedLang;
        }
        String surveyText =
            selectedLang == "English"
                ? "SUR\nVEY."
                : selectedLang == "Creole"
                ? "SON\nDAJ."
                : selectedLang == "French"
                ? "SON\nDAGE."
                : "SUR\nVEY.";

        String helpText =
            selectedLang == "English"
                ? "Need help finding guidance for your problems?"
                : selectedLang == "Creole"
                ? "Bezwen èd pou jwenn gid pou pwoblèm ou yo?"
                : selectedLang == "Spanish"
                ? "¿Necesitas ayuda para encontrar orientación para tus problemas?"
                : "Need help finding guidance for your problems?";

        String takeButtonText =
            selectedLang == "English"
                ? "Take"
                : selectedLang == "Creole"
                ? "Pran"
                : selectedLang == "Spanish"
                ? "Tomar"
                : "Take";
        return Scaffold(
          backgroundColor: Colors.lightBlue.shade100,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 8),
                  child: Text(
                    surveyText,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w800,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Text(
                          helpText,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 35.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 20,
                          right: 70,
                          left: 70,
                        ),
                        child: Stack(
                          children: [
                            Container(
                              height: 100.h,
                              width: double.infinity.w,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(70.r),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Question1(),
                                    ),
                                  );
                                },
                                icon: Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(70.r),
                                    color: Colors.lightBlue.shade300,
                                  ),
                                  width: 130,
                                  height: 60,
                                  child: Center(
                                    child: Text(
                                      takeButtonText,
                                      style: GoogleFonts.lexend(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 15,
                              left: 30,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeOfflineHack(),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                icon: Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                      size: 20.r,
                                    ),
                                    Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.grey,
                                      size: 20.r,
                                    ),
                                    Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.grey.shade700,
                                      size: 20.r,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Q1

class Question1 extends StatefulWidget {
  const Question1({super.key});

  @override
  State<Question1> createState() => _Question1State();
}

class _Question1State extends State<Question1> {
  String selectedLang = "English";
  String selectedThing = "";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        if (state is SelectedLanguageState) {
          selectedLang = state.selectedLang;
        }
        String foodWaterText =
            selectedLang == "English"
                ? "Food / Water"
                : selectedLang == "Creole"
                ? "Manje / Dlo"
                : selectedLang == "French"
                ? "Nourriture / Eau"
                : "Food / Water";

        String shelterText =
            selectedLang == "English"
                ? "Shelter"
                : selectedLang == "Creole"
                ? "Abri"
                : selectedLang == "French"
                ? "Abri"
                : "Shelter";

        String medicalHelpText =
            selectedLang == "English"
                ? "Medical Help"
                : selectedLang == "Creole"
                ? "Èd Medikal"
                : selectedLang == "French"
                ? "Aide Médicale"
                : "Medical Help";

        String continueText =
            selectedLang == "English"
                ? "Continue"
                : selectedLang == "Creole"
                ? "Kontinye"
                : selectedLang == "French"
                ? "Continuer"
                : "Continue";
        String whatDoYouNeedText =
            selectedLang == "English"
                ? "WHAT DO\nYOU NEED?"
                : selectedLang == "Creole"
                ? "KISA\nOU BEZWEN?"
                : selectedLang == "French"
                ? "DE QUOI\nAVEZ-VOUS BESOIN ?"
                : "WHAT DO\nYOU NEED?";

        return Scaffold(
          backgroundColor: Colors.lightBlue.shade100,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    whatDoYouNeedText,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w800,
                      fontSize: 26.sp,
                    ),
                  ),

                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedThing = foodWaterText;
                                selectedNeed = "Food / Water";
                              });
                            },
                            child: bigButton(context, foodWaterText),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedThing = shelterText;
                                selectedNeed = "Shelter";
                              });
                            },
                            child: bigButton(context, shelterText),
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedThing = medicalHelpText;
                                selectedNeed = "Medical Help";
                              });
                            },
                            child: bigButton(context, medicalHelpText),
                          ),
                          SizedBox(height: 40.h),
                          GestureDetector(
                            onTap: () {
                              if (selectedThing == "") {
                                return;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Question2(),
                                ),
                              );
                              // Add navigation or logic here
                            },
                            child: Container(
                              width: 180,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.lightBlue.shade400,
                                    Colors.blue.shade700,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 8,
                                    offset: Offset(2, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  continueText,
                                  style: GoogleFonts.lexend(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bigButton(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Container(
        width: 300.w,
        height: 70.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedThing == text ? Colors.green.shade700 : Colors.white,
          ),
          borderRadius: BorderRadius.circular(40.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.lexend(
              fontSize: 20.sp,
              color: Colors.black87,
              fontWeight:
                  selectedThing == text ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

Widget bigButton2(BuildContext context, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Container(
      width: 300,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Colors.lightBlue.shade400, Colors.blue.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 4)),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.lexend(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

class Question2 extends StatefulWidget {
  @override
  State<Question2> createState() => _Question2State();
}

class _Question2State extends State<Question2> {
  String selectedLang = "";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        if (state is SelectedLanguageState) {
          selectedLang = state.selectedLang;
        }
        String whichPlaceText =
            selectedLang == "English"
                ? "Which place are you \nclosest to?"
                : selectedLang == "Creole"
                ? "Ki kote ki \npi pre ou?"
                : selectedLang == "French"
                ? "Quel endroit est le \nplus proche de vous ?"
                : "Which place are you \nclosest to?";

        String youChoseText =
            selectedLang == "English"
                ? "You chose $selectedNeed"
                : selectedLang == "Creole"
                ? "Ou chwazi $selectedNeed"
                : selectedLang == "French"
                ? "Vous avez choisi $selectedNeed"
                : "You chose $selectedNeed";
        return Scaffold(
          backgroundColor: Colors.lightBlue.shade50,
          appBar: AppBar(
            backgroundColor: Colors.lightBlue.shade300,
            title: Text(
              whichPlaceText,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            toolbarHeight: 100,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  youChoseText,
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 30),
                locationButton('Port-au-Prince'),
                locationButton('Cap-Haïtien'),
                locationButton('Les Cayes'),
                locationButton('Gonaïves'),
                locationButton('Jacmel'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget locationButton(String locationName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLocation = locationName;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Question3()),
        );
      },
      child: bigButton2(context, locationName),
    );
  }
}

class Question3 extends StatefulWidget {
  @override
  _Question3State createState() => _Question3State();
}

class _Question3State extends State<Question3> {
  bool nearbyOnly = false;
  bool need247 = false;
  String selectedLang = "English";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        if (state is SelectedLanguageState) {
          selectedLang = state.selectedLang;
          selecglOBAL = state.selectedLang;
        }
        String appBarTitle =
            selectedLang == "English"
                ? "Any Limitations?"
                : selectedLang == "Creole"
                ? "Nenpòt Limitasyon?"
                : selectedLang == "French"
                ? "Des limitations ?"
                : "Any Limitations?";

        String headerText =
            selectedLang == "English"
                ? "Click if any of these apply to you:"
                : selectedLang == "Creole"
                ? "Klike si nenpòt nan sa yo aplike pou ou:"
                : selectedLang == "French"
                ? "Cliquez si l’une de ces options vous concerne :"
                : "Click if any of these apply to you:";

        String toggleNearbyText =
            selectedLang == "English"
                ? "In the area only\n(Less than 5 miles)"
                : selectedLang == "Creole"
                ? "Nan zòn nan sèlman\n(Mwens pase 5 mil)"
                : selectedLang == "French"
                ? "Seulement dans la zone\n(Moins de 5 miles)"
                : "In the area only\n(Less than 5 miles)";

        String toggle247Text =
            selectedLang == "English"
                ? "Need 24/7 service\n(Day and night support)"
                : selectedLang == "Creole"
                ? "Bezwen sèvis 24/7\n(Sèvis jou ak nuit)"
                : selectedLang == "French"
                ? "Besoin d’un service 24/7\n(Soutien jour et nuit)"
                : "Need 24/7 service\n(Day and night support)";

        String snackBarMessage =
            selectedLang == "English"
                ? "Please select at least one option"
                : selectedLang == "Creole"
                ? "Tanpri chwazi omwen yon opsyon"
                : selectedLang == "French"
                ? "Veuillez sélectionner au moins une option"
                : "Please select at least one option";

        String finishText =
            selectedLang == "English"
                ? "Finish"
                : selectedLang == "Creole"
                ? "Fini"
                : selectedLang == "French"
                ? "Terminer"
                : "Finish";
        return Scaffold(
          backgroundColor: Colors.lightBlue.shade50,
          appBar: AppBar(
            backgroundColor: Colors.lightBlue.shade300,
            title: Text(
              appBarTitle,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  headerText,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 30),
                bigToggleButton(
                  context,
                  toggleNearbyText,
                  Icons.location_on,
                  nearbyOnly,
                  () {
                    setState(() {
                      nearbyOnly = !nearbyOnly;
                    });
                  },
                ),
                bigToggleButton(
                  context,
                  toggle247Text,
                  Icons.access_time,
                  need247,
                  () {
                    setState(() {
                      need247 = !need247;
                    });
                  },
                ),
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    if (!nearbyOnly && !need247) {
                      String snackBarMessage =
                          selectedLang == "English"
                              ? 'Please select at least one option'
                              : selectedLang == "Creole"
                              ? 'Tanpri chwazi omwen yon opsyon'
                              : selectedLang == "French"
                              ? 'Veuillez sélectionner au moins une option'
                              : 'Please select at least one option';

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text(snackBarMessage),
                        ),
                      );
                      return;
                    }
                    findResults(selectedNeed, selectedLocation);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FinishScreen()),
                    );
                  },
                  child: Container(
                    width: 300,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [
                          Colors.lightBlue.shade400,
                          Colors.blue.shade700,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        finishText,
                        style: GoogleFonts.lexend(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget bigToggleButton(
  BuildContext context,
  String text,
  IconData icon,
  bool selected,
  VoidCallback onPressed,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 300,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: selected ? Colors.green.shade600 : Colors.white,
          border: Border.all(
            color: selected ? Colors.green.shade800 : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(width: 20),
            Icon(icon, color: selected ? Colors.white : Colors.black87),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.left,
                style: GoogleFonts.lexend(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: selected ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

String selecglOBAL = "";
void findResults(String need, String location) {
  if (need == "Food / Water") {
    if (location == "Port-au-Prince") {
      if (selecglOBAL == "English") {
        result1 = "World Food Programme (WFP)";
        address1 =
            "Address: 15 Rue Pipo, Juvénat 7, Pétion-Ville, Port-au-Prince, Haiti";
        description1 = "Description: WFP provides food aid.";
        nearbyLandmark1 = "Nearby Landmark: Pétion-Ville Club";

        result2 = "Outside the Bowl Super Kitchen";
        address2 = "Address: Delmas 75 corridor, Delmas, Port-au-Prince, Haiti";
        description2 = "Description: Cooks meals for schools and shelters.";
        nearbyLandmark2 = "Nearby Landmark: UN Logistics Base";

        result3 = "Food For The Poor Haiti";
        address3 = "Address: Route Nationale #1, Port-au-Prince, Haiti";
        description3 = "Description: Distributes food boxes to families.";
        nearbyLandmark3 = "Nearby Landmark: Carrefour Shada";

        result4 = "Haiti Christian Mission Food Bank";
        address4 = "Address: Tabarre 14, Port-au-Prince";
        description4 = "Description: Serves community food programs.";
        nearbyLandmark4 = "Nearby Landmark: Tabarre Market";

        result5 = "Hope for Haiti Kitchen";
        address5 = "Address: Rue Clercine 10, Port-au-Prince";
        description5 = "Description: Daily meals for low-income families.";
        nearbyLandmark5 = "Nearby Landmark: Clercine Clinic";
      } else if (selecglOBAL == "French") {
        if (need == "Food / Water") {
          if (location == "Port-au-Prince") {
            result1 = "Programme Alimentaire Mondial (PAM)";
            address1 =
                "Adresse : 15 Rue Pipo, Juvénat 7, Pétion-Ville, Port-au-Prince, Haïti";
            description1 = "Description : Le PAM fournit une aide alimentaire.";
            nearbyLandmark1 = "Point de repère : Club de Pétion-Ville";

            result2 = "Cuisine Communautaire Outside the Bowl";
            address2 =
                "Adresse : Corridor Delmas 75, Delmas, Port-au-Prince, Haïti";
            description2 =
                "Description : Prépare des repas pour les écoles et les abris.";
            nearbyLandmark2 = "Point de repère : Base logistique de l'ONU";

            result3 = "Food For The Poor Haïti";
            address3 = "Adresse : Route Nationale #1, Port-au-Prince, Haïti";
            description3 =
                "Description : Distribue des colis alimentaires aux familles.";
            nearbyLandmark3 = "Point de repère : Carrefour Shada";

            result4 = "Banque Alimentaire de la Mission Chrétienne Haïtienne";
            address4 = "Adresse : Tabarre 14, Port-au-Prince";
            description4 =
                "Description : Propose des programmes alimentaires communautaires.";
            nearbyLandmark4 = "Point de repère : Marché de Tabarre";

            result5 = "Cuisine d'Espoir pour Haïti";
            address5 = "Adresse : Rue Clercine 10, Port-au-Prince";
            description5 =
                "Description : Repas quotidiens pour les familles à faible revenu.";
            nearbyLandmark5 = "Point de repère : Clinique Clercine";
          }
        }
      } else if (selecglOBAL == "Creole") {
        if (need == "Food / Water") {
          if (location == "Port-au-Prince") {
            result1 = "Pwogram Alimantè Mondyal (PAM)";
            address1 =
                "Adrès : 15 Ri Pipo, Juvénat 7, Petyonvil, Pòtoprens, Ayiti";
            description1 = "Deskripsyon : PAM bay èd manje.";
            nearbyLandmark1 = "Pwen referans : Club Petyonvil";

            result2 = "Kizin Kominotè Outside the Bowl";
            address2 = "Adrès : Koridò Delmas 75, Delmas, Pòtoprens, Ayiti";
            description2 = "Deskripsyon : Kwit manje pou lekòl ak abri.";
            nearbyLandmark2 = "Pwen referans : Baz lojistik Nasyonzini";

            result3 = "Manje Pou Pòv Ayiti";
            address3 = "Adrès : Wout Nasyonal #1, Pòtoprens, Ayiti";
            description3 = "Deskripsyon : Bay fanmi bwat manje.";
            nearbyLandmark3 = "Pwen referans : Kafou Shada";

            result4 = "Bank Manje Misyon Kretyen Ayiti";
            address4 = "Adrès : Tabar 14, Pòtoprens";
            description4 =
                "Deskripsyon : Òganize pwogram manje pou kominote a.";
            nearbyLandmark4 = "Pwen referans : Makèt Tabar";

            result5 = "Kizin Lespwa pou Ayiti";
            address5 = "Adrès : Ri Klèsin 10, Pòtoprens";
            description5 =
                "Deskripsyon : Bay manje chak jou pou fanmi ki nan bezwen.";
            nearbyLandmark5 = "Pwen referans : Klinik Klèsin";
          }
        }
      }
    } else if (location == "Cap-Haïtien") {
      result1 = "Monastère Bon Berger";
      address1 = "Address: Rue de l’Asile, Cap-Haïtien, Haiti";
      description1 =
          "Description: Provides daily meals to impoverished families.";
      nearbyLandmark1 = "Nearby Landmark: Cap-Haïtien Cathedral";

      result2 = "Multiply Haiti";
      address2 = "Address: Near Rue 19, Cap-Haïtien";
      description2 = "Description: Community feeding program for children.";
      nearbyLandmark2 = "Nearby Landmark: Place d’Armes";

      result3 = "Centre Espoir Cap";
      address3 = "Address: Rue 12, Cap-Haïtien";
      description3 = "Description: Food package distributions weekly.";
      nearbyLandmark3 = "Nearby Landmark: Université Roi Henri Christophe";

      result4 = "Communal Kitchen Cap-Haïtien";
      address4 = "Address: Rue 10, Cap-Haïtien";
      description4 = "Description: Hot meals served daily to locals.";
      nearbyLandmark4 = "Nearby Landmark: Basilique Notre-Dame";

      result5 = "Hope Feeders Haiti";
      address5 = "Address: Rue des Miracles, Cap-Haïtien";
      description5 = "Description: Volunteers distributing prepared meals.";
      nearbyLandmark5 = "Nearby Landmark: Rue 17 Market";
    } else if (location == "Les Cayes") {
      result1 = "IOM Home Garden Project";
      address1 = "Address: Various garden sites, Les Cayes";
      description1 = "Description: Helps families grow their own food.";
      nearbyLandmark1 = "Nearby Landmark: Cathedral of Les Cayes";

      result2 = "Red Cross Food Relief";
      address2 = "Address: Rue Antoine Simon, Les Cayes";
      description2 = "Description: Gives food during emergencies.";
      nearbyLandmark2 = "Nearby Landmark: Place d’Italie";

      result3 = "Caritas Les Cayes";
      address3 = "Address: Avenue des Quatre Chemins, Les Cayes";
      description3 = "Description: Runs feeding programs.";
      nearbyLandmark3 = "Nearby Landmark: Lycée Guerrier des Cayes";

      result4 = "Mercy Corps Nutrition Program";
      address4 = "Address: Rue Alexandre Pétion, Les Cayes";
      description4 = "Description: Nutritional support to children.";
      nearbyLandmark4 = "Nearby Landmark: Centre Ville Park";

      result5 = "Hope for Children Haiti";
      address5 = "Address: Quartier Charpentier, Les Cayes";
      description5 = "Description: Feeds orphans and vulnerable kids.";
      nearbyLandmark5 = "Nearby Landmark: Immaculée Conception Hospital";
    } else if (location == "Gonaïves") {
      result1 = "Gonaïves Food Bank";
      address1 = "Boulevard de la Liberté, Gonaïves";
      description1 = "Description: Distributes food packages to families.";
      nearbyLandmark1 = "Nearby Landmark: Place d’Armes";

      result2 = "Community Kitchen Gonaïves";
      address2 = "Address: Rue de la République, Gonaïves";
      description2 = "Description: Hot meal service daily.";
      nearbyLandmark2 = "Nearby Landmark: Gonaïves Cathedral";

      result3 = "Hope Foundation Haiti";
      address3 = "Address: Avenue Jean-Jacques Dessalines, Gonaïves";
      description3 = "Description: Provides food aid during crises.";
      nearbyLandmark3 = "Nearby Landmark: Liberty Square";

      result4 = "Feed the Future Gonaïves";
      address4 = "Address: Rue des Martyrs, Gonaïves";
      description4 = "Description: School feeding program.";
      nearbyLandmark4 = "Nearby Landmark: City Library";

      result5 = "Missionaries Food Outreach";
      address5 = "Address: Quartier Delmas, Gonaïves";
      description5 = "Description: Community kitchen and food distributions.";
      nearbyLandmark5 = "Nearby Landmark: Delmas Market";
    } else if (location == "Jacmel") {
      result1 = "Jacmel Food Relief Center";
      address1 = "Address: Rue Capois, Jacmel";
      description1 = "Description: Distributes emergency food aid.";
      nearbyLandmark1 = "Nearby Landmark: Jacmel Port";

      result2 = "Harvest Haiti Jacmel";
      address2 = "Address: Boulevard Cadet, Jacmel";
      description2 = "Description: Community meals and food assistance.";
      nearbyLandmark2 = "Nearby Landmark: Jacmel Market";

      result3 = "Jacmel Soup Kitchen";
      address3 = "Address: Rue Saint Michel, Jacmel";
      description3 = "Description: Daily meals for homeless and poor.";
      nearbyLandmark3 = "Nearby Landmark: St. Michel Church";

      result4 = "Good Samaritan Food Bank";
      address4 = "Address: Rue de la République, Jacmel";
      description4 = "Description: Food packages for families.";
      nearbyLandmark4 = "Nearby Landmark: Town Hall";

      result5 = "Food for All Jacmel";
      address5 = "Address: Rue de la Paix, Jacmel";
      description5 = "Description: Volunteer-run feeding center.";
      nearbyLandmark5 = "Nearby Landmark: Jacmel Plaza";
    }
  } else if (need == "Shelter") {
    if (location == "Port-au-Prince") {
      result1 = "Missionaries of Charity Shelter";
      address1 = "Address: Rue Chavannes, Port-au-Prince, Haiti";
      description1 = "Description: Shelter for homeless, elderly, disabled.";
      nearbyLandmark1 = "Nearby Landmark: Champs de Mars";

      result2 = "Haiti Communitere";
      address2 = "Address: 19 Rue Pelican, Port-au-Prince";
      description2 = "Description: Disaster relief shelters & aid.";
      nearbyLandmark2 = "Nearby Landmark: Delmas 33";

      result3 = "Project Haiti Orphanage & Shelter";
      address3 = "Address: Canapé Vert, Port-au-Prince";
      description3 = "Description: Temporary housing for families.";
      nearbyLandmark3 = "Nearby Landmark: Canapé Vert Hospital";

      result4 = "Red Cross Transitional Homes";
      address4 = "Address: Delmas 60 area, Port-au-Prince";
      description4 = "Description: Shelters after earthquakes.";
      nearbyLandmark4 = "Nearby Landmark: Delmas Police Station";

      result5 = "Maison d’Espérance";
      address5 = "Address: Martissant 7, Port-au-Prince";
      description5 = "Description: Women and children's shelter.";
      nearbyLandmark5 = "Nearby Landmark: Martissant Health Center";
    } else if (location == "Cap-Haïtien") {
      result1 = "Caritas Haiti Shelter";
      address1 = "Address: Rue 17 H, Cap-Haïtien, Haiti";
      description1 = "Description: Emergency and transitional housing.";
      nearbyLandmark1 = "Nearby Landmark: Lycée Philippe Guerrier";

      result2 = "Hope Shelter Cap-Haïtien";
      address2 = "Address: Rue Saint-Louis, Cap-Haïtien";
      description2 = "Description: Temporary shelter and aid.";
      nearbyLandmark2 = "Nearby Landmark: Cap-Haïtien City Hall";

      result3 = "Red Cross Cap-Haïtien Shelter";
      address3 = "Address: Avenue Toussaint Louverture, Cap-Haïtien";
      description3 = "Description: Post-disaster emergency housing.";
      nearbyLandmark3 = "Nearby Landmark: Place d’Armes";

      result4 = "Saint Vincent Shelter";
      address4 = "Address: Rue 10, Cap-Haïtien";
      description4 = "Description: Support for homeless families.";
      nearbyLandmark4 = "Nearby Landmark: Basilique Notre-Dame";

      result5 = "Safe Haven Shelter";
      address5 = "Address: Delmas Road, Cap-Haïtien";
      description5 = "Description: Long-term shelter services.";
      nearbyLandmark5 = "Nearby Landmark: Université Roi Henri Christophe";
    } else if (location == "Les Cayes") {
      result1 = "Haiti Red Cross Shelter Program";
      address1 = "Address: Rue Antoine Simon, Les Cayes";
      description1 =
          "Description: Emergency shelter and supplies after disasters.";
      nearbyLandmark1 = "Nearby Landmark: Place d’Italie";

      result2 = "Hope Shelter Les Cayes";
      address2 = "Address: Rue 3, Les Cayes";
      description2 = "Description: Temporary emergency housing.";
      nearbyLandmark2 = "Nearby Landmark: Lycée Guerrier des Cayes";

      result3 = "Caritas Les Cayes Shelter";
      address3 = "Address: Avenue Alexandre Pétion, Les Cayes";
      description3 = "Description: Shelter and support services.";
      nearbyLandmark3 = "Nearby Landmark: Centre Ville Park";

      result4 = "Safe Harbor Shelter";
      address4 = "Address: Rue Charles Hérard, Les Cayes";
      description4 =
          "Description: Long-term housing for vulnerable populations.";
      nearbyLandmark4 = "Nearby Landmark: Hôpital Immaculée Conception";

      result5 = "Maison Soleil Shelter";
      address5 = "Address: Quartier Charpentier, Les Cayes";
      description5 = "Description: Shelter for women and children.";
      nearbyLandmark5 = "Nearby Landmark: Cathédrale Les Cayes";
    } else if (location == "Gonaïves") {
      result1 = "Gonaïves Emergency Shelter";
      address1 = "Address: Rue de la Liberté, Gonaïves";
      description1 = "Description: Emergency housing and aid.";
      nearbyLandmark1 = "Nearby Landmark: Place d’Armes";

      result2 = "Safe Shelter Gonaïves";
      address2 = "Address: Avenue du Peuple, Gonaïves";
      description2 = "Description: Temporary shelter for displaced families.";
      nearbyLandmark2 = "Nearby Landmark: Gonaïves Cathedral";

      result3 = "Hope House Gonaïves";
      address3 = "Address: Rue des Martyrs, Gonaïves";
      description3 = "Description: Support for homeless youth.";
      nearbyLandmark3 = "Nearby Landmark: Liberty Square";

      result4 = "Red Cross Shelter Gonaïves";
      address4 = "Address: Boulevard Saint Michel, Gonaïves";
      description4 = "Description: Transitional housing and emergency aid.";
      nearbyLandmark4 = "Nearby Landmark: City Hospital";

      result5 = "Unity Shelter";
      address5 = "Address: Rue des Sports, Gonaïves";
      description5 = "Description: Community shelter program.";
      nearbyLandmark5 = "Nearby Landmark: Sports Complex";
    } else if (location == "Jacmel") {
      result1 = "Jacmel Shelter Center";
      address1 = "Address: Rue Capois, Jacmel";
      description1 = "Description: Shelter for displaced families.";
      nearbyLandmark1 = "Nearby Landmark: Jacmel Port";

      result2 = "Hope Shelter Jacmel";
      address2 = "Address: Boulevard Cadet, Jacmel";
      description2 = "Description: Emergency and long-term shelter.";
      nearbyLandmark2 = "Nearby Landmark: Jacmel Market";

      result3 = "Good Samaritan Shelter";
      address3 = "Address: Rue Saint Michel, Jacmel";
      description3 = "Description: Support for homeless individuals.";
      nearbyLandmark3 = "Nearby Landmark: St. Michel Church";

      result4 = "Safe Haven Jacmel";
      address4 = "Address: Rue de la République, Jacmel";
      description4 = "Description: Temporary housing and aid.";
      nearbyLandmark4 = "Nearby Landmark: Town Hall";

      result5 = "Community Shelter Jacmel";
      address5 = "Address: Rue de la Paix, Jacmel";
      description5 = "Description: Community-based shelter programs.";
      nearbyLandmark5 = "Nearby Landmark: Jacmel Plaza";
    }
  } else if (need == "Medical Help") {
    if (location == "Port-au-Prince") {
      result1 = "Doctors Without Borders (MSF)";
      address1 = "Address: Avenue Charles Summer, Port-au-Prince, Haiti";
      description1 = "Description: Urgent medical and trauma care.";
      nearbyLandmark1 = "Nearby Landmark: Delmas Market";

      result2 = "Hôpital Bernard Mevs";
      address2 = "Address: Avenue Poupelard, Port-au-Prince";
      description2 = "Description: 24/7 Emergency hospital.";
      nearbyLandmark2 = "Nearby Landmark: St. Louis Roi de France Church";

      result3 = "GHESKIO Center";
      address3 = "Address: Boulevard Harry Truman, Port-au-Prince";
      description3 = "Description: Infectious disease and general care.";
      nearbyLandmark3 = "Nearby Landmark: Port-au-Prince Harbor";

      result4 = "Centre Hospitalier de Fontaine";
      address4 = "Address: Clercine 6, Port-au-Prince";
      description4 = "Description: Pediatrics, surgery, general practice.";
      nearbyLandmark4 = "Nearby Landmark: Clercine Market";

      result5 = "HUEH General Hospital";
      address5 = "Address: Rue Monseigneur Guilloux, Port-au-Prince";
      description5 = "Description: Main public hospital in Haiti.";
      nearbyLandmark5 = "Nearby Landmark: Champ de Mars";
    } else if (location == "Cap-Haïtien") {
      result1 = "Hôpital Universitaire Justinien";
      address1 = "Address: Rue 20, Cap-Haïtien, Haiti";
      description1 = "Description: General and emergency hospital services.";
      nearbyLandmark1 = "Nearby Landmark: Place d’Armes";

      result2 = "Clinique Sainte-Marie";
      address2 = "Address: Avenue Christophe, Cap-Haïtien";
      description2 = "Description: Primary care and outpatient services.";
      nearbyLandmark2 = "Nearby Landmark: Université Roi Henri Christophe";

      result3 = "Hôpital Saint Nicolas";
      address3 = "Address: Rue des Remparts, Cap-Haïtien";
      description3 = "Description: Surgical and emergency care.";
      nearbyLandmark3 = "Nearby Landmark: Place de la Paix";

      result4 = "Clinique Espérance";
      address4 = "Address: Boulevard Jean-Jacques Dessalines, Cap-Haïtien";
      description4 = "Description: Maternal and child health services.";
      nearbyLandmark4 = "Nearby Landmark: Basilique Notre-Dame";

      result5 = "Centre de Santé Communautaire";
      address5 = "Address: Rue 14, Cap-Haïtien";
      description5 = "Description: Community health and vaccinations.";
      nearbyLandmark5 = "Nearby Landmark: Cap-Haïtien Market";
    } else if (location == "Les Cayes") {
      result1 = "Hôpital Immaculée Conception";
      address1 = "Address: Avenue des Quatre Chemins, Les Cayes";
      description1 =
          "Description: Major public hospital for emergency and outpatient care.";
      nearbyLandmark1 = "Nearby Landmark: Place d’Italie";

      result2 = "Centre de Santé Saint Antoine";
      address2 = "Address: Rue Capois, Les Cayes";
      description2 = "Description: Primary care and maternal health.";
      nearbyLandmark2 = "Nearby Landmark: Lycée Guerrier des Cayes";

      result3 = "Clinique Sainte Thérèse";
      address3 = "Address: Boulevard Jean-Jacques Dessalines, Les Cayes";
      description3 = "Description: Outpatient clinic and vaccinations.";
      nearbyLandmark3 = "Nearby Landmark: Centre Ville Park";

      result4 = "Hopital Saint Michel";
      address4 = "Address: Rue de la Paix, Les Cayes";
      description4 = "Description: Surgical and emergency services.";
      nearbyLandmark4 = "Nearby Landmark: Cathédrale Les Cayes";

      result5 = "Clinique Espérance";
      address5 = "Address: Rue Alexandre Pétion, Les Cayes";
      description5 = "Description: Child health and nutrition programs.";
      description5 = "Child health and nutrition programs.";
      nearbyLandmark5 = "Nearby Landmark: Hôpital Immaculée Conception";
    } else if (location == "Gonaïves") {
      result1 = "Hôpital de Gonaïves";
      address1 = "Address: Rue de la Liberté, Gonaïves";
      description1 = "Description: Emergency and general hospital services.";
      nearbyLandmark1 = "Nearby Landmark: Place d’Armes";

      result2 = "Clinique Sainte Bernadette";
      address2 = "Address: Avenue des Martyrs, Gonaïves";
      description2 = "Description: Primary care and outpatient services.";
      nearbyLandmark2 = "Nearby Landmark: Gonaïves Cathedral";

      result3 = "Centre de Santé Communautaire";
      address3 = "Address: Boulevard Saint Michel, Gonaïves";
      description3 = "Description: Vaccinations and maternal care.";
      nearbyLandmark3 = "Nearby Landmark: City Hospital";

      result4 = "Clinique Espérance";
      address4 = "Address: Rue des Martyrs, Gonaïves";
      description4 = "Description: Child health programs and nutrition.";
      nearbyLandmark4 = "Nearby Landmark: Liberty Square";

      result5 = "Mobile Medical Unit Gonaïves";
      address5 = "Address: Rue des Sports, Gonaïves";
      description5 = "Description: Mobile emergency medical services.";
      nearbyLandmark5 = "Nearby Landmark: Sports Complex";
    } else if (location == "Jacmel") {
      result1 = "Hôpital Saint-Michel";
      address1 = "Address: Rue Capois, Jacmel";
      description1 = "Description: General hospital with emergency services.";
      nearbyLandmark1 = "Nearby Landmark: Jacmel Port";

      result2 = "Clinique Saint Louis";
      address2 = "Address: Boulevard Cadet, Jacmel";
      description2 = "Description: Primary and maternal care.";
      nearbyLandmark2 = "Nearby Landmark: Jacmel Market";

      result3 = "Centre de Santé Communautaire";
      address3 = "Address: Rue Saint Michel, Jacmel";
      description3 = "Description: Outpatient services and immunizations.";
      nearbyLandmark3 = "Nearby Landmark: St. Michel Church";

      result4 = "Clinique Bon Samaritan";
      address4 = "Address: Rue de la République, Jacmel";
      description4 = "Description: Surgical and emergency care.";
      nearbyLandmark4 = "Nearby Landmark: Town Hall";

      result5 = "Mobile Health Clinic Jacmel";
      address5 = "Address: Rue de la Paix, Jacmel";
      description5 = "Description: Mobile health and emergency services.";
      nearbyLandmark5 = "Nearby Landmark: Jacmel Plaza";
    }
  }
}

// Final screen
class FinishScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        String selectedLang = "English";
        if (state is SelectedLanguageState) {
          selectedLang = state.selectedLang;
        }

        // Translated text
        String appBarText =
            selectedLang == "English"
                ? "You're Done"
                : selectedLang == "Creole"
                ? "Ou fini"
                : selectedLang == "French"
                ? "Vous avez terminé"
                : "You're Done";

        String messageText =
            selectedLang == "English"
                ? "You finished!\nClick below to see results"
                : selectedLang == "Creole"
                ? "Ou fini!\nKlike anba pou w wè rezilta yo"
                : selectedLang == "French"
                ? "Vous avez terminé!\nCliquez ci-dessous pour voir les résultats"
                : "You finished!\nClick below to see results";

        String buttonText =
            selectedLang == "English"
                ? "See Results"
                : selectedLang == "Creole"
                ? "Gade Rezilta yo"
                : selectedLang == "French"
                ? "Voir les résultats"
                : "See Results";

        return Scaffold(
          backgroundColor: Colors.lightBlue.shade50,
          appBar: AppBar(
            backgroundColor: Colors.lightBlue.shade300,
            title: Text(
              appBarText,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    size: 100,
                    color: Colors.green.shade500,
                  ),
                  SizedBox(height: 30),
                  Text(
                    messageText,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lexend(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Results1()),
                      );
                    },
                    child: Container(
                      width: 300,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [
                            Colors.lightBlue.shade400,
                            Colors.blue.shade700,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          buttonText,
                          style: GoogleFonts.lexend(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

String getOpenLabel(String selecglOBAL) {
  if (selecglOBAL == "Creole") return "Louvri nan Maps";
  if (selecglOBAL == "French") return "Ouvrir dans Maps";
  return "Open in Maps";
}

Widget launchMapButton(String url) {
  String text = getOpenLabel(selecglOBAL);
  return SizedBox(
    width: 300,
    height: 60,
    child: ElevatedButton.icon(
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          // Optional: Show an error snackbar if the URL can't be opened
          debugPrint('Could not launch $url');
        }
      },
      icon: Icon(Icons.map, size: 24),
      label: Text(
        text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightBlue.shade400,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
      ),
    ),
  );
}

// Results 1
class Results1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        String selectedLang = "English";
        if (state is SelectedLanguageState) {
          selectedLang = state.selectedLang;
        }

        // Language translations
        String appBarText =
            selectedLang == "English"
                ? "Your Results"
                : selectedLang == "Creole"
                ? "Rezilta Ou"
                : selectedLang == "French"
                ? "Vos Résultats"
                : "Your Results";

        String nextButtonText =
            selectedLang == "English"
                ? "Next Result"
                : selectedLang == "Creole"
                ? "Rezilta Pwochen"
                : selectedLang == "French"
                ? "Résultat Suivant"
                : "Next Result";
        return Scaffold(
          backgroundColor: Colors.lightBlue.shade50,
          appBar: AppBar(
            backgroundColor: Colors.lightBlue.shade300,
            title: Text(
              appBarText,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            leading: SizedBox(),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    size: 80,
                    color: Colors.green.shade600,
                  ),
                  SizedBox(height: 24),

                  // Result Name
                  resultInfoBox(icon: Icons.place, label: result1),

                  // Address
                  resultInfoBox(icon: Icons.home, label: address1),

                  // Landmark
                  resultInfoBox(
                    icon: Icons.location_city,
                    label: nearbyLandmark1,
                  ),

                  // Description
                  resultInfoBox(icon: Icons.info_outline, label: description1),

                  SizedBox(height: 40),

                  // Next Result Button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Results2()),
                      );
                    },
                    child: Container(
                      width: 250,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        gradient: LinearGradient(
                          colors: [
                            Colors.lightBlue.shade400,
                            Colors.blue.shade700,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          nextButtonText,
                          style: GoogleFonts.lexend(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget resultInfoBox({required IconData icon, required String label}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(2, 4)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue.shade700, size: 28),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Results 2
class Results2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        String selectedLang = "English";
        if (state is SelectedLanguageState) {
          selectedLang = state.selectedLang;
        }

        // Language strings
        String appBarText =
            selectedLang == "English"
                ? "Your Results"
                : selectedLang == "Creole"
                ? "Rezilta Ou"
                : selectedLang == "French"
                ? "Vos Résultats"
                : "Your Results";

        String nextBtnText =
            selectedLang == "English"
                ? "Next"
                : selectedLang == "Creole"
                ? "Pwochen"
                : selectedLang == "French"
                ? "Suivant"
                : "Next";

        String backBtnText =
            selectedLang == "English"
                ? "Back"
                : selectedLang == "Creole"
                ? "Retounen"
                : selectedLang == "French"
                ? "Retour"
                : "Back";

        String retakeBtnText =
            selectedLang == "English"
                ? "Retake"
                : selectedLang == "Creole"
                ? "Rekòmanse"
                : selectedLang == "French"
                ? "Recommencer"
                : "Retake";

        return Scaffold(
          backgroundColor: Colors.lightBlue.shade50,
          appBar: AppBar(
            title: Text(
              appBarText,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            backgroundColor: Colors.lightBlue.shade300,
            centerTitle: true,
            leading: SizedBox(),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Icon(
                    Icons.place_rounded,
                    size: 80,
                    color: Colors.green.shade600,
                  ),
                  SizedBox(height: 24),

                  // Info Boxes
                  resultInfoBox(icon: Icons.place, label: result2), // Name
                  resultInfoBox(icon: Icons.home, label: address2), // Address
                  resultInfoBox(
                    icon: Icons.map,
                    label: nearbyLandmark2,
                  ), // Landmark
                  resultInfoBox(
                    icon: Icons.info_outline,
                    label: description2,
                  ), // Desc

                  SizedBox(height: 30),

                  // Buttons
                  gradientButton(
                    text: nextBtnText,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Results3()),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  gradientButton(
                    text: backBtnText,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 16),
                  gradientButton(
                    text: retakeBtnText,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeOffline(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget resultInfoBox({required IconData icon, required String label}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(2, 4)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue.shade700, size: 28),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget gradientButton({required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            colors: [Colors.lightBlue.shade400, Colors.blue.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

// Results 3
class Results3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        String selectedLang = "English";
        if (state is SelectedLanguageState) {
          selectedLang = state.selectedLang;
        }

        String appBarText =
            selectedLang == "English"
                ? "Your Results"
                : selectedLang == "Creole"
                ? "Rezilta Ou"
                : selectedLang == "French"
                ? "Vos Résultats"
                : "Your Results";

        String nextText =
            selectedLang == "English"
                ? "Next"
                : selectedLang == "Creole"
                ? "Pwochen"
                : selectedLang == "French"
                ? "Suivant"
                : "Next";

        String backText =
            selectedLang == "English"
                ? "Back"
                : selectedLang == "Creole"
                ? "Retounen"
                : selectedLang == "French"
                ? "Retour"
                : "Back";

        String retakeText =
            selectedLang == "English"
                ? "Retake"
                : selectedLang == "Creole"
                ? "Rekòmanse"
                : selectedLang == "French"
                ? "Recommencer"
                : "Retake";

        return Scaffold(
          backgroundColor: Colors.lightBlue.shade50,
          appBar: AppBar(
            title: Text(appBarText),
            backgroundColor: Colors.lightBlue.shade300,
            centerTitle: true,
            leading: SizedBox(),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Icon(
                    Icons.place_rounded,
                    size: 80,
                    color: Colors.green.shade600,
                  ),
                  SizedBox(height: 24),
                  resultInfoBox(icon: Icons.place, label: result3),
                  resultInfoBox(icon: Icons.home, label: address3),
                  resultInfoBox(icon: Icons.map, label: nearbyLandmark3),
                  resultInfoBox(icon: Icons.info_outline, label: description3),
                  SizedBox(height: 30),
                  gradientButton(
                    text: nextText,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Results4()),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  gradientButton(
                    text: backText,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 16),
                  gradientButton(
                    text: retakeText,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeOffline(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Results 4
class Results4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        String selectedLang = "English";
        if (state is SelectedLanguageState) {
          selectedLang = state.selectedLang;
        }

        String appBarText =
            selectedLang == "English"
                ? "Your Results"
                : selectedLang == "Creole"
                ? "Rezilta Ou"
                : selectedLang == "French"
                ? "Vos Résultats"
                : "Your Results";

        String nextText =
            selectedLang == "English"
                ? "Next"
                : selectedLang == "Creole"
                ? "Pwochen"
                : selectedLang == "French"
                ? "Suivant"
                : "Next";

        String backText =
            selectedLang == "English"
                ? "Back"
                : selectedLang == "Creole"
                ? "Retounen"
                : selectedLang == "French"
                ? "Retour"
                : "Back";

        String retakeText =
            selectedLang == "English"
                ? "Retake"
                : selectedLang == "Creole"
                ? "Rekòmanse"
                : selectedLang == "French"
                ? "Recommencer"
                : "Retake";

        return Scaffold(
          backgroundColor: Colors.lightBlue.shade50,
          appBar: AppBar(
            title: Text(appBarText),
            backgroundColor: Colors.lightBlue.shade300,
            centerTitle: true,
            leading: SizedBox(),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Icon(
                    Icons.place_rounded,
                    size: 80,
                    color: Colors.green.shade600,
                  ),
                  SizedBox(height: 24),
                  resultInfoBox(icon: Icons.place, label: result4),
                  resultInfoBox(icon: Icons.home, label: address4),
                  resultInfoBox(icon: Icons.map, label: nearbyLandmark4),
                  resultInfoBox(icon: Icons.info_outline, label: description4),
                  SizedBox(height: 30),
                  gradientButton(
                    text: nextText,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Results5()),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  gradientButton(
                    text: backText,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 16),
                  gradientButton(
                    text: retakeText,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeOffline(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Results 5
class Results5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        String selectedLang = "English";
        if (state is SelectedLanguageState) {
          selectedLang = state.selectedLang;
        }

        String appBarText =
            selectedLang == "English"
                ? "Your Results"
                : selectedLang == "Creole"
                ? "Rezilta Ou"
                : selectedLang == "French"
                ? "Vos Résultats"
                : "Your Results";

        String backText =
            selectedLang == "English"
                ? "Back"
                : selectedLang == "Creole"
                ? "Retounen"
                : selectedLang == "French"
                ? "Retour"
                : "Back";

        String retakeText =
            selectedLang == "English"
                ? "Retake"
                : selectedLang == "Creole"
                ? "Rekòmanse"
                : selectedLang == "French"
                ? "Recommencer"
                : "Retake";

        return Scaffold(
          backgroundColor: Colors.lightBlue.shade50,
          appBar: AppBar(
            title: Text(appBarText),
            backgroundColor: Colors.lightBlue.shade300,
            centerTitle: true,
            leading: SizedBox(),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Icon(
                    Icons.place_rounded,
                    size: 80,
                    color: Colors.green.shade600,
                  ),
                  SizedBox(height: 24),
                  resultInfoBox(icon: Icons.place, label: result5),
                  resultInfoBox(icon: Icons.home, label: address5),
                  resultInfoBox(icon: Icons.map, label: nearbyLandmark5),
                  resultInfoBox(icon: Icons.info_outline, label: description5),
                  SizedBox(height: 30),
                  gradientButton(
                    text: backText,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Results4()),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  gradientButton(
                    text: retakeText,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeOffline(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget resultInfoBox({required IconData icon, required String label}) {
  return Container(
    margin: EdgeInsets.only(bottom: 20),
    padding: EdgeInsets.all(16),
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(2, 4)),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.blue.shade700, size: 28),
        SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget gradientButton({required String text, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 300,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: [Colors.lightBlue.shade400, Colors.blue.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 4)),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.lexend(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ),
    ),
  );
}
