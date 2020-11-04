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

  def all_trans(transaction, value)
    if transaction.group_id.value == nil
          transaction[group_id] = "none"
    else
          transaction[group_name]
    end
  end

  def all_trans=(value)
    if transaction.value.empty?
      write_attribute(:name, nil)
    else
      super
    end
  end
end
# rubocop:enable Style/GuardClause
