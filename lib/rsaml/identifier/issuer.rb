module RSAML #:nodoc:
  module Identifier #:nodoc:
    # Provides information about the issuer of a SAML assertion or protocol message.
    # Requires the use of a string to carry the issuer's name
    class Issuer < Name
      # If no Format value is provided with this element, then the value
      # urn:oasis:names:tc:SAML:2.0:nameid-format:entity is in effect
      def format
        @format ||= Name.formats[:entity]
      end
      
      # Construct an XML fragment representing the issuer
      def to_xml(xml=Builder::XmlMarkup.new)
        attributes = {'Format' => format}
        attributes['NameQualifier'] = name_qualifier unless name_qualifier.nil?
        attributes['SPNameQualifier'] = sp_name_qualifier unless sp_name_qualifier.nil?
        attributes['SPProvidedID'] = sp_provided_id unless sp_provided_id.nil?
        xml.tag!('saml:Issuer', value, attributes)
      end
      
      # Construct an Issuer instance from the given XML Element or fragment.
      def self.from_xml(element)
        element = REXML::Document.new(element).root if element.is_a?(String)
        Issuer.new(element.text)
      end
    end
  end
end
