require 'date'
require 'time'

class YearCounter
  MONTH_STATES = {
    dec: :nov,
    nov: :oct,
    oct: :sep,
    sep: :aug,
    aug: :jul,
    jul: :jun,
    jun: :may,
    may: :apr,
    apr: :mar,
    mar: :feb,
    feb: :jan,
    jan: :dec
  }

  def initialize(year, month)
    @year = year
    @month = month&.to_sym
  end

  def next_month(month)
    if @month.nil?
      @month = month.to_sym
      return
    end

    return unless MONTH_STATES[@month] == month.to_sym

    @year -= 1 if @month == :jan

    @month = month.to_sym
  end

  def year_for_month(month)
    if @month == :dec && month.to_sym == :jan
      @year - 1
    else
      @year
    end
  end
end

year_counter = YearCounter.new(2023, nil)
year = 2023
day = nil
month = nil
name = []
venue = nil
socials = []
starts_at = nil
ends_at = nil
is_am = nil

gigs = []

File.readlines('raw.txt').each do |line|
  case line
  when /^(MON|Mon)/, /^(TUES|Tues|TUE|Tue)/, /^(WED|Wed)/, /^(THU|Thu|THUR|Thur|THURS|Thurs)/, /^(FRI|Fri)/, /^(SAT|Sat)/, /^(SUN|Sun)/
    day, month = line.split(' ').drop(1)
    day = day.sub(/(TH|th|st|nd|rd)/, '')
    month = month.downcase
    year_counter.next_month(month)
    year = year_counter.year_for_month(month)
  when "\n"
    if name.size > 0 && venue
      meridian = if !is_am.nil?
                   if is_am == true
                     'am'
                   else
                     'pm'
                   end
                 else
                   ''
                 end
      gigs.append({
                    name: name.join.strip,
                    venue: venue.strip,
                    socials: socials.join(', '),
                    date: DateTime.parse("#{day} #{month} #{year}"),
                    doors: starts_at ? Time.parse(starts_at.sub('.', ':') + meridian) : nil,
                    ends_at: ends_at ? Time.parse(ends_at.sub('.', ':') + meridian) : nil
                  })
    end
    name = []
    venue = nil
    socials = []
    starts_at = nil
    ends_at = nil
    is_am = nil
  when /^[0-9]{1,2}(\.[0-9]{2})?(-[0-9]{1,2}(\.[0-9]{2})?)?(a|p)m/
    venue ||= name.pop
    is_am = line.include? 'am'

    starts_at, ends_at = line.gsub(/(a|p)m/, '').split(' ').first.split('-')
    ends_at = nil if ends_at == 'late'
  when /^@/
    venue ||= name.pop
    socials.append(line.strip)
  else
    name.append(line.sub("\n", ' '))
  end
end

require 'csv'

CSV.open('gigs.csv', 'w', headers: gigs.first.keys) do |csv|
  gigs.each do |gig|
    csv << gig.values
  end
end
