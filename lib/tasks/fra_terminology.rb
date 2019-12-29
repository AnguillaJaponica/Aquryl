require 'capybara'
require 'webdrivers'
require 'selenium-webdriver'

class AquaticOrganismsTerminology
  attr_reader :browser_session

  SCRAPING_TARGET = 'https://www.fishery-terminology.jp/glossary_browse1.php'

  def start(capybara_client_url)
    capybara_init(capybara_client_url)
    yield(self)
  ensure
    close_browser_session
  end

  # Capybaraの初期設定
  # @param [capybara_client_url] capybaraでwebブラウザを起動させる先のurl
  # @return [Capybara::Session] capybaraのブラウザ（chrome）セッション
  def capybara_init(capybara_client_url)
    # ブラウザ初期設定
    Capybara.register_driver :selenium_chrome do |app|
      Capybara::Selenium::Driver.new(app,
                                     browser: :chrome,
                                     desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
                                         chrome_options: {
                                             args: %w(headless no-sandbox disable-gpu window-size=1280,800),
                                         },
                                         ),
                                     url: capybara_client_url
      )
    end
    Capybara.javascript_driver = :selenium_chrome
    # 画面外の非表示部分の値を取得する設定
    Capybara.ignore_hidden_elements = false
    @browser_session =  Capybara::Session.new(:selenium_chrome)
  end

  # ページ上の学名や各国言語の魚種名を取得する。
  def get_species_names
    sales_with_item_name = {}
    # iframe内の要素を取得する
    browser_session.within_frame browser_session.find('iframe') do
      return nil unless browser_session.has_css?('#col_fixed_table')
      # 販売分析画面の売上項目名を取得
      sales_item_names = get_sales_item_names

      # 店舗ごとの売上の数字だけを取得
      sales_each_shop = get_sales_each_shop

      # 店舗ごとに売上の数字と売上項目を紐付ける
      sales_each_shop.each do |shop_name, sales|
        sales_with_item_name[shop_name] = make_sales_with_items(sales_item_names, sales)
      end
    end
    sales_with_item_name
  end

  # ブラウザを閉じる
  def close_browser_session
    browser_session.driver.quit
  end
end
