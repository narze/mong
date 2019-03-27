require "mong/version"

module Mong
  class ParseError < StandardError; end

  def self.parse_minute(string)
    index = string.to_i

    raise ParseError if index < 0 || index >= 60

    times = %w[
      ศูนย์ หนึ่ง สอง สาม สี่ ห้า หก เจ็ด แปด เก้า
      สิบ สิบเอ็ด สิบสอง สิบสาม สิบสี่ สิบห้า สิบหก สิบเจ็ด สิบแปด สิบเก้า
      ยี่สิบ ยี่สิบเอ็ด ยี่สิบสอง ยี่สิบสาม ยี่สิบสี่ ยี่สิบห้า ยี่สิบหก ยี่สิบเจ็ด ยี่สิบแปด ยี่สิบเก้า
      สามสิบ สามสิบเอ็ด สามสิบสอง สามสิบสาม สามสิบสี่ สามสิบห้า สามสิบหก สามสิบเจ็ด สามสิบแปด สามสิบเก้า
      สี่สิบ สี่สิบเอ็ด สี่สิบสอง สี่สิบสาม สี่สิบสี่ สี่สิบห้า สี่สิบหก สี่สิบเจ็ด สี่สิบแปด สี่สิบเก้า
      ห้าสิบ ห้าสิบเอ็ด ห้าสิบสอง ห้าสิบสาม ห้าสิบสี่ ห้าสิบห้า ห้าสิบหก ห้าสิบเจ็ด ห้าสิบแปด ห้าสิบเก้า
    ]

    if time = times[index]
      time + "นาที"
    end
  end

  def self.parse_hour(string)
    index = string.to_i

    raise ParseError if index < 0 || index >= 24

    times = %w[
      เที่ยงคืน ตีหนึ่ง ตีสอง ตีสาม ตีส่ี ตีห้า หกโมง เจ็ดโมง แปดโมง เก้าโมง สิบโมง สิบเอ็ดโมง เที่ยง บ่ายโมง บ่ายสองโมง บ่ายสามโมง บ่ายสี่โมง บ่ายห้าโมง หกโมงเย็น
      หนึ่งทุ่ม สองทุ่ม สามทุ่ม สี่ทุ่ม ห้าทุ่ม
    ]

    times[index]
  end

  def self.parse_hour_and_minute(string)
    hour, minute = string.split(':')

    hour_out = parse_hour(hour)
    minute_out = parse_minute(minute)

    if !hour_out || !minute_out
      false
    else
      hour_out + minute_out
    end
  end

  def self.parse(time)
    string = time.strftime("%H:%M")

    parse_hour_and_minute(string)
  end
end
