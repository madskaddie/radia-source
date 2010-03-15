
module PlayoutMiddleware
    require 'rubygems'
    require 'active_resource'

    def self.fetch
        Schedule::find(:one, :from => '/schedule.xml').broadcasts
    end

    def self.fech_single id
        begin
            Single::find(:one, :from => "/audio/singles/#{id}.xml")
        rescue
            nil
        end
    end

    class Schedule < ActiveResource::Base
        self.site = $playout_config['scheduler_uri'] << "/"
    end

    class Broadcast < ActiveResource::Base
        self.site = $playout_config['scheduler_uri'] << "/schedule/"
        
        def self.is_valid_broadcast bc
            return true
        end
    end

    class Bloc < ActiveResource::Base
        self.site = ''
    end

    class Structure < ActiveResource::Base
        self.site = ''
    end

    class Segment < ActiveResource::Base
        self.site = ''
    end

    class Single < ActiveResource::Base
        self.site = $playout_config['scheduler_uri'] << "/audio/"
    end
end
