import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Blob "mo:base/Blob";
import Text "mo:base/Text";
import Result "mo:base/Result";
import List "mo:base/List";

module {

  public type Organogram = {
    creator : Principal;
    code : Text;
    name : Text;
    departments : ?List.List<Department>;
    designations : ?List.List<Department>;
    employees : ?List.List<Employee>;
  };

  public type Department = {
    code : Text;
    name : Text;
    creator : Principal;
  };

  public type Leave = {
    id : Nat;
    creator : Principal;
    owner : Principal;
    start_date : Text;
    end_date : Text;
    leave_type : Text;
    reason : Text;
    status : Text;
    created_at : Int;
    modified_at : Int;
  };

  public type Jobgroup = {
    id : Nat;
    name : Text;

  };

  public type Organization = {
    code : Text;
    name : Text;
    creator : Principal;
  };

  public type Designation = {
    code : Text;
    name : Text;
    creator : Principal;
  };

  public type Employee = {
    creator : Principal;
    first_name : Text;
    last_name : Text;
    identity : Text;
    email_address : Text;
    phone_number : Text;
    username : Text;
    gender : Text;
    disability : Bool;
    organization : Text;
    department : Text;
    designation : Text;
    employee_type : Text;
    job_group : Text;
    gross_salary : Nat;
    role : Text;
  };

  public type CreateEmpArgs = {
    first_name : Text;
    last_name : Text;
    email_address : Text;
    identity : Text;
    phone_number : Text;
    username : Text;
    gender : Text;
    disability : Bool;
    organization : Text;
    department : Text;
    designation : Text;
    employee_type : Text;
    job_group : Text;
    gross_salary : Nat;
    role : Text;
  };

  public type CreateEmpResult = Result.Result<CreateEmpSuccess, CreateEmpErr>;
  public type CreateEmpSuccess = {
    employee : Employee;
  };
  public type CreateEmpErr = {
    message : ?Text;
    kind : {
      #InvalidUser;
      #InvalidPrincipal;
      #Other;
    };
  };

  public type CreateDepartmentArgs = {
    name : Text;
  };
  public type CreateDepartmentResult = Result.Result<CreateDepartmentSuccess, CreateDepartmentErr>;
  public type CreateDepartmentSuccess = {
    department : Department;
  };
  public type CreateDepartmentErr = {
    message : ?Text;
    kind : {
      #InvalidDepartment;
      #InvalidPrincipal;
      #Other;
    };
  };

  public type CreateOrganogramArgs = {
    name : Text;
    departments : List.List<Department>;
    designations : List.List<Department>;
    employees : List.List<Employee>;

  };
  public type CreateOrganogramResult = Result.Result<CreateOrganogramSuccess, CreateOrganogramErr>;
  public type CreateOrganogramSuccess = {
    organogram : Organogram;
  };
  public type CreateOrganogramErr = {
    message : ?Text;
    kind : {
      #InvalidOrganogram;
      #InvalidPrincipal;
      #Other;
    };
  };

  public type CreateOrganizationArgs = {
    name : Text;
  };
  public type CreateOrganizationResult = Result.Result<CreateOrganizationSuccess, CreateOrganizationErr>;
  public type CreateOrganizationSuccess = {
    organization : Organization;
  };
  public type CreateOrganizationErr = {
    message : ?Text;
    kind : {
      #InvalidOrganization;
      #InvalidPrincipal;
      #Other;
    };
  };

  public type CreateDesignationArgs = {
    name : Text;
  };
  public type CreateDesignationResult = Result.Result<CreateDesignationSuccess, CreateDesignationErr>;
  public type CreateDesignationSuccess = {
    designation : Designation;
  };
  public type CreateDesignationErr = {
    message : ?Text;
    kind : {
      #InvalidDesignation;
      #InvalidPrincipal;
      #Other;
    };
  };

  public type Notification = {
    id : Nat;
    sender : Text;
    receiver : Text;
    amount : Nat;
    isRead : Bool;
  };

  public type CreateNotificationArgs = {
    sender : Text;
    receiver : Text;
    amount : Nat;
    isRead : Bool;
  };
  public type CreateNotificationResult = Result.Result<CreateNotificationSuccess, CreateNotificationErr>;
  public type CreateNotificationSuccess = {
    notification : Notification;
  };
  public type CreateNotificationErr = {
    message : ?Text;
    kind : {
      #InvalidNotification;
      #Other;
    };
  };

};
