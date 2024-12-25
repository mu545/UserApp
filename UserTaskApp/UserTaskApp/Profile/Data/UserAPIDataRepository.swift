//
//  UserAPIDataRepository.swift
//  Task
//
//  Created by Mohammed Alomar on 25/12/2024.
//

import Foundation

class UserAPIDataRepository: UserRepository {
	
	func fetchUsers() async throws -> [UserDomainModel] {
		guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
			throw URLError(.badURL)
		}
		
		let (data, response) = try await URLSession.shared.data(from: url)
		
		guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
			throw URLError(.badServerResponse)
		}
		
		let apiUsers = try JSONDecoder().decode([UserDTO].self, from: data)
		
		return apiUsers.map { apiUser in
			UserDomainModel(
				id: apiUser.id ?? 0,
				name: apiUser.name ?? "",
				username: apiUser.username ?? "",
				email: apiUser.email ?? "",
				address: apiUser.address.mmapToDomain(),
				phone: apiUser.phone ?? "",
				website: apiUser.website ?? "",
				company: apiUser.company.mapToDomain()
			)
		}
	}
}
