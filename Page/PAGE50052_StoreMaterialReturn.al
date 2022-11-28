page 50052 "Store Material Return"
{
    Caption = 'Store Material Return';
    PageType = Card;
    SourceTable = "Store Issue Header";
    SourceTableView = WHERE("Request Type" = CONST(Job));

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
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = All;
                }
                field("Material Request No."; Rec."Material Request No.")
                {
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field("Customer Job Type"; Rec."Customer Job Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Job Type Code"; Rec."Job Type Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                    Caption = 'Requested By';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                }
            }
            part(RequestLine; "Store Material Return Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            group("User Trail")
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
            }
        }
        area(factboxes)
        {
            systempart(Control29; MyNotes)
            {
                ApplicationArea = All;
            }
            systempart(Control28; Notes)
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
                action("A&pprovals")
                {
                    Caption = 'A&pprovals';
                    Image = Approvals;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                    //   ApprovalEntries: Page "Approval Entries";
                    begin
                        //ApprovalEntries.Setfilters(DATABASE::"Purchase Request Header",13,"No.");
                        //ApprovalEntries.RUN;
                    end;
                }
            }
        }
        area(processing)
        {
            group(ActionGroup38)
            {
                Caption = 'Release';
                action(Release)
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    begin
                        //  PurchReqRelease.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = All;
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        /// PurchReqRelease.PerformManualReopen(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Send A&pproval Request")
                {
                    ApplicationArea = All;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    begin
                        //IF ApprovalMgt.SendPurchReqApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //IF ApprovalMgt.CancelPurchRequestApprovalReq(Rec,TRUE,TRUE) THEN;
                    end;
                }
                action("Get Material Request Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Get Material Request Lines';
                    Image = ItemTrackingLines;

                    trigger OnAction()
                    var
                        JobMatMgt: Codeunit "Job Request Management";
                    begin
                        JobMatMgt.GetMatReqLines(Rec);
                        CurrPage.RequestLine.PAGE.UpdateSubform;




                        //MIS 091917
                        IF "Entry Type" = "Entry Type"::Return THEN BEGIN
                            JobMatMgt.P_GetMatReqLines(Rec);
                            CurrPage.RequestLine.PAGE.UpdateSubform;
                        END ELSE BEGIN
                            JobMatMgt.GetMatReqLines(Rec);
                            CurrPage.RequestLine.PAGE.UpdateSubform;
                        END;
                        //MIS 091917
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("Post&Print")
                {
                    ApplicationArea = All;
                    Caption = 'Post&Print';
                    Image = PostPrint;
                    RunObject = Codeunit "Job Issue Post";
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        StoreReqReturn: Record "Store Issue Line";
                    begin
                        //StoreReqReturn.SETRANGE(StoreReqReturn."Document No.","No.");

                        StoreReqReturn.RESET;
                        StoreReqReturn.SETRANGE(StoreReqReturn."Document No.", "No.");
                        IF StoreReqReturn.FINDSET THEN
                            REPEAT
                            ///StoreReqReturn.TESTFIELD(StoreReqReturn."Applies from Item Entry");
                            UNTIL StoreReqReturn.NEXT = 0;
                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                action(Print)
                {
                    ApplicationArea = All;
                    Caption = 'Print';
                    Image = Print;

                    trigger OnAction()
                    var
                        purchreq: Record "Store Issue Header";
                    begin
                        purchreq.SETRANGE("No.", "No.");
                        IF purchreq.FINDFIRST THEN
                            REPORT.RUN(50002, TRUE, FALSE, purchreq);
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Request Type" := "Request Type"::Job;
        "Entry Type" := "Entry Type"::Return
    end;

    var
        JobMatMgt: Codeunit "Job Request Management";
        PurchReqRelease: Codeunit PurchReqRelease;
        // ApprovalMgt: Codeunit Codeunit439;
        purchreq: Record "Store Issue Header";
        StoreReqReturn: Record "Store Issue Line";
}

