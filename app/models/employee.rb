class Employee < ApplicationRecord
  after_commit :flush_cache!

  VALID_GENDER = %w(male female)

  scope :by_gender, ->(gender) do
    if VALID_GENDER.include?(gender)
      Rails.cache.fetch("employees_#{gender}") {puts 'evaluating...' ; where(gender:gender).order(updated_at: :desc)}
    else
      Rails.cache.fetch('all_employees') {puts 'evaluating...' ; all.order(updated_at: :desc)}
    end
  end

  def final_salary
    Rails.cache.fetch("#{cache_key}/tax") {puts 'calculating tax...'}
  end

  private

  def flush_cache!
    puts 'flushing the cache...'
    Rails.cache.delete 'all_employees'
    Rails.cache.delete "employees_#{gender}"
  end

end
