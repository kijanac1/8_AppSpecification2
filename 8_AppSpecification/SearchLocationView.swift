
import SwiftUI

struct SearchLocationView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        VStack{
            Rectangle()
                .fill(Color("myTeal"))
                .frame(height: 125)
                .ignoresSafeArea(edges: .top)
            VStack {
                HStack {
                    TextField("search location", text: $searchText)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    Button(action: {
                        // Search logic here
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .foregroundColor(Color("myGreen"))
                            .padding(.trailing, 10)
                    }
                }
                .padding(.top, -40)
                
                Spacer()
            }
            //.background(Color("myBeige").ignoresSafeArea())
        }
        .background(Color("myBeige"))
    }
}

#Preview {
    SearchLocationView()
}
