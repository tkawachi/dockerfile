#!/usr/bin/env ruby
# coding: utf-8

# Environmental variables (for aws-cli)
# See. https://github.com/aws/aws-cli
#
# AWS_ACCESS_KEY_ID: access key
# AWS_SECRET_ACCESS_KEY: secret key
# AWS_CONFIG_FILE: credential file
#
# Environmental variables (others)
# AWS_CMD: aws-cli command

require 'json'

class CloudWatchAlert
  def initialize(aws_command)
    @aws_command = aws_command
  end

  def send_notifications
    each_sns_destination do |action, entry|
      message = "#{entry['StateValue']}: #{entry['AlarmName']}"
      # single quote があると面倒なので抜いておく
      message.gsub!("'", '')
      `#{@aws_command} sns publish --message '#{message}' --subject '#{message}' --topic-arn #{action}`
    end
  end

  def all_alarms
    @all_alarms ||= begin
      output = `#{@aws_command} cloudwatch describe-alarms`
      JSON.parse(output)['MetricAlarms']
    end
  end

  def enabled_alarms
    all_alarms.select { |entry| entry['ActionsEnabled'] }
  end

  def with_state(state)
    enabled_alarms.select { |e| e['StateValue'] == state.to_s }
  end

  private
  def each_sns_destination(&block)
    [%w(ALARM AlarmActions), %w(INSUFFICIENT_DATA InsufficientDataActions)].each do |state_value, action_key|
      with_state(state_value).each do |entry|
        (entry[action_key] || []).each do |action|
          next unless action.start_with?('arn:aws:sns:')
          block.call(action, entry)
        end
      end
    end
  end
end

if __FILE__ == $0
  ENV['LC_ALL'] = 'C'
  alert = CloudWatchAlert.new(ENV['AWS_CMD'] || 'aws')
  alert.send_notifications
end
