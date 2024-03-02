//
//  Content.swift
//  Actividad5
//
//  Created by Luciano Blanco 2/3/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var data = MovieListModel()
    @State private var searchString: String = ""
    let gridItem: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        var movieFilters: [Result] {
            if searchString.isEmpty {
                return data.movies
            } else {
                return data.movies.filter { $0.title.lowercased().contains(searchString.lowercased())}
            }
        }
        
        NavigationStack{
            VStack{
                
        
                Text("MovieView")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                TextField("Buscar pelicula", text: $searchString)
                    .padding()
                    .overlay(
                      RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding()
                
                Text("Peliculas")
                    .font(.callout)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            
                ScrollView {
                    LazyVGrid(columns: gridItem, spacing: 5) {
                        ForEach(movieFilters, id:\.id){ movie in
                            Item(movie: movie)
                        }
                    }
                }
            }
        }
    }
}

struct Item: View {
    let movie:Result
    
    var body: some View {
        
        ZStack{
            
            VStack(alignment: .leading){
                NavigationLink(destination: DetailMovieView(movie: movie)) {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original/"+movie.poster_path)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 170)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 170)
                                .cornerRadius(10)
                        case .failure(_):
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original/"+movie.poster_path)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 170)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 170)
                                        .cornerRadius(10)
                                case .failure(let failure):
                                    let _ = print(failure.localizedDescription)
                                    Image("movierror")
                                        .scaledToFill()
                                        .frame(width: 170)
                                        .cornerRadius(10)
                                @unknown default:
                                    EmptyView()
                                        .frame(width: 170)
                                }
                            }
                        @unknown default:
                            EmptyView()
                                .frame(width: 170)
                        }
                    }
                }
                    
                Text(movie.title)
                    .font(.subheadline)
                    
                Text(Genero.generos[Genero.generos.firstIndex(where: { $0.id == movie.genre_ids[0] })!].nombre)
                    .font(.caption2)
                    .padding(.all, 5)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(10)
            }.padding()
                
            Circle()
                .fill(.redCarpet)
                .frame(width:25)
                .position(CGPoint(x: 180, y: 15))
            
            Text("\(String(describing: Double(round(10 * movie.vote_average) / 10)))")
                .font(.caption)
                .position(CGPoint(x: 180, y: 15))
            
        }
    }
}

