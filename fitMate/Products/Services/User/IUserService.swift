//
//  IUserService.swift
//  fitMate
//
//  Created by Emre Simsek on 13.04.2025.
//

protocol IUserService {
    
    func createUser(user: UserModel) async throws
    
    func updateUser(user: UserModel) async throws
    
    func fetchUser(by uid: String) async throws -> UserModel
}
