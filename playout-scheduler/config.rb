    class Time
        def to_s
            #sprintf("%4d-%02d-%02d %02d:%02d:%02d", @year, @month, @day, @hour, @min, @sec) 
            strftime("%Y-%m-%d %H:%M:%S")
        end
    end
module PlayoutScheduler
    require 'rubygems'
    require 'dm-core'
    require 'dm-types'
    # require 'assets'
    # require 'gap'
    # require 'scheduler'
    # require 'update_service'
    # require 'asset-manager'
    #

    $playout_config = {'scheduler_uri' => "http://welles.radiozero.pt:3000"}
    DEBUG = 1


    #DataMapper.setup(:default, 'sqlite3::memory:')
    DataMapper.setup(:default, 'sqlite3:/tmp/dev.sqlite3')
    SocketFile = "/tmp/rs-playout.sock"
    #playout_config = {:yaml => File.open("/tmp/schedule_1.yml")}

    Dir["app/models/*"].each{ |x| load x }
    #DataMapper.auto_migrate!

end
