//
//  Events.swift
//  Movies
//
//  Created by Vaibhav Gawde on 23/05/24.
//

import Foundation



enum Events {
    case loading
    case stopLoading
    case success
    case error(error : Error?)
}
