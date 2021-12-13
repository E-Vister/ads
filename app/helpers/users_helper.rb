module UsersHelper
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.username, class: "gravatar")
  end
  
  def email_print(user)
    email = user.email
    (email[1] == "@") ? (email[0] + "***@" + email.split("@")[1]) : (email[0,2] + "***@" + email.split("@")[1])
  end
  
  def phone_print(user)
    phone = user.phone
    phone.slice(0,2) + " •• ••• •• " + phone.slice(-2, 2)
  end
end
