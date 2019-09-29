//
//  GPMSampleController.swift
//  App
//
//  Created by Marcus on 29/09/2019.
//

import Vapor
import WsGPM

final class GPMSampleController {

    func sample(_ req: Request) throws -> Future<String> {
        let promise = req.eventLoop.newPromise(Void.self)
        var result: String = ""
        /// Dispatch some work to happen on a background thread
        DispatchQueue.global().async {
            let gpm = AcordPlacing()
            gpm.ServiceProvider.Party.Name << GPMConstant.serviceProvider.rawValue
            result = gpm.makeXMLString(nil, version: AcordRLCVersion.AcordRLC201306)
            promise.succeed()
        }
        return promise.futureResult.transform(to: result)
    }

}
