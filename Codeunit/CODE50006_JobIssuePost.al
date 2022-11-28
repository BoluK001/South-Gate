codeunit 50006 "Job Issue Post"
{
    //

    TableNo = "Store Issue Header";

    trigger OnRun()
    var
        TempIssueLine: Record "Store Issue Line";
        JobJnlLine: Record "Job Journal Line";
        TempJobJnlLine: Record "Job Journal Line";
    begin
        TESTFIELD(Status, Status::Released);
        IF NOT CONFIRM('Do you want to Post the Store Issue?') THEN
            EXIT;
        TESTFIELD("No.");
        TESTFIELD("Posting Date");
        TESTFIELD(Location);

        TempIssueLine.RESET;
        TempIssueLine.SETRANGE("Document No.", "No.");
        TempIssueLine.SETFILTER(Quantity, '<>%1', 0);

        InvtSetup.GET;
        IF "No." <> '' THEN BEGIN
            IF "Entry Type" = "Entry Type"::Issue THEN BEGIN
                InvtSetup.TESTFIELD(InvtSetup."Posted Material Issue");
                DocNo := NoSeriesMgt.GetNextNo(InvtSetup."Posted Material Issue", "Posting Date", TRUE);
            END ELSE BEGIN
                InvtSetup.TESTFIELD(InvtSetup."Store Return Nos");
                DocNo := NoSeriesMgt.GetNextNo(InvtSetup."Store Return Nos", "Posting Date", TRUE);
            END
        END;

        PostedIssueHeader.INIT;
        PostedIssueHeader.TRANSFERFIELDS(Rec);
        PostedIssueHeader."No." := DocNo;
        PostedIssueHeader."Pre Assigned No." := "No.";
        PostedIssueHeader."Posted By" := USERID;
        PostedIssueHeader."Posted Date" := TODAY;
        PostedIssueHeader."Posted Time" := TIME;
        PostedIssueHeader.INSERT;


        StoreIssueLine.RESET;
        StoreIssueLine.SETRANGE("Document No.", "No.");
        IF StoreIssueLine.FIND('-') THEN
            REPEAT
                PostedIssueLine.TRANSFERFIELDS(StoreIssueLine);
                PostedIssueLine."Document No." := PostedIssueHeader."No.";
                PostedIssueLine.INSERT;
            UNTIL StoreIssueLine.NEXT = 0;


        IF TempIssueLine.FIND('-') THEN
            REPEAT
                JobJournalBatch.GET('JOB', 'DEFAULT');
                JobJnlLine.VALIDATE("Journal Template Name", 'JOB');
                JobJnlLine.VALIDATE("Journal Batch Name", 'DEFAULT');
                TempJobJnlLine.SETRANGE("Journal Template Name", JobJnlLine."Journal Template Name");
                TempJobJnlLine.SETRANGE("Journal Batch Name", JobJnlLine."Journal Batch Name");
                IF TempJobJnlLine.FIND('+') THEN
                    JobJnlLine."Line No." := TempJobJnlLine."Line No." + 10000
                ELSE
                    JobJnlLine."Line No." := 10000;
                JobJnlLine.INIT;
                JobJnlLine."Document No." := PostedIssueHeader."No.";
                JobJnlLine.VALIDATE("Posting Date", "Posting Date");
                JobJnlLine.VALIDATE("Job No.", TempIssueLine."Job No.");
                JobJnlLine.VALIDATE("Job Task No.", TempIssueLine."Job Task No.");
                JobJnlLine.VALIDATE(JobJnlLine.Type, JobJnlLine.Type::Item);
                IF TempIssueLine."Item No." <> '' THEN
                    JobJnlLine.VALIDATE(JobJnlLine."No.", TempIssueLine."Item No.");
                JobJnlLine.VALIDATE(Quantity, TempIssueLine.Quantity);
                JobJnlLine.VALIDATE("Location Code", TempIssueLine."Location Code");
                //JobJnlLine.VALIDATE(JobJnlLine."Gen. Bus. Posting Group",'JOBS');   //ddada

                JobJnlLine.VALIDATE(JobJnlLine."Gen. Bus. Posting Group", TempIssueLine."Gen. Bus. Posting Group");
                IF "Entry Type" = "Entry Type"::Issue THEN
                    JobJnlLine.VALIDATE(Quantity, TempIssueLine.Quantity)
                ELSE
                    JobJnlLine.VALIDATE(Quantity, -TempIssueLine.Quantity);

                //<<CREATE PLANNING LINES
                JobPlanningLine.RESET;
                JobPlanningLine.SETRANGE("Job No.", TempIssueLine."Job No.");
                JobPlanningLine.SETRANGE("Job Task No.", TempIssueLine."Job Task No.");
                JobPlanningLine.SETRANGE(JobPlanningLine.Type, JobPlanningLine.Type::Item);
                JobPlanningLine.SETRANGE(JobPlanningLine."No.", TempIssueLine."Item No.");
                IF NOT JobPlanningLine.FIND('-') THEN BEGIN
                    JobPlanningLine2.INIT;
                    JobPlanningLine2.VALIDATE("Job No.", TempIssueLine."Job No.");
                    JobPlanningLine2.VALIDATE("Job Task No.", TempIssueLine."Job Task No.");
                    JobPlanningLine2.VALIDATE("Line Type", JobPlanningLine2."Line Type"::"Both Budget and Billable");
                    JobPlanningLine2.VALIDATE("Planning Date", TODAY);
                    JobPlanningLine2.VALIDATE(JobPlanningLine2.Type, JobPlanningLine2.Type::Item);
                    JobPlanningLine2.VALIDATE(JobPlanningLine2."No.", TempIssueLine."Item No.");
                    JobPlanningLine2.VALIDATE(Quantity, TempIssueLine.Quantity);
                    IF Job.GET(JobPlanningLine2."Job No.") THEN BEGIN
                        //JobPlanningLine2.VALIDATE(JobPlanningLine2."Customer Job Type", Job."Customer Job Type");
                        //JobPlanningLine2.VALIDATE("Job Type Code", Job."Job Type Code");
                        // JobPlanningLine2.VALIDATE("Gen. Bus. Posting Group",'JOBS');

                        JobPlanningLine2.VALIDATE("Gen. Bus. Posting Group", TempIssueLine."Gen. Bus. Posting Group");

                    END;
                    JobPlanningLine2.INSERT(TRUE);
                END;
                //>>

                JobJnlLine.VALIDATE("Source Code", 'JOBJNL');
                //JobJnlLine.VALIDATE("Customer Job Type", "Customer Job Type");
                //JobJnlLine.VALIDATE("Job Type Code", "Job Type Code");
                //JobJnlLine.VALIDATE("Responsibility Center", "Responsibility Center");
                JobJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                JobJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                //JobJnlLine.VALIDATE("Shortcut Dimension 3 Code", "Shortcut Dimension 3 Code");
                //JobJnlLine.VALIDATE("Shortcut Dimension 4 Code", "Shortcut Dimension 4 Code");
                JobJnlLine.VALIDATE(JobJnlLine."Applies-from Entry", TempIssueLine."Applies from Item Entry");
                IF JobJnlLine.Type = JobJnlLine.Type::Item THEN BEGIN
                    Job.GET("Job No.");
                    //IF Job."Customer Job Type" = 'INTERNAL' THEN BEGIN
                        JobJnlLine.VALIDATE("Unit Price", 0);
                    //END;
                END;


                JobJnlLine.INSERT;
            UNTIL TempIssueLine.NEXT = 0;

        JobJnlLine.RESET;
        JobJnlLine.SETRANGE("Journal Template Name", 'JOB');
        JobJnlLine.SETRANGE("Journal Batch Name", 'DEFAULT');
        JobJnlLine.SETRANGE("Document No.", PostedIssueHeader."No.");
        JobPostBatch.RUN(JobJnlLine);



        StoreIssueLine.DELETEALL;
        DELETE;
    end;

    var
        InvtSetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DocNo: Code[20];
        PostedIssueHeader: Record "Posted Store Issue Header";
        PostedIssueLine: Record "Posted Store Issue Line";
        StoreIssueLine: Record "Store Issue Line";
        JobJournalBatch: Record "Job Journal Batch";
        JobPostLine: Codeunit "Job Jnl.-Post Line";
        JobPostBatch: Codeunit "Job Jnl.-Post Batch";
        Job: Record Job;
        JobPlanningLine: Record "Job Planning Line";
        JobTask: Record "Job Task";
        JobPlanningLine2: Record "Job Planning Line";
}

