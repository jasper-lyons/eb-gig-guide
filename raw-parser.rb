require 'date'
require 'time'
year = 2023
day = nil
month = nil
previous_month = nil
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
    year -= 1 if month != previous_month && month == 'dec' && previous_month == 'jan'
    previous_month = month
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
