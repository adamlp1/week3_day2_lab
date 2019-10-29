require('pg')

class Property
  attr_accessor :address, :value, :num_of_rooms, :year_built
  attr_reader :id

  def initialize(options)
    @address = options['address']
    @value = options['value'].to_i
    @num_of_rooms = options['num_of_rooms'].to_i
    @year_built = options['year_built'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    db = PG.connect( {dbname: 'property_tracker', host: 'localhost'} )
    sql = "INSERT INTO properties
        (address,
        value,
        num_of_rooms,
        year_built) VALUES
        ($1, $2, $3, $4)
        RETURNING *;"

      values = [@address, @value, @num_of_rooms, @year_built]
      db.prepare("save", sql)
      result = db.exec_prepared("save", values)
      @id = result[0]['id'].to_i
      db.close()
    end

      def delete()
        db = PG.connect( {dbname: 'property_tracker', host: 'localhost'} )
        sql = "DELETE FROM properties WHERE id = $1"
        values = [@id]
        db.prepare("delete_one", sql)
        db.exec_prepared("delete_one", values)
        db.close
      end

      def Property.delete_all()
        db = PG.connect( {dbname: 'property_tracker', host: 'localhost'} )
        sql = "DELETE FROM properties;"
        db.prepare("delete_all", sql)
        db.exec_prepared("delete_all")
        db.close
      end


      def find()
        db = PG.connect( {dbname: 'property_tracker', host: 'localhost'} )
        sql = "SELECT * FROM properties WHERE id = $1;"
        values = [@id]
        db.prepare("find", sql)
        found_property = db.exec_prepared("find", values)
        db.close
        return found_property.map{ |column| Property.new(column)}
      end

      def find_by_address()
        db = PG.connect( {dbname: 'property_tracker', host: 'localhost'} )
        sql = "SELECT * FROM properties WHERE address = $1;"
        values = [@address]
        db.prepare("find", sql)
        found_property = db.exec_prepared("find", values)
        db.close
        return found_property.map{ |column| Property.new(column)}
      end


  def Property.all()
    db = PG.connect( {dbname: 'property_tracker', host: 'localhost'} )
    sql = "SELECT * FROM properties;"
    db.prepare("all", sql)
    buildings = db.exec_prepared("all")
    db.close()
    return buildings.map{ |building| Property.new(building)}
  end




end
