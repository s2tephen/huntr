require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  # instead of testing the entire Listing.fetch function, which gets different results
  # each time it is called (since it only fetches "unread" emails), we test various aspects
  # of the fetch function


  # testing that the fetch a single email from Anne Hunter
  test "fetch a single email" do
    Mail.defaults do
      retriever_method :imap, { :address    => 'imap.gmail.com',
                                :port       => 993,
                                :user_name  => ENV['GMAIL_USERNAME'],
                                :password   => ENV['GMAIL_PASSWORD'],
                                :enable_ssl => true }
    end
    # checks to make sure email is from the proper sender
    assert_equal(Mail.first.sender, 'eecs-jobs-announce-bounces@lists.csail.mit.edu', 'ERROR: email was sent from wrong address') 
  end

  test "create listing from email" do
    m = Mail.new(subject: 'Event on 12/8 in 32-123 at 2pm', sender: 'eecs-jobs-announce-bounces@lists.csail.mit.edu', 
      parts: "Hello, this is the body.")

    # like in the Listing.filter method, checks to see if there is a valid date
    # in the subject line, and asserts the listing as an event if so
    is_event = false # is true if subject contains a valid date
    date = m.subject.match(/(?<= )\d{1,2}\/\d{1,2}/).to_s
    if date.empty?
      if m.subject.match(/today/i)
        date = Date.today.to_s
        is_event = true
      end
    else
      is_event = true
    end
    assert(is_event, "ERROR: this email is about an event")

    time = m.subject.match(/(?<= )(1?\d(?!\/)(?::\d{2})?(?!\d)\s?(?:am|pm)?)(\s?-\s?\d{1,2}(?::\d{2})?(?!\d)\s?(?:am|pm)?)?/i)
    # time[0] gets the start time
    assert_equal(time[0], '2pm', 'ERROR: this event happens at 2pm')

    # checks if there is a valid location in the subject line
    location = m.subject.match(/(?<= )[ENW]{0,2}\d{1,3}[A-G]?-\d{3,4}/).to_s
    if location.empty? # other location names
      ['Student Center', 'Kresge', 'Walker Memorial', 'Religious Activities Center',
       'Lobby 13', 'MIT Chapel', 'Lobby 10', 'Wong Auditorium', 'Stata'].each do |loc|
          location = m.subject.match(/#{loc}/).to_s unless m.subject.match(/#{loc}/).nil?
      end
    end
    assert_equal(location, '32-123', 'ERROR: this event is happening in 32-123')
  end
end
