//
//  MarsRoverInteractor.swift
//  Desafio Beblue_LucasCordeiro
//
//  Created by Lucas Cordeiro on 03/03/19.
//  Copyright (c) 2019 Sparks. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MarsRoverBusinessLogic {
  func doSomething(request: MarsRover.Something.Request)
}

protocol MarsRoverDataStore {
  //var name: String { get set }
}

class MarsRoverInteractor: MarsRoverBusinessLogic, MarsRoverDataStore {
  var presenter: MarsRoverPresentationLogic?
  var worker: MarsRoverWorker?
  //var name: String = ""

  // MARK: Do something

  func doSomething(request: MarsRover.Something.Request) {
    worker = MarsRoverWorker()
    worker?.doSomeWork()

    let response = MarsRover.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
