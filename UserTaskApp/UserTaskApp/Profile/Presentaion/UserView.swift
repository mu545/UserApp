//
//  UserView.swift
//  UserTaskApp
//
//  Created by Mohammed Alomar on 25/12/2024.
//
import SwiftUI

struct UserView: View {
	@StateObject var viewModel = UserViewModel()
		
	var body: some View {
		ZStack {
			if viewModel.state.isLoading {
				ProgressView()
			} else {
				ScrollView {
					ForEach(viewModel.state.users , id: \.id) { user in
						LazyVStack(alignment: .center) {
							HStack {
								VStack(alignment: .leading, spacing: 6) {
									HStack{
										Text(user.name)
										Spacer()
										Button {
											viewModel.toggleFavorite(for: user)
										} label: {
											Image(systemName: viewModel.isFavorite(user: user) ? "star.fill" : "star")
												.foregroundColor(viewModel.isFavorite(user: user) ? .yellow : .gray)
										}
									}
									.padding(.all,10)
									
								}
								.padding(.trailing)
							}
						}
					}
				}
			}
		}
		.onAppear{
			viewModel.getUsers()
		}
	}
}
