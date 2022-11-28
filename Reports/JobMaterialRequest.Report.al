// report 50001 "Job Material Request"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './JobMaterialRequest.rdlc';

//     dataset
//     {
//         dataitem(DataItem1000000000; "Material Request Header")
//         {
//             DataItemTableView = SORTING("No.");
//             RequestFilterFields = "No.";
//             RequestFilterHeading = 'Material Request Header';
//             column(No_MaterialRequestHeader; "No.")
//             {
//             }
//             column(RequestType_MaterialRequestHeader; "Request Type")
//             {
//             }
//             column(RequestDate_MaterialRequestHeader; "Request Date")
//             {
//             }
//             column(JobNo_MaterialRequestHeader; "Job No.")
//             {
//             }
//             column(LocationCode_MaterialRequestHeader; "Location Code")
//             {
//             }
//             column(CreatedBy_MaterialRequestHeader; "Created By")
//             {
//             }
//             column(CreatedDate_MaterialRequestHeader; "Created Date")
//             {
//             }
//             column(CreatedTime_MaterialRequestHeader; "Created Time")
//             {
//             }
//             column(Engine_No; Engine)
//             {
//             }
//             column(Chassis_no; Chassis)
//             {
//             }
//             column(Model_No; Model)
//             {
//             }
//             column(Make; Make)
//             {
//             }
//             column(VehicleNo; VehRegNo)
//             {
//             }
//             column(Today; FORMAT(TODAY, 0, 4))
//             {
//             }
//             column(PAGENO; CurrReport.PAGENO)
//             {
//             }
//             column(CompPicture; CompInfo.Picture)
//             {
//             }
//             column(OutputNo; OutputNo)
//             {
//             }
//             column(USERID; USERID)
//             {
//             }
//             column(TIME; 'Time' + ' ' + FORMAT(TIME))
//             {
//             }
//             column(Vehiclemodel; Vehmodel)
//             {
//             }
//             dataitem(CopyLoop; Integer)
//             {
//                 DataItemTableView = SORTING(Number);
//                 dataitem(DimensionLoop1; Integer)
//                 {
//                     //DataItemLinkReference = "Material Request Header";
//                     DataItemTableView = SORTING(Number)
//                                         WHERE(Number = FILTER(1 ..));
//                     column(DimText; DimText)
//                     {
//                     }
//                     column(Number_DimensionLoop1; Number)
//                     {
//                     }

//                     trigger OnAfterGetRecord()
//                     begin
//                         IF Number = 1 THEN BEGIN
//                             IF NOT DimSetEntry1.FINDSET THEN
//                                 CurrReport.BREAK;
//                         END ELSE
//                             IF NOT Continue THEN
//                                 CurrReport.BREAK;

//                         CLEAR(DimText);
//                         Continue := FALSE;
//                         REPEAT
//                             OldDimText := DimText;
//                             IF DimText = '' THEN
//                                 DimText := STRSUBSTNO('%1 - %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
//                             ELSE
//                                 DimText :=
//                                   STRSUBSTNO(
//                                     '%1; %2 - %3', DimText,
//                                     DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
//                             IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
//                                 DimText := OldDimText;
//                                 Continue := TRUE;
//                                 EXIT;
//                             END;
//                         UNTIL DimSetEntry1.NEXT = 0;
//                     end;

//                     trigger OnPreDataItem()
//                     begin
//                         IF NOT ShowInternalInfo THEN
//                             CurrReport.BREAK;
//                     end;
//                 }
//                 dataitem("Material Request Line"; "Material Request Line")
//                 {
//                     //DataItemLink = "Document No." = FIELD("No.");
//                     //DataItemLinkReference = "Material Request Header";
//                     column(Quantity_MaterialRequestLine; Quantity)
//                     {
//                     }
//                     column(ItemNo_MaterialRequestLine; "Item No.")
//                     {
//                     }
//                     column(ItemCategoryCode_MaterialRequestLine; "Item Category Code")
//                     {
//                     }
//                     column(ProductGroupCode_MaterialRequestLine; "Product Group Code")
//                     {
//                     }
//                     column(Description_MaterialRequestLine; Description)
//                     {
//                     }
//                     column(LineNo_MaterialRequestLine; "Line No.")
//                     {
//                     }
//                     column(QuantityinInventory_MaterialRequestLine; "Quantity in Inventory")
//                     {
//                     }
//                     column(UnitofMeasureCode_MaterialRequestLine; "Unit of Measure Code")
//                     {
//                     }
//                     column(Cage; Cage)
//                     {
//                     }
//                     column(Shelf_No; Shelf_No)
//                     {
//                     }
//                     column(QtyInStock; QtyInStock)
//                     {
//                     }
//                     column(Usage30Days; Usage30Days)
//                     {
//                         DecimalPlaces = 0 : 2;
//                     }
//                     column(Usage180Days; Usage180Days)
//                     {
//                         DecimalPlaces = 0 : 2;
//                     }
//                     column(Usage360Days; Usage360Days)
//                     {
//                         DecimalPlaces = 0 : 2;
//                     }

//                     trigger OnAfterGetRecord()
//                     begin
//                         TotalAmount := TotalAmount + Amount;
//                         IF "Item No." <> '' THEN BEGIN
//                             ItemRec.GET("Item No.");
//                             ItemRec.SETRANGE(ItemRec."Variant Filter", "Variant Code");
//                             ItemRec.SETRANGE(ItemRec."Date Filter");
//                             ItemRec.CALCFIELDS(ItemRec.Inventory, ItemRec."Qty. on Purch. Order", ItemRec."Qty. On Request");
//                             QtyInStock := ItemRec.Inventory;
//                             QtyOnRequest := ItemRec."Qty. On Request";
//                             QtyOnPurchOrder := ItemRec."Qty. on Purch. Order";

//                             // 30 days usage
//                             ItemRec.SETRANGE(ItemRec."Variant Filter", "Variant Code");
//                             ItemRec.SETRANGE(ItemRec."Date Filter", CALCDATE('-1M', TODAY), TODAY);
//                             ItemRec.CALCFIELDS(ItemRec."Issue Qty");
//                             Usage30Days := ItemRec."Issue Qty";

//                             // 180 days usage
//                             ItemRec.SETRANGE(ItemRec."Variant Filter", "Variant Code");
//                             ItemRec.SETRANGE(ItemRec."Date Filter", CALCDATE('-2Q', TODAY), TODAY);
//                             ItemRec.CALCFIELDS(ItemRec."Issue Qty");
//                             Usage180Days := ItemRec."Issue Qty";

//                             // 360 days usage
//                             ItemRec.SETRANGE(ItemRec."Variant Filter", "Variant Code");
//                             ItemRec.SETRANGE(ItemRec."Date Filter", CALCDATE('-1Y', TODAY), TODAY);

//                             ItemRec.CALCFIELDS(ItemRec."Issue Qty");
//                             Usage360Days := ItemRec."Issue Qty";
//                             // Remark := "Stores Requisition Header.".Remark

//                         END ELSE BEGIN
//                             QtyInStock := 0;
//                             QtyOnRequest := 0;
//                             QtyOnPurchOrder := 0;
//                             Usage30Days := 0;
//                             Usage180Days := 0;
//                             Usage360Days := 0;


//                         END;

//                         IF ItemRec.GET("Material Request Line"."Item No.") THEN
//                             Cage := ItemRec.Cage;
//                         Shelf_No := ItemRec."Bin Code";

//                         DimSetEntry2.SETRANGE("Dimension Set ID", "Dimension Set ID");
//                     end;
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     IF Number > 1 THEN BEGIN
//                         CopyText := Text000;
//                         OutputNo += 1;
//                     END;
//                     CurrReport.PAGENO := 1;
//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     NoOfLoops := ABS(NoOfCopies) + 1;
//                     CopyText := '';
//                     SETRANGE(Number, 1, NoOfLoops);
//                     OutputNo := 1;
//                 end;
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");
//                 ServHeader.RESET;
//                 ServHeader.SETRANGE("Job Card No", "Material Request Header"."Job No.");
//                 IF ServHeader.FINDFIRST THEN BEGIN
//                     Engine := ServHeader."Engine Serial Number";
//                     Make := ServHeader."Vehicle/Equipment Make";
//                     Chassis := ServHeader."Chassis No.";
//                     VehRegNo := ServHeader."Service Item";
//                     //Model  :=ServHeader.;
//                     //ServiceItem := VehReg."Service Item";
//                     Vehmodel := ServHeader."Vehicle/Equipment Model";
//                     //VehReg:=ServHeader."Registration No.";
//                 END;
//                 /*VehReg.RESET;
//                 VehReg.SETRANGE("Registration ID","Material Request Header"."No.");
//                 IF VehReg.FINDFIRST THEN BEGIN
//                  ServiceItem := VehReg."Service Item";
//                  Vehmodel := VehReg."Engine Model";
                
//                 end;*/

//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnInitReport()
//     begin
//         CompInfo.GET;
//         CompInfo.CALCFIELDS(Picture);
//     end;

//     var
//         Engine: Code[30];
//         Chassis: Code[30];
//         Make: Code[30];
//         Model: Code[30];
//         ServiceItem: Code[30];
//         ItemRec: Record 27;
//         QtyInStock: Decimal;
//         QtyOnPurchOrder: Decimal;
//         QtyOnRequest: Decimal;
//         Usage30Days: Decimal;
//         Usage180Days: Decimal;
//         Usage360Days: Decimal;
//         DimSetEntry1: Record 480;
//         DimSetEntry2: Record 480;
//         //ServHeader: Record 50050;
//         CompInfo: Record 79;
//         ShowInternalInfo: Boolean;
//         Continue: Boolean;
//         OutputNo: Integer;
//         DimText: Text[120];
//         OldDimText: Text[75];
//         TotalAmount: Decimal;
//         Amount: Decimal;
//         Cage: Code[30];
//         Shelf_No: Code[30];
//         NoOfCopies: Integer;
//         NoOfLoops: Integer;
//         CopyText: Text[30];
//         Text000: Label 'COPY';
//         Text001: Label 'Transfer Order %1';
//         Text002: Label 'Page %1';
//         HdrDimensionsCaptionLbl: Label 'Header Dimensions';
//         LineDimensionsCaptionLbl: Label 'Line Dimensions';
//         VehRegNo: Code[30];
//         Vehmodel: Code[30];
// }

