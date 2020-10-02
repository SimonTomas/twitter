module ApplicationHelper
    def avatar_for(user, width = '', height = '')
        @avatar = user.profile_picture
        if @avatar.empty?
            @avatar_user = image_tag('avatar_default.png', width: width, height: height, class: 'rounded-circle')
        else
            @avatar_user = image_tag(user.profile_picture, width: width, height: height, class: 'rounded-circle')
        end
        return @avatar_user
    end
end
