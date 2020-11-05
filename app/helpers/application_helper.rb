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

  def all_trans_icon(transaction)
    if transaction.group_id.nil?
      content_tag(:i, '', class: 'fa fa-file-o display-3')
    else
      ('<i class=" display-3 ' + transaction.group.icon + '"></i>').html_safe
    end
  end

  def all_trans_name(transaction)
    if transaction.group_id.nil?
      content_tag(:p, 'Group Name: Nil', class: 'card-text')
    else
      content_tag(:p, transaction.group.name, class: 'card-text')
    end
  end
end
# rubocop:enable Style/GuardClause
