codeunit 50001 "Job Request Management"
{

    trigger OnRun()
    begin
    end;

    var
        MatReqHeader: Record "Material Request Header";
        Text001: Label 'Request has already been created for %1 in Job No. %2 Job Task No.%3';
        Text002: Label 'Request has already been created for %1 in Purchase Request  %2 ';
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        ItemRec: Record Item;
        QtyRemtoconsume: Decimal;

    procedure GetJobPlanningLines(var MaterialReqHeader: Record "Material Request Header")
    var
        MaterialReqLine: Record "Material Request Line";
        JobPlanningLine: Record "Job Planning Line";
        MaterialReqLine2: Record "Material Request Line";
    begin
        MaterialReqHeader.TESTFIELD("Request Type", MaterialReqHeader."Request Type"::Job);
        MaterialReqHeader.TESTFIELD("No.");
        MaterialReqHeader.TESTFIELD("Job No.");



        JobPlanningLine.RESET;
        JobPlanningLine.SETRANGE("Job No.", MaterialReqHeader."Job No.");

        //10/14/20 Added cos Items posted with PO will not be considerred when requesting
        JobPlanningLine.CALCFIELDS(JobPlanningLine."Consumed Quantity");
        QtyRemtoconsume := JobPlanningLine.Quantity - JobPlanningLine."Consumed Quantity";
        //10/14/20 Added cos Items posted with PO will not be considerred when requesting

        IF MaterialReqHeader."Job Task No." <> '' THEN
            JobPlanningLine.SETRANGE("Job Task No.", MaterialReqHeader."Job Task No.");
        JobPlanningLine.SETRANGE(Type, JobPlanningLine.Type::Item);

        //10/14/20 Added:Items posted with PO will not be considerred when requesting
        JobPlanningLine.SETRANGE(JobPlanningLine."Consumed Quantity", 0);  //10/14/20
        //JobPlanningLine.SETFILTER(QtyRemtoconsume ,'>%1',0);  //10/14/20
        JobPlanningLine.SETFILTER(JobPlanningLine."Gen. Bus. Posting Group", '<>%1', 'JOBS-PO');
        //10/14/20 Added:Items posted with PO will not be considerred when requesting

        JobPlanningLine.SETFILTER(Quantity, '<>%1', 0);
        IF JobPlanningLine.FIND('-') THEN BEGIN
            // prevent material line creation for the same item in the same job No. & task No.
            /* MaterialReqLine2.SETRANGE("Job No.",JobPlanningLine."Job No.");
             MaterialReqLine2.SETRANGE("Job Task No.",JobPlanningLine."Job Task No.");
             MaterialReqLine2.SETRANGE("Item No.",JobPlanningLine."No.");
             IF MaterialReqLine2.FIND('-') THEN
              ERROR(Text001,MaterialReqLine2."Item No.",MaterialReqLine2."Job No.",MaterialReqLine2."Job Task No.");
             */

            MaterialReqLine.RESET;
            MaterialReqLine.SETRANGE("Document No.", MaterialReqHeader."No.");
            IF MaterialReqLine.FIND('-') THEN
                MaterialReqLine.DELETEALL;
            REPEAT
                MaterialReqLine.INIT;
                MaterialReqLine."Document No." := MaterialReqHeader."No.";
                MaterialReqLine."Line No." += 1000;
                MaterialReqLine.VALIDATE("Item No.", JobPlanningLine."No.");

                JobPlanningLine.CALCFIELDS(JobPlanningLine."Consumed Quantity Usage");
                QtyRemtoconsume := JobPlanningLine.Quantity - JobPlanningLine."Consumed Quantity"; //new
                MaterialReqLine.VALIDATE(Quantity, QtyRemtoconsume);     //new
                                                                         //MaterialReqLine.VALIDATE(Quantity ,JobPlanningLine.Quantity-JobPlanningLine."Consumed Quantity Usage");

                MaterialReqLine.VALIDATE("Job No.", JobPlanningLine."Job No.");
                MaterialReqLine.VALIDATE("Job Task No.", JobPlanningLine."Job Task No.");
                MaterialReqLine.VALIDATE("Location Code", JobPlanningLine."Location Code");
                MaterialReqLine.VALIDATE("Gen. Bus. Posting Group", JobPlanningLine."Gen. Bus. Posting Group");

                //DD
                MaterialReqLine.VALIDATE("Quantity CONSM Per Year", MaterialReqLine."Quantity CONSM Per Year");
                MaterialReqLine.VALIDATE("Service Item", MaterialReqHeader."Vehicle Registration No.");
                MaterialReqLine.VALIDATE("Approved By", MaterialReqLine."Quotation Approved By");
                MaterialReqLine.VALIDATE("Approval Date", MaterialReqLine."Quotation Approval Date");
                MaterialReqLine.VALIDATE("Allow Approved Usage", MaterialReqLine."Allow Approved Usage");
                // MaterialReqLine.VALIDATE(MaterialReqLine."User ID- BLocked Item Removed" );
                //DD

                //MaterialReqLine.VALIDATE( );





                //  MaterialReqLine.VALIDATE("Gen. Bus. Posting Group",JobPlanningLine."Gen. Bus. Posting Group");

                MaterialReqLine.INSERT;
            UNTIL JobPlanningLine.NEXT = 0;
        END;

    end;

    procedure SetPurchHeader(var PurchHeader2: Record "Purchase Header")
    begin
        PurchHeader.GET(PurchHeader2."Document Type", PurchHeader2."No.");
    end;

    procedure GetMatReqLines(var PurchReqHeader: Record "Store Issue Header")
    var
        PurchReqLine: Record "Store Issue Line";
        MaterialReqLine: Record "Material Request Line";
        MatReqHeader: Record "Material Request Header";
        PurchReqLine2: Record "Store Issue Line";
    begin
        PurchReqHeader.TESTFIELD("No.");
        MatReqHeader.RESET;
        MatReqHeader.SETRANGE("No.", PurchReqHeader."Material Request No.");
        IF MatReqHeader.FIND('-') THEN BEGIN
            MaterialReqLine.SETRANGE("Document No.", MatReqHeader."No.");
            MaterialReqLine.SETFILTER(Quantity, '<>%1', 0);
            IF MaterialReqLine.FIND('-') THEN BEGIN

                // prevent material line creation for the same item in the same job No. & task No.
                PurchReqLine2.SETRANGE("Material Request No.", PurchReqHeader."Material Request No.");
                PurchReqLine2.SETRANGE(PurchReqLine2."Item No.", MaterialReqLine."Item No.");
                IF NOT PurchReqLine2.FIND('-') THEN BEGIN
                    //ERROR(Text001,PurchReqLine2."Item No.",PurchReqLine2."Document No.");

                    REPEAT
                        PurchReqLine.INIT;
                        PurchReqLine."Document No." := PurchReqHeader."No.";
                        PurchReqLine."Line No." += 1000;
                        PurchReqLine.VALIDATE("Item No.", MaterialReqLine."Item No.");
                        PurchReqLine.VALIDATE(Description, MaterialReqLine.Description);     //ddada

                        MaterialReqLine.TESTFIELD("Location Code");
                        ItemRec.RESET;
                        ItemRec.SETRANGE("No.", MaterialReqLine."Item No.");
                        ItemRec.SETFILTER("Location Filter", '%1', MaterialReqLine."Location Code");
                        IF ItemRec.FIND('-') THEN BEGIN
                            ItemRec.CALCFIELDS(Inventory);
                            IF ItemRec.Inventory >= MaterialReqLine.Quantity THEN
                                PurchReqLine.VALIDATE(Quantity, MaterialReqLine.Quantity)
                            ELSE
                                PurchReqLine.VALIDATE(Quantity, 0);
                        END;
                        PurchReqLine.VALIDATE("Location Code", MaterialReqLine."Location Code");
                        PurchReqLine.VALIDATE("Job No.", PurchReqHeader."Job No.");
                        PurchReqLine.VALIDATE("Job Task No.", PurchReqHeader."Job Task No.");
                        PurchReqLine.VALIDATE("Shortcut Dimension 1 Code", MaterialReqLine."Shortcut Dimension 1 Code");
                        PurchReqLine.VALIDATE("Shortcut Dimension 2 Code", MaterialReqLine."Shortcut Dimension 2 Code");
                        PurchReqLine.VALIDATE("Shortcut Dimension 3 Code", MaterialReqLine."Shortcut Dimension 3 Code");
                        PurchReqLine.VALIDATE("Shortcut Dimension 4 Code", MaterialReqLine."Shortcut Dimension 4 Code");
                        PurchReqLine.VALIDATE(PurchReqLine."Quantity Requested", MaterialReqLine.Quantity);
                        PurchReqLine.VALIDATE(PurchReqLine."Gen. Bus. Posting Group", MaterialReqLine."Gen. Bus. Posting Group");

                        //DD
                        PurchReqLine.VALIDATE("Vehicle Registration No.", PurchReqHeader."Vehicle Registration No.");
                        PurchReqLine.VALIDATE("Approved By", MaterialReqLine."Quotation Approved By");
                        PurchReqLine.VALIDATE("Approval Date", MaterialReqLine."Quotation Approval Date");
                        PurchReqLine.VALIDATE("Allow Approved Usage", MaterialReqLine."Allow Approved Usage");
                        PurchReqLine.VALIDATE(PurchReqLine."Quantity CONSM Per Year", MaterialReqLine."Quantity CONSM Per Year");

                        // DD
                        //MaterialReqLine.VALIDATE();



                        PurchReqLine.INSERT;
                    UNTIL MaterialReqLine.NEXT = 0;
                END;
            END;
        END;
    end;

    procedure P_GetMatReqLines(PurchReqHeader: Record "Store Issue Header")
    var
        PurchReqLine: Record "Store Issue Line";
        P_MaterialReqLine: Record "Posted Store Issue Line";
        P_MatReqHeader: Record "Posted Store Issue Header";
        PurchReqLine2: Record "Store Issue Line";
    begin
        //MIS 091917ddada
        PurchReqHeader.TESTFIELD("No.");
        P_MatReqHeader.RESET;
        P_MatReqHeader.SETRANGE("No.", PurchReqHeader."Material Request No.");
        IF P_MatReqHeader.FIND('-') THEN BEGIN
            P_MaterialReqLine.SETRANGE("Document No.", P_MatReqHeader."No.");
            P_MaterialReqLine.SETFILTER(Quantity, '<>%1', 0);
            IF P_MaterialReqLine.FIND('-') THEN BEGIN

                // prevent material line creation for the same item in the same job No. & task No.
                PurchReqLine2.SETRANGE("Material Request No.", PurchReqHeader."Material Request No.");
                PurchReqLine2.SETRANGE(PurchReqLine2."Item No.", P_MaterialReqLine."Item No.");
                IF NOT PurchReqLine2.FIND('-') THEN BEGIN
                    //ERROR(Text001,PurchReqLine2."Item No.",PurchReqLine2."Document No.");

                    REPEAT
                        PurchReqLine.INIT;
                        PurchReqLine."Document No." := PurchReqHeader."No.";
                        PurchReqLine."Line No." += 1000;
                        PurchReqLine.VALIDATE("Item No.", P_MaterialReqLine."Item No.");
                        PurchReqLine.VALIDATE(Description, P_MaterialReqLine.Description);     //ddada

                        P_MaterialReqLine.TESTFIELD("Location Code");
                        ItemRec.RESET;
                        ItemRec.SETRANGE("No.", P_MaterialReqLine."Item No.");
                        ItemRec.SETFILTER("Location Filter", '%1', P_MaterialReqLine."Location Code");
                        IF ItemRec.FIND('-') THEN BEGIN
                            ItemRec.CALCFIELDS(Inventory);
                            IF ItemRec.Inventory >= P_MaterialReqLine.Quantity THEN
                                PurchReqLine.VALIDATE(Quantity, P_MaterialReqLine.Quantity)
                            ELSE
                                PurchReqLine.VALIDATE(Quantity, 0);
                        END;
                        PurchReqLine.VALIDATE("Location Code", P_MaterialReqLine."Location Code");
                        PurchReqLine.VALIDATE("Job No.", PurchReqHeader."Job No.");
                        PurchReqLine.VALIDATE("Job Task No.", PurchReqHeader."Job Task No.");
                        PurchReqLine.VALIDATE("Shortcut Dimension 1 Code", P_MaterialReqLine."Shortcut Dimension 1 Code");
                        PurchReqLine.VALIDATE("Shortcut Dimension 2 Code", P_MaterialReqLine."Shortcut Dimension 2 Code");
                        PurchReqLine.VALIDATE("Shortcut Dimension 3 Code", P_MaterialReqLine."Shortcut Dimension 3 Code");
                        PurchReqLine.VALIDATE("Shortcut Dimension 4 Code", P_MaterialReqLine."Shortcut Dimension 4 Code");
                        PurchReqLine.VALIDATE(PurchReqLine."Quantity Requested", P_MaterialReqLine.Quantity);
                        PurchReqLine.VALIDATE(PurchReqLine."Gen. Bus. Posting Group", P_MaterialReqLine."Gen. Bus. Posting Group");
                        PurchReqLine.INSERT;
                    UNTIL P_MaterialReqLine.NEXT = 0;
                END;
            END;
        END;
        //MIS 091917     ddada
    end;
}

