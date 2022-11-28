codeunit 50002 "Job Material Request Release"
{
    TableNo = "Material Request Header";

    trigger OnRun()
    begin
        if Status = Status::Released then
          exit;

        TestField("Request Date");
        TestField(Status,Status::Open);
        TestField("Job No.");

        MaterialReqLine.SetRange("Document No.","No.");
        MaterialReqLine.SetFilter(Quantity,'<>0');
        if not MaterialReqLine.Find('-') then
          Error(Text001,"No.");
        if not Confirm(Text002,false,"No.") then
          exit;
        MaterialReqLine.Reset;
        Validate(Status,Status::Released);
        Validate("Released Date",WorkDate);
        Validate("Released By",UserId);
        Modify;
    end;

    var
        MaterialReqLine: Record "Material Request Line";
        Text001: Label 'There is nothing to release for Material Requisition %1.';
        Text002: Label 'Do you want to Release the Material Requisition %1?';
        Text003: Label 'Do you want to Reopen the Material Requisition %1?';

    procedure Reopen(var MaterialReqHeader: Record "Material Request Header")
    begin
        with MaterialReqHeader do begin
          if Status = Status::Open then
            exit;
          if not Confirm(Text003,false,MaterialReqHeader."No.") then
            exit;
          Validate(Status,Status::Open);
          Modify;
        end;
    end;
}

