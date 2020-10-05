ActiveAdmin.register User do

	permit_params :username, :email, :profile_picture

	index do
		column 'Nombre de Usuario', :username

		column 'Cantidad de Usuarios Seguidos' do |user|
			user.friends.count
		end

		column 'Cantidad de Tweets' do |user|
			user.tweets.count
		end

		column 'Cantidad de Likes' do |user|
			user.likes.count
		end

		column 'Cantidad de Retweets' do |user|
			arr = []
			user.tweets.each do |tweet|
				arr << tweet.tweet_id
			end
			arr.delete(nil)
			arr.length
		end


		actions
	end
	
  
end
