module  PlayoutScheduler

    class AudioAsset
        include DataMapper::Resource

        property :id, Integer, :key => true
        property :type, Discriminator
        property :name, String
        property :length, Float
        
        has n, :segments
        has n, :broadcasts
    end
    class Single < AudioAsset

        property :retrieval_uri, String
        property :live_source, String
        property :md5_hash, String

        def self.load_from_scheduler asset
            begin
                a = Single.get!(asset.id)
            rescue DataMapper::ObjectNotFoundError
                a = Single.new(:id => asset.id)
            end
            return a
        end

    end

    class Playlist < AudioAsset
        has n, :elements, 'AudioAsset'
    end

end
