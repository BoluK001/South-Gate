tableextension 50002 PurchaseHeaderExt extends "Purchase Header"
{
    fields
    {
        field(50000; "Purchase Type"; Option)
        {
            OptionCaption = 'LPO,Expence,IOU Retirement,IPO,Charge';
            OptionMembers = LPO,Expence,"IOU Retirement",IPO,Charge;

            trigger OnValidate()
            begin
                //UpdatePurchLines.(fieldCAPTION("Import File No."));
            end;
        }
        field(50001; "Import File No."; Code[20])
        {
            Description = 'UNLIP 2.0';

            trigger OnValidate()
            var
                VendorRec: Record Vendor;
            begin
                TESTfield(Status, Status::Open);

                IF VendorRec.GET("Import File No.") THEN
                    VALIDATE("Import File Name", VendorRec.Name)
                ELSE
                    VALIDATE("Import File Name", '');
                //UpdatePurchLines(fieldCAPTION("Import File No."));

                /*IF "Document Type" = "Document Type" :: Order THEN
                  VALIDATE("Buy-from Vendor No.",'FR-VND-0003');
                */

            end;
        }
        field(50002; "Import File Name"; Text[50])
        {
            Description = 'UNLIP 2.0';
            Editable = false;

            trigger OnValidate()
            begin
                //UpdatePurchLines(fieldCAPTION("Import File Name"));
            end;
        }
        field(50010; "Advance Payment %"; Decimal)
        {
            Description = '//DJ.. added to enable update prepayment % on only lines with postive values';

            trigger OnValidate()
            var
                PurchLine: Record "Purchase Line";
                Currency: Record Currency;
            begin
                PurchLine.SETRANGE("Document Type", "Document Type");
                PurchLine.SETRANGE("Document No.", "No.");
                PurchLine.SETFILTER("Direct Unit Cost", '>%1', 0);
                PurchLine.SETFILTER(PurchLine."Qty. to Invoice", '<>%1', 0);
                IF PurchLine.FIND('-') THEN BEGIN
                    REPEAT
                        PurchLine.VALIDATE("Prepayment %", "Advance Payment %");
                        PurchLine.MODIFY;
                    UNTIL PurchLine.NEXT = 0;
                    CALCfieldS("Amount Including VAT");
                    "Advance Payment Amt" := ROUND("Amount Including VAT" * "Advance Payment %" / 100, Currency."Amount Rounding Precision");
                END;
            end;
        }
        field(50011; "Advance Payment Amt"; Decimal)
        {
            Description = '//DJ.. added to enable update prepayment Amount on only lines with postive values';

            trigger OnValidate()
            var
                PurchLine: Record "Purchase Line";
            begin
                PurchLine.SETRANGE("Document Type", "Document Type");
                PurchLine.SETRANGE("Document No.", "No.");
                PurchLine.SETFILTER("Direct Unit Cost", '>%1', 0);
                PurchLine.SETFILTER(PurchLine."Qty. to Invoice", '<>%1', 0);
                IF PurchLine.FIND('-') THEN BEGIN
                    CALCfieldS("Amount Including VAT");
                    VALIDATE("Advance Payment %", ROUND(("Advance Payment Amt" / "Amount Including VAT") * 100, 0.00001));

                END;
            end;
        }
        field(50074; "Requested By"; Code[20])
        {
            Editable = false;
        }
        field(50075; "Requested By Name"; Text[50])
        {
            Editable = false;
        }
        field(50076; "WHT Amount"; Decimal)
        {
            fieldClass = Flowfield;
            CalcFormula = Sum("Purchase Line".WHTaxAmt WHERE("Document Type" = FILTER(Order), "Document No." = field("No.")));

        }
        field(50077; "BackLog Entry"; Boolean)
        {
        }
        field(50078; "GRN No."; Code[150])
        {
            Description = 'UNLIP 2.0';

            trigger OnLookup()
            var
                PurchRcptHeader: Record "Purch. Rcpt. Header";
            begin
                PurchRcptHeader.RESET;
                IF PurchRcptHeader.FIND('-') THEN BEGIN
                    IF PAGE.RUNMODAL(0, PurchRcptHeader) = ACTION::LookupOK THEN BEGIN
                        IF "GRN No." = '' THEN
                            "GRN No." := PurchRcptHeader."No."
                        ELSE
                            IF "GRN No." <> '' THEN
                                "GRN No." := "GRN No." + '|' + PurchRcptHeader."No.";
                    END;
                END;
            end;

            trigger OnValidate()
            var
                PurchRcptHeader: Record 120;
            begin
            end;
        }
        field(50079; "Job No."; Code[20])
        {
            TableRelation = Job;

            trigger OnValidate()
            var
                JobRec: Record Job;
            begin
                IF JobRec.GET("Job No.") THEN
                    "Job Description" := JobRec.Description
                ELSE
                    "Job Description" := '';
            end;
        }
        field(50080; "Job Description"; Text[50])
        {
        }
        field(50081; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(50082; "Created Date"; Date)
        {
            Editable = false;
        }
        field(50083; "Created Time"; Time)
        {
            Editable = false;
        }
        field(50084; "Purchase Request Type"; Option)
        {
            OptionCaption = ' ,Purchase Request,Service Request';
            OptionMembers = " ","Purchase Request","Service Request";
        }
        // field(50085; "Vendor Agreed Rate"; Decimal)
        // {

        //     trigger OnValidate()
        //     var
        //         UserSetup: Record "User Setup";
        //     begin
        //         UserSetup.GET(USERID);

        //         IF xRec."Vendor Agreed Rate" <> "Vendor Agreed Rate" THEN BEGIN
        //             IF NOT UserSetup."Change PO Agreed Rate" THEN
        //                 ERROR(Text055);
        //         END ELSE
        //             "Vendor Agreed Rate" := xRec."Vendor Agreed Rate";
        //     end;
        // }
        field(50086; "PO Status"; Option)
        {
            OptionCaption = ',VALID,CANCELLED,DELETE';
            OptionMembers = ,VALID,CANCELLED,DELETE;
        }

    }
    // Local procedure UpdatePurchLines(ChangedfieldName: Text[100])
    // var
    //     UpdateConfirmed: Boolean;
    // begin
    //     IF NOT PurchLinesExist THEN
    //         EXIT;

    //     IF NOT GUIALLOWED THEN
    //         UpdateConfirmed := TRUE
    //     ELSE
    //         CASE ChangedfieldName OF
    //             fieldCAPTION("Expected Receipt Date"):
    //                 BEGIN
    //                     UpdateConfirmed :=
    //                       CONFIRM(
    //                         STRSUBSTNO(
    //                           Text032 +
    //                           Text033, ChangedfieldName));
    //                     IF UpdateConfirmed THEN
    //                         ConfirmResvDateConflict;
    //                 END;
    //             fieldCAPTION("Requested Receipt Date"):
    //                 BEGIN
    //                     UpdateConfirmed :=
    //                       CONFIRM(
    //                         STRSUBSTNO(
    //                           Text032 +
    //                           Text033, ChangedfieldName));
    //                     IF UpdateConfirmed THEN
    //                         ConfirmResvDateConflict;
    //                 END;
    //             fieldCAPTION("Promised Receipt Date"):
    //                 BEGIN
    //                     UpdateConfirmed :=
    //                       CONFIRM(
    //                         STRSUBSTNO(
    //                           Text032 +
    //                           Text033, ChangedfieldName));
    //                     IF UpdateConfirmed THEN
    //                         ConfirmResvDateConflict;
    //                 END;
    //             fieldCAPTION("Lead Time Calculation"):
    //                 BEGIN
    //                     UpdateConfirmed :=
    //                       CONFIRM(
    //                         STRSUBSTNO(
    //                           Text032 +
    //                           Text033, ChangedfieldName));
    //                     IF UpdateConfirmed THEN
    //                         ConfirmResvDateConflict;
    //                 END;
    //             fieldCAPTION("Inbound Whse. Handling Time"):
    //                 BEGIN
    //                     UpdateConfirmed :=
    //                       CONFIRM(
    //                         STRSUBSTNO(
    //                           Text032 +
    //                           Text033, ChangedfieldName));
    //                     IF UpdateConfirmed THEN
    //                         ConfirmResvDateConflict;
    //                 END;
    //             fieldCAPTION("Prepayment %"):
    //                 UpdateConfirmed :=
    //                   CONFIRM(
    //                     STRSUBSTNO(
    //                       Text032 +
    //                       Text033, ChangedfieldName));
    //         END;

    //     PurchLine.LOCKTABLE;
    //     MODIFY;

    //     REPEAT
    //         xPurchLine := PurchLine;
    //         CASE ChangedfieldName OF
    //             fieldCAPTION("Expected Receipt Date"):
    //                 IF UpdateConfirmed AND (PurchLine."No." <> '') THEN
    //                     PurchLine.VALIDATE("Expected Receipt Date", "Expected Receipt Date");
    //             fieldCAPTION("Currency Factor"):
    //                 IF PurchLine.Type <> PurchLine.Type::" " THEN
    //                     PurchLine.VALIDATE("Direct Unit Cost");
    //             fieldCAPTION("Transaction Type"):
    //                 PurchLine.VALIDATE("Transaction Type", "Transaction Type");
    //             fieldCAPTION("Transport Method"):
    //                 PurchLine.VALIDATE("Transport Method", "Transport Method");
    //             fieldCAPTION("Entry Point"):
    //                 PurchLine.VALIDATE("Entry Point", "Entry Point");
    //             fieldCAPTION(Area):
    //                 PurchLine.VALIDATE(Area, Area);
    //             fieldCAPTION("Transaction Specification"):
    //                 PurchLine.VALIDATE("Transaction Specification", "Transaction Specification");
    //             fieldCAPTION("Requested Receipt Date"):
    //                 IF UpdateConfirmed AND (PurchLine."No." <> '') THEN
    //                     PurchLine.VALIDATE("Requested Receipt Date", "Requested Receipt Date");
    //             fieldCAPTION("Prepayment %"):
    //                 IF UpdateConfirmed AND (PurchLine."No." <> '') THEN
    //                     PurchLine.VALIDATE("Prepayment %", "Prepayment %");
    //             fieldCAPTION("Promised Receipt Date"):
    //                 IF UpdateConfirmed AND (PurchLine."No." <> '') THEN
    //                     PurchLine.VALIDATE("Promised Receipt Date", "Promised Receipt Date");
    //             fieldCAPTION("Lead Time Calculation"):
    //                 IF UpdateConfirmed AND (PurchLine."No." <> '') THEN
    //                     PurchLine.VALIDATE("Lead Time Calculation", "Lead Time Calculation");
    //             fieldCAPTION("Inbound Whse. Handling Time"):
    //                 IF UpdateConfirmed AND (PurchLine."No." <> '') THEN
    //                     PurchLine.VALIDATE("Inbound Whse. Handling Time", "Inbound Whse. Handling Time");
    //         END;
    //         PurchLine.MODIFY(TRUE);
    //         ReservePurchLine.VerifyChange(PurchLine, xPurchLine);
    //     UNTIL PurchLine.NEXT = 0;
    // end;
}
