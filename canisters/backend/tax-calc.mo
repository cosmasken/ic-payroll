import Debug "mo:base/Debug";
import Bool "mo:base/Bool";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

module {

  var salary : Nat = 0;
  var benefits : Nat = 0;
  var deduct_nssf : Bool = false;
  var deduct_nhif : Bool = false;
  var monthly : Bool = true;
  var isNewRates : Bool = false;

  public func setSalary(value : Nat) : async () {
    salary := value;
    Debug.print("Salary set to: " # Nat.toText(value));
  };

  public func setBenefits(value : Nat) : async () {
    benefits := value;
    Debug.print("Benefits set to: " # Nat.toText(value));
  };

  public func setDeductNSSF(value : Bool) : async () {
    deduct_nssf := value;
    Debug.print("NSSF Deduction set to: " # Bool.toText(value));
  };

  public func setDeductNHIF(value : Bool) : async () {
    deduct_nhif := value;
    Debug.print("NHIF Deduction set to: " # Bool.toText(value));
  };

  public func setMonthly(value : Bool) : async () {
    monthly := value;
    Debug.print("Monthly set to: " # Bool.toText(value));
  };

  public func setNewRates(value : Bool) : async () {
    isNewRates := value;
    Debug.print("New Rates set to: " # Bool.toText(value));
  };

  private func totalIncome() : Nat {
    salary + benefits;
  };

  private func nssfDeduction() : Nat {
    if (isNewRates) {
      if (salary > 18000) 2160 else salary * 12 / 100;
    } else 200;
  };

  private func nhifDeduction() : Nat {
    if (salary >= 1000) {
      if (salary <= 5999) 150 else if (salary <= 7999) 300 else if (salary <= 11999) 400 else if (salary <= 14999) 500 else if (salary <= 19999) 600 else if (salary <= 24999) 750 else if (salary <= 29999) 850 else if (salary <= 34999) 900 else if (salary <= 39999) 950 else if (salary <= 44999) 1000 else if (salary <= 49999) 1100 else if (salary <= 59999) 1200 else if (salary <= 69999) 1300 else if (salary <= 79999) 1400 else if (salary <= 89999) 1500 else if (salary <= 99999) 1600 else 1700;
    } else 0;
  };

  private func getPersonalRelief() : Nat {
    if (monthly) 2400 else 28800;
  };

  private func getTaxOnTaxableIncome() : Nat {
    let income = totalIncome();
    if (income <= 12298) income * 10 / 100 else if (income <= 23885) income * 15 / 100 else if (income <= 35472) income * 20 / 100 else if (income <= 47059) income * 25 / 100 else income * 30 / 100;
  };

  public func getNetPay(totalIncome : Nat) : async Nat {
    let totalIncome = totalIncome;
    let nssf = if (deduct_nssf) nssfDeduction() else 0;
    let nhif = if (deduct_nhif) nhifDeduction() else 0;
    let personalRelief = getPersonalRelief();
    let taxOnIncome = getTaxOnTaxableIncome();
    let paye = taxOnIncome - personalRelief;

    totalIncome - (paye + nhif + nssf);
  };
};
