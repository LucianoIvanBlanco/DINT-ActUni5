//
//  MovieListModel.swift
//  Actividad5
//
//  Created by Luciano Blanco 2/3/24.
//
import Foundation

class MovieListModel: ObservableObject {
    @Published var movies: [Result] = []
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        print("Llamando a la API...")
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Define las cabeceras aquí
        let headers = [
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZDg0ZDFkZDY5NzE2MzM2OGMzNDBhYzM1OGYxOTE5YSIsInN1YiI6IjY1Y2UzNWIzOTkyNTljMDE4NjI2MDk2YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.TtAq1Skmm3NK74oAAZilpsQU7Qz2-Jfs0E3u5AMWwFg",
            "Accept": "application/json"
        ]
        request.allHTTPHeaderFields = headers

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("HTTP Error: \(httpResponse.statusCode)")
                return
            }
            guard let data = data else { return }

            do {
                let response = try JSONDecoder().decode(Movie.self, from: data)
                DispatchQueue.main.async {
                    self.movies = response.results
                }
            } catch {
                print("Error en la lectura del json: ", error.localizedDescription)
            }
        }.resume()
    }
}
