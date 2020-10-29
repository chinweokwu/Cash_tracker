module ApplicationHelper
    def user_allowed
        logged_in? && current_user.id
    end
end
