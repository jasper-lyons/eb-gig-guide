# frozen_string_literal: true
# Bootstraps Venue records from the legacy string-based venue field on Gig.
# Run with: bin/rails runner bootstrap_venues.rb

VENUE_ALIASES = {
  # Aqua Bar
  "The Aqua Bar, Pevensey" => "The Aqua Bar",
  "Aqua Bar"               => "The Aqua Bar",

  # All Saints Church
  "All Saints Church" => "All Saints Church",

  # Alexandra Arms
  "The Alexandra Arms" => "The Alexandra Arms",
  "Alexandra Arms"     => "The Alexandra Arms",

  # Bad Habit Studios
  "Bad Habit Studios" => "Bad Habit Studios",

  # Bandstand
  "Bandstand"     => "The Bandstand",
  "The Bandstand" => "The Bandstand",

  # Bankers Corner
  "Bankers Corner" => "Bankers Corner",

  # Bar Blue
  "Bar Blue" => "Bar Blue",
  "Blue Bar"  => "Bar Blue",

  # Beerarama
  "Beerarama" => "Beerarama",

  # Belgian Cafe
  "Belgian Cafe"     => "The Belgian Cafe",
  "The Belgian Cafe" => "The Belgian Cafe",

  # Bibendum
  "Bibendum" => "Bibendum",

  # The Bohemian
  "The Bohemian" => "The Bohemian",

  # British Queen
  "British Queen"     => "The British Queen",
  "The British Queen" => "The British Queen",

  # Buskers
  "Buskers"     => "Buskers",
  "Buskers Bar" => "Buskers",

  # The Castle Inn Pevensey
  "The Castle Inn, Pevensey"     => "The Castle Inn Pevensey",
  "The Castle Inn, Pevensey Bay" => "The Castle Inn Pevensey",
  "Castle Inn Pevensey"          => "The Castle Inn Pevensey",
  "The Castle Inn Pevensey Bay"  => "The Castle Inn Pevensey",
  "Castle Inn, Pevensey Bay"     => "The Castle Inn Pevensey",
  "Castle Inn, Pevensey"         => "The Castle Inn Pevensey",
  "The Castle Inn Pevensey"      => "The Castle Inn Pevensey",

  # Cavendish Hotel
  "The Cavendish Hotel" => "The Cavendish Hotel",

  # Community Wise
  "Community Wise" => "Community Wise",

  # Congress Theatre
  "Conress Theatre"  => "Congress Theatre",
  "Congress Theatre" => "Congress Theatre",

  # The Crown & Anchor
  "Crown and Anchor"              => "The Crown & Anchor",
  "The Crown & Anchor"            => "The Crown & Anchor",
  "The Crown and Anchor"          => "The Crown & Anchor",
  "Upstairs @ The Crown & Anchor" => "The Crown & Anchor",
  "The Crown & Anchor (upstairs)" => "The Crown & Anchor",

  # The Crown Old Town (separate venue from The Crown & Anchor)
  "The Crown Old Town"    => "The Crown Old Town",
  "The Crown, Old Town"   => "The Crown Old Town",
  "@thecrowneastbourne"   => "The Crown Old Town",
  "The Crown"             => "The Crown Old Town",

  # Dawson's Wine Bar
  "Dawson's Wine Bar" => "Dawson's Wine Bar",

  # Dem Shish
  "Dem Shish" => "Dem Shish",

  # Devonshire Park Theatre
  "Devonshire Park Theatre" => "Devonshire Park Theatre",
  "Devonshire Theatre"      => "Devonshire Park Theatre",

  # The Dolphin
  "The Dolphin" => "The Dolphin",
  "The Dophin"  => "The Dolphin",

  # Drop In The Ocean
  "Drop In The Ocean"  => "Drop In The Ocean",
  "Drop in the Ocean"  => "Drop In The Ocean",

  # The Eagle
  "The Eagle" => "The Eagle",

  # Eastern Seafront
  "Eastern Seafront"             => "Eastern Seafront",
  "Princes Park | Eastern Seafront" => "Eastern Seafront",

  # Eastbourne & District Trade Union Club
  "TUC Club"                                  => "Eastbourne & District Trade Union Club",
  "Eastbourne and District Trade Union Club"  => "Eastbourne & District Trade Union Club",
  "Eastbourne & District Trade Union Club"    => "Eastbourne & District Trade Union Club",

  # Eastbourne Angling Club
  "Eastbourne Angling Club"       => "Eastbourne Angling Club",
  "Eastbourne Angling Association" => "Eastbourne Angling Club",
  "The Angling Club"               => "Eastbourne Angling Club",

  # Eastbourne Borough Football Club
  "Eastbourne Borough Football Club" => "Eastbourne Borough Football Club",
  "Eastbourne Borough FC "           => "Eastbourne Borough Football Club",
  "Eastbourne Borough FC"            => "Eastbourne Borough Football Club",

  # Eastbourne College Theatre
  "Eastbourne College Theatre" => "Eastbourne College Theatre",

  # Eastbourne Riviera Hotel
  "Eastbourne Riviera Hotel" => "Eastbourne Riviera Hotel",

  # Eastbourne Town Hall
  "Eastbourne Town Hall" => "Eastbourne Town Hall",

  # Eastbourne Working Men's Club
  "Eastbourne Working Mens Club"   => "Eastbourne Working Men's Club",
  "Eastbourne Working Men's Club"  => "Eastbourne Working Men's Club",

  # El Changarro
  "El Changarro" => "El Changarro",

  # The Emerald Bar
  "The Emerald Bar" => "The Emerald Bar",

  # The Farm Friday Street
  "The Farm Friday Street"                    => "The Farm Friday Street",
  "The Farm, Friday Street"                   => "The Farm Friday Street",
  "The Farm Friday Street Pub & Restaurant"   => "The Farm Friday Street",

  # The Fishermens Club
  "The Fishermens"      => "The Fishermens Club",
  "The Fishermens Club" => "The Fishermens Club",

  # The Garden Bar
  "The Garden Bar" => "The Garden Bar",
  "Garden Bar"     => "The Garden Bar",

  # Gildredge Park
  "Gildredge Park" => "Gildredge Park",

  # Grove Road
  "Grove Road"              => "Grove Road",
  "Grove Road / South Street" => "Grove Road",

  # The Grove Theatre
  "The Grove Theatre "  => "The Grove Theatre",
  "The Grove Theatre"   => "The Grove Theatre",
  "Grove Theatre "      => "The Grove Theatre",

  # The Box @ Grove Theatre (separate room within the same building)
  "THE BOX @ Grove Theatre"            => "The Box @ Grove Theatre",
  "The Box @ Grove Theatre"            => "The Box @ Grove Theatre",
  "The Box @ The Grove Theatre"        => "The Box @ Grove Theatre",
  "THE BOX @ Grove Theatre Eastbourne" => "The Box @ Grove Theatre",

  # Hampden Park
  "Hampden Park" => "Hampden Park",

  # HMV
  "HMV" => "HMV",

  # Jesters
  "Jesters"                  => "Jesters",
  "Jesters Bar"              => "Jesters",
  "Jesters Sports & Music Bar" => "Jesters",

  # Joy Bar
  "Joy Bar" => "Joy Bar",

  # Kings Centre
  "Kings Center" => "Kings Centre",
  "Kings Centre" => "Kings Centre",

  # La Locanda Del Duca
  "La Locanda Del Duca" => "La Locanda Del Duca",

  # The Lamb Inn
  "The Lamb Inn (upstairs)" => "The Lamb Inn",
  "The Lamb Inn | Old Town" => "The Lamb Inn",
  "The Lamb Inn"            => "The Lamb Inn",
  "The Lamb"                => "The Lamb Inn",

  # Langham Hotel
  "Langham Hotel | Eastbourne" => "The Langham Hotel",

  # Langney Sports Club
  "Langley Sports Club" => "Langney Sports Club",
  "Langney Sports Club" => "Langney Sports Club",

  # The Lansdowne
  "The Lansdowne" => "The Lansdowne",

  # Leaf Hall
  "Leaf Hall" => "Leaf Hall",

  # The Little Big Top in Helen Gardens
  "The Little Big Top in Helen Gardens" => "The Little Big Top in Helen Gardens",

  # The Martello Inn
  "The Martello"     => "The Martello Inn",
  "The Martello Inn" => "The Martello Inn",

  # Meads Parish Hall
  "Meads Parish Hall" => "Meads Parish Hall",

  # Ninkaci
  "Ninkaci Eastbourne" => "Ninkaci",
  "Ninkaci"            => "Ninkaci",

  # The Pavilion
  "The Pavillion" => "The Pavilion",

  # The Perch Cafe
  "The Perch Cafe (Princes Park)" => "The Perch Cafe",

  # The Pilot Inn
  "The Pilot Inn" => "The Pilot Inn",

  # The Prince Albert
  "The Prince Albert"     => "The Prince Albert",
  "The Prince Albert Pub" => "The Prince Albert",

  # The Printers Playhouse
  "Printer Playhouse"      => "The Printers Playhouse",
  "Printers Playhouse"     => "The Printers Playhouse",
  "The Printers Playhouse" => "The Printers Playhouse",

  # Pur-Pulse
  "Purpulse"                       => "Pur-Pulse",
  "Pur-pulse"                      => "Pur-Pulse",
  "Pur-Pulse"                      => "Pur-Pulse",
  "Pur Pulse"                      => "Pur-Pulse",
  "Pur-Pulse "                     => "Pur-Pulse",
  "Pur-Pulse @ The Belgian Cafe"   => "Pur-Pulse",
  "Pur Pulse (The Belgian Cafe)"   => "Pur-Pulse",

  # Racquet Studios
  "Racquet Studios" => "Racquet Studios",

  # The Railway Club
  "The Railway Club" => "The Railway Club",

  # The Red Lion Stone Cross
  "The Red Lion | Stone Cross"  => "The Red Lion Stone Cross",
  "The Red Lion Stone Cross"    => "The Red Lion Stone Cross",
  "Red Lion Stone Cross"        => "The Red Lion Stone Cross",
  "Red Lion, Stone Cross"       => "The Red Lion Stone Cross",
  "The Red Lion, Stone Cross"   => "The Red Lion Stone Cross",

  # The Red Lion Willingdon
  "The Red Lion Willingdon "   => "The Red Lion Willingdon",
  "Red Lion Willingdon"        => "The Red Lion Willingdon",
  "The Red Lion | Willingdon"  => "The Red Lion Willingdon",
  "The Red Lion, Willingdon"   => "The Red Lion Willingdon",
  "The Red Lion Willingdon"    => "The Red Lion Willingdon",

  # The Rodmill
  "The Rodmill" => "The Rodmill",

  # The Royal Hippodrome
  "Royal Hippodrome"            => "The Royal Hippodrome",
  "The Royal Hippodrome Theatre" => "The Royal Hippodrome",
  "The Royal Hippodrome"        => "The Royal Hippodrome",

  # The Seven Sisters
  "The Seven Sisters"                       => "The Seven Sisters",
  "The Seven Sisters Pub | Lower Willingdon" => "The Seven Sisters",
  "Seven Sisters Willingdon"                => "The Seven Sisters",

  # The Ship Inn
  "The Ship Inn" => "The Ship Inn",

  # The Sports Bar at EBFC
  "The Sports Bar @ EBFC" => "The Sports Bar at EBFC",
  "The Sports Bar"        => "The Sports Bar at EBFC",

  # The Stage Door
  "The Stage Door" => "The Stage Door",

  # The Star Inn
  "The Star Inn, Old Town" => "The Star Inn",
  "The Star Inn Old Town"  => "The Star Inn",
  "The Star Inn"           => "The Star Inn",

  # St. Saviour's Church
  "St. Saviour's Eastbourne" => "St. Saviour's Church",

  # Taylors
  "Taylors"                          => "Taylors",
  "Taylors Sports Bar"               => "Taylors",
  "Taylors Restaurant and Sports Bar" => "Taylors",
  "Taylors Restaurant & Sports Bar"  => "Taylors",

  # The Temple Bar
  "The Temple Bar" => "The Temple Bar",
  "The Temple"     => "The Temple Bar",

  # That Coffee Place
  "That Coffee Place" => "That Coffee Place",

  # The Townhouse
  "The Townhouse"  => "The Townhouse",
  "The Town House" => "The Townhouse",

  # The Underground Theatre
  "Underground Theatre"       => "The Underground Theatre",
  "The Underground Theatre"   => "The Underground Theatre",
  "Under Ground Theatre"      => "The Underground Theatre",
  "The Under Ground Threatre" => "The Underground Theatre",

  # Victoria Baptist Church
  "Victoria Baptist Church" => "Victoria Baptist Church",

  # The Victoria Hotel
  "The Victoria Hotel" => "The Victoria Hotel",

  # Victoria Place Pop Up Park
  "Victoria Place Pop Up Park"    => "Victoria Place Pop Up Park",
  "Pop-up Park | Victoria Place"  => "Victoria Place Pop Up Park",

  # The Vinyl Frontier
  "Vinyl Frontier Bar"  => "The Vinyl Frontier",
  "The Vinyl Frontier"  => "The Vinyl Frontier",
  "The Frontier Bar"    => "The Vinyl Frontier",

  # Welcome Building
  "Welcome Building" => "Welcome Building",

  # The Wheatsheaf Inn
  "The Wheatsheaf Inn | Willingdon" => "The Wheatsheaf Inn",
  "The Wheatsheaf"                  => "The Wheatsheaf Inn",

  # The Windsor Tavern
  "The Windsor Tavern" => "The Windsor Tavern",
  "Windsor Tavern"     => "The Windsor Tavern",

  # The Winter Garden
  "The Winter Garden" => "The Winter Garden",
  "Winter Garden"     => "The Winter Garden",

  # Wish Tower Slopes
  "Wish Tower Slopes" => "Wish Tower Slopes",

  # Western Lawns
  "Western Lawns" => "Western Lawns",
}.freeze

canonical_names = VENUE_ALIASES.values.uniq.sort
puts "Creating #{canonical_names.count} canonical venues..."

venues_by_name = {}
canonical_names.each do |name|
  venue = Venue.find_or_create_by!(name: name)
  venues_by_name[name] = venue
  puts "  [#{venue.id}] #{venue.name}"
end

puts "\nLinking gigs to venues..."

linked = 0
already_linked = 0
skipped = 0
unmapped = []

Gig.find_each do |gig|
  raw = gig.venue&.strip
  next if raw.blank?

  canonical = VENUE_ALIASES[raw]

  if canonical.nil?
    unmapped << raw unless unmapped.include?(raw)
    skipped += 1
    next
  end

  venue = venues_by_name[canonical]

  if gig.venue_id == venue.id
    already_linked += 1
  else
    gig.update_column(:venue_id, venue.id)
    linked += 1
  end
end

puts "\nResults:"
puts "  Linked:         #{linked}"
puts "  Already linked: #{already_linked}"
puts "  Skipped:        #{skipped}"

if unmapped.any?
  puts "\nUnmapped venue strings (add these to VENUE_ALIASES):"
  unmapped.sort.each { |v| puts "  #{v.inspect}" }
end
