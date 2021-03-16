defmodule BgSiteOfficial.Email do
  import Bamboo.Email

  def welcome_email do
    new_email(
      to: "qskatak04@gmail.com",
      from: "mv24ko@gmail.com",
      subject: "Welcome to the app.",
      html_body: "<strong>Thanks for joining!</strong>",
      text_body: "Thanks for joining!"
    )
  end
end
