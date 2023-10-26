import SwiftUI

struct ContentView: View {
    let coreDataManager: CoreDataManager
    
    @State private var movieTitle: String = ""
    @State private var movieYear: String = ""
    @State private var movies: [Movie] = [Movie]()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HeaderView(title: "Login", subtitle: "todo list", angle: 15, backColor: .pink)
                TextField("Movie Title", text: $movieTitle).textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Movie Year", text: $movieYear).textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Save") {
                    guard !movieTitle.isEmpty, let intMovieYear = Int(movieYear) else {
                        return
                    }
                    coreDataManager.saveMovie(title: movieTitle, year: intMovieYear)
                    populateMovies()
                }
                List {
                    ForEach(movies, id: \.self) { movie in
                        NavigationLink(destination: MovieDetailsView(movie: movie, coreDataManager: coreDataManager), label: {
                            HStack {
                                Text(movie.title ?? "")
                                    .frame(width: 150)
                                Text(verbatim: "\(movie.year)")
                            }
                            .font(.system(size: 12, weight: .light, design: .default))
                        })
                    }
                    .onDelete(perform: { indexSet in
                        indexSet.forEach({ index in
                            let movie = movies[index]
                            coreDataManager.deleteMovie(movie: movie)
                            populateMovies()
                        })
                    })
                }
            }
            .padding()
            .navigationTitle("Movies")
            .onAppear(perform: {
                movies = []
                populateMovies()
            })
        }
    }

    private func populateMovies() {
        movies = coreDataManager.getAllMovies()
    }
}

#Preview {
    ContentView(coreDataManager: CoreDataManager())
}
