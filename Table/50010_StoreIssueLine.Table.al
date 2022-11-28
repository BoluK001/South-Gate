table 50010 "Store Issue Line"
{
    Caption = 'Store Issue Line';
    PasteIsValid = false;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';

            trigger OnValidate()
            begin
                ///
            end;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = Item;

            trigger OnValidate()
            var
            // ICPartner: Record "413";
            // ItemCrossReference: Record "5717";
            // PrepmtMgt: Codeunit "441";
            begin
                PurchReqHeader.GET("Document No.");

                //"Request Date" := PurchReqHeader."Request Date";
                //VALIDATE("Location Code" , PurchReqHeader.Location);
                VALIDATE("Shortcut Dimension 1 Code", PurchReqHeader."Shortcut Dimension 1 Code");
                VALIDATE("Shortcut Dimension 2 Code", PurchReqHeader."Shortcut Dimension 2 Code");
                VALIDATE("Shortcut Dimension 3 Code", PurchReqHeader."Shortcut Dimension 3 Code");
                VALIDATE("Shortcut Dimension 4 Code", PurchReqHeader."Shortcut Dimension 4 Code");
                VALIDATE("Shortcut Dimension 5 Code", PurchReqHeader."Shortcut Dimension 5 Code");
                VALIDATE("Shortcut Dimension 6 Code", PurchReqHeader."Shortcut Dimension 6 Code");
                VALIDATE("Shortcut Dimension 7 Code", PurchReqHeader."Shortcut Dimension 7 Code");
                VALIDATE("Shortcut Dimension 8 Code", PurchReqHeader."Shortcut Dimension 8 Code");
                VALIDATE("Material Request No.", PurchReqHeader."Material Request No.");
                VALIDATE("Request Type", PurchReqHeader."Request Type");
                VALIDATE("Expected Receipt Date", PurchReqHeader."Expected Receipt Date");
                VALIDATE("Requested Receipt Date", PurchReqHeader."Requested Receipt Date");
                VALIDATE(Status, PurchReqHeader.Status);
                VALIDATE("Job No.", PurchReqHeader."Job No.");
                VALIDATE("Job Task No.", PurchReqHeader."Job Task No.");


                IF "Item No." = '' THEN
                    EXIT;

                PurchReqHeader.GET("Document No.");
                ItemRec.GET("Item No.");
                ItemRec.TESTFIELD(Blocked, FALSE);
                VALIDATE(Description, ItemRec.Description);
                VALIDATE("Unit of Measure Code", ItemRec."Base Unit of Measure");
                VALIDATE("Inventory Posting Group", ItemRec."Inventory Posting Group");
                VALIDATE("Item Category Code", ItemRec."Item Category Code");
                //VALIDATE("Product Group Code" , ItemRec."Product Group Code");
                VALIDATE("Gen. Prod. Posting Group", ItemRec."Gen. Prod. Posting Group");
                VALIDATE("Unit Cost", ItemRec."Unit Cost");
                VALIDATE("Shortcut Dimension 1 Code", PurchReqHeader."Shortcut Dimension 1 Code");
                VALIDATE("Shortcut Dimension 2 Code", PurchReqHeader."Shortcut Dimension 2 Code");
                VALIDATE("Shortcut Dimension 3 Code", PurchReqHeader."Shortcut Dimension 3 Code");
                VALIDATE("Shortcut Dimension 4 Code", PurchReqHeader."Shortcut Dimension 4 Code");

            end;
        }
        field(4; "Location Code"; Code[20])
        {
            Caption = '"Location Code"';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(5; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
        }
        field(6; Description; Text[55])
        {
            Caption = 'Description';
        }
        field(7; "Description 2"; Text[55])
        {
            Caption = 'Description 2';
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                Amount := Quantity * "Unit Cost";



                IF Quantity > "Quantity Requested" THEN
                    //ERROR('Quantity Greater than Quantity Requested.');


                    CheckILESUM();



                CheckPartUsageDD();
            end;
        }
        field(9; "Outstanding Quantity"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(10; "Job No."; Code[20])
        {
            Caption = '"Job No."';
            TableRelation = Job;

            trigger OnValidate()
            var
                Job: Record Job;
            begin
            end;
        }
        field(11; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));
        }
        field(12; "Job Line Type"; Option)
        {
            Caption = 'Job Line Type';
            OptionCaption = ' ,Schedule,Contract,Both Schedule and Contract';
            OptionMembers = " ",Schedule,Contract,"Both Schedule and Contract";
        }
        field(13; "Job Unit Price"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Unit Price';
        }
        field(14; "Job Total Price"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Total Price';
            Editable = false;
        }
        field(15; "Job Line Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Job Line Amount';
        }
        field(16; "Job Line Discount Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Job Line Discount Amount';
        }
        field(17; "Job Line Discount %"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(19; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(20; "Product Group Code"; Code[20])
        {
            Caption = 'Product Group Code';
            TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(21; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';
        }
        field(22; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(23; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(24; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(25; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(26; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            end;
        }
        field(27; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");
            end;
        }
        field(28; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(7, "Shortcut Dimension 7 Code");
            end;
        }
        field(29; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(8, "Shortcut Dimension 8 Code");
            end;
        }
        field(30; "Unit of Measure Code"; Code[20])
        {
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(31; "Inventory Posting Group"; Code[20])
        {
            TableRelation = "Inventory Posting Group";
        }
        field(32; "Gen. Prod. Posting Group"; Code[20])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(33; "Request Date"; Date)
        {
        }
        field(34; "Unit Cost"; Decimal)
        {

            trigger OnValidate()
            begin
                Amount := Quantity * "Unit Cost"
            end;
        }
        field(35; "Variant Code"; Code[20])
        {
        }
        field(36; "Unit Price"; Decimal)
        {
        }
        field(37; Amount; Decimal)
        {
        }
        field(38; "Material Request No."; Code[20])
        {
        }
        field(39; "Qty on Purch. Order"; Decimal)
        {
        }
        field(40; Inventory; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                  "Location Code" = FIELD("Location Code")));
            FieldClass = FlowField;
        }
        field(41; "Quantity Invoiced"; Decimal)
        {
        }
        field(42; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
            TableRelation = "Purch. Rcpt. Line"."Line No." WHERE("Document No." = FIELD("Document No."));
        }
        field(43; Status; Option)
        {
            OptionCaption = 'Open,Released,Pending Approval';
            OptionMembers = Open,Released,"Pending Approval";
        }
        field(44; "Request Type"; Option)
        {
            OptionCaption = 'Job,Inventory';
            OptionMembers = Job,Inventory;

            trigger OnValidate()
            begin
                "Material Request No." := '';
            end;
        }
        field(50; "Appl.-to Item Entry"; Integer)
        {
            Caption = 'Appl.-to Item Entry';
            Description = 'ddada';

            trigger OnLookup()
            begin
                //sElectItemEntry(FIELDNO("Appl.-to Item Entry"));
            end;

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
                ItemTrackingLines: Page "Item Tracking Lines";
            begin
                //IF "Appl.-to Item Entry" <> 0 THEN BEGIN
                //  AddOnIntegrMgt.CheckReceiptOrderStatus(Rec);

                //TESTFIELD(Type,Type::Item);
                TESTFIELD(Quantity);
                // IF "Entry Type" IN ["Entry Type"::Return] THEN BEGIN
                //  IF Quantity > 0 THEN
                //    FIELDERROR(Quantity,Text030);
                //  ELSE BEGIN
                //   IF Quantity < 0 THEN
                //      FIELDERROR(Quantity,Text029);
                //  END;
                ItemLedgEntry.GET("Appl.-to Item Entry");
                ItemLedgEntry.TESTFIELD(Positive, TRUE);
                IF (ItemLedgEntry."Lot No." <> '') OR (ItemLedgEntry."Serial No." <> '') THEN
                    ERROR(Text040, ItemTrackingLines.CAPTION, FIELDCAPTION("Appl.-to Item Entry"));

                IF Quantity > ItemLedgEntry.Quantity THEN
                    ERROR(ShippingMoreUnitsThanReceivedErr, ItemLedgEntry.Quantity, ItemLedgEntry."Document No.");

                VALIDATE("Unit Cost", CalcUnitCost(ItemLedgEntry));

                "Location Code" := ItemLedgEntry."Location Code";
                IF NOT ItemLedgEntry.Open THEN
                    MESSAGE(Text042, "Appl.-to Item Entry");
                //END;


            end;
        }
        field(51; "Applies from Item Entry"; Integer)
        {
            Caption = 'Appl.-from Item Entry';
            Description = 'ddada';
            MinValue = 0;

            trigger OnLookup()
            begin
                SelectItemEntry(FIELDNO("Applies from Item Entry"));
            end;

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
                ItemTrackingLines: Page "Item Tracking Lines";
            begin
                IF "Applies from Item Entry" <> 0 THEN BEGIN
                    TESTFIELD(Quantity);
                    /*  IF Signed(Quantity) < 0 THEN BEGIN
                       IF Quantity > 0 THEN
                         FIELDERROR(Quantity,Text030);
                       IF Quantity < 0 THEN
                         FIELDERROR(Quantity,Text029);
                     END; */
                    ItemLedgEntry.GET("Applies from Item Entry");
                    ItemLedgEntry.TESTFIELD(Positive, FALSE);
                    IF (ItemLedgEntry."Lot No." <> '') OR (ItemLedgEntry."Serial No." <> '') THEN
                        ERROR(Text033, FIELDCAPTION("Applies from Item Entry"), ItemTrackingLines.CAPTION);
                    "Unit Cost" := CalcUnitCost(ItemLedgEntry);
                END;

            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ///ShowDimensions;
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
        field(489; "Quantity Requested"; Decimal)
        {
            Editable = false;
        }
        field(490; "Inventory Qty."; Decimal)
        {
            BlankNumbers = BlankZero;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                  "Location Code" = FIELD("Location Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(491; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";// WHERE("Service Only" = FILTER(true));
        }
        field(492; "TEMP GBPG"; Code[20])
        {
            CalcFormula = Lookup("Job Planning Line"."Gen. Bus. Posting Group" WHERE("Job No." = FIELD("Job No."), "No." = FIELD("Item No.")));
            Description = 'sss';
            FieldClass = FlowField;
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
        field(50082; "Vehicle Registration No."; Code[20])
        {
        }
        field(50083; "Send To"; Code[50])
        {
            Description = 'BLOCKING';
            //  TableRelation = "User Setup"."User ID" WHERE("Expired Items UnBlock Mgr" = CONST(true));
        }
        field(50084; Sender; Code[50])
        {
            Description = 'BLOCKING';
        }
       /*  field(50085; "Send For Approval"; Option)
        {
            Description = 'BLOCKING';
            OptionCaption = ' ,Send,Re-Send';
            OptionMembers = " ",Send,"Re-Send";

            trigger OnValidate()
            var
                Mailsender: Codeunit 397;
            begin
                TESTFIELD("Reason For Approval");

                Item.GET("Item No.");

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
                        //Subject:=STRSUBSTNO(text101,"Document No.","Service Item No.");
                        //Body:= STRSUBSTNO(Text107,"Document No.","Item No.","Service Item No.","Reason For Approval");
                        // Mailsender.NewMessage('ddada@agleventis.com',JobSetup."Email to copy 4 Tyres/Battery",Subject,Body,attachement,FALSE);
                        /// Mailsender.NewMessage(UserSetup."E-Mail", JobSetup."Email to copy 4 Tyres/Battery", Subject, Body, attachement, FALSE);
                        TESTFIELD("Approve/Reject", 0);
                        //END;
                    END ELSE BEGIN
                        IF (UserSetup.GET("Send To")) AND ("Gen. Prod. Posting Group" = 'TYRE') THEN BEGIN
                            TESTFIELD("Reason For Approval");
                            TESTFIELD("Send To");
                            Sender := USERID;
                            "Sent Date" := CURRENTDATETIME;
                            TESTFIELD("Send To");
                            Subject := STRSUBSTNO(text101, "Document No.", "Vehicle Registration No.");
                            Body := STRSUBSTNO(Text106, "Document No.", "Item No.", "Vehicle Registration No.", "Reason For Approval");
                            //Mailsender.NewMessage('ddada@agleventis.com',JobSetup."Email to copy 4 Tyres/Battery",Subject,Body,attachement,FALSE);
                            ///Mailsender.NewMessage('dirabor@agleventis.com', JobSetup."Email to copy 4 Tyres/Battery", Subject, Body, attachement, FALSE);
                            TESTFIELD("Approve/Reject", 0);
                            //   END;
                        END ELSE BEGIN
                            IF UserSetup.GET("Send To") THEN BEGIN
                                Sender := USERID;
                                "Sent Date" := CURRENTDATETIME;
                                TESTFIELD("Send To");
                                Subject := STRSUBSTNO(text101, "Document No.");
                                Body := STRSUBSTNO(text102, "Document No.", "Item No.", Item."Usage period (Warranty)", "Vehicle Registration No.", "Reason For Approval");
                                /// Mailsender.NewMessage(UserSetup."E-Mail", JobSetup."Email to copy For Spares", Subject, Body, attachement, FALSE);
                                TESTFIELD("Approve/Reject", 0);
                            END;
                        END;
                    END;
                END;

            end;
        } */
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
                /*  TempPerm.GET(USERID);
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
            Clustered = true;
        }
        key(Key2; "Item No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        PurchCommentLine: Record "Purch. Comment Line";
    begin
    end;

    var
        ItemRec: Record Item;
        PurchReqHeader: Record "Store Issue Header";
        Text000: Label 'Request  No. %1:';
        Text001: Label 'The program cannot find this purchase line.';
        Currency: Record Currency;
        DimMgt: Codeunit DimensionManagement;
        Text029: Label 'must be positive';
        Text030: Label 'must be negative';
        Text040: Label 'You must use form %1 to enter %2, if item tracking is used.';
        Text042: Label 'When posting the Applied to Ledger Entry %1 will be opened first';
        ShippingMoreUnitsThanReceivedErr: Label 'You cannot ship more than the %1 units that you have received for document no. %2.';
        SalesLineCompletelyShippedErr: Label 'You cannot change the purchasing code for a sales line that has been completely shipped.';
        Text033: Label 'If the item carries serial or lot numbers, then you must use the %1 field in the %2 window.';
        TOTQty: Decimal;
        I: Integer;
        JQty: Decimal;
        TRUEJQty: Decimal;
        JQty2: Decimal;
        TRUEJQty2: Decimal;
        Mailsender: Codeunit "Mail";
        ToName: Text[80];
        CCName: Text[80];
        Subject: Text[50];
        Body: Text[260];
        attachement: Text[260];
        UserSetup: Record "User Setup";
        //TempPerm: Record "39006162";
        GLAcc: Record "G/L Account";
        ServMgtSetup: Record "Service Mgt. Setup";
        Item: Record item;
        JobSetup: Record "Jobs Setup";
        text101: Label 'Document  ''%1''  requires your approv.';
        text102: Label 'Document  ''%1''  requires your approv.  . \''%2'' .The %5  ''%3'' Months  .\ Requires your permission to be reused for Truck no. ''%4''.';
        text103: Label 'Document ''%1'' has been approved';
        text104: Label 'Document ''%1'' has been rejected';
        text105: Label 'Document ''%1'' is on hold';
        Text106: Label 'Document  ''%1''  requires your approv  .\ ''''%2'' The %5  .\ Requires your permission for Tyres to be reused for Truck ''%3''';
        Text107: Label 'Document  ''%1''  requires your approv .\ ''''%2'' The %5  .\ Requires your permission for Batt(s) to be reused for Truck ''%3''';
        ServiceLine: Record "Service Line";
        LastUsageDate: Date;
    /*
    Reservation: Page Reservation;
                     ReservMgt: Codeunit "Reservation Management";
                     ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
                     ReserveSalesLine: Codeunit "Sales Line-Reserve";
                     ReserveJobJnlLine: Codeunit "Job Jnl. Line-Reserve";
                     */

    //[Scope('OnPrem')]
    procedure CheckILESUM()
    begin

        //,SParePare Requesting is More ThanYearly Default Qty,SparePart Issued + Qty Requesting is More than Yearly Default Quantity,SparePart Requesting has been Collected within the Last 6M/1Yr
        //TESTFIELD("Reason For Approval");

        IF ("Gen. Prod. Posting Group" = 'TYRE') THEN BEGIN
            IF (Quantity > 8) AND (NOT "Allow Approved Usage") THEN BEGIN
                MESSAGE('STOP!!!!\YOU CANT ISSUE MORE THAN 8 TYRES FROM THE STORE FOR VEHICLE %1 IN A YEAR. \GET IT APPROVED', "Shortcut Dimension 4 Code");
                "BLocking Notification" := TRUE; //DDADA  100417
                VALIDATE(Quantity, 0);
                "Reason For Approval" := 1;
            END;
        END;



        IF ("Gen. Prod. Posting Group" = 'BATTERY') THEN BEGIN
            IF (Quantity > 2) AND (NOT "Allow Approved Usage") THEN BEGIN
                MESSAGE('STOP!!!!\YOU CANT ISSUE MORE THAN 2 BATTERIES FOR VEHICLE %1 IN A YEAR. \GET IT APPROVED', "Shortcut Dimension 4 Code");
                "BLocking Notification" := TRUE; //DDADA  100417
                VALIDATE(Quantity, 0);
                "Reason For Approval" := 1;

            END;
        END;
    end;

    //[Scope('OnPrem')]
    procedure CheckPartUsagePsting()
    begin
    end;

    //[Scope('OnPrem')]
    procedure CheckPartUsageDD()
    var
        ItemRec: Record item;
        JLE: Record "Job Ledger Entry";
    begin

        // To use item Expiry Days not Inventory Posting Group
        //DDADA  092117
        // TESTFIELD("Approve/Reject","Approve/Reject"::Approved);
        //,SParePart Requesting is More ThanYearly Default Qty,
        //SparePart Issued + Qty Requesting is More than Yearly Default Qty,
        //SparePart Requested has already Exceeded the Yearly Default Qty,
        //SparePart Requesting has been Collected within the Last 6M/1Yr
        //Document  '%1'  requires your approv. \''%2' The %5 .\ Requires your permission for Tyres to be reused for Truck '%3'


        JobSetup.GET;
        IF JobSetup."Same part usage period@" = TRUE THEN BEGIN

            //ddada 022020   Used for Tyres that cannot exceed 8 Tyres a year
            IF ("Gen. Prod. Posting Group" = 'TYRE') AND (NOT "Allow Approved Usage") THEN BEGIN
                JLE.RESET;
                //CALCSUMS("Shortcut Dimension 4 Code");
                //ServiceLine.SETRANGE("Allow Approved Usage", FALSE);
                JLE.SETRANGE(JLE."Service Item No.", "Vehicle Registration No.");
                //JLE.SETRANGE(JLE."Service Item No.","Shortcut Dimension 4 Code"); //"Service Item No.");
                JLE.SETFILTER(JLE."Posting Date", '%1..%2', JobSetup."Period Start for Items", JobSetup."Period End for Items");
                //JLE.SETFILTER(JLE."Item Type",'%1',JLE."Item Type"::Tyres);        //,Spares,Lubricant,Tyres,Battery,Fuel,Others,Labour,Tyres_Accesories
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
                    IF (JQty >= 8) AND (NOT "Allow Approved Usage") THEN   ///OR (Quantity > 8)   THEN//(TRUEJQty > 8) THEN
                        BEGIN
                        TESTFIELD("Approve/Reject", 0);
                        "BLocking Notification" := TRUE; //DDADA  100417
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
            //ddada 022020   Used for Tyres that cannot exceed 8 Tyres a year

            //Reason For Approval
            //

            //ddada 022020   Used for Battery that cannot exceed 2 Batteries a year

            IF ("Gen. Prod. Posting Group" = 'BATTERY') AND (NOT "Allow Approved Usage") THEN BEGIN
                JLE.RESET;
                //CALCSUMS("Shortcut Dimension 4 Code");
                //ServiceLine.SETRANGE("Allow Approved Usage", FALSE);
                //JLE.SETRANGE(JLE."Service Item No.", "Vehicle Registration No.");
                //JLE.SETRANGE(JLE."Service Item No.","Shortcut Dimension 4 Code"); //"Service Item No.");
                JLE.SETFILTER(JLE."Posting Date", '%1..%2', JobSetup."Period Start for Items", JobSetup."Period End for Items");
                //JLE.SETFILTER(JLE."Item Type",'%1',JLE."Item Type"::Tyres);        //,Spares,Lubricant,Tyres,Battery,Fuel,Others,Labour,Tyres_Accesories
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
                    IF (JQty >= 2) AND (NOT "Allow Approved Usage") THEN   ///OR (Quantity > 8)   THEN//(TRUEJQty > 8) THEN
                        BEGIN
                        TESTFIELD("Approve/Reject", 0);
                        "BLocking Notification" := TRUE; //DDADA  100417
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

            //ddada 022020   Used for Battery that cannot exceed 2 Batteries a year



            /*
                //ddada 022020   Used for SPARES that cannot exceed 6M/1YR
            IF ("Gen. Prod. Posting Group" <> 'TYRES') OR ( "Gen. Prod. Posting Group" <> 'BATTERY') THEN
            BEGIN
                  ServiceLine.SETRANGE("Allow Approved Usage",FALSE);
                  JLE.SETRANGE(JLE."Service Item No.","Service Item No.");
                  //JLE.SETFILTER(JLE."Item Type",'%1|%2',JLE."Item Type"::Spares,JLE."Item Type"::Others);       //ddstoped on 07172020
                  //JLE.SETFILTER(JLE."Item Type",'<>%1',JLE."Item Type"::Tyres);        //,Spares,Lubricant,Tyres,Battery,Fuel,Others,Labour,Tyres_Accesories
                  JLE.SETRANGE(JLE."Gen. Prod. Posting Group","Gen. Prod. Posting Group");
                  JLE.SETRANGE(JLE.Type,JLE.Type::Item);
                  JLE.SETRANGE(JLE."No.","Item No.");
                  IF  JLE.FINDLAST THEN BEGIN
                   ItemRec.GET("Item No.");
                   LastUsageDate := CALCDATE(ItemRec."Usage period (Warranty)",JLE."Posting Date");
                   IF LastUsageDate <> "Request Date" THEN          //   "Posting Date" THEN
                   IF("Request Date" < LastUsageDate) AND (NOT "Allow Approved Usage") THEN
                     BEGIN
                     TESTFIELD("Approve/Reject",0);
                    "BLocking Notification" :=TRUE; //DDADA  100417
                     "Reason For Approval" :=4;
                    "Last Inv Doc":= JLE."Document No.";
                    "Last Inv Date":= JLE."Posting Date";
                    // MESSAGE('Last JLE date %1,./Last Usage Date:%2,./Current Posting Date:%3,./Item Period:%4./',JLE."Posting Date",LastUsageDate,"Posting Date",ItemRec."Usage period (Warranty)");
                     MESSAGE('Part No. %1 was used on this same Vehicle No. %2 on %3  .\You can only issue this Item  utill %4 cos it has a %5 Yr/Mnth Warranty Usage Period.\Further approval is needed to use the part, please contact your Head Of Operations'
                          ,"Request Date","Service Item No.",JLE."Posting Date",LastUsageDate,ItemRec."Usage period (Warranty)");
                     VALIDATE(Quantity,0);
                     END;
                  END;
             END;
             */
            //ddada 022020   Used for SPARES that cannot exceed 6M/1YR

        END;

    end;

    //[Scope('OnPrem')]
    procedure InsertInvLineFromReqLine(var PurchLine: Record "Purchase Line")
    var
        PurchInvHeader: Record "Purchase Header";
        PurchOrderHeader: Record "Purchase Header";
        PurchOrderLine: Record "Purchase Line";
        TempPurchLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        TransferOldExtLines: Codeunit "Transfer Old Ext. Text Lines";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        NextLineNo: Integer;
        ExtTextLine: Boolean;
    begin
        SETRANGE("Document No.", "Document No.");

        CALCFIELDS("Qty on Purch. Order");
        IF (Quantity - "Qty on Purch. Order") > 0 THEN BEGIN

            TempPurchLine := PurchLine;
            IF PurchLine.FIND('+') THEN
                NextLineNo := PurchLine."Line No." + 10000
            ELSE
                NextLineNo := 10000;

            IF PurchInvHeader."No." <> TempPurchLine."Document No." THEN
                PurchInvHeader.GET(TempPurchLine."Document Type", TempPurchLine."Document No.");

            /*IF PurchLine."Receipt No." <> "Document No." THEN BEGIN
              PurchLine.INIT;
              PurchLine."Line No." := NextLineNo;
              PurchLine."Document Type" := TempPurchLine."Document Type";
              PurchLine."Document No." := TempPurchLine."Document No.";
              PurchLine.Description := STRSUBSTNO(Text000,"Document No.");
              PurchLine.INSERT;
              NextLineNo := NextLineNo + 10000;
            END;
            */

            TransferOldExtLines.ClearLineNumbers;

            REPEAT

                ExtTextLine := (TransferOldExtLines.GetNewLineNumber("Attached to Line No.") <> 0);

                PurchLine := PurchOrderLine;
                PurchLine."Line No." := NextLineNo;
                PurchLine."Document Type" := TempPurchLine."Document Type";
                PurchLine."Document No." := TempPurchLine."Document No.";
                CALCFIELDS("Qty on Purch. Order");
                PurchLine.Type := PurchLine.Type::Item;
                PurchLine.VALIDATE("No.", "Item No.");
                PurchLine."Variant Code" := "Variant Code";
                PurchLine.VALIDATE("Location Code", "Location Code");
                PurchLine.VALIDATE("Job No.", "Job No.");
                PurchLine.VALIDATE("Job Task No.", "Job Task No.");
                // PurchLine."Purch. Request No." := "Document No.";
                PurchLine."Quantity (Base)" := 0;
                PurchLine.Quantity := 0;
                PurchLine."Outstanding Qty. (Base)" := 0;
                PurchLine."Outstanding Quantity" := 0;
                PurchLine."Quantity Received" := 0;
                PurchLine."Qty. Received (Base)" := 0;
                PurchLine."Quantity Invoiced" := 0;
                PurchLine."Qty. Invoiced (Base)" := 0;
                PurchLine.Amount := 0;
                PurchLine."Amount Including VAT" := 0;
                PurchLine."Sales Order No." := '';
                PurchLine."Sales Order Line No." := 0;
                PurchLine."Drop Shipment" := FALSE;
                PurchLine."Special Order Sales No." := '';
                PurchLine."Special Order Sales Line No." := 0;
                PurchLine."Special Order" := FALSE;
                PurchLine."Receipt Line No." := "Line No.";
                PurchLine."Appl.-to Item Entry" := 0;
                PurchLine."Prepmt. Amt. Inv." := 0;
                IF NOT ExtTextLine THEN BEGIN
                    CALCFIELDS("Qty on Purch. Order");
                    PurchLine.VALIDATE(Quantity, Quantity - "Qty on Purch. Order");
                    PurchLine.VALIDATE("Direct Unit Cost", PurchOrderLine."Direct Unit Cost");
                    PurchSetup.GET;
                END;

                PurchLine."Attached to Line No." :=
                 TransferOldExtLines.TransferExtendedText(
                  "Line No.",
                   NextLineNo,
                   "Attached to Line No.");

                PurchLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
                PurchLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                PurchLine."Dimension Set ID" := "Dimension Set ID";

                PurchLine.INSERT;

                // ItemTrackingMgt.CopyHandledItemTrkgToInvLine2(PurchOrderLine, PurchLine); //Dennis

                NextLineNo := NextLineNo + 10000;
                IF "Attached to Line No." = 0 THEN
                    SETRANGE("Attached to Line No.", "Line No.");
            UNTIL (NEXT = 0) OR ("Attached to Line No." = 0);
        END;

    end;

    //[Scope('OnPrem')]
    procedure TestStatusOpen()
    begin
        /*TESTFIELD("Document No.");
        IF (PurchReqHeader."No." <> "Document No.") THEN
          PurchReqHeader.GET("Document No.");
        PurchReqHeader.TESTFIELD(Status,PurchReqHeader.Status::Open);
             */

    end;

    //[Scope('OnPrem')]
    procedure ShowDimensions()
    var
        DocDim: Record "IC Document Dimension";
        DimMgt: Codeunit DimensionManagement;

    begin
        "Dimension Set ID" := DimMgt.EditDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2', "Document No.", "Line No."));
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    //[Scope('OnPrem')]
    procedure ShowShortcutDimCode(var ShortcutDimCode: array[15] of Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    //[Scope('OnPrem')]
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    //[Scope('OnPrem')]
    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
    end;

    local procedure CalcUnitCost(ItemLedgEntry: Record "Item Ledger Entry"): Decimal
    var
        ValueEntry: Record "Value Entry";
        UnitCost: Decimal;
    begin
        WITH ValueEntry DO BEGIN
            RESET;
            SETCURRENTKEY("Item Ledger Entry No.");
            SETRANGE("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
            CALCSUMS("Cost Amount (Expected)", "Cost Amount (Actual)");
            UnitCost :=
              ("Cost Amount (Expected)" + "Cost Amount (Actual)") / ItemLedgEntry.Quantity;
        END;
        EXIT(ABS(UnitCost * 1));
    end;

    local procedure SelectItemEntry(CurrentFieldNo: Integer)
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemJnlLine2: Record "Store Issue Line";
    begin
        ItemLedgEntry.SETCURRENTKEY("Item No.", Positive);
        ItemLedgEntry.SETRANGE("Item No.", "Item No.");
        ItemLedgEntry.SETRANGE("Job No.", "Job No.");
        ItemLedgEntry.SETRANGE(Correction, FALSE);

        IF "Location Code" <> '' THEN
            ItemLedgEntry.SETRANGE("Location Code", "Location Code");

        IF PAGE.RUNMODAL(PAGE::"Item Ledger Entries", ItemLedgEntry) = ACTION::LookupOK THEN BEGIN
            ItemJnlLine2 := Rec;
            ItemJnlLine2.VALIDATE("Applies from Item Entry", ItemLedgEntry."Entry No.");
            CheckItemAvailable(CurrentFieldNo);
            Rec := ItemJnlLine2;
        END;
    end;

    local procedure CheckItemAvailable(CalledByFieldNo: Integer)
    begin
        IF (CurrFieldNo = 0) OR (CurrFieldNo <> CalledByFieldNo) THEN // Prevent two checks on quantity
            EXIT;

        /*IF (CurrFieldNo <> 0) AND ("Item No." <> '') AND (Quantity <> 0) AND
           ("Value Entry Type" = "Value Entry Type"::"Direct Cost") AND ("Item Charge No." = '')
        THEN
          IF ItemCheckAvail.ItemJnlCheckLine(Rec) THEN
            ItemCheckAvail.RaiseUpdateInterruptedError;
         */

    end;

    //[Scope('OnPrem')]
    procedure OpenItemTrackingLinesXXX()
    var
        Job: Record Job;
    begin
        TESTFIELD("Item No.");
        TESTFIELD(Quantity);

        //IF "Job Contract Entry No." <> 0 THEN
        //  ERROR(Text048,TABLECAPTION,Job.TABLECAPTION);

        //ReserveSalesLine.CallItemTracking(Rec);
        //REMMED FOR REELTECH REVIEW
    end;

    //[Scope('OnPrem')]
    procedure OpenItemTrackingLines(IsReclass: Boolean)
    begin
        TESTFIELD("Item No.");
        //ReserveJobJnlLine.CallItemTracking(Rec,IsReclass);
    end;
}

