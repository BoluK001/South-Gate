codeunit 50005 PurchReqRelease
{
    TableNo = "Store Issue Header";

    trigger OnRun()
    var
        PurchReqLine: Record "Store Issue Line";
    begin
        IF Status = Status::Released THEN
            EXIT;

        TESTFIELD("No.");
        TESTFIELD("Posting Date");
        IF NOT PurchReqtLineExist THEN
            ERROR(Text001, "No.", "Request Type");

        VALIDATE(Status, Status::Released);
        MODIFY(TRUE);
    end;

    var
        Text001: Label 'Line does not exist in %1,%2';
        Text002: Label 'This Request can only be released when the approval process is complete.';
        Text003: Label 'The Approval Process must be cancelled or completed to reopen this Request.';

    procedure Reopen(var PurchReqHeader: Record "Store Issue Header")
    begin
        WITH PurchReqHeader DO BEGIN
            IF Status = Status::Open THEN
                EXIT;
            VALIDATE(Status, Status::Open);
            MODIFY(TRUE);
        END;
    end;

    procedure PerformManualRelease(var PurchReqHeader: Record "Store Issue Header")
    var
        ApprovalEntry: Record "Approval Entry";
        ApprovalManagement: Codeunit "Approval mgt custom";
        ApprovedOnly: Boolean;
    begin
        WITH PurchReqHeader DO BEGIN
            CODEUNIT.RUN(CODEUNIT::PurchReqRelease, PurchReqHeader);
        END;
    end;

    procedure PerformManualReopen(var PurchReqHeader: Record "Store Issue Header")
    var
        ApprovalManagement: Codeunit "Approval mgt custom";
    begin
        WITH PurchReqHeader DO BEGIN
            /*IF ApprovalManagement.CheckApprPurchRequest(PurchReqHeader) THEN BEGIN
              CASE Status OF
                Status::"Pending Approval":
                  ERROR(Text003);
                Status::Open,Status::Released:
                  Reopen(PurchReqHeader);
              END;
            END ELSE */
            Reopen(PurchReqHeader);
        END;

    end;
}

