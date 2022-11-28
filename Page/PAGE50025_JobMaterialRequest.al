page 50025 "Job Material Request"
{
    PageType = Card;
    SourceTable = "Material Request Header";
    SourceTableView = WHERE("Request Type" = CONST(Job), "Entry Type" = FILTER(Issue));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = All;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                }
                field("Job Task Description"; Rec."Job Task Description")
                {
                    ApplicationArea = All;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                }
                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    //  Editable = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    NotBlank = true;
                    ApplicationArea = All;
                }
                field("Vehicle Registration No."; Rec."Vehicle Registration No.")
                {
                    ApplicationArea = All;
                }
            }
            part(RequestLine; "Job Material Request Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group("User Trial")
            {
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created Time"; Rec."Created Time")
                {
                    ApplicationArea = All;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                }
                field("Modified Time"; Rec."Modified Time")
                {
                    ApplicationArea = All;
                }
                field("Released Date"; Rec."Released Date")
                {
                    ApplicationArea = All;
                }
                field("Released By"; Rec."Released By")
                {
                    ApplicationArea = All;
                }
                field(Processed; Rec.Processed)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control26; Outlook)
            {
                ApplicationArea = All;
            }
            systempart(Control27; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control28; MyNotes)
            {
                ApplicationArea = All;
            }
            systempart(Control29; Links)
            {
                ApplicationArea = All;
            }
            part(Control33; "Item Invoicing FactBox")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Request")
            {
                Caption = '&Request';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                action("A&pprovals")
                {
                    Caption = 'A&pprovals';
                    Image = Approvals;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page 658;
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        doctype: Enum "Approval Document Type";
                    begin
                        //doctype := doctype::Requisition;
                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"Material Request Header", DocType.AsInteger(), "No.");
                    end;
                }
            }
        }
        area(processing)
        {
            group(Release)
            {
                Caption = 'Release';
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Get Job Planning Lines")
                {
                    Caption = 'Get Job Planning Lines';
                    Image = JobLines;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        JobPlanningLine: Record "Job Planning Line";
                        JobMatMgt: Codeunit "Job Request Management";
                    begin
                        JobPlanningLine.RESET;
                        JobPlanningLine.SETRANGE(JobPlanningLine."Job No.", Rec."Job No.");
                        JobPlanningLine.SETRANGE(JobPlanningLine.Type, JobPlanningLine.Type::Item);
                        IF JobPlanningLine.FIND('-') THEN
                            REPEAT
                            BEGIN
                                //Look for JOB LEDger here on Task line.

                                //////USed to check Default qty for battery and Tyres   ddada04132020
                                IF (JobPlanningLine."Gen. Prod. Posting Group" = 'TYRE') AND (NOT JobPlanningLine."Allow Approved Usage") THEN BEGIN

                                    TOTQty := JobPlanningLine."Quantity CONSM Per Year" + JobPlanningLine.Quantity;
                                    IF TOTQty > 8 THEN BEGIN
                                        JobPlanningLine.RESET;
                                        JobPlanningLine.TESTFIELD(JobPlanningLine."Approve/Reject", 0);
                                        JobPlanningLine."Reason For Approval" := 2;
                                        JobPlanningLine."BLocking Notification" := TRUE;
                                        ERROR('You cannot Create Jobs-Sales Invoice. The Item %4 \You had Prev. Consu. %1 Already + current qty %2 = %3 Tyres \You have excedded the 8 Batteries Default Qty. \please contact your Head Of Operations'
                                        , JobPlanningLine."Quantity CONSM Per Year", JobPlanningLine.Quantity, TOTQty, JobPlanningLine."No.");
                                    END;
                                END;

                                //////USed to check Default qty for battery and Tyres   ddada04132020

                                IF (JobPlanningLine."Gen. Prod. Posting Group" = 'BATTERY') AND (NOT JobPlanningLine."Allow Approved Usage") THEN BEGIN

                                    TOTQty := JobPlanningLine."Quantity CONSM Per Year" + JobPlanningLine.Quantity;
                                    IF TOTQty > 2 THEN BEGIN
                                        JobPlanningLine.RESET;
                                        JobPlanningLine.TESTFIELD(JobPlanningLine."Approve/Reject", 0);
                                        JobPlanningLine."Reason For Approval" := 2;
                                        JobPlanningLine."BLocking Notification" := TRUE;
                                        ERROR('You cannot Create Jobs-Sales Invoice. The Item %4 \You had Prev. Consu. %1 Already + current qty %2 = %3 Tyres \You have excedded the 2 Tyres Default Qty. \please contact your Head Of Operations'
                                        , JobPlanningLine."Quantity CONSM Per Year", JobPlanningLine.Quantity, TOTQty, JobPlanningLine."No.");
                                        // VALIDATE(Quantity,0);
                                    END;
                                END;
                            END;
                            UNTIL JobPlanningLine.NEXT = 0;

                        //////USed to check Default qty for battery and Tyres   ddada04132020




                        /*IF (JobPlanningLine."Gen. Prod. Posting Group" = 'TYRE') AND  (NOT JobPlanningLine."Allow Approved Usage") THEN
                          BEGIN

                           TOTQty := JobPlanningLine."Quantity CONSM Per Year" + JobPlanningLine.Quantity;
                           IF   TOTQty > 8   THEN
                           BEGIN
                              JobPlanningLine.RESET;
                              JobPlanningLine.TESTFIELD(JobPlanningLine."Approve/Reject",0);
                              JobPlanningLine."Reason For Approval" := 2;
                              JobPlanningLine."BLocking Notification" :=TRUE;
                              ERROR('You cannot Create Jobs-Sales Invoice. The Item %4 \You had Prev. Consu. %1 Already + current qty %2 = %3 Tyres \You have excedded the 8 Batteries Default Qty. \please contact your Head Of Operations'
                              ,JobPlanningLine."Quantity CONSM Per Year",JobPlanningLine.Quantity,TOTQty,JobPlanningLine."No.");
                            END;
                          END;

                        IF (JobPlanningLine."Gen. Prod. Posting Group" = 'BATTERY')  AND (NOT JobPlanningLine."Allow Approved Usage") THEN
                          BEGIN

                           TOTQty := JobPlanningLine."Quantity CONSM Per Year" + JobPlanningLine.Quantity;
                           IF TOTQty>2 THEN
                           BEGIN
                              JobPlanningLine.RESET;
                              JobPlanningLine.TESTFIELD(JobPlanningLine."Approve/Reject",0);
                              JobPlanningLine."Reason For Approval" := 2;
                              JobPlanningLine."BLocking Notification" :=TRUE;
                              ERROR('You cannot Create Jobs-Sales Invoice. The Item %4 \You had Prev. Consu. %1 Already + current qty %2 = %3 Tyres \You have excedded the 2 Tyres Default Qty. \please contact your Head Of Operations'
                              ,JobPlanningLine."Quantity CONSM Per Year",JobPlanningLine.Quantity,TOTQty,JobPlanningLine."No.");
                              // VALIDATE(Quantity,0);
                            END;
                          END;
                        //////USed to check Default qty for battery and Tyres   ddada04132020
                         */



                        JobMatMgt.GetJobPlanningLines(Rec);
                        CurrPage.RequestLine.PAGE.UpdateSubform;
                        //

                    end;
                }
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    ApplicationArea = All;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        IF NOT LinesExists THEN
                            ERROR('There are no Lines created for this Document');

                        //Status:=Status::Released;
                        //MODIFY;

                        //Release the Imprest for Approval
                        /// IF ApprovalMgt.SendJobMatRequestApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Reject;
                    Promoted = true;
                    ApplicationArea = All;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        ///  IF ApprovalMgt.CancelJobMatRequestApprovalRequest(Rec, TRUE, TRUE) THEN;
                    end;
                }
                action(Action1000000002)
                {
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    ApplicationArea = All;
                    RunObject = Codeunit "Job Material Request Release";
                    Visible = false;
                }
                action(Repoen)
                {
                    Caption = 'Repoen';
                    Image = ReOpen;
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /// MatReqRelease.Reopen(Rec);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
            }
            group("&Print")
            {
                Caption = '&Print';
                action(Print)
                {
                    Caption = 'Print';
                    Image = Print;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        JobPlanningLine: Record "Job Planning Line";
                        MatReqHeader: Record "Material Request Header";
                    begin
                        //////USed to check Default qty for battery and Tyres   ddada04132020
                        IF (JobPlanningLine."Gen. Prod. Posting Group" = 'TYRE') AND (NOT JobPlanningLine."Allow Approved Usage") THEN BEGIN

                            TOTQty := JobPlanningLine."Quantity CONSM Per Year" + JobPlanningLine.Quantity;
                            IF TOTQty > 8 THEN BEGIN
                                JobPlanningLine.RESET;
                                JobPlanningLine.TESTFIELD(JobPlanningLine."Approve/Reject", 0);
                                JobPlanningLine."Reason For Approval" := 2;
                                JobPlanningLine."BLocking Notification" := TRUE;
                                ERROR('You cannot Create Jobs-Sales Invoice. The Item %4 \You had Prev. Consu. %1 Already + current qty %2 = %3 Tyres \You have excedded the 8 Batteries Default Qty. \please contact your Head Of Operations'
                                , JobPlanningLine."Quantity CONSM Per Year", JobPlanningLine.Quantity, TOTQty, JobPlanningLine."No.");
                            END;
                        END;

                        IF (JobPlanningLine."Gen. Prod. Posting Group" = 'BATTERY') AND (NOT JobPlanningLine."Allow Approved Usage") THEN BEGIN

                            TOTQty := JobPlanningLine."Quantity CONSM Per Year" + JobPlanningLine.Quantity;
                            IF TOTQty > 2 THEN BEGIN
                                JobPlanningLine.RESET;
                                JobPlanningLine.TESTFIELD(JobPlanningLine."Approve/Reject", 0);
                                JobPlanningLine."Reason For Approval" := 2;
                                JobPlanningLine."BLocking Notification" := TRUE;
                                ERROR('You cannot Create Jobs-Sales Invoice. The Item %4 \You had Prev. Consu. %1 Already + current qty %2 = %3 Tyres \You have excedded the 2 Tyres Default Qty. \please contact your Head Of Operations'
                                , JobPlanningLine."Quantity CONSM Per Year", JobPlanningLine.Quantity, TOTQty, JobPlanningLine."No.");
                                // VALIDATE(Quantity,0);
                            END;
                        END;
                        //////USed to check Default qty for battery and Tyres   ddada04132020

                        MatReqHeader.SETRANGE("No.", Rec."No.");
                        IF MatReqHeader.FINDFIRST THEN
                            REPORT.RUN(50001, TRUE, FALSE, MatReqHeader);
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Request Type" := "Request Type"::Job;
        "Entry Type" := "Entry Type"::Issue
    end;

    var
        JobMatMgt: Codeunit "Job Request Management";
        MatReqRelease: Codeunit "Job Material Request Release";
        MatReqHeader: Record "Material Request Header";
        ApprovalMgt: Codeunit "Approval mgt custom";
        HasLines: Boolean;
        JobPlanningLine: Record "Job Planning Line";
        TOTQty: Decimal;

    procedure LinesExists(): Boolean
    var
        JobMatReqLines: Record "Material Request Line";
    begin
        HasLines := FALSE;
        JobMatReqLines.RESET;
        JobMatReqLines.SETRANGE(JobMatReqLines."Document No.", Rec."No.");
        IF JobMatReqLines.FIND('-') THEN BEGIN
            JobMatReqLines.TESTFIELD(JobMatReqLines."Gen. Bus. Posting Group");    //DDADA
            HasLines := TRUE;
            EXIT(HasLines);
        END;
    end;
}



