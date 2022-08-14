//
//  ImageLoader.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 14.08.2022.
//

import Foundation
import UIKit

struct ImageLoader {
    
    let queueForLoad = DispatchQueue.global(qos: .utility)
    let session = URLSession(configuration: .default)
    
    func loadImage(from url: URL, _ onLoadWasComplited: @escaping (_ result: Result<UIImage, Error>) -> Void)  {
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                onLoadWasComplited(.failure(error))
            }
            if let data = data, let image = UIImage(data: data) {
                onLoadWasComplited(.success(image))
            }
        }
        .resume()
    }
    
}
