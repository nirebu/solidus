# frozen_string_literal: true

ActiveRecord::Base.transaction do
  Spree::Country.where.not(iso: 'IT').each do |country|
    carmen_country = Carmen::Country.coded(country.iso)
    next unless carmen_country.subregions?

    carmen_country.subregions.each do |subregion|
      Spree::State.where(abbr: subregion.code, country: country).first_or_create!(
        name: subregion.name
      )
    end
  end
  Spree::Country.where(iso: 'IT').each do |country|
    carmen_country_with_provinces = Carmen::Country.coded(country.iso)
    next unless carmen_country_with_provinces.subregions?

    carmen_country_with_provinces.subregions.each do |subregion|
      subregion.subregions.each do |province|
        Spree::State.where(abbr: province.code, country: country).first_or_create!(
          name: province.name
        )
      end
    end
  end
end
