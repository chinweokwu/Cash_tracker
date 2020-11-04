# rubocop:disable Style/GuardClause
module ApplicationHelper
  def group_edit_destroy(group)
    if group.user_id == current_user.id
      (link_to 'Edit |', edit_group_path(group)) +
        (link_to ' Destroy', group, method: :delete, data: { confirm: 'Are you sure?' })
    end
  end

  def user_total_trans(user, amount)
    user.transactions.sum(amount)
  end
end
# rubocop:enable Style/GuardClause
