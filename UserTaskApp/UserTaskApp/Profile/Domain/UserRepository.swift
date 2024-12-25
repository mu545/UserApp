//
//  UserRepository.swift
//  UserTaskApp
//
//  Created by Mohammed Alomar on 25/12/2024.
//

protocol UserRepository {
	func fetchUsers() async throws -> [UserDomainModel]
}
