namespace :parse do
  desc "Parse data from the website and save it to the database"
  task :services_data => :environment do
   
    require 'open-uri'
    require 'nokogiri'
    
    html = URI.open('https://www.nerdwallet.com/article/small-business/service-business-ideas').read
    doc = Nokogiri::HTML(html)
    
    current_h2 = nil
    first_h2_processed = false
    
    doc.traverse do |node|
      h2Header = node.name == 'h2' && node['class'] == '_3P4ktl zeCuXk DFVVwC _1My7YX'
      h3Header = node.name == 'h3' && node['class'] == '_21EZtY eHXiWO _3_uGsM DFVVwC _1My7YX'

      if h2Header || h3Header
        if !first_h2_processed
          first_h2_processed = true
          next
        end
        current_h2 = node.text.strip
      end
    
      if node.name == 'ol' && node.at_css('span') && current_h2
        list_content = node.css('span.DFVVwC._3-to_p').map(&:text)
        list_content.each do |item|
          difficulty = Difficulty.find_or_create_by(title: "Medium")
          difficulty.save!
          service = Service.find_or_create_by(title: item.strip, service_type: current_h2, difficulty: Difficulty.first)
          if service.persisted?
            puts "Service #{service.title} created successfully"
          else
            puts "Failed to create service: #{service.errors.full_messages.join(', ')}"
          end
        end
        current_h2 = nil
      end
    end
  end
end


  # namespace :add do
  #   desc "Add data to specialization"
  #   task :specialization_data => :environment do
  #     Specialization.find_or_create_by(title: "Tutor")
  #     Specialization.find_or_create_by(title: "Locksmith")
  #     Specialization.find_or_create_by(title: "Cook")
  #   end
  # end

  namespace :add do
    desc "Add data to specialization"
    task :specialization_data => :environment do
      titles = ["Tutor", "Locksmith", "Cook"]
      successes = 0
  
      titles.each do |title|
        specialization = Specialization.find_or_create_by(title: title)
        if specialization.persisted?
          successes += 1
        else
          puts "Failed to add specialization: #{title}"
        end
      end
  
      if successes == titles.length
        puts "Specializations added successfully"
      else
        puts "Some specializations failed to add"
      end
    end
  end

  
  namespace :add do
    desc "Add data to urgency"
    task :urgency_data => :environment do
      titles = ["Critical", "Urgent", "Normal", "Non-urgent"]
      successes = 0
  
      titles.each do |title|
        urgency = Urgency.create(title: title)
        if urgency.persisted?
          successes += 1
        else
          puts "Failed to add urgency: #{title}"
        end
      end
  
      if successes == titles.length
        puts "Urgencies added successfully"
      else
        puts "Some urgencies failed to add"
      end
    end
  end

  
  # namespace :add do
  #   desc "Add data to comment"
  #   task :comment_data => :environment do
  #     contents = ["Hello1", "Hello2", "Hello3", "Hello4"]
  #     successes = 0
  
  #     contents.each do |content|
  #       comment = Comment.create(content: content)
  #       if comment.persisted?
  #         successes += 1
  #       else
  #         puts "Failed to add comment: #{content}"
  #       end
  #     end
  
  #     if successes == contents.length
  #       puts "Comments added successfully"
  #     else
  #       puts "Some comments failed to add"
  #     end
  #   end
  # end
  

  namespace :add do
    desc "Add data to status"
    task :status_data => :environment do
      titles = ["Done", "In Progress", "Approved", "Not Approved"]
      successes = 0
  
      titles.each do |title|
        status = Status.create(title: title)
        if status.persisted?
          successes += 1
        else
          puts "Failed to add status: #{title}"
        end
      end
  
      if successes == titles.length
        puts "Statuses added successfully"
      else
        puts "Some statuses failed to add"
      end
    end
  end
  

  # namespace :add do
  #   desc "Add data to status"
  #   task :status_data => :environment do
  #     Status.create(title: "Done")
  #     Status.create(title: "In Progress")
  #     Status.create(title: "Not Done")
  #   end
  # end


  # namespace :add do
  #   desc "Add data to urgency"
  #   task :urgency_data => :environment do
  #     Urgency.create(title: "Critical")
  #     Urgency.create(title: "Urgent")
  #     Urgency.create(title: "Normal")
  #     Urgency.create(title: "Non-urgent")
  #   end
  # end


  # namespace :add do
  #   desc "Add data to comment"
  #   task :comment_data => :environment do
  #     Comment.create(content: "Hello1")
  #     Comment.create(content: "Hello2")
  #     Comment.create(content: "Hello3")
  #     Comment.create(content: "Hello4")
  #   end
  # end
  
  # namespace :db do
  #   desc "Clear the services table"
  #   task clear_services: :environment do
  #     Service.destroy_all
  #     # puts "Services table has been cleared"
  #   end
  # end
  
  
  