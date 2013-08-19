module LiveChat
  module REST
    ##
    # A class to wrap an instance resource (like a call or application) within
    # the LiveChat API. All other instance resource classes within this library
    # inherit from this class. You shouldn't need to instantiate this class
    # directly. But reviewing the available methods is informative since they
    # are rarely overridden in the inheriting class.
    class InstanceResource
      include Utils

      ##
      # Instantiate a new instance resource object. You must pass the +path+ of
      # the instance (e.g. /chats/MH022RD0K5) as well as a
      # +client+ object that responds to #get #post and #delete. This client
      # is meant to be an instance of LiveChat::REST::Client but could just as
      # well be a mock object if you want to test the interface. The optional
      # +params+ hash will be converted into attributes on the instantiated
      # object.
      def initialize(path, client, params = {})
        @path, @client = path, client
        set_up_properties_from params
      end

      def inspect # :nodoc:
        "<#{self.class} @path=#{@path}>"
      end

      ##
      # Update the properties of this instance resource using the key/value
      # pairs in +params+. This makes an HTTP POST request to <tt>@path</tt>
      # to handle the update. For example, to update the +VoiceUrl+ of a LiveChat
      # Application you could write:
      #
      #   @app.update :voice_url => 'http://my.other.app.com/handle_voice'
      #
      # After returning, the object will contain the most recent state of the
      # instance resource, including the newly updated properties.
      def update(params = {})
        raise "Can't update a resource without a REST Client" unless @client
        yield params if block_given?
        set_up_properties_from(@client.put(@path, params))
        self
      end

      ##
      # Refresh the attributes of this instance resource object by fetching it
      # from LiveChat. Calling this makes an HTTP GET request to <tt>@path</tt>.
      def refresh
        raise "Can't refresh a resource without a REST Client" unless @client
        @updated = false
        set_up_properties_from(@client.get(@path))
        self
      end

      ##
      # Delete an instance resource from LiveChat. This operation isn't always
      # supported. For instance, you can't delete an SMS. Calling this method
      # makes an HTTP DELETE request to <tt>@path</tt>.
      def delete
        raise "Can't delete a resource without a REST Client" unless @client
        @client.delete @path
      end

      ##
      # Lazily load attributes of the instance resource by waiting to fetch it
      # until an attempt is made to access an unknown attribute.
      def method_missing(method, *args)
        super if @updated
        set_up_properties_from(@client.get(@path))
        self.send method, *args
      end

      protected

      def set_up_properties_from(hash)
        eigenclass = class << self; self; end
        hash.each do |p,v|
          property = unrestify p
          unless ['client', 'updated'].include? property
            eigenclass.send :define_method, property.to_sym, &lambda {v}
          end
        end
        @updated = !hash.keys.empty?
      end

      def resource(*resources)
        resources.each do |r|
          resource = restify r
          relative_path = resource
          path = "#{@path}/#{relative_path}"
          resource_class = LiveChat::REST.const_get resource
          instance_variable_set("@#{r}", resource_class.new(path, @client))
        end
        self.class.instance_eval {attr_reader *resources}
      end

    end
  end
end