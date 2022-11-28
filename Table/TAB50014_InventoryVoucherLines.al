table 50014 "Inventory Voucher Lines"
{

    fields
    {
        field(1; "Voucher Type"; Option)
        {
            OptionCaption = 'Damaged,Posted Damaged,Damaged Voucher,Shortages,Posted Shortages,Shortage Voucher,Expired,Posted Expired,Expired Voucher,PostiveAdj,Posted PostiveAdj,PositiveVoucher';
            OptionMembers = Damaged,"Posted Damaged","Damaged Voucher",Shortages,"Posted Shortages","Shortage Voucher",Expired,"Posted Expired","Expired Voucher",PostiveAdj,"Posted PostiveAdj",PositiveVoucher;
        }
        field(2; "Document No."; Code[20])
        {
        }
        field(3; "Line No."; Integer)
        {
        }
        field(4; "Item No."; Code[20])
        {
            TableRelation = Item;

            trigger OnValidate()
            begin
                ///TestStatusOpen;
                IF "Item No." = '' THEN
                    EXIT;

                Item.GET("Item No.");
                /// Item.TESTFIELD(Blocked,FALSE);
                //IF Item."Unit Cost" = 0 THEN
                //  ERROR(Text000,Item."No.")
                //ELSE
                BEGIN
                    Description := Item.Description;
                    "Description 2" := Item."Description 2";
                    "Unit of Measure Code" := Item."Base Unit of Measure";
                    "Inventory Posting Group" := Item."Inventory Posting Group";
                    "Item Category Code" := Item."Item Category Code";
                    // "Product Group Code" := Item."Product Group Code";
                    "Unit Cost" := Item."Unit Cost";
                    /// InvVoucherHdr.GET("Voucher Type","Document No.");
                    IF InvVoucherHdr."Voucher Type" = InvVoucherHdr."Voucher Type"::PostiveAdj THEN
                        "Gen. Prod. Posting Group" := 'RECONDITIO';//'Expired';

                    ///   "Location Code" := InvVoucherHdr."Location Code";
                    "Shortcut Dimension 1 Code" := InvVoucherHdr."Shortcut Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := InvVoucherHdr."Shortcut Dimension 2 Code";
                    "Posting Date" := InvVoucherHdr."Posting Date";
                    IF InvVoucherHdr."Voucher Type" = InvVoucherHdr."Voucher Type"::PostiveAdj THEN
                        "Document Type" := "Document Type"::"Positive Adjmt."
                    ELSE
                        "Document Type" := "Document Type"::"Negative Adjmt.";
                    Narration := InvVoucherHdr.Narration;
                END;
            end;
        }
        field(5; "Document Type"; Option)
        {
            OptionMembers = "Positive Adjmt.","Negative Adjmt.";
        }
        field(6; Description; Text[50])
        {

            trigger OnValidate()
            begin
                ///  TestStatusOpen;
            end;
        }
        field(7; "Description 2"; Text[50])
        {

            trigger OnValidate()
            begin
                /// TestStatusOpen;
            end;
        }
        field(8; "Location Code"; Code[20])
        {
            Editable = false;
            TableRelation = Location;

            trigger OnValidate()
            begin
                /// TestStatusOpen;
            end;
        }
        field(9; Quantity; Decimal)
        {

            trigger OnValidate()
            begin
                TestStatusOpen;
                CheckItemAvailable(FIELDNO(Quantity));

                Amount := Quantity * "Unit Cost";
            end;
        }
        field(10; "Unit Cost"; Decimal)
        {

            trigger OnValidate()
            begin
                TestStatusOpen;

                Amount := Quantity * "Unit Cost";
            end;
        }
        field(11; "Unit of Measure Code"; Code[20])
        {
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));

            trigger OnValidate()
            begin
                /// TestStatusOpen;
            end;
        }
        field(12; "Posting Date"; Date)
        {
        }
        field(13; "Inventory Posting Group"; Code[20])
        {
            TableRelation = "Inventory Posting Group";
        }
        field(14; "Gen. Prod. Posting Group"; Code[20])
        {
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            begin
                /// TestStatusOpen;
            end;
        }
        field(15; "Gen. Business Posting Group"; Code[20])
        {
            TableRelation = "Gen. Business Posting Group";
        }
        field(16; "External Document No."; Code[20])
        {

            trigger OnValidate()
            begin
                ///  TestStatusOpen;
            end;
        }
        field(17; "Posting No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(18; "Item Category Code"; Code[20])
        {
            TableRelation = "Item Category";
        }
        field(19; "Product Group Code"; Code[20])
        {
            TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(20; "Responsibility Center"; Code[20])
        {
        }
        field(21; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(22; Size; Code[20])
        {
        }
        field(23; Grade; Code[20])
        {
        }
        field(24; "Expiry Date"; Date)
        {
        }
        field(25; Amount; Decimal)
        {
        }
        field(26; Narration; Text[100])
        {
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDimensions;
            end;
        }
        field(50001; "Reason Code"; Code[20])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(60000; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);
                /// ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(60001; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);
                /// ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(60002; "Quantity In Location"; Decimal)
        {
            /// CalcFormula = Sum("Item Ledger Entry".Quantity WHERE (Item No.=FIELD(Item No.), Location Code=FIELD(Location Code)));
            Caption = 'Available Quantity';
            FieldClass = FlowField;
        }
        field(60003; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
    }

    keys
    {
        key(Key1; "Voucher Type", "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record Item;
        invsetup: Record "Inventory Setup";
        InvVoucherHdr: Record "Inventory Voucher Header";
        Text000: Label 'Unit Cost must not be 0 in Item No %1';

    /// DimMgt: Codeunit DimensionManagement;

    procedure TestStatusOpen()
    begin
        TESTFIELD("Document No.");
        IF (InvVoucherHdr."Voucher Type" <> "Voucher Type") OR (InvVoucherHdr."Document No." <> "Document No.") THEN
            InvVoucherHdr.GET("Voucher Type", "Document No.");
        InvVoucherHdr.TESTFIELD(Status, InvVoucherHdr.Status::Open);
    end;

    local procedure CheckItemAvailable(CalledByFieldNo: Integer)
    var
        ItemCheckAvail: Codeunit "Item-Check Avail.";
    begin
        /*IF (CurrFieldNo = 0) OR (CurrFieldNo <> CalledByFieldNo) THEN // Prevent two checks on quantity
          EXIT;
        
          IF (CurrFieldNo <> 0) AND ("Item No." <> '') AND (Quantity <> 0)
        THEN
          IF ItemCheckAvail.InventoryVoucherLineCheck(Rec) THEN
            ItemCheckAvail.RaiseUpdateInterruptedError;
         */

    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        /// DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");
    end;

    procedure ShowDimensions()
    var
        DocDim: Record "IC Document Dimension";
    begin
        /// "Dimension Set ID" :=
        ///  DimMgt.EditDimensionSet("Dimension Set ID",STRSUBSTNO('%1 %2 %3',"Voucher Type","Document No.","Line No."));
        /// DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
    end;
}

