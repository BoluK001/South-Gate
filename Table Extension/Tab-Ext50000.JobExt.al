tableextension 50000 JobExt extends Job
{
    fields
    {
        field(50000; LPO; Decimal)
        {
            Caption = 'LPO';
            fieldClass = FlowField;
            CalcFormula = Sum("Job Planning Line"."Line Amount (LCY)" where("Job No." = field("No."), "Contract Line" = const(true), "Planning Date" = field("Planning Date Filter")));
        }
        field(50001; "BIZ Won Cost"; Decimal)
        {
            Caption = 'BIZ Won Cost';
            fieldClass = FlowField;
            CalcFormula = Sum("Job Planning Line"."Total Cost (LCY)" where("Job No." = field("No."), "Schedule Line" = const(true), "Planning Date" = field("Planning Date Filter")));
        }
        field(50002; "Design GP"; Decimal)
        {
            Caption = 'Design GP';
            DataClassification = ToBeClassified;
        }
        field(50003; "Actual GP"; Decimal)
        {
            Caption = 'Actual GP';
            DataClassification = ToBeClassified;
        }
        field(50004; "Usage Cost"; Decimal)
        {
            Caption = 'Usage Cost';
            fieldClass = FlowField;
            CalcFormula = Sum("Job Ledger Entry"."Total Cost (LCY)" where("Job No." = field("No."), "Entry Type" = filter(usage), "Posting Date" = field("Planning Date Filter")));
        }
        field(50005; "WIP Amount"; Decimal)
        {
            fieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount where("G/L Account No." = filter('20614'), "Posting Date" = field("Posting Date Filter"), "Job No." = field("No.")));
        }
        field(50006; "Provision"; Decimal)
        {
            fieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount where("G/L Account No." = filter('50518'), "Posting Date" = field("Posting Date Filter"), "Job No." = field("No.")));
        }
        field(50007; "Amount to Invoice"; Decimal)
        {
            fieldClass = FlowField;
            CalcFormula = Sum("Job Ledger Entry"."Line Amount (LCY)" where("Job No." = field("No."), "Entry Type" = filter('Sale'), "Posting Date" = field("Posting Date Filter")));
        }
        field(60000; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
                UpdateJobPlaningLines(fieldNO("Shortcut Dimension 1 Code"));

                //"Responsibility Center" := "Shortcut Dimension 1 Code";
            end;
        }
        field(60001; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
                UpdateJobPlaningLines(fieldNO("Shortcut Dimension 2 Code"));
            end;
        }
        field(60002; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
                UpdateJobPlaningLines(fieldNO("Shortcut Dimension 3 Code"));
            end;
        }
        field(60003; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
                UpdateJobPlaningLines(fieldNO("Shortcut Dimension 4 Code"));
            end;
        }
        field(60004; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
                UpdateJobPlaningLines(fieldNO("Shortcut Dimension 5 Code"));
            end;
        }
        field(60005; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");
                UpdateJobPlaningLines(fieldNO("Shortcut Dimension 6 Code"));
            end;
        }
        field(60006; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(7, "Shortcut Dimension 7 Code");
                UpdateJobPlaningLines(fieldNO("Shortcut Dimension 7 Code"));
            end;
        }
        field(60007; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(8, "Shortcut Dimension 8 Code");
                UpdateJobPlaningLines(fieldNO("Shortcut Dimension 8 Code"));
            end;
        }
        field(60008; "Dimension Set ID"; Integer)
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
    local procedure UpdateJobPlaningLines(fieldRef: Integer)
    var
        JobPlaningLines: Record "Job Planning Line";
    begin
        JobPlaningLines.LOCKTABLE;
        JobPlaningLines.SETRANGE("Document No.", "No.");
        //JobPlaningLines.SETFILTER("Account No.", '<>%1', '');
        IF JobPlaningLines.FIND('-') THEN BEGIN
            REPEAT
                CASE fieldRef OF
                    fieldNO(Status):
                        JobPlaningLines.VALIDATE(Status, Status);
                    fieldNO("Shortcut Dimension 1 Code"):
                        JobPlaningLines.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                    fieldNO("Shortcut Dimension 2 Code"):
                        JobPlaningLines.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                    fieldNO("Shortcut Dimension 3 Code"):
                        JobPlaningLines.VALIDATE("Shortcut Dimension 3 Code", "Shortcut Dimension 3 Code");
                    fieldNO("Shortcut Dimension 4 Code"):
                        JobPlaningLines.VALIDATE("Shortcut Dimension 4 Code", "Shortcut Dimension 4 Code");
                    fieldNO("Shortcut Dimension 5 Code"):
                        JobPlaningLines.VALIDATE("Shortcut Dimension 5 Code", "Shortcut Dimension 5 Code");
                    fieldNO("Shortcut Dimension 6 Code"):
                        JobPlaningLines.VALIDATE("Shortcut Dimension 6 Code", "Shortcut Dimension 6 Code");
                    fieldNO("Shortcut Dimension 7 Code"):
                        JobPlaningLines.VALIDATE("Shortcut Dimension 7 Code", "Shortcut Dimension 7 Code");
                    fieldNO("Shortcut Dimension 8 Code"):
                        JobPlaningLines.VALIDATE("Shortcut Dimension 8 Code", "Shortcut Dimension 8 Code");
                    fieldNO("Currency Code"):
                        JobPlaningLines.VALIDATE("Currency Code", "Currency Code");
                END;
                JobPlaningLines.MODIFY(TRUE);
            UNTIL JobPlaningLines.NEXT = 0;
        END;
    end;


    // [Scope('OnPrem')]
    // procedure ShowDocDim()
    // var
    //     //DocDim: Record "IC Document Dimension";
    //     DimMgt: Codeunit DimensionManagement;
    //     OldDimSetID: Integer;
    // begin
    //     OldDimSetID := "Dimension Set ID";
    //     "Dimension Set ID" :=
    //       DimMgt.EditDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2', "Voucher Type", "No."),
    //         "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    //     IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
    //         MODIFY;
    //         IF JobplanningLinesExist THEN
    //             UpdateAllLineDim("Dimension Set ID", OldDimSetID);
    //     END;
    // end;  Dennis

}