class GroupMembershipActivity < Activity

 def group
    target
  end

  def group_name
    group.name 
  end

  def email
    actor.email
  end
end