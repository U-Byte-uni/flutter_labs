import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const BirthdayCard());
}

class Person {
  String name;
  String gift;

  Person({required this.name, required this.gift});
}

class BirthdayCard extends StatelessWidget {
  const BirthdayCard({super.key});

  @override
  Widget build(BuildContext context) {

    Person person1 = Person(name: "Ali", gift: "Watch");
    Person person2 = Person(name: "Asfand", gift: "Burger");
    Person person3 = Person(name: "Shayan", gift: "Dumbell");
    Person person4 = Person(name: "Mian", gift: "AirJet");
    Person person5 = Person(name: "Usman", gift: "Dua");
    Person chiefguest = Person(name: "Haris", gift: "Gardens on the Moon (PaperBack)");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Center(
            child: Text(
              "Happy Birthday Card",
              style: GoogleFonts.coda(
                fontSize: 38,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today, size: 50, color: Colors.deepPurple),
                      SizedBox(height: 20),
                      Text(
                        'Event Details',
                        style: GoogleFonts.lobster(
                          fontSize: 28,
                          color: Colors.deepPurple,
                        ),
                      ),
                      SizedBox(height: 30),
                      Icon(Icons.access_time, size: 30, color: Colors.pink),
                      SizedBox(height: 10),
                      Text(
                        'Saturday, Feb 7',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '6:00 PM - 10:00 PM',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 30),
                      Icon(Icons.location_on, size: 30, color: Colors.pink),
                      SizedBox(height: 10),
                      Text(
                        'Al-Hayat Restaurant',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Adda, Sahiwal',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 30),
                      Divider(thickness: 2),
                      SizedBox(height: 20),
                      Text(
                        '"Celebrate life,\ncelebrate joy,\ncelebrate togetherness!"',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dancingScript(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 14),

              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.celebration, size: 40, color: Colors.orange),
                          SizedBox(width: 10),
                          Icon(Icons.cake, size: 50, color: Colors.pink),
                          SizedBox(width: 10),
                          Icon(Icons.celebration, size: 40, color: Colors.orange),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Happy Birthday!",
                        style: GoogleFonts.pacifico(
                          fontSize: 48,
                          color: Colors.pink.shade700,
                        ),
                      ),
                      Text(
                        "M.Uzair Sadiq",
                        style: GoogleFonts.pacifico(
                          fontSize: 48,
                          color: Colors.pink.shade700,
                        ),
                      ),

                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepPurple, width: 4),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/photo.jpg',
                            width: 300,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Wishing you a day filled with happiness! 🎉',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 14),

              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.workspace_premium, size: 50, color: Colors.deepPurple),
                      SizedBox(height: 10),

                      Text(
                        'Chief Guest',
                        style: GoogleFonts.lobster(
                          fontSize: 24,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        chiefguest.name,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Gift: ${chiefguest.gift}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 30),
                      Divider(thickness: 2),
                      SizedBox(height: 20),
                      Icon(Icons.people, size: 40, color: Colors.pink),
                      SizedBox(height: 10),
                      Text(
                        'Guest List',
                        style: GoogleFonts.lobster(
                          fontSize: 24,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),

                      Text(person1.name, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('Gift: ${person1.gift}', style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700])),
                      SizedBox(height: 10),

                      Text(person2.name, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('Gift: ${person2.gift}', style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700])),
                      SizedBox(height: 10),

                      Text(person3.name, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('Gift: ${person3.gift}', style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700])),
                      SizedBox(height: 10),

                      Text(person4.name, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('Gift: ${person4.gift}', style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700])),
                      SizedBox(height: 10),

                      Text(person5.name, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('Gift: ${person5.gift}', style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700])),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}