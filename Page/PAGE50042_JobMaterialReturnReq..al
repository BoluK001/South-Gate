page 50042 "Job Material Return Req."
{
    PageType = Card;
    SourceTable = "Material Request Header";
    SourceTableView = WHERE("Request Type" = CONST(Job), "Entry Type" = FILTER(Return));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
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
                field("Requested Name"; Rec."Requested Name")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
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
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDocDim;
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
                    ApplicationArea = All;
                    Caption = 'Get Job Planning Lines';
                    Image = JobLines;
                    Visible = false;

                    trigger OnAction()
                    begin
                        JobMatMgt.GetJobPlanningLines(Rec);
                        CurrPage.RequestLine.PAGE.UpdateSubform;
                    end;
                }
                action("Get Return Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Get Return Lines';
                    Image = JobLines;
                    RunObject = Page "Job Ledger Entries";

                    trigger OnAction()
                    begin
                        /*JobMatMgt.GetJobPlanningLines(Rec);
                        CurrPage.RequestLine.PAGE.UpdateSubform;
                         */

                    end;
                }
                action("Send A&pproval Request")
                {
                    ApplicationArea = All;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
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
                    ApplicationArea = All;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        ///  IF ApprovalMgt.CancelJobMatRequestApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
                action(Action1000000002)
                {
                    ApplicationArea = All;
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    RunObject = Codeunit "Job Material Request Release";
                }
                action(Repoen)
                {
                    ApplicationArea = All;
                    Caption = 'Repoen';
                    Image = ReOpen;

                    trigger OnAction()
                    begin
                        MatReqRelease.Reopen(Rec);
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
                    ApplicationArea = All;
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
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
        "Entry Type" := "Entry Type"::Return;
    end;

    trigger OnOpenPage()
    var
        UserMgt: Codeunit 5700;
    begin
        IF UserMgt.GetServiceFilter <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Responsibility Center", UserMgt.GetServiceFilter);
            FILTERGROUP(0);
        END;
    end;

    var
        JobMatMgt: Codeunit "Job Request Management";
        MatReqRelease: Codeunit "Job Material Request Release";
        MatReqHeader: Record "Material Request Header";
        /// ApprovalMgt: Codeunit Codeunit439;
        HasLines: Boolean;

        UserMgt: Codeunit "User Setup Management";

    procedure LinesExists(): Boolean
    var
        JobMatReqLines: Record "Material Request Line";
    begin
        HasLines := FALSE;
        JobMatReqLines.RESET;
        JobMatReqLines.SETRANGE(JobMatReqLines."Document No.", Rec."No.");
        IF JobMatReqLines.FIND('-') THEN BEGIN
            HasLines := TRUE;
            EXIT(HasLines);
        END;
    end;
}

