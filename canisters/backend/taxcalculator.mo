import Principal "mo:base/Principal";
import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Result "mo:base/Result";
import Text "mo:base/Text";
import Types "types";
import PaymentTypes "payment-types";
module {

  type Payslip = PaymentTypes.Payslip;

  public type Taxbands = {
    #tenpercent;
    #twentyfivepercent;
    #thirtypercent;
    #thirtytwofivepercent;
    #thirtyfivepercent;
  };

  public func nhifCalculator(income : Nat) : async Nat {
    var gross_salary : Nat = income;

    if (gross_salary > 0 and gross_salary <= 5999) { return 150 } else if (gross_salary >= 6000 and gross_salary <= 7999) {
      return 300;
    } else if (gross_salary >= 8000 and gross_salary <= 11999) { return 400 } else if (gross_salary >= 12000 and gross_salary <= 14999) {
      return 500;
    } else if (gross_salary >= 15000 and gross_salary <= 19999) { return 600 } else if (gross_salary >= 20000 and gross_salary <= 24999) {
      return 750;
    } else if (gross_salary >= 25000 and gross_salary <= 29999) { return 850 } else if (gross_salary >= 30000 and gross_salary <= 34999) {
      return 950;
    } else if (gross_salary >= 40000 and gross_salary <= 44999) { return 1000 } else if (gross_salary >= 45000 and gross_salary <= 49999) {
      return 1100;
    } else if (gross_salary >= 50000 and gross_salary <= 59999) { return 1200 } else if (gross_salary >= 60000 and gross_salary <= 69999) {
      return 1300;
    } else if (gross_salary >= 70000 and gross_salary <= 79999) { return 1400 } else if (gross_salary >= 80000 and gross_salary <= 89999) {
      return 1500;
    } else if (gross_salary >= 90000 and gross_salary <= 99999) { return 1600 } else if (gross_salary >= 100000) {
      return 1700;
    } else { return 0 } // default case
  };
  public func nssfCalculator(income : Nat) : async Nat {
    var gross_salary : Nat = income;
    var maxnssf : Nat = 2160;

    // if(gross_salary < 18000){
    //   360;
    // }else (gross_salary > 18000){
    //   720;
    // };
    360;

  };

  public func calculateTax(income : Nat) : async Payslip {
    let personalRelief : Nat = 2400;
    let minimumTaxableIncome : Nat = 24001;
    var paye : Nat = 0;
    var nhif : Nat = 0;
    var nssf : Nat = 0;
    var housing : Nat = 0;
    var other_deductions : Nat = 0;
    var total_tax : Nat = 0;
    var net_salary : Nat = 0;
    var gross_salary : Nat = income;

    var remainingIncome : Nat = 0;

    nhif := await nhifCalculator(income);
    nssf := await nssfCalculator(income);

    if (income >= minimumTaxableIncome) {
      remainingIncome := income;

      if (remainingIncome > 24001 and remainingIncome < 32000) {
        paye := remainingIncome * 10 / 100; // Apply a 10% tax rate
        housing := remainingIncome * 25 / 1000; // Apply a 2.5% tax rate
        total_tax := paye + nhif + nssf + housing;
        net_salary := income - total_tax;
        let payslip : Payslip = {
          gross_salary = gross_salary;
          taxable_income = remainingIncome;
          net_salary = net_salary;
          nhif_deductions = nhif;
          housing = housing;
          nssf_deductions = nssf;
          personal_relief = personalRelief;
          paye = paye;
          other_deductions = other_deductions;
          total_tax = total_tax;
        };

        // return {
        //   status = 200;
        //   status_text = "OK";
        //   data = ?payslip;
        //   error_text = null;
        // };
        return payslip;
      } else if (remainingIncome > 32000 and remainingIncome < 32500) {
        paye := remainingIncome * 10 / 100; // Apply a 10% tax rate
        housing := remainingIncome * 25 / 1000; // Apply a 2.5% tax rate
        total_tax := paye + nhif + nssf + housing;
        net_salary := income - total_tax;
        let payslip : Payslip = {
          gross_salary = gross_salary;
          taxable_income = remainingIncome;
          net_salary = net_salary;
          nhif_deductions = nhif;
          housing = housing;
          nssf_deductions = nssf;
          personal_relief = personalRelief;
          paye = paye;
          other_deductions = other_deductions;
          total_tax = total_tax;
        };

        // return {
        //   status = 200;
        //   status_text = "OK";
        //   data = ?payslip;
        //   error_text = null;
        // };
        return payslip;
      } else {
        paye := remainingIncome * 10 / 100; // Apply a 10% tax rate
        housing := remainingIncome * 25 / 1000; // Apply a 2.5% tax rate
        total_tax := paye + nhif + nssf + housing;
        net_salary := income - total_tax;
        let payslip : Payslip = {
          gross_salary = gross_salary;
          taxable_income = remainingIncome;
          net_salary = net_salary;
          nhif_deductions = nhif;
          housing = housing;
          nssf_deductions = nssf;
          personal_relief = personalRelief;
          paye = paye;
          other_deductions = other_deductions;
          total_tax = total_tax;
        };

        // return {
        //   status = 200;
        //   status_text = "OK";
        //   data = ?payslip;
        //   error_text = null;
        // };
        return payslip;
      };

    } else {
      let payslip : Payslip = {
        gross_salary = gross_salary;
        taxable_income = 0;
        net_salary = 0;
        nhif_deductions = 0;
        housing = 0;
        nssf_deductions = 0;
        personal_relief = 0;
        paye = 0;
        other_deductions = 0;
        total_tax = 0;
      };

      return payslip;
      // return {
      //   status = 400;
      //   status_text = "Bad Request";
      //   data = ?payslip;
      //   error_text = ?"Income is less than minimum taxable income";
      // };
    };
  };
};
