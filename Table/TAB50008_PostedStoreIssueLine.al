table 50008 "Posted Store Issue Line"
{
    Caption = 'Posted Store Issue Line';
    PasteIsValid = false;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
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
                ICPartner: Record "IC Partner";
                ItemCrossReference: Record "Item Cross Reference";
                PrepmtMgt: Codeunit "Prepayment Mgt.";
            begin
            end;
        }
        field(4; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            // TableRelation = Location WHERE (Use As In-Transit=CONST(No));
        }
        field(5; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(7; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(9; "Outstanding Quantity"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(10; "Job No."; Code[20])
        {
            Caption = 'Job No.';
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
        }
        field(23; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(24; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(25; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(26; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
        }
        field(27; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));
        }
        field(28; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));
        }
        field(29; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));
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
        field(40; "Quantity Received"; Decimal)
        {
        }
        field(41; "Quantity Invoiced"; Decimal)
        {
        }
        field(42; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
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
            /// ItemTrackingLines: Page "Item Tracking Lines";
            begin
                /*//IF "Appl.-to Item Entry" <> 0 THEN BEGIN
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
                  ItemLedgEntry.TESTFIELD(Positive,TRUE);
                  IF (ItemLedgEntry."Lot No." <> '') OR (ItemLedgEntry."Serial No." <> '') THEN
                    ERROR(Text040,ItemTrackingLines.CAPTION,FIELDCAPTION("Appl.-to Item Entry"));
                
                  IF Quantity > ItemLedgEntry.Quantity THEN
                    ERROR(ShippingMoreUnitsThanReceivedErr,ItemLedgEntry.Quantity,ItemLedgEntry."Document No.");
                
                  VALIDATE("Unit Cost",CalcUnitCost(ItemLedgEntry));
                
                  "Location Code" := ItemLedgEntry."Location Code";
                  IF NOT ItemLedgEntry.Open THEN
                    MESSAGE(Text042,"Appl.-to Item Entry");
                //END;
                 */

            end;
        }
        field(51; "Applies from Item Entry"; Integer)
        {
            Caption = 'Appl.-from Item Entry';
            Description = 'ddada';
            MinValue = 0;

            trigger OnLookup()
            begin
                //SelectItemEntry(FIELDNO("Applies from Item Entry"));
            end;

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
            /// ItemTrackingLines: Page "Item Tracking Lines";
            begin
                /*IF "Applies from Item Entry" <> 0 THEN BEGIN
                  TESTFIELD(Quantity);
                  {IF Signed(Quantity) < 0 THEN BEGIN
                    IF Quantity > 0 THEN
                      FIELDERROR(Quantity,Text030);
                    IF Quantity < 0 THEN
                      FIELDERROR(Quantity,Text029);
                  END;  }
                  ItemLedgEntry.GET("Applies from Item Entry");
                  ItemLedgEntry.TESTFIELD(Positive,FALSE);
                  IF (ItemLedgEntry."Lot No." <> '') OR (ItemLedgEntry."Serial No." <> '') THEN
                    ERROR(Text033,FIELDCAPTION("Applies from Item Entry"),ItemTrackingLines.CAPTION);
                  "Unit Cost" := CalcUnitCost(ItemLedgEntry);
                END;
                 */

            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDimensions;
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
        field(491; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(492; "TEMP GBPG"; Code[20])
        {
            /// CalcFormula = Lookup("Job Planning Line"."Gen. Bus. Posting Group" WHERE (Job No.=FIELD(Job No.), No.=FIELD(Item No.)));
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
        field(50082; "Service Item No."; Code[15])
        {
        }
        field(50083; "Send To"; Code[50])
        {
            Description = 'BLOCKING';
            /// TableRelation = "User Setup"."User ID" WHERE (Expired Items UnBlock StoreMgr=CONST(Yes));
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
        }
        field(50086; "Sent Date"; DateTime)
        {
            Description = 'BLOCKING';
        }
        field(50087; "Approve/Reject"; Option)
        {
            Description = 'BLOCKING';
            OptionMembers = " ",Approved,Reject;
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
        Text000: Label 'Request  No. %1:';
        Text001: Label 'The program cannot find this purchase line.';
}

