require 'sprockets/sass_compressor'

# This is required because of this error:
#
#  Failure/Error: <%= stylesheet_link_tag "tailwind", "inter-font", "data-turbo-track": "reload" %>
#
#     ActionView::Template::Error:
#       Error: Function rgb is missing argument $green.
#              on line 1 of stdin
#       >> ay-200{--tw-border-opacity:1;border-color:rgb(229 231 235/var(--tw-border-op
#
# The fix is from this github thread:
# - https://github.com/tailwindlabs/tailwindcss/discussions/6738#discussioncomment-3456638
class Sprockets::SassCompressor
  TAILWIND_SEARCH = '--tw-'.freeze
  def call(*args)
    input = if defined?(data)
              data # sprockets 2.x
            else
              args[0][:data] # sprockets 3.x
            end

    return input if skip_compiling?(input) # added this line

    SassC::Engine.new(
      input,
      {
        style: :compressed
      }
    ).render
  end

  def skip_compiling?(body)
    body.include?(TAILWIND_SEARCH)
  end
end
