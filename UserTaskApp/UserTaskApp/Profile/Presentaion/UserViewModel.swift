//
//  UserViewModel.swift
//  UserTaskApp
//
//  Created by Mohammed Alomar on 25/12/2024.
//

import Foundation

class UserViewModel: ObservableObject {
	private var repo: UserRepository
	@Published public var state = UserState()
	
	
	public init(repo: UserRepository = UserAPIDataRepository()) {
		self.repo = repo
		
	}
	
	func getUsers()  {
		
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			self.state.isLoading = true
		}
		
		Task {
			do {
				let result = try await repo.fetchUsers()
				DispatchQueue.main.async { [weak self] in
					guard let self = self else { return }
					self.state.users = result
					self.state.isLoading = false
				}
			} catch {
				DispatchQueue.main.async { [weak self] in
					guard let self = self else { return }
					self.state.error = error.localizedDescription
					self.state.isLoading = false
				}
			}
		}
		
	}
	
	func toggleFavorite(for user: UserDomainModel) {
		
		if state.favoriteUserIds.contains(user.id) {
			state.favoriteUserIds.removeAll { $0 == user.id }
		} else {
			state.favoriteUserIds.append(user.id)
		}
		saveFavorite()
	}
	
	func saveFavorite() {
		UserDefaults.standard.set(state.favoriteUserIds, forKey: "favoriteUsers")
	}
	
	func getFavorites() -> [Int] {
		return UserDefaults.standard.array(forKey: "favoriteUsers") as? [Int] ?? []
	}
	
	// Check if a user is a favorite
	func isFavorite(user: UserDomainModel) -> Bool {
		return state.favoriteUserIds.contains(user.id)
	}
}


struct UserState {
	var users: [UserDomainModel] = []
	public var error: String? = nil
	public var isEmpty: Bool = false
	public var isLoading: Bool = false
	public var isShowError: Bool = false
	public var favoriteUserIds: [Int] = []
}
