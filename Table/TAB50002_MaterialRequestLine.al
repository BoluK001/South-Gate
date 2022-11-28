table 50002 "Material Request Line"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(2; "Request Type"; Option)
        {
            OptionCaption = 'Project,Internal';
            OptionMembers = Job,Internal;
        }
        field(3; "Line No."; Integer)
        {
        }
        field(4; "Item No."; Code[20])
        {
            TableRelation = Item;

            trigger OnValidate()
            begin
                TestStatusOpen;
                MaterialReqHeader.GET("Document No.");

                "Request Type" := MaterialReqHeader."Request Type";
                "Request Date" := MaterialReqHeader."Request Date";
                VALIDATE("Location Code", MaterialReqHeader."Location Code");
                VALIDATE("Shortcut Dimension 1 Code", MaterialReqHeader."Global Dimension 1 Code");
                VALIDATE("Shortcut Dimension 2 Code", MaterialReqHeader."Global Dimension 2 Code");
                VALIDATE("Shortcut Dimension 3 Code", MaterialReqHeader."Shortcut Dimension 3 Code");
                VALIDATE("Shortcut Dimension 4 Code", MaterialReqHeader."Shortcut Dimension 4 Code");
                VALIDATE("Shortcut Dimension 5 Code", MaterialReqHeader."Shortcut Dimension 5 Code");
                VALIDATE("Shortcut Dimension 6 Code", MaterialReqHeader."Shortcut Dimension 6 Code");
                VALIDATE("Shortcut Dimension 7 Code", MaterialReqHeader."Shortcut Dimension 7 Code");
                VALIDATE("Shortcut Dimension 8 Code", MaterialReqHeader."Shortcut Dimension 8 Code");

                VALIDATE("Job No.", MaterialReqHeader."Job No.");

                IF "Item No." = '' THEN
                    EXIT;
                ItemRec.GET("Item No.");
                ItemRec.CALCFIELDS(Inventory);
                IF MaterialReqHeader."Entry Type" = MaterialReqHeader."Entry Type"::Issue THEN
                    IF ItemRec.Inventory = 0 THEN;
                //ERROR('You can not select an Item with 0 Inventory!');
                ItemRec.TESTFIELD(Blocked, FALSE);
                VALIDATE(Description, ItemRec.Description);
                VALIDATE("Unit of Measure Code", ItemRec."Base Unit of Measure");
                VALIDATE("Inventory Posting Group", ItemRec."Inventory Posting Group");
                VALIDATE("Item Category Code", ItemRec."Item Category Code");
                //VALIDATE("Product Group Code" , ItemRec."Product Group Code");      ddada remmed cos notshowing on job planning line
                VALIDATE("Gen. Prod. Posting Group", ItemRec."Gen. Prod. Posting Group");
                VALIDATE("Unit Cost", ItemRec."Unit Cost");
            end;
        }
        field(5; "Item Category Code"; Code[20])
        {
            TableRelation = "Item Category";
        }
        field(6; "Product Group Code"; Code[20])
        {
            TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(7; "Variant Code"; Code[20])
        {
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(8; Description; Text[100])
        {
        }
        field(9; "Unit of Measure Code"; Code[20])
        {
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));

            trigger OnValidate()
            begin
                TestStatusOpen;
            end;
        }
        field(10; Quantity; Decimal)
        {
            Caption = 'Requested Quantity';

            trigger OnValidate()
            begin
                TestStatusOpen;

                //TESTFIELD("Item No.");  //// Released to allow items
                //CheckJobPlanningLine;
                "Line Amount" := Quantity * "Unit Cost";

                IF Quantity > "Quantity in Inventory" THEN
                    //ERROR('Insufficient Balance In Inventory');


                    CheckILESUM();



                CheckPartUsageDD();
            end;
        }
        field(11; "Unit Cost"; Decimal)
        {

            trigger OnValidate()
            begin
                "Line Amount" := Quantity * "Unit Cost";
            end;
        }
        field(12; "Inventory Posting Group"; Code[20])
        {
            TableRelation = "Inventory Posting Group";
        }
        field(13; "Gen. Prod. Posting Group"; Code[20])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(16; "Request Date"; Date)
        {
        }
        field(17; "Location Code"; Code[20])
        {
            TableRelation = Location.Code WHERE("Use As In-Transit" = FILTER(false));
        }
        field(18; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(19; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(20; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(21; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(22; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            end;
        }
        field(23; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");
            end;
        }
        field(24; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(7, "Shortcut Dimension 7 Code");
            end;
        }
        field(25; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(8, "Shortcut Dimension 8 Code");
            end;
        }
        field(26; Status; Option)
        {
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(27; "Applies-to Entry"; Integer)
        {

            trigger OnLookup()
            begin
                SelectItemEntry(FIELDNO("Applies-to Entry"));
            end;

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
            // ItemTrackingLines: Page "Item Tracking Lines";
            begin
                /*      IF "Applies-to Entry" <> 0 THEN BEGIN
                          ItemLedgEntry.GET("Applies-to Entry");

                          IF "Value Entry Type" = "Value Entry Type"::Revaluation THEN BEGIN
                              IF "Inventory Value Per" <> "Inventory Value Per"::" " THEN
                                  ERROR(Text006, FIELDCAPTION("Applies-to Entry"));

                              IF "Inventory Value Per" = "Inventory Value Per"::" " THEN BEGIN
                                  GetItem;
                                  IF Item."Costing Method" = Item."Costing Method"::Average THEN
                                      ERROR(Text034);
                              END;

                              InitRevalJnlLine(ItemLedgEntry);
                              ItemLedgEntry.TESTFIELD(Positive, TRUE);
                          END ELSE BEGIN
                              TESTFIELD(Quantity);
                              IF Signed(Quantity) * ItemLedgEntry.Quantity > 0 THEN BEGIN
                                  IF Quantity > 0 THEN
                                      FIELDERROR(Quantity, Text030);
                                  IF Quantity < 0 THEN
                                      FIELDERROR(Quantity, Text029);
                              END;
                              IF (ItemLedgEntry."Lot No." <> '') OR (ItemLedgEntry."Serial No." <> '') THEN
                                  ERROR(Text033, FIELDCAPTION("Applies-to Entry"), ItemTrackingLines.CAPTION);

                              IF NOT ItemLedgEntry.Open THEN
                                  MESSAGE(Text032, "Applies-to Entry");

                              IF "Entry Type" = "Entry Type"::Output THEN BEGIN
                                  ItemLedgEntry.TESTFIELD("Order Type", "Order Type"::Production);
                                  ItemLedgEntry.TESTFIELD("Order No.", "Order No.");
                                  ItemLedgEntry.TESTFIELD("Order Line No.", "Order Line No.");
                                  ItemLedgEntry.TESTFIELD("Entry Type", "Entry Type");
                              END;
                          END;

                          "Location Code" := ItemLedgEntry."Location Code";
                          "Variant Code" := ItemLedgEntry."Variant Code";
                      END ELSE BEGIN
                          IF "Value Entry Type" = "Value Entry Type"::Revaluation THEN BEGIN
                              VALIDATE("Unit Amount", 0);
                              VALIDATE(Quantity, 0);
                              "Inventory Value (Calculated)" := 0;
                              "Inventory Value (Revalued)" := 0;
                              "Location Code" := '';
                              "Variant Code" := '';
                              "Bin Code" := '';
                          END;
                      END;

      */
            end;
        }
        field(28; "Quantity in Inventory"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("Item No."), "Location Code" = FIELD("Location Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(29; "Line Amount"; Decimal)
        {
        }
        field(30; Type; Option)
        {
            OptionCaption = ' ,Item';
            OptionMembers = " ",Item;
        }
        field(31; "Job No."; Code[20])
        {
            Caption = '"Job No."';
            TableRelation = Job;
        }
        field(32; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));
        }
        field(34; "Qty on Purch. Order"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Outstanding Qty. (Base)" WHERE("Document Type" = FILTER(Order | Invoice), Type = CONST(Item), "No." = FIELD("Item No."), "Outstanding Qty. (Base)" = FILTER(<> 0)));
            FieldClass = FlowField;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions;
            end;
        }
        field(487; "Customer Job Type"; Code[20])
        {
            //TableRelation = "Customer Job Type";
        }
        field(488; "Job Type Code"; Code[20])
        {
            //TableRelation = "Job Type Code"."Job Type Code" WHERE("Customer Job Type" = FIELD("Customer Job Type"));
        }
        field(489; "Vehicle Registration No."; Code[20])
        {
            Description = 'BLOCKING';
        }
        field(491; "Gen. Bus. Posting Group"; Code[15])
        {
            Caption = 'Gen. Bus. Posting Group';
            Editable = true;
            TableRelation = "Gen. Business Posting Group";//WHERE("Service Only" = FILTER(true));
        }
        field(492; "Planning Line GBPG"; Code[15])
        {
            CalcFormula = Lookup("Job Planning Line"."Gen. Bus. Posting Group" WHERE("Job No." = FIELD("Job No.")));
            FieldClass = FlowField;
        }
        field(493; "Planning Line Status"; Code[20])
        {
        }
        field(494; "Value Entry Type"; Option)
        {
            Caption = 'Value Entry Type';
            OptionCaption = 'Direct Cost,Revaluation,Rounding,Indirect Cost,Variance';
            OptionMembers = "Direct Cost",Revaluation,Rounding,"Indirect Cost",Variance;
        }
        field(495; "Inventory Value Per"; Option)
        {
            Caption = 'Inventory Value Per';
            Editable = false;
            OptionCaption = ' ,Item,Location,Variant,Location and Variant';
            OptionMembers = " ",Item,Location,Variant,"Location and Variant";
        }
        field(496; "Applies-from Entry"; Integer)
        {
        }
        field(50001; "Service Item"; Code[20])
        {
        }
        field(50002; "Def. Qty. Excd. Approved"; Boolean)
        {
        }
        field(50008; "Unblock Usage"; Boolean)
        {
        }
        field(50017; "Allow Approved Usage"; Boolean)
        {
            Description = 'BLOCKING';
        }
        field(50018; "User ID- BLocked Item Removed"; Code[50])
        {
            Description = 'BLOCKING';
        }
        field(50019; "BLocking Notification"; Boolean)
        {
            Description = 'BLOCKING';
        }
        field(50020; "Last Inv Doc"; Code[30])
        {
            Description = 'BLOCKING';
            TableRelation = Job;
        }
        field(50021; "Last Inv Date"; Date)
        {
            Description = 'BLOCKING';
        }
        field(50022; "Unblock-Approver"; Code[50])
        {
            Description = 'BLOCKING';
            TableRelation = "User Setup";
        }
        field(50082; "Service Item No."; Code[15])
        {
        }
        field(50083; "Send To"; Code[50])
        {
            Description = 'BLOCKING';
            // TableRelation = "User Setup"."User ID" WHERE("Expired Items UnBlock Mgr" = CONST(true)); //B.Dennis
        }
        field(50084; Sender; Code[50])
        {
            Description = 'BLOCKING';
        }
        field(50085; "Send For Approval"; Option)
        {
            Description = 'BLOCKING';
            OptionCaption = ' ,Send,Re-Send';
            OptionMembers = " ",Send,"Re-Send";

            trigger OnValidate()
            begin
                /*    Item.GET("Item No.");

                    //,SParePare Requesting is More ThanYearly Default Qty,SparePart Issued + Qty Requesting is More than Yearly Default Quantity,SparePart Requesting has been Collected within the Last 6M/1Yr
                    //TESTFIELD("Reason For Approval");
                    //
                    JobSetup.GET;
                    IF ("Send For Approval" = "Send For Approval"::Send) OR ("Send For Approval" = "Send For Approval"::"Re-Send") THEN BEGIN
                        IF (UserSetup.GET("Send To")) AND ("Gen. Prod. Posting Group" = 'BATTERY') THEN BEGIN
                            TESTFIELD("Send To");
                            TESTFIELD("Reason For Approval");
                            Sender := USERID;
                            "Sent Date" := CURRENTDATETIME;
                            Subject := STRSUBSTNO(text101, "Document No.", "Service Item No.");
                            Body := STRSUBSTNO(Text107, "Document No.", "No.", "Service Item No.", "Reason For Approval");
                            // Mailsender.NewMessage('ddada@agleventis.com',JobSetup."Email to copy 4 Tyres/Battery",Subject,Body,attachement,FALSE);
                            Mailsender.NewMessage(UserSetup."E-Mail", JobSetup."Email to copy 4 Tyres/Battery", Subject, Body, attachement, FALSE);
                            TESTFIELD("Approve/Reject", 0);
                            //END;
                        END ELSE BEGIN
                            IF (UserSetup.GET("Send To")) AND ("Gen. Prod. Posting Group" = 'TYRE') THEN BEGIN
                                TESTFIELD("Reason For Approval");
                                TESTFIELD("Send To");
                                Sender := USERID;
                                "Sent Date" := CURRENTDATETIME;
                                TESTFIELD("Send To");
                                Subject := STRSUBSTNO(text101, "Document No.", "Service Item No.");
                                Body := STRSUBSTNO(Text106, "Document No.", "No.", "Service Item No.", "Reason For Approval");
                                //Mailsender.NewMessage('ddada@agleventis.com',JobSetup."Email to copy 4 Tyres/Battery",Subject,Body,attachement,FALSE);
                                Mailsender.NewMessage('dirabor@agleventis.com', JobSetup."Email to copy 4 Tyres/Battery", Subject, Body, attachement, FALSE);
                                TESTFIELD("Approve/Reject", 0);
                                //   END;
                            END ELSE BEGIN
                                IF UserSetup.GET("Send To") THEN BEGIN
                                    Sender := USERID;
                                    "Sent Date" := CURRENTDATETIME;
                                    TESTFIELD("Send To");
                                    Subject := STRSUBSTNO(text101, "Document No.");
                                    Body := STRSUBSTNO(text102, "Document No.", "No.", Item."Usage period (Warranty)", "Service Item No.", "Reason For Approval");
                                    Mailsender.NewMessage(UserSetup."E-Mail", JobSetup."Email to copy For Spares", Subject, Body, attachement, FALSE);
                                    TESTFIELD("Approve/Reject", 0);
                                END;
                            END;
                        END;
                    END;

    */
            end;
        }
        field(50086; "Sent Date"; DateTime)
        {
            Description = 'BLOCKING';
        }
        field(50087; "Approve/Reject"; Option)
        {
            Description = 'BLOCKING';
            OptionMembers = " ",Approved,Reject;

            trigger OnValidate()
            begin
                /* TempPerm.GET(USERID);
                 //IF TempPerm."90 Days Unblocking Approved" = FALSE THEN
                     ERROR('You do not permission to allow this item use, It has being used in 90 days and Requires Approval.');


                 IF "Approve/Reject" = "Approve/Reject"::Approved THEN BEGIN
                     // VALIDATE("Unblock Usage Notification",TRUE);
                     VALIDATE("Allow Approved Usage", TRUE);
                     "Approved By" := USERID;
                     "Approval Date" := CURRENTDATETIME;
                 END ELSE BEGIN
                     VALIDATE("Allow Approved Usage", FALSE);
                     "Approved By" := '';
                     "Approval Date" := 0DT;
                 END;

 */
            end;
        }
        field(50088; "Approved By"; Code[50])
        {
            Description = 'BLOCKING';
        }
        field(50089; "Approval Date"; DateTime)
        {
            Description = 'BLOCKING';
        }
        field(50090; "Reasons for Rejecting Part"; Text[250])
        {
        }
        field(50091; "Quantity CONSM Per Year"; Decimal)
        {
            BlankZero = true;
        }
        field(50092; "Reason For Approval"; Option)
        {
            OptionCaption = '  ,SparePart Requesting is More Than Yearly Def. Qty,SparePart Issued + Qty Requesting is More than Yearly Def. Qty,SparePart Requested has already Exceeded the Yearly Def. Qty,SparePart Requesting has been Collected within the Last 6M/1Yr';
            OptionMembers = "  ","SparePart Requesting is More Than Yearly Def. Qty","SparePart Issued + Qty Requesting is More than Yearly Def. Qty","SparePart Requested has already Exceeded the Yearly Def. Qty","SparePart Requesting has been Collected within the Last 6M/1Yr";
        }
        field(50093; "Quotation Approved By"; Code[50])
        {
            Description = 'BLOCKING';
        }
        field(50094; "Quotation Approval Date"; DateTime)
        {
            Description = 'BLOCKING';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        MaterialReqHeader: Record "Material Request Header";
        ItemRec: Record Item;
        Text001: Label 'You cannot request more than %1 quantity of %2  in "Job No."%3 , Task No. %4';
        // DimMgt: Codeunit DimensionManagement;
        Text006: Label 'You must not enter %1 in a revaluation sum line.';
        Item: Record Item;
        Text034: Label 'You cannot revalue individual item ledger entries for items that use the average costing method.';
        ItemCheckAvail: Codeunit "Item-Check Avail.";
        JobSetup: Record "Jobs Setup";
        UserSetup: Record "User Setup";
        TOTQty: Decimal;
        I: Integer;
        JQty: Decimal;
        TRUEJQty: Decimal;
        JQty2: Decimal;
        TRUEJQty2: Decimal;
        /// Mailsender: Codeunit Mail;
        ToName: Text[80];
        CCName: Text[80];
        Subject: Text[50];
        Body: Text[260];
        attachement: Text[260];
        ServiceLine: Record "Store Issue Line"; //Dennis
        LastUsageDate: Date;

    procedure CheckJobPlanningLine()
    var
        JobPlanningLine: Record "Job Planning Line";
    begin
        JobPlanningLine.RESET;
        JobPlanningLine.SETRANGE("Job No.", "Job No.");
        JobPlanningLine.SETRANGE("Job Task No.", "Job Task No.");
        JobPlanningLine.SETRANGE(Type, JobPlanningLine.Type::Item);
        JobPlanningLine.SETRANGE("No.", "Item No.");
        JobPlanningLine.SETFILTER(Quantity, '<>%1', 0);
        IF JobPlanningLine.FINDFIRST THEN BEGIN
            JobPlanningLine.CALCFIELDS("Consumed Quantity Usage");
            IF Quantity > (JobPlanningLine.Quantity - JobPlanningLine."Consumed Quantity Usage") THEN
                ERROR(Text001, JobPlanningLine.Quantity - JobPlanningLine."Consumed Quantity Usage", JobPlanningLine."No.", JobPlanningLine."Job No.", JobPlanningLine."Job Task No.");
        END;

    end;

    procedure ShowDimensions()
    var
        DimMgt: Codeunit 408;
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2', "Document No.", "Line No."));
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit 408;
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure TestStatusOpen()
    begin
        TESTFIELD("Document No.");
        IF (MaterialReqHeader."No." <> "Document No.") THEN
            MaterialReqHeader.GET("Document No.");
        MaterialReqHeader.TESTFIELD(Status, MaterialReqHeader.Status::Open);
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[15] of Code[20])
    var
        DimMgt: Codeunit 408;
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit 408;
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
    end;

    local procedure GetItem()
    begin
        IF Item."No." <> "Item No." THEN
            Item.GET("Item No.");
    end;

    local procedure InitRevalJnlLine(ItemLedgEntry2: Record "Item Ledger Entry")
    var
        ItemApplnEntry: Record "Item Application Entry";
        ValueEntry: Record "Value Entry";
        CostAmtActual: Decimal;
    begin
        /*   IF "Value Entry Type" <> "Value Entry Type"::Revaluation THEN
               EXIT;

           ItemLedgEntry2.TESTFIELD("Item No.", "Item No.");
           ItemLedgEntry2.TESTFIELD("Completely Invoiced", TRUE);
           ItemLedgEntry2.TESTFIELD(Positive, TRUE);
           ItemApplnEntry.CheckAppliedFromEntryToAdjust(ItemLedgEntry2."Entry No.");

           VALIDATE("Entry Type", ItemLedgEntry2."Entry Type");
           "Posting Date" := ItemLedgEntry2."Posting Date";
           VALIDATE("Unit Amount", 0);
           VALIDATE(Quantity, ItemLedgEntry2."Invoiced Quantity");

           ValueEntry.RESET;
           ValueEntry.SETCURRENTKEY("Item Ledger Entry No.", "Entry Type");
           ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgEntry2."Entry No.");
           ValueEntry.SETFILTER("Entry Type", '<>%1', ValueEntry."Entry Type"::Rounding);
           ValueEntry.FIND('-');
           REPEAT
               IF NOT (ValueEntry."Expected Cost" OR ValueEntry."Partial Revaluation") THEN
                   CostAmtActual := CostAmtActual + ValueEntry."Cost Amount (Actual)";
           UNTIL ValueEntry.NEXT = 0;

           VALIDATE("Inventory Value (Calculated)", CostAmtActual);
           VALIDATE("Inventory Value (Revalued)", CostAmtActual);

           "Location Code" := ItemLedgEntry2."Location Code";
           "Variant Code" := ItemLedgEntry2."Variant Code";
           "Applies-to Entry" := ItemLedgEntry2."Entry No.";
           CopyDim(ItemLedgEntry2."Dimension Set ID");
   */
    end;

    local procedure SelectItemEntry(CurrentFieldNo: Integer)
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemJnlLine2: Record "Material Request Line";
    begin
        ItemLedgEntry.SETCURRENTKEY("Item No.", Positive);
        ItemLedgEntry.SETRANGE("Item No.", "Item No.");
        ItemLedgEntry.SETRANGE(Correction, FALSE);

        IF "Location Code" <> '' THEN
            ItemLedgEntry.SETRANGE("Location Code", "Location Code");

        IF CurrentFieldNo = FIELDNO("Applies-to Entry") THEN BEGIN
            IF "Value Entry Type" <> "Value Entry Type"::Revaluation THEN BEGIN
                ItemLedgEntry.SETCURRENTKEY("Item No.", Open);
                ItemLedgEntry.SETRANGE(Open, TRUE);
            END;
        END ELSE
            ItemLedgEntry.SETRANGE(Positive, FALSE);

        IF PAGE.RUNMODAL(PAGE::"Item Ledger Entries", ItemLedgEntry) = ACTION::LookupOK THEN BEGIN
            ItemJnlLine2 := Rec;
            IF CurrentFieldNo = FIELDNO("Applies-to Entry") THEN
                CheckItemAvailable(CurrentFieldNo);
            Rec := ItemJnlLine2;
        END;
    end;

    local procedure CheckItemAvailable(CalledByFieldNo: Integer)
    begin
        IF (CurrFieldNo = 0) OR (CurrFieldNo <> CalledByFieldNo) THEN // Prevent two checks on quantity
            EXIT;

        IF (CurrFieldNo <> 0) AND ("Item No." <> '') AND (Quantity <> 0) AND
           ("Value Entry Type" = "Value Entry Type"::"Direct Cost")
        THEN
            ;
        //
        //  IF ItemCheckAvail.ItemJnlCheckLine(Rec) THEN
        ItemCheckAvail.RaiseUpdateInterruptedError;
    end;

    procedure CheckILESUM()
    begin

        //,SParePare Requesting is More ThanYearly Default Qty,SparePart Issued + Qty Requesting is More than Yearly Default Quantity,SparePart Requesting has been Collected within the Last 6M/1Yr
        //TESTFIELD("Reason For Approval");

        IF ("Gen. Prod. Posting Group" = 'TYRE') THEN BEGIN
            IF (Quantity > 8) AND (NOT "Allow Approved Usage") THEN BEGIN
                MESSAGE('STOP!!!!\YOU CANT ISSUE MORE THAN 8 TYRES FROM THE STORE FOR VEHICLE %1 IN A YEAR. \GET IT APPROVED', "Shortcut Dimension 4 Code");
                "BLocking Notification" := TRUE; // 100417
                VALIDATE(Quantity, 0);
                "Reason For Approval" := 1;
            END;
        END;


        /*
                IF ("Gen. Prod. Posting Group" = 'BATTERY') THEN BEGIN
                    IF (Quantity > 2) AND (NOT "Allow Approved Usage") THEN BEGIN
                        MESSAGE('STOP!!!!\YOU CANT ISSUE MORE THAN 2 BATTERIES FOR VEHICLE %1 IN A YEAR. \GET IT APPROVED', "Shortcut Dimension 4 Code");
                        "BLocking Notification" := TRUE; // 100417
                        VALIDATE(Quantity, 0);
                        "Reason For Approval" := 1;

                    END;

        */

        /*
                    IF (TRUEJQty > 2) AND (NOT "Allow Approved Usage") THEN BEGIN
                        MESSAGE('STOP!!!!\YOU CANT ISSUE MORE THAN 2 BATTERIES, \QTY ISSUED in THE YEAR(%2) + Quantity(%3) now = %1 ,GET IT APPROVED', TRUEJQty, "Quantity USED Per Year", Quantity);
                        VALIDATE(Quantity, 0);
                    END;
    END;
*/
    end;

    procedure CheckPartUsagePsting()
    begin
    end;

    procedure CheckPartUsageDD()
    var
        ItemRec: Record Item;
        JLE: Record "Job Ledger Entry";
    begin

        // To use item Expiry Days not Inventory Posting Group

        // TESTFIELD("Approve/Reject","Approve/Reject"::Approved);
        //,SParePart Requesting is More ThanYearly Default Qty,
        //SparePart Issued + Qty Requesting is More than Yearly Default Qty,
        //SparePart Requested has already Exceeded the Yearly Default Qty,
        //SparePart Requesting has been Collected within the Last 6M/1Yr
        //Document  '%1'  requires your approv. \''%2' The %5 .\ Requires your permission for Tyres to be reused for Truck '%3'


        JobSetup.GET;
        IF JobSetup."Same part usage period@" = TRUE THEN BEGIN

            //022020   Used for Tyres that cannot exceed 8 Tyres a year
            IF ("Gen. Prod. Posting Group" = 'TYRE') AND (NOT "Allow Approved Usage") THEN BEGIN
                JLE.RESET;
                ServiceLine.SETRANGE("Allow Approved Usage", FALSE);
                JLE.SETRANGE(JLE."Service Item No.", "Vehicle Registration No.");
                JLE.SETFILTER(JLE."Posting Date", '%1..%2', JobSetup."Period Start for Items", JobSetup."Period End for Items");
                JLE.SETRANGE(JLE."Gen. Prod. Posting Group", 'TYRE');
                JLE.SETFILTER(JLE."Entry Type", '%1', JLE."Entry Type"::Usage);
                JLE.SETRANGE(JLE.Type, JLE.Type::Item);
                JLE.CALCSUMS(JLE.Quantity);
                JQty := JLE.Quantity;
                TRUEJQty := JLE.Quantity + Quantity;
                I := JLE.COUNT;
                IF JLE.FIND('-') THEN BEGIN
                    // REPEAT
                    ItemRec.GET("Item No.");
                    IF (JQty >= 8) AND (NOT "Allow Approved Usage") THEN   // OR (Quantity > 8)   THEN//(TRUEJQty > 8) THEN
                     BEGIN
                        TESTFIELD("Approve/Reject", 0);
                        "BLocking Notification" := TRUE; // 100417
                        "Last Inv Date" := JLE."Posting Date";
                        "Quantity CONSM Per Year" := JQty;
                        MESSAGE('TYRE %4 UNITs have been used on this same Vehicle No. %2 between %5 To %6. .\You can only issue 8 TYRES in a Year  .\Further approval is needed to use the part, please contact your Head Of Operations'
                             , "Item No.", "Vehicle Registration No.", JLE."Posting Date", JQty, JobSetup."Period Start for Items", JobSetup."Period End for Items");
                        VALIDATE(Quantity, 0);
                        "Reason For Approval" := 3;

                    END
                    ELSE BEGIN
                        "Quantity CONSM Per Year" := JQty;
                        MESSAGE('NOTE: \%1 No of Tyre(s) have being used From %2 TO %3 Already', JQty, JobSetup."Period Start for Items", JobSetup."Period End for Items");
                        "Reason For Approval" := 0;
                    END;
                    //  UNTIL JLE.NEXT =0;
                END;


            END;
            //022020   Used for Tyres that cannot exceed 8 Tyres a year



            /*
                        //022020   Used for Battery that cannot exceed 2 Batteries a year

                        IF ("Gen. Prod. Posting Group" = 'BATTERY') AND (NOT "Allow Approved Usage") THEN BEGIN
                            JLE.RESET;
                            //CALCSUMS("Shortcut Dimension 4 Code");
                            ServiceLine.SETRANGE("Allow Approved Usage", FALSE);
                            JLE.SETRANGE(JLE."Service Item No.", "Vehicle Registration No.");
                            JLE.SETFILTER(JLE."Posting Date", '%1..%2', JobSetup."Period Start for Items", JobSetup."Period End for Items");
                            JLE.SETRANGE(JLE."Gen. Prod. Posting Group", 'BATTERY');
                            JLE.SETFILTER(JLE."Entry Type", '%1', JLE."Entry Type"::Usage);
                            JLE.SETRANGE(JLE.Type, JLE.Type::Item);
                            JLE.CALCSUMS(JLE.Quantity);
                            JQty := JLE.Quantity;
                            TRUEJQty := JLE.Quantity + Quantity;
                            I := JLE.COUNT;
                            IF JLE.FIND('-') THEN BEGIN
                                // REPEAT
                                ItemRec.GET("Item No.");
                                IF (JQty >= 2) AND (NOT "Allow Approved Usage") THEN    //OR (Quantity > 8)   THEN//(TRUEJQty > 8) THEN
                                 BEGIN
                                    TESTFIELD("Approve/Reject", 0);
                                    "BLocking Notification" := TRUE; // 100417
                                    "Last Inv Date" := JLE."Posting Date";
                                    "Quantity CONSM Per Year" := JQty;
                                    MESSAGE('BATTERY(S) %4 UNITs have been used on this same Vehicle No. %2 between %5 To %6. .\You can only issue 2 BATTERIES in a Year  .\Further approval is needed to use the part, please contact your Head Of Operations'
                                         , "Item No.", "Vehicle Registration No.", JLE."Posting Date", JQty, JobSetup."Period Start for Items", JobSetup."Period End for Items");
                                    VALIDATE(Quantity, 0);
                                    "Reason For Approval" := 3;

                                END
                                ELSE BEGIN
                                    "Quantity CONSM Per Year" := JQty;
                                    MESSAGE('NOTE: \%1 No of BATTERY(s) have being used From %2 TO %3 Already', JQty, JobSetup."Period Start for Items", JobSetup."Period End for Items");
                                    "Reason For Approval" := 0;
                                END;
                            END;
                        END;
            /*
                        //022020   Used for Battery that cannot exceed 2 Batteries a year

                        /*            
                                    //022020   Used for SPARES that cannot exceed 6M/1YR
                                IF ("Gen. Prod. Posting Group" <> 'TYRES') OR ("Gen. Prod. Posting Group" <> 'BATTERY') THEN BEGIN
                                        ServiceLine.SETRANGE("Allow Approved Usage", FALSE);
                                        JLE.SETRANGE(JLE."Service Item No.", "Vehicle Registration No.");
                                        JLE.SETRANGE(JLE."Gen. Prod. Posting Group", "Gen. Prod. Posting Group");
                                        JLE.SETRANGE(JLE.Type, JLE.Type::Item);
                                        JLE.SETRANGE(JLE."No.", "Item No.");
                                        IF JLE.FINDLAST THEN BEGIN
                                            ItemRec.GET("Item No.");
                                            LastUsageDate := CALCDATE(ItemRec."Usage period (Warranty)", JLE."Posting Date");
                                            IF LastUsageDate <> "Request Date" THEN          //   "Posting Date" THEN
                                                IF ("Request Date" < LastUsageDate) AND (NOT "Allow Approved Usage") THEN BEGIN
                                                    TESTFIELD("Approve/Reject", 0);
                                                    "BLocking Notification" := TRUE; // 100417
                                                    "Reason For Approval" := 4;
                                                    "Last Inv Doc" := JLE."Document No.";
                                                    "Last Inv Date" := JLE."Posting Date";
                                                    MESSAGE('Part No. %1 was used on this same Vehicle No. %2 on %3  .\You can only issue this Item  utill %4 cos it has a %5 Yr/Mnth Warranty Usage Period.\Further approval is needed to use the part, please contact your Head Of Operations'
                                                         , "Request Date", "Service Item No.", JLE."Posting Date", LastUsageDate, ItemRec."Usage period (Warranty)");
                                                    VALIDATE(Quantity, 0);
                                                END;
                                        END;
                                    END;

                                    //022020   Used for SPARES that cannot exceed 6M/1YR
                        */
        END;


    end;
}

