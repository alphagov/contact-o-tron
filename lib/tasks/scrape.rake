task :scrape => :environment do
  require 'open-uri'

  ENDPOINT_URI = URI.parse('http://www.direct.gov.uk/en/Dl1/Directories/A-ZOfCentralGovernment/index.htm').freeze
  PHONE_NUMBER_KINDS = { 'Phone number' => 'phone', 'Fax' => 'fax', 'Text phone' => 'minicom' }

  def scrape_hrefs(node_set, base_uri, rule)
    node_set.css(rule).css('a').map { |a| base_uri.merge a[:href] }
  end

  def scrape_index_uris(node_set, base_uri)
    scrape_hrefs node_set, base_uri, '.atoz'
  end

  def scrape_organisation_uris(node_set, base_uri)
    scrape_hrefs node_set, base_uri, '.subLinks'
  end

  def scrape_contact_details(node_set)
    node_set.css '.contactsInfo li'
  end

  def organisations
    Enumerator.new do |y|
      scrape_index_uris(Nokogiri::HTML(open(ENDPOINT_URI)), ENDPOINT_URI).each do |index_uri|
        scrape_organisation_uris(Nokogiri::HTML(open(index_uri)), index_uri).each do |organisation_uri|
          y << [organisation_uri, scrape_contact_details(Nokogiri::HTML(open(organisation_uri)))]
        end
      end
    end
  end

  def scrape_text(node_set)
    node_set.text.strip
  end

  def scrape_heading(node_set)
    scrape_text node_set.css('.headingContainer span strong')
  end

  def scrape_value(node_set)
    node_set.css '.infoContainer span'
  end

  alias :scrape_name          :scrape_text
  alias :scrape_email_address :scrape_text
  alias :scrape_opening_hours :scrape_text

  def scrape_postal_address(node_set)
    node_set.xpath('text()').map(&:content)
  end

  def scrape_labelled_phone_numbers(node_set)
    node_set.xpath('text()').map do |node|
      [node.xpath('preceding-sibling::strong[1]').text.presence, node.text]
    end
  end

  def scrape_uri(node_set)
    URI.parse(scrape_text(node_set)).normalize.to_s
  end

  organisations.each do |uri, contact_details|
    puts "Scraping #{uri}..."
    attributes = {}

    contact_details.each do |contact_detail|
      heading = scrape_heading contact_detail
      value   = scrape_value contact_detail

      case heading
      when 'Contact point'
        attributes[:name] = scrape_name value
      when 'Address'
        attributes[:postal_address] = scrape_postal_address(value).join("\n")
      when *PHONE_NUMBER_KINDS.keys
        scrape_labelled_phone_numbers(value).each do |label, phone_number|
          (attributes[:phone_numbers_attributes] ||= []) << { kind: PHONE_NUMBER_KINDS[heading], label: label, value: phone_number }
        end
      when 'Email address'
        attributes[:email_address] = scrape_email_address value
      when 'Website (opens new window)'
        attributes[:website_url] = scrape_uri value
      when 'Opening Hours'
        attributes[:opening_hours] = scrape_opening_hours value
      else
        raise "Don't know what to do with #{heading}"
      end
    end

    if attributes.present?
      Contact.find_or_initialize_by_name(attributes[:name]).update_attributes! attributes
    else
      puts "WARNING: Couldn't find any contact details on #{uri}"
    end
  end
end
