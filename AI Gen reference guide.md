# Rails Codebase Guide for Beginners

## 1️⃣ OVERVIEW: What Does This App Do?

**EB Gig Guide** is an event listing platform for live music performances. Users can:
- Browse upcoming gigs/concerts
- See past gigs
- Subscribe for updates
- Artists manage their acts and appearances
- Admin panel to manage gigs, venues, acts, and subscribers

---

## 2️⃣ CORE ARCHITECTURE

### Data Model (Database Relationships)

```
Gig (Event)
  ├── has_many :acts (through acts_gigs)
  └── belongs_to :venue (via venue string field)

Act (Performer/Band)
  ├── has_many :gigs (through acts_gigs)
  └── has the acts_gigs join table

Venue
  └── Fields only (no associations yet)

Subscriber
  └── Stores emails for updates

AnalyticsEvent
  └── Tracks user page views
```

### Key Files by Purpose

| Purpose | Files | What You'll Find |
|---------|-------|------------------|
| **Models (Business Logic)** | `app/models/*.rb` | Act, Gig, Venue, Subscriber classes—where database queries live |
| **Routes (URL Mapping)** | `config/routes.rb` | Maps URLs like `/gigs` to controller actions |
| **Controllers (Request Handlers)** | `app/controllers/*.rb` | GigsController, SubscribersController—processes requests |
| **Views (HTML Templates)** | `app/views/` | ERB files that render the web pages |
| **Database** | `db/schema.rb` | Current database structure (auto-generated) |
| **Migrations (DB Changes)** | `db/migrate/` | Each file is a database change (add column, create table, etc.) |
| **Admin Configs** | `app/dashboards/*.rb` | Administrate gem configurations for admin panel |
| **Tests** | `spec/` | RSpec tests + FactoryBot factories for creating test data |

---

## 3️⃣ NAVIGATING THE CODEBASE

### Finding Where Something Happens

**Q: "I want to change what shows on the gigs list page"**
- Start: `config/routes.rb` → Find `GET /gigs` → maps to `GigsController#index`
- Go to: `app/controllers/gigs_controller.rb` → Look at `index` method
- Then: `app/views/gigs/index.html.erb` → Edit the template
- Check: `app/models/gig.rb` → if you need to add query logic

**Q: "How do I add a new field to gigs?"**
1. Create migration: `rails generate migration AddFieldToGigs field_name:type`
2. Edit: `db/migrate/[timestamp]_add_field_to_gigs.rb`
3. Run: `rails db:migrate`
4. Update: `app/models/gig.rb` (if needed for validations)
5. Update: Views in `app/views/gigs/` and admin dashboard `app/dashboards/gig_dashboard.rb`

**Q: "How do I add a new admin feature?"**
- Create/edit dashboard: `app/dashboards/*.rb` (Administrate configuration)
- Exists at: `localhost:3000/admin/[resource_name]`

### Important Patterns to Know

**Model Methods Example** (`app/models/gig.rb`):
```ruby
class Gig < ApplicationRecord
  # Associations
  has_many :acts_gig
  has_many :acts, through: :acts_gig

  # Custom methods (like doors_time_only)
  def doors_time_only
    doors&.strftime('%l:%M%P')  # Formats time for display
  end
end
```

**Controller Example** (`app/controllers/gigs_controller.rb`):
- `index` → show list of all gigs
- `show` → show details of one gig
- `past` → custom action for past gigs

**Views Use Helpers**:
- `app/helpers/gigs_helper.rb` → can add custom view methods
- Use in templates: `<%= helper_method_name %>`

---

## 4️⃣ IMPORTANT NOTES FOR DEVELOPMENT

### Dev Database Setup
- **Development**: Uses SQLite (`db/development.sqlite3`)
- **Test**: Uses SQLite (`db/test.sqlite3`) — automatically prepared before tests
- **Production**: Uses PostgreSQL

### Data Type Gotcha ⚠️
The `date` field in Gig has special handling in `app/models/gig.rb`:
```ruby
def date
  # Dev (SQLite) stores as string, Prod (PostgreSQL) as datetime
  return Date.parse(self[:date]) if self[:date].is_a?(String)
  self[:date]
end
```
**Why this matters**: If you query gigs by date, use the `date` method, not `self[:date]`

### Administrate Admin Panel
The app uses the Administrate gem for `/admin` dashboard:
- Each resource has a dashboard class: `app/dashboards/*_dashboard.rb`
- Configs define which columns show, search fields, filters, etc.
- Don't edit routes for admin—Administrate auto-generates them

### Tailwind CSS
- Configured in `config/tailwind.config.js`
- Styles defined inline on elements: `class="bg-blue-500 p-4"`
- Development watcher: `bin/rails tailwindcss:watch`

---

## 5️⃣ HOW TO TEST YOUR CHANGES LOCALLY

### Quick Start: Running the App

```bash
# 1. First time setup
bundle install            # Install gems
rails db:create          # Create development database
rails db:migrate         # Run all migrations
rails db:seed            # Load seed data (if seeds.rb has content)

# 2. Start development server (runs Rails + Tailwind together)
bin/dev

# Open browser to: http://localhost:3000
```

### Running Tests

```bash
# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/models/gig_spec.rb

# Run with verbose output
bundle exec rspec --format documentation

# Run tests matching a pattern
bundle exec rspec --pattern "gig"
```

### Test Setup Steps

```bash
# Prepare test database (Rails does this automatically)
rails db:test:prepare

# Create test data using FactoryBot in your test
# Example in a spec file:
# factory :gig, class: Gig do
#   name { "Test Gig" }
#   date { Date.tomorrow }
# end
```

### Common Testing Patterns

**In `spec/models/gig_spec.rb`:**
```ruby
require 'rails_helper'

describe Gig, type: :model do
  # Create test data
  let(:gig) { FactoryBot.create(:gig) }
  
  # Test relationships
  it { is_expected.to have_many(:acts).through(:acts_gig) }
  
  # Test methods
  it 'formats doors time correctly' do
    gig.doors = Time.parse("14:30")
    expect(gig.doors_time_only).to eq("2:30pm")
  end
end
```

**In `spec/features/` (end-to-end browser tests):**
```ruby
require 'rails_helper'

feature 'User views gigs' do
  scenario 'sees list of upcoming gigs' do
    gig = FactoryBot.create(:gig, name: "Concert")
    visit gigs_path
    expect(page).to have_content("Concert")
  end
end
```

### Debugging

```bash
# Print to console in tests
puts gig.inspect
p acts.map(&:name)

# Use byebug for interactive debugging (in gem Gemfile)
# In your code: byebug  # execution pauses, you can inspect variables

# Check what SQL is being generated
gig.acts.to_sql  # Shows the SQL query
```

### Test Database Gotchas

- **Test database is wiped between test runs** (configured in `rails_helper.rb`)
- **Each test starts with clean state** (no test data from manual test carries over)
- **Factories create data**: Check `spec/factories/` to see available factories
  - Example: `FactoryBot.create(:gig)` creates a gig with defaults

### Development Workflow

**Typical flow for making a change:**

```bash
# 1. Make code changes in your editor

# 2. If you added/removed columns:
rails generate migration DescribeYourChange
# Edit the migration file, then:
rails db:migrate

# 3. Run tests for that feature
bundle exec rspec spec/models/gig_spec.rb -v

# 4. Test in browser
# App auto-reloads on file changes (no restart needed)

# 5. If all green, commit!
git add .
git commit -m "Brief description of change"
```

---

## 6️⃣ COMMAND REFERENCE

| Command | What It Does |
|---------|---|
| `bin/dev` | Start Rails server + Tailwind watcher (port 3000) |
| `rails s` or `rails server` | Start Rails server only |
| `bundle install` | Install/update gems from Gemfile |
| `rails db:migrate` | Run pending database migrations |
| `rails db:rollback` | Undo last migration |
| `rails generate model Name field:type` | Generate a new model with migration |
| `rails generate migration AddColumnToTable col:type` | Create migration only |
| `bundle exec rspec` | Run all tests |
| `bundle exec rspec spec/models/gig_spec.rb` | Run one test file |
| `rails console` | Interactive Ruby prompt with app loaded |
| `rails routes` | List all routes |

---

## 7️⃣ WHERE TO LOOK FIRST (By Task Type)

| I want to... | Look here |
|---|---|
| Add a gig field | `app/models/gig.rb`, `app/dashboards/gig_dashboard.rb`, view files in `app/views/gigs/` |
| Change the gig display | `app/views/gigs/` (templates) + `app/controllers/gigs_controller.rb` (logic) |
| Add validation (e.g., required field) | `app/models/gig.rb` (add `validates :field, presence: true`) |
| Add a new admin feature | `app/dashboards/*_dashboard.rb` (Administrate config) |
| Connect a gig to a new resource | `app/models/gig.rb` (add association) + migrate database + update controller/view |
| Write a test | `spec/models/`, `spec/features/`, `spec/factories/` (for test data) |
| Fix styling | `app/views/` files (add Tailwind classes) or `config/tailwind.config.js` |

---

## 8️⃣ RAILS CONCEPTS FOR BEGINNERS

### Model ← Controller → View (MVC)

```
User visits /gigs 
  ↓
Router finds config/routes.rb: GET /gigs → gigs#index
  ↓
GigsController#index (app/controllers/gigs_controller.rb)
  Runs: @gigs = Gig.all
  ↓
Renders: app/views/gigs/index.html.erb with @gigs data
  ↓
Browser displays HTML
```

### ActiveRecord (Database ORM)

```ruby
# Instead of writing SQL, you use Ruby methods:
Gig.all                    # SELECT * FROM gigs
Gig.where(venue: 'Club X') # SELECT * FROM gigs WHERE venue = 'Club X'
gig.acts                   # Automatic SQL join via association
gig.save                   # INSERT or UPDATE
gig.destroy                # DELETE
```

### Migrations (Schema Changes)

```ruby
# Each migration is a timestamped file
# They're applied in order:
rails db:migrate           # Runs up to the latest
rails db:rollback          # Undoes the last one
```

### ActionView Helpers (View Methods)

```erb
<!-- In app/views/gigs/show.html.erb -->
<%= gig.name %>                    <!-- Outputs gig.name -->
<%= link_to "Edit", edit_gig_path(gig) %>  <!-- Creates <a> tag -->
<%= form_with(model: gig) do |f| %>  <!-- Creates form -->
  <%= f.text_field :name %>         <!-- Creates input field -->
<% end %>
```

---

## 9️⃣ NEXT STEPS

1. **Explore the app**: `bin/dev` and click around at `http://localhost:3000`
2. **Read a model**: Open `app/models/gig.rb` and understand the relationships
3. **Find routes**: Run `rails routes | grep gig` to see URL patterns
4. **Write a test**: Copy `spec/models/gig_spec.rb` pattern, modify it
5. **Make a small change**: Add a field, run tests, see it work

---

**Questions?** Check the Rails Guides: https://guides.rubyonrails.org/
