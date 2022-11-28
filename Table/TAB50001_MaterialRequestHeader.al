table 50001 "Material Request Header"
{
    LookupPageID = "Job Material Request List";

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Request Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Project,Internal';
            OptionMembers = Job,Internal;

            trigger OnValidate()
            var
                MaterialRequestHeader: Record "Material Request Line";
            begin
                UpdateMaterialReqLine(FIELDNO("Request Type"));
            end;
        }
        field(3; "Request Date"; Date)
        {
        }
        field(4; Status; Option)
        {
            OptionCaption = 'Open,Released,Pending Approval';
            OptionMembers = Open,Released,"Pending Approval";

            trigger OnValidate()
            begin
                UpdateMaterialReqLine(FIELDNO(Status));
            end;
        }
        field(5; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;

            trigger OnValidate()
            var
                JobRec: Record Job;
            begin
                IF JobRec.GET("Job No.") THEN BEGIN
                    "Requested By" := JobRec."Person Responsible";
                    VALIDATE("Global Dimension 1 Code", JobRec."Global Dimension 1 Code");
                    VALIDATE("Global Dimension 2 Code", JobRec."Global Dimension 2 Code");
                    VALIDATE("Shortcut Dimension 3 Code", JobRec."Shortcut Dimension 3 Code");
                    VALIDATE("Shortcut Dimension 4 Code", JobRec."Shortcut Dimension 4 Code");
                    VALIDATE("Shortcut Dimension 5 Code", JobRec."Shortcut Dimension 5 Code");
                    "Job Description" := JobRec.Description;
                    //VALIDATE("Responsibility Center", JobRec."Responsibility Center");
                    //VALIDATE("Customer Job Type", JobRec."Customer Job Type");
                    //VALIDATE("Job Type Code", JobRec."Job Type Code");
                    //VALIDATE("Vehicle Registration No.", JobRec."Vehicle Registr. Plate No");
                END ELSE BEGIN
                    "Requested By" := '';
                    "Requested Name" := '';
                    VALIDATE("Global Dimension 1 Code", '');
                    "Job Description" := '';
                END;

                VALIDATE("Job Task No.", '');
            end;
        }
        field(6; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));

            trigger OnValidate()
            var
                JobTask: Record "Job Task";
            begin
                IF JobTask.GET("Job No.", "Job Task No.") THEN
                    Rec."Job Task Description" := JobTask.Description
                ELSE
                    "Job Task Description" := '';
            end;
        }
        field(7; Comment; Boolean)
        {
        }
        field(8; "Location Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = Location.Code;// WHERE("Use As In-Transit" = FILTER(No), Workshop = FILTER(No));
        }
        field(9; "No. Series"; Code[20])
        {
        }
        field(10; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(11; "Created Date"; Date)
        {
            Editable = false;
        }
        field(12; "Created Time"; Time)
        {
            Editable = false;
        }
        field(13; "Modified By"; Code[20])
        {
            Editable = false;
        }
        field(14; "Modified Date"; Date)
        {
            Editable = false;
        }
        field(15; "Modified Time"; Time)
        {
            Editable = false;
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
                UpdateMaterialReqLine(FIELDNO("Global Dimension 2 Code"));
            end;
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
                UpdateMaterialReqLine(FIELDNO("Global Dimension 2 Code"));
            end;
        }
        field(18; "Released Date"; Date)
        {
            Editable = false;
        }
        field(19; "Released By"; Code[50])
        {
            Editable = false;
        }
        field(20; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
                UpdateMaterialReqLine(FIELDNO("Shortcut Dimension 3 Code"));
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
                UpdateMaterialReqLine(FIELDNO("Shortcut Dimension 4 Code"));
            end;
        }
        field(22; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
                UpdateMaterialReqLine(FIELDNO("Shortcut Dimension 5 Code"));
            end;
        }
        field(23; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");
                UpdateMaterialReqLine(FIELDNO("Shortcut Dimension 6 Code"));
            end;
        }
        field(24; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(7, "Shortcut Dimension 7 Code");
                UpdateMaterialReqLine(FIELDNO("Shortcut Dimension 7 Code"));
            end;
        }
        field(25; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));

            trigger OnValidate()
            var

            begin
                ValidateShortcutDimCode(8, "Shortcut Dimension 8 Code");
                UpdateMaterialReqLine(FIELDNO("Shortcut Dimension 8 Code"));
            end;
        }
        field(26; "Requested By"; Code[50])
        {
            Caption = 'Requested By';
            Editable = false;
        }
        field(27; "Requested Name"; Text[50])
        {
            Caption = 'Project Manager Name';
            Editable = false;
        }
        field(28; "Job Description"; Text[50])
        {
            Editable = false;
        }
        field(29; "Job Task Description"; Text[50])
        {
            Editable = false;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(481; "Project Engineer"; Code[20])
        {
            //TableRelation = Resource WHERE (Type=CONST(Person), "Resource Group No."=CONST(PE));
        }
        field(482; Processed; Boolean)
        {
        }
        field(483; "Entry Type"; Option)
        {
            OptionCaption = 'Issue,Return';
            OptionMembers = Issue,Return;
        }
        field(484; "Responsibility Center"; Code[20])
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
        field(485; TotalAmount; Decimal)
        {
            CalcFormula = Sum("Material Request Line"."Line Amount" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(486; "Store Issue No."; Code[20])
        {
            CalcFormula = Lookup("Posted Store Issue Header"."No." WHERE("Material Request No." = FIELD("No.")));
            FieldClass = FlowField;
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

            trigger OnValidate()
            begin
                //
            end;
        }
        field(490; "T-NO"; Code[20])
        {

            trigger OnValidate()
            begin
                //
            end;
        }
        field(491; "CONTRACT"; Code[20])
        {

            trigger OnValidate()
            begin
                //
            end;
        }
        field(492; "Part Availability"; Option)
        {

            OptionMembers = ,Exploded,Stolen;
            OptionCaption = ' ,Exploded,Stolen';

            trigger OnValidate()
            begin
                //
            end;
        }
        field(493; "DRIVER NAME"; Text[30])
        {

            trigger OnValidate()
            begin
                //
            end;
        }
        field(494; "DRIVER COMPLAINT"; Text[30])
        {

            trigger OnValidate()
            begin
                //
            end;
        }
        field(495; "TECHNICIAN DIAGNOSIS"; Text[250])
        {

            trigger OnValidate()
            begin
                //
            end;
        }

        field(496; "SA VALIDATION"; Code[20])
        {

            trigger OnValidate()
            begin
                //
            end;
        }

        field(497; "HOD APPROVAL"; Code[20])
        {

            trigger OnValidate()
            begin
                //
            end;
        }
        field(498; "LAST DATE OF ISSUANCE"; Date)
        {

            trigger OnValidate()
            begin
                //
            end;
        }
        field(499; "BATTERY BRAND"; Code[20])
        {

            trigger OnValidate()
            begin
                //
            end;
        }
        field(500; "BATTERY CAPACITY"; Code[20])
        {

            trigger OnValidate()
            begin
                //
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
        MaterialReqLine.SETRANGE("Document No.", "No.");
        MaterialReqLine.DELETEALL(TRUE);
    end;

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        InvSetup.GET;

        IF "No." = '' THEN BEGIN
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", "Request Date", "No.", "No. Series");
        END;


        IF "Request Date" = 0D THEN
            "Request Date" := WORKDATE;

        "Created By" := USERID;
        "Created Date" := TODAY;
        "Created Time" := TIME;
        "Requested By" := USERID;
    end;

    var
        InvSetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MaterialReqLine: Record "Material Request Line";
        JobRec: Record Job;
        JobTask: Record "Job Task";
        DimMgt: Codeunit DimensionManagement;
        RespCenter: Record "Responsibility Center";
        UserMgt: Codeunit "User Setup Management";
        Text001: Label 'Your identification is set up to process from %1 %2 only.';

    procedure AssistEdit(OldMaterialReqHeader: Record "Material Request Header"): Boolean
    begin
        InvSetup.GET;
        TestNoSeries;
        IF NoSeriesMgt.SelectSeries(GetNoSeriesCode, OldMaterialReqHeader."No. Series", "No. Series") THEN BEGIN
            InvSetup.GET;
            ;
            TestNoSeries;
            NoSeriesMgt.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;

    local procedure TestNoSeries(): Boolean
    begin
        InvSetup.GET;
        InvSetup.TESTFIELD(InvSetup."Material Request Nos.");
    end;

    local procedure GetNoSeriesCode(): Code[20]
    begin
        InvSetup.GET;
        IF "Entry Type" = "Entry Type"::Issue THEN
            EXIT(InvSetup."Material Request Nos.")
        ELSE
            IF "Entry Type" = "Entry Type"::Return THEN
                EXIT(InvSetup."Material Return Nos.");

    end;

    procedure UpdateMaterialReqLine(FieldRef: Integer)
    var
        MatReqLine: Record "Material Request Line";
    begin
        MatReqLine.LOCKTABLE;
        MatReqLine.SETRANGE("Document No.", "No.");
        IF MatReqLine.FIND('-') THEN BEGIN
            REPEAT
                CASE FieldRef OF
                    FIELDNO("Request Date"):
                        BEGIN
                            MatReqLine.VALIDATE("Request Date", "Request Date");
                        END;
                    FIELDNO("Request Type"):
                        MatReqLine.VALIDATE("Request Type", "Request Type");

                    FIELDNO(Status):
                        MatReqLine.VALIDATE(Status, Status);
                    FIELDNO("Global Dimension 1 Code"):
                        MatReqLine.VALIDATE("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                    FIELDNO("Global Dimension 2 Code"):
                        MatReqLine.VALIDATE("Shortcut Dimension 2 Code", "Global Dimension 2 Code");
                    FIELDNO("Shortcut Dimension 3 Code"):
                        MatReqLine.VALIDATE("Shortcut Dimension 3 Code", "Shortcut Dimension 3 Code");
                    FIELDNO("Shortcut Dimension 4 Code"):
                        MatReqLine.VALIDATE("Shortcut Dimension 4 Code", "Shortcut Dimension 4 Code");
                    FIELDNO("Shortcut Dimension 5 Code"):
                        MatReqLine.VALIDATE("Shortcut Dimension 5 Code", "Shortcut Dimension 5 Code");
                    FIELDNO("Shortcut Dimension 6 Code"):
                        MatReqLine.VALIDATE("Shortcut Dimension 6 Code", "Shortcut Dimension 6 Code");
                    FIELDNO("Shortcut Dimension 7 Code"):
                        MatReqLine.VALIDATE("Shortcut Dimension 7 Code", "Shortcut Dimension 7 Code");
                    FIELDNO("Shortcut Dimension 8 Code"):
                        MatReqLine.VALIDATE("Shortcut Dimension 8 Code", "Shortcut Dimension 8 Code");
                END;
                MatReqLine.MODIFY(TRUE);
            UNTIL MatReqLine.NEXT = 0;
        END;
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        IF "No." <> '' THEN
            MODIFY;

        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            MODIFY;
            IF MatReqLinesExist THEN;
        END;
    end;

    procedure MatReqLinesExist(): Boolean
    var
        MatReqLine: Record "Material Request Line";
    begin
        MatReqLine.RESET;
        MatReqLine.SETRANGE("Document No.", "No.");
        EXIT(MatReqLine.FINDFIRST);
    end;

    procedure ShowDocDim()
    var
        DocDim: Record "IC Document Dimension";
        // DocDims: Page "IC Document Dimensions";
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
         DimMgt.EditDimensionSet(
           "Dimension Set ID", STRSUBSTNO('%1', "No."),
           "Global Dimension 1 Code", "Global Dimension 2 Code");
        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            MODIFY;
            IF MatReqLinesExist THEN;
            //UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        END;
    end;
}

