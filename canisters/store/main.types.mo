import Text "mo:base/Text";
module Types {

public type Freelancer = {
    name : Text;
    email_notifications : Bool;
    email_address : Text;
    phone : Text;
    phone_notifications : Bool;

};

public type Client = {
    name : Text;
    email_notifications : Bool;
    email_address : Text;
    phone : Text;
    phone_notifications : Bool;
}
    
}