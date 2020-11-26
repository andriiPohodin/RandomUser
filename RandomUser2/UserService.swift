
import Foundation
import Kingfisher

struct UserService {
    
    let session = URLSession.shared
    
    func getUsers(completion: @escaping (([Result]) -> Void)) {
        
        guard let url = URL(string: "https://randomuser.me/api/?results=50") else { return }
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            else {
                guard let data = data else { return }
                guard let response = response as? HTTPURLResponse else { return }
                switch response.statusCode {
                case 200:
                    let decoder = JSONDecoder()
                    do {
                        let users = try decoder.decode(Response.self, from: data)
                        DispatchQueue.main.async {
                            completion(users.results)
                        }
                    } catch {
                        print("Error decoding, \(error.localizedDescription)")
                    }
                default:
                    print("\(response.statusCode) Unexpected!")
                    break
                }
            }
        }
        task.resume()
    }
}
