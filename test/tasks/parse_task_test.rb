require 'minitest/autorun'
require 'nokogiri'
require 'open-uri'
require 'rake'

class ParseTaskTest < Minitest::Test
  def setup
    Rake.application.clear
    Rake.application.load_rakefile
    Rake::Task['db:clear_services'].invoke
  end

  def test_services_data_task
    Rake::Task['parse:services_data'].invoke

    # Проверяем => в бд были сохранены данные
    assert Service.count.positive?, 'No services were saved'

    # Проверяем => конкретные данные были сохранены с ожидаемыми значениями
    assert Service.exists?(title: 'Errand-runner', service_type: 'Personal concierge services'), 'Expected service not found'
  end

  def test_services_data_task_only_existing_services
    Rake::Task['parse:services_data'].invoke

    # Получаем список всех уникальных типов сервисов
    service_types = Service.pluck(:service_type).uniq

    # Проверяем => все типы сервисов являются допустимыми
    valid_service_types = ['Personal health and wellness services', 'Personal concierge services',
                           'Beauty and lifestyle service business ideas', 'Serving parents, babies, and small children',
                           'Academic consulting services', 'Elder care services', 'Animal care services', 'Home maintenance and repair services',
                           'Automobile maintenance and repair', 'B2B administrative services', 'Sales and marketing', 'Technology maintenance and repair services',
                           'B2B legal services', 'Travel and tourism service business ideas', 'Event service business ideas']

    assert_empty service_types - valid_service_types, 'Invalid service types found'
  end

  # Проверяем => все созданные записи имеют уникальные названия сервисов
  def test_services_data_task_unique_titles
    Rake::Task['parse:services_data'].invoke
    assert_equal Service.count, Service.pluck(:title).uniq.size, 'Non-unique service titles found'
  end

  # Проверяем => все созданные записи имеют непустые названия сервисов
  def test_services_data_task_non_empty_titles
    Rake::Task['parse:services_data'].invoke

    assert Service.where(title: nil).empty?, 'Some services have empty titles'
  end

  # Проверяем => все созданные записи имеют непустые типы сервисов
  def test_services_data_task_non_empty_types
    Rake::Task['parse:services_data'].invoke
    assert Service.where(service_type: nil).empty?, 'Some services have empty types'
  end

  # Аналог предыдущих двух тестов
  def test_services_data_task_creates_services_with_correct_data
    Rake::Task['parse:services_data'].invoke
    services = Service.all
    services.each do |service|
      assert_not_nil service.title, 'Service title should not be nil'
      assert_not_nil service.service_type, 'Service type should not be nil'
    end
  end

  # Проверяем => после выполнения задачи парсинга данных в базе нет повторяющихся комбинаций заголовка и типа сервиса
  def test_services_data_task_unique_combinations
    Rake::Task['parse:services_data'].invoke
    unique_combinations_count = Service.distinct.pluck(:title, :service_type).uniq.size
    assert_equal Service.count, unique_combinations_count, 'Non-unique combinations of title and service type found'
  end

  # Проверяем => после выполнения задачи парсинга данных было создано ровно 145 записей о сервисах
  def test_services_data_task_creates_services
    Rake::Task['parse:services_data'].invoke
    assert_equal 145, Service.count, 'Expected 145 services to be created'
  end
end
