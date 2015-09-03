# School Loop API


[![Build Status](https://travis-ci.org/webdestroya/school_loop.svg)](https://travis-ci.org/webdestroya/school_loop)


## Installation

Install the gem by issuing

```ruby
gem install school_loop
```

or put it in your Gemfile and run `bundle install`

```ruby
gem "school_loop"
```

## Configuration

These global settings will be used unless specifically overridden by an instance below.

```ruby
SchoolLoop.configure do |config|
  config.subdomain  = 'demoschool'
  config.username   = 'apiuser'
  config.password   = 'some_api_password'
  config.adapter    = :net_http
end
```

## Usage

Create a new client using the global defaults:

```ruby
school_loop = SchoolLoop.new
```

Create a new client instance and override global defaults

```ruby
school_loop = SchoolLoop.new subdomain: 'demoschool', username: 'apiuser', password: 'some_api_password'
```

Alternatively, you can configure the School Loop settings by passing a block:

```ruby
school_loop = SchoolLoop.new do |config|
  config.subdomain  = 'demoschool'
  config.username   = 'apiuser'
  config.password   = 'some_api_password'
  config.adapter    = :net_http
end
```


Currently, only three methods are implemented:

#### Get Entire School Roster

```ruby
roster = school_loop.get_roster
# returns a Nokogiri::XML::Document
```

#### Get Teacher Roster

```ruby
teacher_id = "12345"
roster = school_loop.get_roster(teacher_id)
# returns a Nokogiri::XML::Document (with a single 'teacher' node)
```

Example roster data is available on [School Loop's Documentation](http://www.schoolloop.com/about-us/partners/progress-report-api/progress-report-api-schema/#ProgressReportSchema-IVSampleSchoolLoopRosterDownload)

#### Posting Progress Reports

For a detailed schema for Progress reports, you can look at [School Loop's Progress Report API Schema](http://www.schoolloop.com/about-us/partners/progress-report-api/progress-report-api-schema/)

```ruby
prog_report_xml = <<-EOF
<?xml version="1.0" encoding="UTF-8"?>
<root>
  <sections>
    <section ID="1234">
      <progressReports>
        <progressReport markName="Current Grades" ... grade="A">
          ...
        </progressReport>
      </progressReports>
    </section>
  </sections>
</root>
EOF

school_loop.publish_progress_report(prog_report_xml)
```

## License
[MIT](http://opensource.org/licenses/MIT)

## Special Thanks
This gem is heavily based on the [bitbucket_rest_api](https://github.com/vongrippen/bitbucket) gem by Mike Cochran.
