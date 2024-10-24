import SwiftUI

struct GuideView: View {
    
    @State var locationName: String
    @State var currentIndex: Int
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color("myTeal"))
                .frame(height: 125)
                .ignoresSafeArea(edges: .top)
            
            ZStack {
                // Stationary rectangle as the background
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(15)
                    .frame(width: 370)
                    .frame(maxHeight: .infinity)
                    .shadow(radius: 5)
                
                // Scrollable text inside the rectangle
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text(locationName)
                            .foregroundColor(Color("myTeal"))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.custom("Roboto-Thin", size: 24))
                            .padding(.top, 30)

                        Text("TRAVELER'S GUIDE")
                            .foregroundColor(Color("myTeal"))
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Divider()
                            .frame(width: 200, height: 2)
                            .background(Color("myGreen"))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                        
                        Text("Body Language Tips")
                            .font(.title2)
                            .padding(.bottom, 5)
                        
                        // Do's Section
                        Text("Do’s:")
                            .font(.headline)
                        ForEach(guideBodyLanguageDo[currentIndex], id: \.self) { doTip in
                            HStack(alignment: .top) {
                                Text("•")
                                Text(doTip)
                            }
                        }
                        
                        // Don'ts Section
                        Text("Don’ts:")
                            .font(.headline)
                        ForEach(guideBodyLanguageDont[currentIndex], id: \.self) { dontTip in
                            HStack(alignment: .top) {
                                Text("•")
                                Text(dontTip)
                            }
                        }
                        
                        // Common Words & Phrases Section
                        Text("Common Words & Phrases")
                            .font(.title2)
                            .padding(.top, 10)
                        
                        ForEach(commonPhrases[currentIndex], id: \.0) { phrase in
                            HStack(alignment: .top) {
                                Text("•")
                                Text(phrase.0 + ": " + phrase.1)
                            }
                        }
                        
                        // Electrical Plug & Outlet Info Section
                        Text("Electrical Plug & Outlet Info")
                            .font(.title2)
                            .padding(.top, 10)
                        
                        ForEach(electricalInfo[currentIndex], id: \.0) { info in
                            HStack(alignment: .top) {
                                Text("•")
                                Text(info.0 + ": " + info.1)
                            }
                        }
                        
                        // Cultural Dos & Don’ts Section
                        Text("Cultural Dos & Don’ts")
                            .font(.title2)
                            .padding(.top, 10)
                        
                        ForEach(culturalInfo[currentIndex], id: \.0) { cultureTip in
                            HStack(alignment: .top) {
                                Text("•")
                                Text(cultureTip.0 + ": " + cultureTip.1)
                            }
                        }
                    }
                    
                }
                .frame(width: 330)
                .frame(maxHeight: .infinity)
                .cornerRadius(15)
            } // ZStack
            .padding(.top, -25)
            .padding(.bottom, 100)
        } // VStack
        .background(Color("myBeige"))
    }
    
    @State private var guideBodyLanguageDo: [[String]] = [
        // Index 0: Fiji
        ["Smile: Fijians are known for their warmth and friendliness, and smiling is considered a sign of respect and hospitality."],
        // Index 1: Placeholder for another location
        ["None"],
        // Index 2: Placeholder for another location
        ["None"]
    ]
    
    @State private var guideBodyLanguageDont: [[String]] = [
        // Index 0: Fiji
        ["Avoid pointing at people with your finger. Instead, use your whole hand to gesture."],
        // Index 1: Placeholder
        ["None"],
        // Index 2: Placeholder
        ["None"]
    ]

    @State private var commonPhrases: [[(String, String)]] = [
        // Index 0: Fiji
        [("Bula!", "The universal Fijian greeting, meaning 'Hello!' and often used with a smile."),
         ("Vinaka", "Means 'Thank you.'")],
        // Index 1: Placeholder
        [("Phrase", "None")],
        // Index 2: Placeholder
        [("Phrase", "None")]
    ]

    @State private var electricalInfo: [[(String, String)]] = [
        // Index 0: Fiji
        [("Plug Type", "Fiji uses plug types I (three flat pins in a triangular configuration)."),
         ("Voltage", "The standard voltage is 240V, and the frequency is 50Hz."),
         ("Adapter Needed?", "Travelers from most countries (like the US, UK, and Europe) will need an adapter.")],
        // Index 1: Placeholder
        [("Plug Type", "None")],
        // Index 2: Placeholder
        [("Plug Type", "None")]
    ]

    @State private var culturalInfo: [[(String, String)]] = [
        // Index 0: Fiji
        [("Don't", "Wear hats in villages: In Fijian culture, hats are reserved for chiefs, so wearing one in a village is considered disrespectful.")],
        // Index 1: Placeholder
        [("Don't", "None")],
        // Index 2: Placeholder
        [("Don't", "None")]
    ]
}

#Preview {
    GuideView(
        locationName: "Fiji, South Pacific Islands", currentIndex: 0
    )
}
