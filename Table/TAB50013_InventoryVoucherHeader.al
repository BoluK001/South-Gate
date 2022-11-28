table 50013 "Inventory Voucher Header"
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
        field(3; "Document Type"; Option)
        {
            OptionCaption = 'Positive Adjmt.,Negative Adjmt.';
            OptionMembers = "Positive Adjmt.","Negative Adjmt.";
        }
        field(4; "Posting Date"; Date)
        {

            trigger OnValidate()
            var
                Location: Record Location;
                Confirmed: Boolean;
            begin
                TESTFIELD(Status, Status::Open);


                IF (xRec."Posting Date" <> "Posting Date") THEN BEGIN
                    IF HideValidationDialog OR
                      (xRec."Posting Date" = 0D)
                    THEN
                        Confirmed := TRUE
                    ELSE
                        Confirmed := CONFIRM(Text001, FALSE, FIELDCAPTION("Posting Date"));
                    IF Confirmed THEN
                        UpdateInvVoucherLines(FIELDNO("Posting Date"))
                    ELSE BEGIN
                        "Posting Date" := xRec."Posting Date";
                        EXIT;
                    END;
                END;
            end;
        }
        field(5; Status; Option)
        {
            OptionCaption = 'Open,Released,Pending Approval';
            OptionMembers = Open,Released,"Pending Approval";

            trigger OnValidate()
            begin
                ///UpdateInvVoucherLines(FIELDNO(Status))
            end;
        }
        field(6; "Location Code"; Code[20])
        {
            /// TableRelation = Location.Code WHERE ("Use As In-Transit"=FILTER(No));

            trigger OnValidate()
            var
                Location: Record Location;
                Confirmed: Boolean;
            begin
                TESTFIELD(Status, Status::Open);

                IF (xRec."Location Code" <> "Location Code") THEN BEGIN
                    IF HideValidationDialog OR
                      (xRec."Location Code" = '')
                    THEN
                        Confirmed := TRUE
                    ELSE
                        Confirmed := CONFIRM(Text001, FALSE, FIELDCAPTION("Location Code"));
                    IF Confirmed THEN
                        UpdateInvVoucherLines(FIELDNO("Location Code"))
                    ELSE BEGIN
                        "Location Code" := xRec."Location Code";
                        EXIT;
                    END;
                END;
            end;
        }
        field(7; "No. Series"; Code[20])
        {
        }
        field(25; Amount; Decimal)
        {
            /// CalcFormula = Sum("FS Setup Table".Field25 WHERE (Field1=FIELD(Voucher Type), Field2=FIELD(Document No.)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(100; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(101; "Created By Name"; Text[50])
        {
            Editable = false;
        }
        field(102; "Created Date"; Date)
        {
            Editable = false;
        }
        field(103; "Created Time"; Time)
        {
            Editable = false;
        }
        field(104; "Modified By"; Code[50])
        {
            Editable = false;
        }
        field(105; "Modified By Name"; Text[50])
        {
            Editable = false;
        }
        field(106; "Modified Date"; Date)
        {
            Editable = false;
        }
        field(107; "Modified Time"; Time)
        {
            Editable = false;
        }
        field(108; "Posted By"; Code[50])
        {
            Editable = false;
        }
        field(109; "Posted By Name"; Text[50])
        {
            Editable = false;
        }
        field(110; "Posted Date"; Date)
        {
            Editable = false;
        }
        field(111; "Posted Time"; Time)
        {
            Editable = false;
        }
        field(112; "Document Status"; Option)
        {
            OptionMembers = Created,Posted;
        }
        field(113; "Pre Assigned No."; Code[20])
        {
        }
        field(114; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
                UpdateInvVoucherLines(FIELDNO("Shortcut Dimension 1 Code"));
            end;
        }
        field(115; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
                UpdateInvVoucherLines(FIELDNO("Shortcut Dimension 2 Code"));
            end;
        }
        field(116; "Released Date"; Date)
        {
        }
        field(117; "Released By"; Code[50])
        {
        }
        field(118; Narration; Text[100])
        {
        }
        field(119; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
                UpdateInvVoucherLines(FIELDNO("Shortcut Dimension 3 Code"));
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDocDim;
            end;
        }
    }

    keys
    {
        key(Key1; "Voucher Type", "Document No.")
        {
        }
        key(Key2; "Document No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TESTFIELD(Status, Status::Open);

        InvVoucherLine.SETRANGE("Document No.", "Document No.");
        InvVoucherLine.DELETEALL(TRUE);
    end;

    trigger OnInsert()
    begin
        InvSetup.GET;

        IF "Document No." = '' THEN BEGIN
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", "Posting Date", "Document No.", "No. Series");
        END;

        IF "Posting Date" = 0D THEN
            "Posting Date" := WORKDATE;

        "Created By" := USERID;
        "Created Date" := TODAY;
        "Created Time" := TIME;
    end;

    trigger OnModify()
    begin

        "Modified By" := USERID;
        "Modified Date" := TODAY;
        "Modified Time" := TIME;
    end;

    var
        InvSetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        InvtSetup: Record "Inventory Setup";
        InvVoucherLine: Record "Inventory Voucher Lines";
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnLline: Record "Item Journal Line";
        ItemJnLline2: Record "Item Journal Line";
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";
        DocNo: Code[20];
        InvVoucherLine2: Record "Inventory Voucher Lines";
        InvVoucherHdr: Record "Inventory Voucher Header";
        HideValidationDialog: Boolean;
        Text001: Label 'Do you want to change %1?';
        /// DimMgt: Codeunit DimensionManagement;
        Text010: Label 'You may have changed a dimension.\\Do you want to update the lines?';
        VoucherLine: Record "Inventory Voucher Lines";
        LocationRec: Record Location;

    procedure AssistEdit(OldVoucherHeader: Record "Inventory Voucher Header"): Boolean
    begin
        InvSetup.GET;
        TestNoSeries;
        IF NoSeriesMgt.SelectSeries(GetNoSeriesCode, OldVoucherHeader."No. Series", "No. Series") THEN BEGIN
            InvSetup.GET;
            ;
            TestNoSeries;
            NoSeriesMgt.SetSeries("Document No.");
            EXIT(TRUE);
        END;
    end;

    local procedure TestNoSeries(): Boolean
    begin

        InvSetup.GET;
        CASE "Voucher Type" OF

            "Voucher Type"::PostiveAdj:
                InvSetup.TESTFIELD(InvSetup."Aggregate Nos");
        END;
    end;

    local procedure GetNoSeriesCode(): Code[20]
    begin

        InvSetup.GET;
        CASE "Voucher Type" OF
            "Voucher Type"::PostiveAdj:
                EXIT(InvSetup."Aggregate Nos");
        END;
    end;

    procedure PostDamages()
    var
        LineCount: Integer;
        Window: Dialog;
    begin
    end;

    procedure InVoucherLinesExist(): Boolean
    begin
        InvVoucherLine.RESET;
        InvVoucherLine.SETRANGE("Voucher Type", "Voucher Type");
        InvVoucherLine.SETRANGE("Document No.", "Document No.");
        EXIT(InvVoucherLine.FINDFIRST);
    end;

    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean)
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;

    local procedure UpdateInvVoucherLines(FieldRef: Integer)
    var
        InvVoucherLine: Record "Inventory Voucher Lines";
    begin
        InvVoucherLine.LOCKTABLE;
        InvVoucherLine.SETRANGE("Document No.", "Document No.");
        IF InvVoucherLine.FIND('-') THEN BEGIN
            REPEAT
                CASE FieldRef OF
                    FIELDNO("Location Code"):
                        BEGIN
                            InvVoucherLine.VALIDATE("Location Code", "Location Code");
                        END;
                /*  FIELDNO(Status): InvVoucherLine.VALIDATE(Status,Status);
                 FIELDNO("Posting Date"): InvVoucherLine.VALIDATE("Posting Date","Posting Date");
                 FIELDNO("Shortcut Dimension 1 Code"): InvVoucherLine.VALIDATE("Shortcut Dimension 1 Code","Shortcut Dimension 1 Code"); *///Gbenga

                END;
                InvVoucherLine.MODIFY(TRUE);
            UNTIL InvVoucherLine.NEXT = 0;
        END;
    end;

    procedure PostShortages()
    var
        LineCount: Integer;
        Window: Dialog;
    begin
    end;

    procedure PostExpired()
    var
        LineCount: Integer;
        Window: Dialog;
    begin
    end;

    procedure Navigate()
    var
        NavigatePage: Page Navigate;
    begin
        NavigatePage.SetDoc("Posting Date", "Document No.");
        NavigatePage.RUN;
    end;

    procedure VoucherLinesExist(): Boolean
    var
        VoucherLine: Record "Inventory Voucher Lines";
    begin
        VoucherLine.RESET;
        VoucherLine.SETRANGE("Voucher Type", "Voucher Type");
        VoucherLine.SETRANGE("Document No.", "Document No.");
        EXIT(VoucherLine.FINDFIRST);
    end;

    procedure PostPositiveAdj()
    var
        LineCount: Integer;
        Window: Dialog;
    begin
        InvtSetup.GET;
        InvVoucherLine.RESET;
        InvVoucherLine.SETRANGE(InvVoucherLine."Voucher Type", "Voucher Type");
        InvVoucherLine.SETRANGE(InvVoucherLine."Document No.", "Document No.");
        IF NOT InvVoucherLine.FIND('-') THEN
            ERROR('Line Item cannot be Blank');

        IF "Document No." <> '' THEN BEGIN
            // InvtSetup.TESTFIELD("Aggregate Nos"); Gbenga

            // DocNo := NoSeriesMgt.GetNextNo(InvtSetup."Posted Aggregate Nos","Posting Date",TRUE); Gbenga
        END;

        InvVoucherLine.SETRANGE(InvVoucherLine."Document No.", "Document No.");
        InvVoucherLine.SETRANGE(InvVoucherLine."Voucher Type", "Voucher Type");
        IF InvVoucherLine.FIND('-') THEN BEGIN
            REPEAT
                InvVoucherLine2.INIT;
                InvVoucherLine2.TRANSFERFIELDS(InvVoucherLine);
                InvVoucherLine2."Document Type" := InvVoucherLine2."Document Type"::"Positive Adjmt.";
                InvVoucherLine2."Voucher Type" := InvVoucherLine2."Voucher Type"::"Posted PostiveAdj";
                /*  InvVoucherLine2."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
                 InvVoucherLine2."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code"; *///Gbenga
                InvVoucherLine2."Document No." := DocNo;
                /* InvVoucherLine2."Posting Date" := "Posting Date";
                InvVoucherLine2.Narration := Narration; *///Gbenga
                InvVoucherLine2.INSERT;
            UNTIL InvVoucherLine.NEXT = 0;
        END;

        InvVoucherHdr := Rec;
        InvVoucherHdr.SETRANGE(InvVoucherHdr."Document No.", "Document No.");
        InvVoucherHdr.SETRANGE(InvVoucherHdr."Voucher Type", "Voucher Type");
        IF InvVoucherHdr.FINDFIRST THEN BEGIN
            InvVoucherHdr."Pre Assigned No." := "Document No.";
            InvVoucherHdr."Document No." := DocNo;
            InvVoucherHdr."Voucher Type" := InvVoucherHdr."Voucher Type"::"Posted PostiveAdj";
            InvVoucherHdr."Posting Date" := "Posting Date";
            InvVoucherHdr.Narration := Narration;
            InvVoucherHdr.INSERT;
        END;

        IF InvVoucherLine.FINDSET THEN BEGIN
            REPEAT
                ItemJnlBatch.GET('RECONDITIO', 'RECONDITIO');
                ItemJnLline.VALIDATE("Journal Template Name", 'RECONDITIO');
                ItemJnLline.VALIDATE("Journal Batch Name", 'RECONDITIO');
                ItemJnLline2.SETRANGE("Journal Template Name", ItemJnLline."Journal Template Name");
                ItemJnLline2.SETRANGE("Journal Batch Name", ItemJnLline."Journal Batch Name");
                IF ItemJnLline2.FIND('+') THEN
                    ItemJnLline."Line No." := ItemJnLline2."Line No." + 1000
                ELSE
                    ItemJnLline."Line No." := 1000;

                ItemJnLline.INIT;
                ItemJnLline.VALIDATE("Entry Type", ItemJnLline."Entry Type"::"Positive Adjmt.");
                ItemJnLline."Document No." := DocNo;
                ItemJnLline.VALIDATE("Posting Date", "Posting Date");
                IF InvVoucherLine."Item No." <> '' THEN BEGIN
                    ItemJnLline.VALIDATE("Item No.", InvVoucherLine."Item No.");
                    IF InvVoucherLine."Location Code" <> '' THEN
                        ItemJnLline.VALIDATE("Location Code", "Location Code");
                    ///ItemJnLline.VALIDATE("Gen. Prod. Posting Group" ,InvVoucherLine."Gen. Prod. Posting Group");
                    ItemJnLline.VALIDATE(ItemJnLline."Unit of Measure Code", InvVoucherLine."Unit of Measure Code");
                    ItemJnLline.VALIDATE(Quantity, InvVoucherLine.Quantity);
                    ///ItemJnLline.VALIDATE("Reason Code",InvVoucherLine."Reason Code");
                    ItemJnLline.VALIDATE("Unit Amount", InvVoucherLine."Unit Cost");
                    ItemJnLline.VALIDATE("Unit Cost", InvVoucherLine."Unit Cost");
                    ItemJnLline."Source Code" := 'ITEMJNL';
                    ///ItemJnLline.VALIDATE("Shortcut Dimension 1 Code",InvVoucherLine."Shortcut Dimension 1 Code");
                    ///ItemJnLline.VALIDATE("Shortcut Dimension 2 Code",InvVoucherLine."Shortcut Dimension 2 Code");
                END;
                ItemJnLline.INSERT;

            UNTIL InvVoucherLine.NEXT = 0;
        END;
        ItemJnlPostBatch.RUN(ItemJnLline);
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        ///DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");
        IF "Document No." <> '' THEN
            MODIFY;

        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            MODIFY;
            IF VoucherLinesExist THEN
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        END;
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        ATOLink: Record "Assemble-to-Order Link";
        NewDimSetID: Integer;
    begin
        // Update all lines with changed dimensions.

        IF NewParentDimSetID = OldParentDimSetID THEN
            EXIT;
        IF NOT CONFIRM(Text010) THEN
            EXIT;

        VoucherLine.RESET;
        VoucherLine.SETRANGE("Voucher Type", "Voucher Type");
        VoucherLine.SETRANGE("Document No.", "Document No.");
        VoucherLine.LOCKTABLE;
        IF VoucherLine.FIND('-') THEN
            REPEAT
            /* NewDimSetID := DimMgt.GetDeltaDimSetID(VoucherLine."Dimension Set ID",NewParentDimSetID,OldParentDimSetID);
                  IF VoucherLine."Dimension Set ID" <> NewDimSetID THEN BEGIN
                VoucherLine."Dimension Set ID" := NewDimSetID;
                DimMgt.UpdateGlobalDimFromDimSetID(
                  VoucherLine."Dimension Set ID",VoucherLine."Shortcut Dimension 1 Code",VoucherLine."Shortcut Dimension 2 Code");
                VoucherLine.MODIFY;
              END; */ ///Gbenga
            UNTIL VoucherLine.NEXT = 0;
    end;

    procedure ShowDocDim()
    var
        DocDim: Record "IC Document Dimension";
        DocDims: Page "IC Document Dimensions";
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        /* "Dimension Set ID" :=
          DimMgt.EditDimensionSet2(
            "Dimension Set ID",STRSUBSTNO('%1 %2',"Voucher Type","Document No."),
            "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code"); *///Gbenga
        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            MODIFY;
            IF VoucherLinesExist THEN
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        END;
    end;
}

