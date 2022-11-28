table 50009 "Store Issue Header"
{
    Caption = 'Store Issue Header';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Description; Text[55])
        {
        }
        field(3; "Description 2"; Text[55])
        {
            Caption = 'Job Task Description';
        }
        field(4; "Posting Date"; Date)
        {

            trigger OnValidate()
            begin
                ///UpdateReqLine(FIELDNO("Posting Date"));
            end;
        }
        field(5; Location; Code[20])
        {
            ///TableRelation = Location WHERE (Use As In-Transit=CONST(No), Workshop=CONST(No));

            trigger OnValidate()
            begin
                /// UpdateReqLine(FIELDNO(Location));
            end;
        }
        field(6; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';

            trigger OnValidate()
            begin
                ///UpdateReqLine(FIELDNO("Expected Receipt Date"));
            end;
        }
        field(7; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';

            trigger OnValidate()
            begin
                /// UpdateReqLine(FIELDNO("Requested Receipt Date"));
            end;
        }
        field(8; "Requested By"; Code[50])
        {
            Editable = false;
        }
        field(9; "Requested By Name"; Text[50])
        {
            Editable = false;
        }
        field(10; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(11; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("""Global Dimension No.""" = CONST(1));

            trigger OnValidate()
            begin
                ///  ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
                ///   UpdateReqLine(FIELDNO("Shortcut Dimension 1 Code"));
            end;
        }
        field(12; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                /// ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
                /// UpdateReqLine(FIELDNO("Shortcut Dimension 2 Code"));
            end;
        }
        field(13; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                /// ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                /// UpdateReqLine(FIELDNO("Shortcut Dimension 3 Code"));
            end;
        }
        field(14; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

            trigger OnValidate()
            begin
                /// ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
                /// UpdateReqLine(FIELDNO("Shortcut Dimension 4 Code"));
            end;
        }
        field(15; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));

            trigger OnValidate()
            begin
                /// ValidateShortcutDimCode(5,"Shortcut Dimension 5 Code");
                ///  UpdateReqLine(FIELDNO("Shortcut Dimension 5 Code"));
            end;
        }
        field(16; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));

            trigger OnValidate()
            begin
                /// ValidateShortcutDimCode(6,"Shortcut Dimension 6 Code");
                /// UpdateReqLine(FIELDNO("Shortcut Dimension 6 Code"));
            end;
        }
        field(17; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));

            trigger OnValidate()
            begin
                /// ValidateShortcutDimCode(7,"Shortcut Dimension 7 Code");
                ///  UpdateReqLine(FIELDNO("Shortcut Dimension 7 Code"));
            end;
        }
        field(18; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));

            trigger OnValidate()
            begin
                /// ValidateShortcutDimCode(8,"Shortcut Dimension 8 Code");
                //  UpdateReqLine(FIELDNO("Shortcut Dimension 8 Code"));
            end;
        }
        field(19; "Job No."; Code[20])
        {
            TableRelation = Job;

            trigger OnValidate()
            var
                JobRec: Record Job;
            begin
                IF JobRec.GET("Job No.") THEN BEGIN
                    Description := JobRec.Description;
                    VALIDATE("Shortcut Dimension 1 Code", JobRec."Global Dimension 1 Code");
                    //"Requested By" := JobRec."Assigned User ID";
                    //"Requested By Name" := JobRec."Assigned User ID";
                END ELSE BEGIN
                    "Job Task No." := '';
                    // "Requested By" := '';
                    // "Requested By Name" := '';
                    VALIDATE("Shortcut Dimension 1 Code", '');
                END;
            end;
        }
        field(20; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));

            trigger OnValidate()
            var
                JobTask: Record "Job Task";
            begin
                IF JobTask.GET("Job No.", "Job Task No.") THEN
                    "Description 2" := JobTask.Description
                ELSE
                    "Description 2" := '';
            end;
        }
        field(21; "Created By"; Code[50])
        {
        }
        field(22; "Created Date"; Date)
        {
            Editable = false;
        }
        field(23; "Created Time"; Time)
        {
            Editable = false;
        }
        field(24; "Modified By"; Code[50])
        {
            Editable = false;
        }
        field(25; "Modified Date"; Date)
        {
            Editable = false;
        }
        field(26; "Modified Time"; Time)
        {
            Editable = false;
        }
        field(27; "Released Date"; Date)
        {
        }
        field(28; "Released By"; Code[50])
        {
        }
        field(29; "Material Request No."; Code[20])
        {
            Description = 'IF (Request Type=CONST(Job),Entry Type=CONST(Issue)) "Material Request Header" WHERE (Request Type=CONST(Job),Status=CONST(Released),Store Issue No.=FILTER(''''),Entry Type=CONST(Issue)) ELSE IF (Request Type=CONST(Job),Entry Type=CONST(Return)) "Material Request Header" WHERE (Request Type=CONST(Job),Status=CONST(Released),Store Issue No.=FILTER(''''),Entry Type=CONST(Return)) ELSE IF (Request Type=CONST(Inventory)) "Material Request Header" WHERE (Request Type=CONST(Internal),Status=CONST(Released))';
            TableRelation = IF ("Request Type" = CONST(Job), "Entry Type" = CONST(Issue)) "Material Request Header" WHERE("Request Type" = CONST(Job), Status = CONST(Released), "Store Issue No." = FILTER(''), "Entry Type" = CONST(Issue)) ELSE
            IF ("Request Type" = CONST(Job), "Entry Type" = CONST(Return)) "Posted Store Issue Header" WHERE("Job No." = FIELD("Job No.")) ELSE
            IF ("Request Type" = CONST(Inventory)) "Material Request Header" WHERE("Request Type" = CONST(Internal), Status = CONST(Released));

            trigger OnValidate()
            var
                P_MatReqHeader: Record "Posted Store Issue Header";
                MatReqHeader: Record "Material Request Header";
            begin
                IF "Entry Type" <> "Entry Type"::Return THEN BEGIN
                    IF MatReqHeader.GET("Material Request No.") THEN BEGIN
                        "Job No." := MatReqHeader."Job No.";
                        "Job Task No." := MatReqHeader."Job Task No.";
                        Location := MatReqHeader."Location Code";
                        "Requested By" := MatReqHeader."Requested By";
                        "Requested By Name" := MatReqHeader."Requested Name";
                        VALIDATE("Shortcut Dimension 1 Code", MatReqHeader."Global Dimension 1 Code");
                        VALIDATE("Shortcut Dimension 2 Code", MatReqHeader."Global Dimension 2 Code");
                        VALIDATE("Shortcut Dimension 3 Code", MatReqHeader."Shortcut Dimension 3 Code");
                        VALIDATE("Shortcut Dimension 4 Code", MatReqHeader."Shortcut Dimension 4 Code");
                        Description := MatReqHeader."Job Description";
                        "Description 2" := MatReqHeader."Job Task Description";
                        VALIDATE("Responsibility Center", MatReqHeader."Responsibility Center");
                        VALIDATE("Customer Job Type", MatReqHeader."Customer Job Type");
                        VALIDATE("Job Type Code", MatReqHeader."Job Type Code");
                        //VALIDATE("Vehicle Registration No.",MatReqHeader."Vehicle Registration No.");

                    END ELSE BEGIN
                        "Job No." := '';
                        "Job Task No." := '';
                        Location := '';
                        "Requested By" := '';
                        "Requested By Name" := '';
                        VALIDATE("Shortcut Dimension 1 Code", '');
                        VALIDATE("Shortcut Dimension 2 Code", '');
                        VALIDATE("Shortcut Dimension 3 Code", '');
                        Description := '';
                        "Description 2" := '';
                        "Responsibility Center" := '';
                        "Customer Job Type" := '';
                        "Job Type Code" := '';
                    END;
                END;


                //DD
                IF "Entry Type" = "Entry Type"::Return THEN BEGIN
                    IF P_MatReqHeader.GET("Material Request No.") THEN BEGIN
                        "Job No." := P_MatReqHeader."Job No.";
                        "Job Task No." := P_MatReqHeader."Job Task No.";
                        Location := P_MatReqHeader.Location;
                        "Requested By" := P_MatReqHeader."Requested By";
                        "Requested By Name" := P_MatReqHeader."Requested By Name";
                        VALIDATE("Shortcut Dimension 1 Code", P_MatReqHeader."Shortcut Dimension 1 Code"); //P_MatReqHeader."Global Dimension 1 Code");
                        VALIDATE("Shortcut Dimension 2 Code", P_MatReqHeader."Shortcut Dimension 2 Code"); //P_MatReqHeader."Global Dimension 2 Code");
                        VALIDATE("Shortcut Dimension 3 Code", P_MatReqHeader."Shortcut Dimension 3 Code"); //P_MatReqHeader."Shortcut Dimension 3 Code");
                        VALIDATE("Shortcut Dimension 4 Code", P_MatReqHeader."Shortcut Dimension 4 Code"); //P_MatReqHeader."Shortcut Dimension 4 Code");
                        Description := P_MatReqHeader.Description;//MatReqHeader."Job Description";
                        "Description 2" := P_MatReqHeader."Description 2"; //MatReqHeader."Job Task Description";
                        VALIDATE("Responsibility Center", P_MatReqHeader."Responsibility Center");
                        VALIDATE("Customer Job Type", P_MatReqHeader."Customer Job Type");
                        VALIDATE("Job Type Code", P_MatReqHeader."Job Type Code");
                        ///VALIDATE("Vehicle Registration No.",); //MatReqHeader."Vehicle Registration No.");

                    END ELSE BEGIN
                        "Job No." := '';
                        "Job Task No." := '';
                        Location := '';
                        "Requested By" := '';
                        "Requested By Name" := '';
                        VALIDATE("Shortcut Dimension 1 Code", '');
                        VALIDATE("Shortcut Dimension 2 Code", '');
                        VALIDATE("Shortcut Dimension 3 Code", '');
                        Description := '';
                        "Description 2" := '';
                        "Responsibility Center" := '';
                        "Customer Job Type" := '';
                        "Job Type Code" := '';
                    END;

                END;
            end;
        }
        field(30; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);
                IF NOT UserMgt.CheckRespCenter(1, "Responsibility Center") THEN
                    ERROR(
                      Text001,
                          RespCenter.TABLECAPTION, UserMgt.GetPurchasesFilter);

            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(481; "Request Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Job,Inventory';
            OptionMembers = Job,Inventory;

            trigger OnValidate()
            begin
                "Material Request No." := '';
                ///  UpdateReqLine(FIELDNO("Request Type"));
            end;
        }
        field(482; Status; Option)
        {
            OptionCaption = 'Open,Released,Pending Approval';
            OptionMembers = Open,Released,"Pending Approval";

            trigger OnValidate()
            begin
                ///UpdateReqLine(FIELDNO(Status));
            end;
        }
        field(483; Amount; Decimal)
        {
            /// CalcFormula = Sum("Store Issue Line".Amount WHERE ("Document No."=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(484; "Entry Type"; Option)
        {
            OptionCaption = 'Issue,Return';
            OptionMembers = Issue,Return;
        }
        field(489; "Customer Job Type"; Code[20])
        {
            //TableRelation = "Customer Job Type";
        }
        field(490; "Job Type Code"; Code[20])
        {
            //TableRelation = "Job Type Code"."Job Type Code" WHERE("Customer Job Type" = FIELD("Customer Job Type"));
        }
        field(491; "Vehicle Registration No."; Code[20])
        {
            Description = 'ss';

            trigger OnValidate()
            begin
                //UpdateReqLine(FIELDNO(PurchReqLine."Service Item No."));
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        PurchReqLine.SETRANGE("Document No.", "No.");
        PurchReqLine.DELETEALL(TRUE);
    end;

    trigger OnInsert()
    begin
        InvSetup.GET;

        IF "No." = '' THEN BEGIN
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", "Posting Date", "No.", "No. Series");
        END;

        IF "Posting Date" = 0D THEN BEGIN
            "Posting Date" := WORKDATE;
            "Expected Receipt Date" := WORKDATE;
            "Requested Receipt Date" := WORKDATE;
        END;

        "Created By" := USERID;
        "Created Date" := TODAY;
        "Created Time" := TIME;
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchReqLine: Record "Store Issue Line";
        JobRec: Record Job;
        MatReqHeader: Record "Material Request Header";
        P_MatReqHeader: Record "Posted Store Issue Header";
        DimMgt: Codeunit DimensionManagement;
        Text001: Label 'You may have changed a dimension.\\Do you want to update the lines?';
        JobTask: Record "Job Task";
        InvSetup: Record "Inventory Setup";
        UserMgt: Codeunit "User Setup Management";
        RespCenter: Record "Responsibility Center";

    procedure AssistEdit(OldPurchReqHeader: Record "Store Issue Header"): Boolean
    begin
        InvSetup.GET;
        TestNoSeries;
        IF NoSeriesMgt.SelectSeries(GetNoSeriesCode, OldPurchReqHeader."No. Series", "No. Series") THEN BEGIN
            InvSetup.GET;
            ;
            TestNoSeries;
            ;
            NoSeriesMgt.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;

    local procedure TestNoSeries(): Boolean
    begin
        InvSetup.GET;
        InvSetup.TESTFIELD(InvSetup."Store Issue Nos");
    end;

    local procedure GetNoSeriesCode(): Code[20]
    begin
        InvSetup.GET;
        EXIT(InvSetup."Store Issue Nos");
    end;

    procedure PurchReqtLineExist(): Boolean
    begin
        PurchReqLine.RESET;
        PurchReqLine.SETRANGE("Document No.", "No.");
        EXIT(PurchReqLine.FINDFIRST);
    end;

    local procedure UpdateReqLine(FieldRef: Integer)
    var
        PurchReqLine: Record "Store Issue Line";
    begin
        PurchReqLine.LOCKTABLE;
        PurchReqLine.SETRANGE("Document No.", "No.");
        IF PurchReqLine.FIND('-') THEN BEGIN
            REPEAT
                CASE FieldRef OF
                    FIELDNO("Posting Date"):
                        PurchReqLine.VALIDATE("Request Date", "Posting Date");
                    FIELDNO("Request Type"):
                        /// PurchReqLine.VALIDATE("Request Type", "Request Type");
                        /// FIELDNO(Location):
                        PurchReqLine.VALIDATE("Location Code", Location);
                    FIELDNO("Expected Receipt Date"):
                        PurchReqLine.VALIDATE("Expected Receipt Date", "Expected Receipt Date");
                    FIELDNO("Requested Receipt Date"):
                        PurchReqLine.VALIDATE("Requested Receipt Date", "Requested Receipt Date");
                    FIELDNO(Status):
                        ///  PurchReqLine.VALIDATE(Status, Status);
                        ///  FIELDNO("Shortcut Dimension 1 Code"):
                        PurchReqLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                    FIELDNO("Shortcut Dimension 2 Code"):
                        PurchReqLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                    FIELDNO("Shortcut Dimension 3 Code"):
                        PurchReqLine.VALIDATE("Shortcut Dimension 3 Code", "Shortcut Dimension 3 Code");
                    FIELDNO("Shortcut Dimension 4 Code"):
                        PurchReqLine.VALIDATE("Shortcut Dimension 4 Code", "Shortcut Dimension 4 Code");
                    FIELDNO("Shortcut Dimension 5 Code"):
                        PurchReqLine.VALIDATE("Shortcut Dimension 5 Code", "Shortcut Dimension 5 Code");
                    FIELDNO("Shortcut Dimension 6 Code"):
                        PurchReqLine.VALIDATE("Shortcut Dimension 6 Code", "Shortcut Dimension 6 Code");
                    FIELDNO("Shortcut Dimension 7 Code"):
                        PurchReqLine.VALIDATE("Shortcut Dimension 7 Code", "Shortcut Dimension 7 Code");
                    FIELDNO("Shortcut Dimension 8 Code"):
                        PurchReqLine.VALIDATE("Shortcut Dimension 8 Code", "Shortcut Dimension 8 Code");

                END;
                PurchReqLine.MODIFY(TRUE);
            UNTIL PurchReqLine.NEXT = 0;
        END;
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        ChangeLogMgt: Codeunit "Change Log Management";
        RecRef: RecordRef;
        xRecRef: RecordRef;
        OldDimSetID: Integer;
        DimMgt: Codeunit DimensionManagement;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        IF "No." <> '' THEN
            MODIFY;

        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            MODIFY;
            IF PurchReqtLineExist THEN
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        END;
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        ATOLink: Record "Assemble-to-Order Link";
        NewDimSetID: Integer;
        DimMgt: Codeunit DimensionManagement;
    begin
        // Update all lines with changed dimensions.

        IF NewParentDimSetID = OldParentDimSetID THEN
            EXIT;
        IF NOT CONFIRM(Text001) THEN
            EXIT;

        PurchReqLine.RESET;
        PurchReqLine.SETRANGE("Document No.", "No.");
        PurchReqLine.LOCKTABLE;
        IF PurchReqLine.FIND('-') THEN
            REPEAT
                ///  NewDimSetID := DimMgt.GetDeltaDimSetID(PurchReqLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                IF PurchReqLine."Dimension Set ID" <> NewDimSetID THEN BEGIN
                    PurchReqLine."Dimension Set ID" := NewDimSetID;
                    DimMgt.UpdateGlobalDimFromDimSetID(
                      PurchReqLine."Dimension Set ID", PurchReqLine."Shortcut Dimension 1 Code", PurchReqLine."Shortcut Dimension 2 Code");
                    PurchReqLine.MODIFY;
                END;
            UNTIL PurchReqLine.NEXT = 0;
    end;

    procedure ShowDocDim()
    var
        DocDim: Record "IC Document Dimension";
        /// DocDims: Page "IC Document Dimensions";
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        /* "Dimension Set ID" :=
          DimMgt.EditDimensionSet2(
            "Dimension Set ID",STRSUBSTNO('%1',"No."),
            "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code"); */ ///Gbenga
        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            MODIFY;
            IF PurchReqtLineExist THEN;
            //UpdateAllLineDim("Dimension Set ID",OldDimSetID);
        END;
    end;
}

