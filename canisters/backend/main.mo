import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Result "mo:base/Result";
import Int "mo:base/Int";
import Time "mo:base/Time";
import CkBtcLedger "canister:ckbtc_ledger";
import Types "./types";
import { toAccount; toSubaccount; createInvoice } "./utils";
import Error "mo:base/Error";
import Nat "mo:base/Nat";
import Debug "mo:base/Debug";
import Utils "utils";


actor Backend {


    let cookies = [
    "A journey of a thousand miles begins with a single step.",
    "Your greatest fortune is the friends you keep.",
    "Good things come to those who wait.",
    "The best way to predict the future is to create it.",
    "Opportunity knocks on your door every day. Be ready to answer.",
    "Success is the sum of small efforts repeated day in and day out.",
    "Believe in yourself, and others will too.",
    "A smile is the universal language of kindness.",
    "Your dreams are within reach. Pursue them with passion.",
    "Kindness is a gift that keeps on giving.",
    "Patience is the key to unlocking life's greatest treasures.",
    "Fortune favors the bold.",
    "Success is not final, failure is not fatal: It is the courage to continue that counts.",
    "The greatest risk is not taking any risks at all.",
    "Your positive attitude will lead to positive outcomes.",
    "In every ending, there is a new beginning.",
    "Happiness is not a destination, but a way of life.",
    "Success is not measured by wealth, but by the impact you make on others.",
    "Embrace change, for it leads to growth.",
    "The best lessons are learned from mistakes.",
    "Your creative ideas will lead to great achievements.",
    "The secret to happiness is to count your blessings.",
    "Love and laughter are the keys to a joyful heart.",
    "Success comes to those who work for it.",
    "You have the power to make a difference in the world.",
    "Cherish the present moment, for it is a gift.",
    "Persistence and determination will bring you closer to your goals.",
    "A kind word can change someone's entire day.",
    "The only limit is the one you set for yourself.",
    "Take the road less traveled, and you will discover new horizons.",
    "Your greatest strength lies within you.",
    "Luck is what happens when preparation meets opportunity.",
    "Every setback is a setup for a comeback.",
    "A grateful heart attracts abundance.",
    "The best is yet to come.",
    "The harder you work, the luckier you get.",
    "Life is a beautiful journey. Enjoy every step.",
    "Your passion will lead you to success.",
    "Every problem has a solution. Keep a positive mindset.",
    "Wisdom is knowing what to do; virtue is doing it.",
    "You are capable of achieving great things.",
    "A kind gesture can change someone's entire day.",
    "Great things take time. Be patient.",
    "Believe in yourself, and others will believe in you.",
    "Your generosity will be rewarded tenfold.",
    "Keep your face always toward the sunshine, and shadows will fall behind you.",
    "Success is not just about reaching the destination, but enjoying the journey.",
    "An open mind is an opportunity magnet.",
    "The world is full of endless possibilities. Embrace them.",
    "Your potential is limitless. Believe in yourself and aim high.",
  ];
let addressConverter_ = Utils.addressConverter;
  

   public shared ({ caller }) func whoami() : async Principal {
return caller;
 };

public shared ({ caller }) func getInvoice() : async Types.Account {
  
  return  toAccount({ caller; canister = Principal.fromActor(Backend) });
 // Debug.print(Debug_show(toAccount({ caller; canister = Principal.fromActor(Backend) })));
  };

  public shared ({ caller }) func getFundingBalance() : async Text {
    let balance = await CkBtcLedger.icrc1_balance_of(

      {
        owner = caller;
        subaccount = null;
      }
    //  toAccount({ caller; canister = Principal.fromActor(Backend) })
    );
    return Nat.toText(balance);
  };

  public shared ({ caller }) func getTradingBalance() : async Text {
     let balance = await CkBtcLedger.icrc1_balance_of(

      {
        owner = Principal.fromActor(Backend);
        subaccount = ?toSubaccount(caller);
      }
    //  toAccount({ caller; canister = Principal.fromActor(Backend) })
    // owner = Principal.fromActor(Backend) ;
    //  subaccount = ?toSubaccount(caller);
    );
     return Nat.toText(balance);
  };

    public shared ({ caller }) func getCanisterBalance() : async Text {
     let balance = await CkBtcLedger.icrc1_balance_of(

      {
        owner = Principal.fromActor(Backend);
        subaccount = null;
      }
    //  toAccount({ caller; canister = Principal.fromActor(Backend) })
    // owner = Principal.fromActor(Backend) ;
    //  subaccount = ?toSubaccount(caller);
    );
     return Nat.toText(balance);
  };

public shared ({caller}) func getFundingAddress() : async Text {
  let acc : Types.Account = {
    owner = caller;
    subaccount = null;
  };
  let address = addressConverter_.toText(acc);
  return address;
};


public shared ({ caller }) func getTradingAddress() : async Text {
  let acc : Types.Account = {
    owner = Principal.fromActor(Backend);
    subaccount = ?toSubaccount(caller);
  };
  let address = addressConverter_.toText(acc);
  return address;
};

public shared ({ caller }) func getCanisterAddress() : async Text {
  let acc : Types.Account = {
    owner = Principal.fromActor(Backend);
    subaccount = null;
  };
  let address = addressConverter_.toText(acc);
  return address;
};
  
   

  public shared ({ caller }) func transferToCanister(): async Result.Result<Text, Text> {

    // check ckBTC balance of the callers dedicated account
    let balance = await CkBtcLedger.icrc1_balance_of(
       {
        owner = caller;
        subaccount = null;
      }
    );

    if (balance < 100) {
      return #err("Not enough funds available in the Account. Make sure you send at least 100 ckSats.");
    };

       Debug.print("balance to transfer to subaccount :  is  " # debug_show(balance));

    try {
      // if enough funds were sent, move them to the canisters default account
      let transferResult = await CkBtcLedger.icrc1_transfer(
        {
          amount = balance -10;
          from_subaccount = null;
          created_at_time = null;
          fee = ?10;
          memo = null;
          to = {
            owner = Principal.fromActor(Backend);
            subaccount = null;
          };
        }
      );

      Debug.print("transferresult:  is  " # debug_show(transferResult));

      switch (transferResult) {
        case (#Err(transferError)) {
          return #err("Couldn't transfer funds to default account:\n" # debug_show (transferError));
        };
        case (_) {};
      };
    } catch (error : Error) {
      return #err("Reject message: " # Error.message(error));
    };

    return #ok("🥠: " # cookies[Int.abs(Time.now() / 1000 % 50)]);
  };


  //transfer funds from the default canister subaccount to the user subaccount
  //Works
  public shared ({ caller }) func transferFromCanistertoSubAccount(): async Result.Result<Text, Text> {

    // check ckBTC balance of the callers dedicated account
    let balance = await CkBtcLedger.icrc1_balance_of(
       {
        owner = Principal.fromActor(Backend);
        subaccount = null;
      }
    );

    if (balance < 100) {
      return #err("Not enough funds available in the Account. Make sure you send at least 100 ckSats.");
    };

       Debug.print("balance:  is  " # debug_show(balance));

    try {
      // if enough funds were sent, move them to the canisters default account
      let transferResult = await CkBtcLedger.icrc1_transfer(
        {
          amount = balance -10;
          from_subaccount = null;
          created_at_time = null;
          fee = ?10;
          memo = null;
          to = {
            owner = Principal.fromActor(Backend);
            subaccount = ?toSubaccount(caller);
          };
        }
      );

         Debug.print("transferresult:  is  " # debug_show(transferResult));

      switch (transferResult) {
        case (#Err(transferError)) {
          return #err("Couldn't transfer funds to default account:\n" # debug_show (transferError));
        };
        case (_) {};
      };
    } catch (error : Error) {
      return #err("Reject message: " # Error.message(error));
    };

    return #ok("🥠: " # cookies[Int.abs(Time.now() / 1000 % 50)]);
  };  

  //transfer from one subaccount to another
//works
  public shared ({ caller }) func transferFromSubAccountToSubAccount(receiver:Text,amount:Nat): async Result.Result<Text, Text> {

    // check ckBTC balance of the callers dedicated account
    let balance = await CkBtcLedger.icrc1_balance_of(
       {
        owner = Principal.fromActor(Backend);
        subaccount = ?toSubaccount(caller);
      }
    );

    if (balance < 100) {
      return #err("Not enough funds available in the Account. Make sure you send at least 100 ckSats.");
    };

       Debug.print(" su acc balance:  is  " # debug_show(balance));

    try {
      // if enough funds were sent, move them to the canisters default account
      let transferResult = await CkBtcLedger.icrc1_transfer(
        {
          amount = amount;
          from_subaccount = ?toSubaccount(caller);
          created_at_time = null;
          fee = ?10;
          memo = null;
          to = {
            owner = Principal.fromActor(Backend);
            subaccount = ?toSubaccount(Principal.fromText(receiver));
          };
        }
      );

         Debug.print("fom subaccount transferresult:  is  " # debug_show(transferResult));

      switch (transferResult) {
        case (#Err(transferError)) {
          return #err("Couldn't transfer funds to default account:\n" # debug_show (transferError));
        };
        case (_) {};
      };
    } catch (error : Error) {
      return #err("Reject message: " # Error.message(error));
    };

    return #ok("🥠: " # cookies[Int.abs(Time.now() / 1000 % 50)]);
  };


  

}