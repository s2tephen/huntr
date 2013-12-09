# Teamwork
## Stakeholders

* **MIT Community** - These are our “users.”  They are the main beneficiaries of this project.  They will use Huntr to easily browse eecs-jobs-announce emails and to add events to their own calendars.
* **Anne Hunter** -  She is the liaison between sponsors and the MIT community, responsible for communicating information.  For Project Huntr, she is the source of information.
* **Sponsors** - They are people who have announcements they wish to communicate to the MIT community through Anne Hunter.  Sponsors include companies and campus organizations looking to publicize events and opportunities, professors and graduate students looking for UROP students and TAs, course administrators looking to publicize courses, and anyone else looking to publicize events or opportunities.

## Resources
### Computational constraints

* Running our parser and creating a listing out of an email
* Supporting search and filter on all the emails

### Cost constraints

* Space: How many and how much (i.e. what content) of each email we want to store
* Database: Heroku limits 10,000 rows

### Time constraints

* Learning to use gems (treat, devise, mail, textacular, simpleform)
* Processing: Email from Anne Hunter --> Mailman --> Gmail --> Huntr (many machines along process)
* Efficiency in querying and filtering listings

## Tasks
See tasks list [here](https://docs.google.com/spreadsheet/ccc?key=0AorjNO4_rSvxdEs2cEp4ajlWSVZrdDhEUVRQUHFDa1E).

## Risks
### Security

* Email server crashes  
  → Retroactive updating after server failure (can show last update time)

* Spam sent to the email that receives Anne Hunter’s email  
  → Filtering on app side

* Email gets hacked  
  → Notify admin / back-up email

* Unauthorized access  
  → Require user registration with @mit address

### Implementation

* We have too many emails to process efficiently and quickly  
  → Use models (“Filters”) to help us build cleanly and quickly query for emails

* Have a limited range of emails to test on  
  → Start collection early and use old emails

* Anne Hunter sends from a different email address or someone else takes over her job  
  → Quick fix in Gmail filter.

### Design

* Listing protocol is too strict or unspecific, so emails aren't parsed accurately  
  → Carefully select which attributes/keywords are most important for the parser to parse. Also decide which categories are best to sort emails into. May have to manually edit/fix typos.

## Minimum Viable Product (MVP)
### Subset of features to be included

* **User authentication.** Users will be able to sign up & log in with their @mit.edu emails.
* **Up-to-date feed.** Huntr will display a feed of Anne Hunter’s recent emails. 
* **Search.** Huntr will allow users to perform text search of the active listings. 
* **Basic Statistic.** Huntr will show a single statistic (# of email sent today).

### Issues postponed
* **Filtering.** Users will be able to filter the listings by predetermined categories.
* **Calendar view.** Huntr will contain a calendar with all of the event listings.
* **Calendar export.** Huntr will be able to export listings as events to calendars such as Google Calendar and iCal.
* **Vaorites & Notifications.** Huntr will let users favorite listings and notify visually if the listings they have subscribed to have been updated.
* **Huntr statistics.** Huntr will display interesting statistics about Anne Hunter’s emails at the bottom of the page.


## Team Contract
see contract [here](https://docs.google.com/document/d/1GRtc1o18b_x63Y_GO6GwKTbj-nyYCq7IRZHIs9lGkWQ/edit?usp=drive_web)

## Meetings
see meeting agenda and minutes [here](https://drive.google.com/?tab=mo&authuser=0#folders/0B4rjNO4_rSvxQThweVNCczB4Vnc)
Progress report are located together with tasks [here](https://docs.google.com/spreadsheet/ccc?key=0AorjNO4_rSvxdEs2cEp4ajlWSVZrdDhEUVRQUHFDa1E&usp=drive_web#gid=0)
