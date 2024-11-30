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
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(15)
                    .frame(width: 370)
                    .frame(maxHeight: .infinity)
                    .shadow(radius: 5)

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
                        Spacer()

                        ExpandableSection(title: "Body Language Tips") {
                            Text("Do's:")
                                .font(.headline)
                            ForEach(TravelGuideData.guideBodyLanguageDo[currentIndex], id: \.self) { doTip in
                                Text("• \(doTip)")
                            }

                            Text("Don'ts:")
                                .font(.headline)
                            ForEach(TravelGuideData.guideBodyLanguageDont[currentIndex], id: \.self) { dontTip in
                                Text("• \(dontTip)")
                            }
                        }
                        Spacer()

                        ExpandableSection(title: "Common Words & Phrases") {
                            ForEach(TravelGuideData.commonPhrases[currentIndex], id: \.0) { phrase in
                                Text("• \(phrase.0): \(phrase.1)")
                            }
                        }
                        Spacer()

                        ExpandableSection(title: "Electrical Plug & Outlet Info") {
                            ForEach(TravelGuideData.electricalInfo[currentIndex], id: \.0) { info in
                                Text("• \(info.0): \(info.1)")
                            }
                        }
                        Spacer()

                        ExpandableSection(title: "Cultural Dos & Don’ts") {
                            Text("Don'ts:")
                                .font(.headline)
                            ForEach(TravelGuideData.culturalInfo[currentIndex], id: \.0) { cultureTip in
                                Text("• \(cultureTip.0) \(cultureTip.1)")
                            }
                        }
                    }
                }
                .frame(width: 330)
                .frame(maxHeight: .infinity)
                .cornerRadius(15)
            }
            .padding(.top, -25)
            .padding(.bottom, 100)
        }
        .background(Color("myBeige"))
    }
}

// Expandable Section View
struct ExpandableSection<Content: View>: View {
    let title: String
    @ViewBuilder var content: Content
    @State private var isExpanded = false

    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color("myGreen"))
                .frame(maxWidth: .infinity) // Ensure the background spans full width
            }
            .buttonStyle(PlainButtonStyle()) // Remove default button styling

            if isExpanded {
                VStack(alignment: .leading, spacing: 10) {
                    content
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.white)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 1) // Add a green border
        )
        .cornerRadius(5) // Match the corner radius of the overlay
        .padding(.bottom, 10) // Space between sections
    }
}




#Preview {
    GuideView(locationName: "Fiji, South Pacific Islands", currentIndex: 0)
}
