
//  DetailFilmMovie.swift
//  Actividad5
//
//  Created by Luciano Blanco 2/3/24.
//

import SwiftUI

struct DetailMovieView: View {
    
    let movie:Result
    
    var body: some View {
        
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original/"+movie.poster_path)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 250)
                    .cornerRadius(15)
                    .shadow(radius: 7)
            case .failure:
                Image(systemName: "photo")
            @unknown default:
                EmptyView()
            }
        }
        
        VStack(alignment: .leading){
            
            HStack{
                Text(movie.title)
                    .font(.subheadline)
                    .bold()
                Spacer()
                Image(systemName: "star.fill")
                    .foregroundColor(.gold)
                    .padding(.trailing, 10)
            }
            
            Text(movie.release_date)
                .font(.subheadline)
                .foregroundColor(.redCarpet)
            
            Text("Sinopsis")
                .font(.subheadline)
                .foregroundColor(.gray.opacity(0.9))
            
            Text(movie.overview)
                .font(.caption)
            
            Text("Categorias")
                .font(.subheadline)
                .foregroundColor(.gray.opacity(0.9))
            
            HStack{
                ForEach(movie.genre_ids, id: \.self) { id in
                    Text(Genero.generos[Genero.generos.firstIndex(where: { $0.id == id })!].nombre)
                        .font(.caption2)
                        .padding(.all, 5)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(10)
                }
            }
        }.padding(.leading, 10)
    }
}

