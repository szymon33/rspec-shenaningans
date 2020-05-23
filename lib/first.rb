# double can be use as an object prorotype
class Job
  def initialize(ceo = Employee.new(name: 'Marcus'))
    @ceo = ceo
  end

  def ceo_name
    @ceo.name
  end

  def log_me!
    Log.info("hello from a new job!")
  end
end

class Employee
  def initialize(name: name)
    @name = name
  end

  def name
    @name
  end
end

class Log
  def self.info(txt = 'default text')
    txt
  end
end

