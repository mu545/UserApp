//
//  UserDTO.swift
//  Task
//  Created by Mohammed Alomar on 25/12/2024.
//

import Foundation


struct UserDTO: Decodable {
	let id: Int?
	let name: String?
	let username: String?
	let email: String?
	let address: AddressDTO
	let phone: String?
	let website: String?
	let company: CompanyDTO
	
	
	func mapToDomain() -> UserDomainModel {
		return UserDomainModel(
			id: id ?? 0,
			name: name ?? "",
			username: username ?? "",
			email: email ?? "",
			address: address.mmapToDomain(),
			phone: phone ?? "",
			website: website ?? "",
			company: company.mapToDomain())
	}
}


struct AddressDTO: Decodable {
	let street: String?
	let suite: String?
	let city: String?
	let zipcode: String?
	let geo: GeoDTO
	
	func mmapToDomain() -> AddressDomainModel {
		return AddressDomainModel(
			street: street ?? "",
			suite: suite ?? "",
			city: city ?? "",
			zipcode: zipcode ?? "",
			geo: geo.mapToDomain())
	}
}



struct GeoDTO: Decodable {
	let lat: String?
	let lng: String?
	
	func mapToDomain() -> GeoDomainModel {
		return GeoDomainModel(
			lat: lat ?? "",
			lng: lng ?? "")
	}
}


struct CompanyDTO: Decodable {
	let name: String?
	let catchPhrase: String?
	let bs: String?
	
	func mapToDomain() -> CompanyDomainModel {
		return CompanyDomainModel(
			name: name ?? "",
			catchPhrase: catchPhrase ?? "",
			bs: bs ?? "")
	}
}




