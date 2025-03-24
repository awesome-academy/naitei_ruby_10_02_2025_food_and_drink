module ApplicationHelper
  include Pagy::Frontend
  def price_in price
    case I18n.locale
    when :en
      price * I18n.t("exchange_rate.vnd_to_usd")
    else
      price * I18n.t("exchange_rate.usd_to_vnd")
    end
  end
end
