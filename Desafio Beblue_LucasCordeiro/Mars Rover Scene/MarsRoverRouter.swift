//
//  MarsRoverRouter.swift
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

@objc protocol MarsRoverRoutingLogic {
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol MarsRoverDataPassing {
  var dataStore: MarsRoverDataStore? { get }
}

class MarsRoverRouter: NSObject, MarsRoverRoutingLogic, MarsRoverDataPassing {
  weak var viewController: MarsRoverViewController?
  var dataStore: MarsRoverDataStore?

  // MARK: Routing

  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC =
  //    storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation

  //func navigateToSomewhere(source: MarsRoverViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}

  // MARK: Passing data

  //func passDataToSomewhere(source: MarsRoverDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
