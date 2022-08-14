//
//  PicturesService.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 13.08.2022.
//

import Foundation

struct PicturesService {
    
    let dataTask = BaseNetworkTask<EmptyModel, [PictureResponseModel]>(
        isNeedInjectToken: true,
        method: .post,
        path: "picture/"
    )
    
    func loadPictures(_ onResponseWasReceived: @escaping (_ result: Result<[PictureResponseModel], Error>) -> Void) {
        dataTask.performRequest(onResponseWasReceived)
    }
    
}
