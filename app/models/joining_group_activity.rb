class JoiningGroupActivity < Activity

 def group
    subject.group
  end

  def group_name
    group.name 
  end

  def email
    subject.member.email
  end
end