import SwiftUI

struct UnauthenticatedHomeView: View {
    @EnvironmentObject var authenticator: Authenticator
    @State private var isLinkActive = false
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    
                    Image("madrid")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: geometry.size.height * 0.65)
                        .overlay(
                            LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .center, endPoint: .bottom)
                        )
                        .clipped()
                        .edgesIgnoringSafeArea(.top)
                    
                    VStack(alignment: .leading) {
                        VStack (alignment: .leading, spacing: 10){
                            Text("Hello!")
                                .font(.system(size: 48))
                                .fontWeight(.bold)
                            Text("Welcome to Adventure Ai")
                                .font(.system(size: 24))
                        }
                        
                        VStack{
                            NavigationLink(
                                destination: SignUpView())
                            {
                                Text("Let's Get Started")
                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                    .background(Color(red: 224 / 255, green: 227 / 255, blue: 72 / 255))
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                            }
                            DividerWithText(text: "or")
                            Button(action: {
                                print("Let's Get Started")
                            }) {
                                Text("Already have an account")
                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                    .background(Color(red: 153 / 255, green: 153 / 255, blue: 153 / 255))
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.top)
                        
                    }
                    .padding()
                    .offset(y: geometry.size.height * 0.4)
                }
            }
        }
    }
}

struct DividerWithText: View {
    let text: String
    var fontSize: CGFloat = 17
    
    var body: some View {
        HStack {
            Line()
            Text(text)
                .font(.system(size: fontSize))
                .fixedSize(horizontal: true, vertical: false)
                .padding(.horizontal, 10)
            Line()
        }
        .padding()
    }
}

struct Line: View {
    var body: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UnauthenticatedHomeView().preferredColorScheme(.dark)
    }
}
