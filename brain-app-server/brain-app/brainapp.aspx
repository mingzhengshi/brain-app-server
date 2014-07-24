﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="brainapp.aspx.cs" Inherits="brain_app_server.brainapp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Brain Data Viewer</title>

    <link rel="stylesheet" type="text/css" href="../extern/dc.css" />
    <style type="text/css">
        html, body {
            height: 100%;
            width: 100%;
        }

        body {
            margin: 0;
            padding: 0;
            overflow: hidden;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;
        }

        h1 {
            font-size: 30px;
            font-weight: bold;
            line-height: normal;
        }

        h2 {
            font-size: 18px;
            font-weight: bold;
            line-height: normal;
        }

        h3 {
            font-size: 14px;
            font-weight: bold;
            line-height: normal;
        }

        #control-panel {
            position: absolute;
            left: 0px;
            width: 250px;
            top: 0px;
            bottom: 0px;
            overflow: hidden;
            padding: 10px;
            font-size: 12px;
        }

        /* Holds the #view-panel and the #pin. */
        #outer-view-panel {
            position: absolute;
            left: 272px;
            right: 0px;
            top: 0px;
            bottom: 0px;
            overflow: hidden;
        }

        #view-panel {
            position: absolute;
            left: 12px;
            right: 12px;
            top: 12px;
            bottom: 12px;
        }

        #view-top-left {
            top: 0px;
            left: 0px;
            background-color: #ffe5e5;
        }

        #view-top-right {
            top: 0px;
            right: 0px;
            background-color: #d7e8ff;
        }

        #view-bottom-left {
            bottom: 0px;
            left: 0px;
            background-color: #fcffb2;
        }

        #view-bottom-right {
            bottom: 0px;
            right: 0px;
            background-color: #d2ffbd;
        }

        .view {
            position: absolute;
            overflow: hidden;
            border: 2px solid;
            border-color: white;
        }

        .tab {
            padding: 0px;
            margin-left: -16px;
            margin-right: -16px;
        }

        #accordion {
            height: 380px;
        }

        #accordion .ui-accordion-content {
            padding: 12px;
        }

        /* Used to set the size of the input (type = 'file') elements in the accordion */
        input {
            width: 196px;
        }

        .fold {
            padding: 0;
        }
        
        /* The element situated at the intersection of the four views that is dragged to resize them */
        #pin {
            position: absolute;
            width: 24px;
            height: 24px;
            background-color: grey;
            opacity: 0.2;
            z-index: 1000;
        }

        #pin:hover {
            opacity: 1;
        }

        .icon {
            width: 96px;
            height: 32px;
            z-index: 10;
            text-align: center;
            line-height: 32px; /* Force vertical alignment to be centred (for text) */
            font-size: 14px;
            font-weight: bold;
        }

        /* The draggable part of an icon */
        .icon-front {
            position: absolute;
        }

        #dataset1-icon-back, #dataset2-icon-back, #brain3d-icon-back {
            background-color: #133cac;
        }

        #dataset1-icon-front, #dataset2-icon-front, #brain3d-icon-front {
            background-color: #6d89d5;
        }

        .dataset-info {
            height: 100px;
        }

        .dataset-component {
            font-size: 14px;
            font-weight: bold;
            line-height: 7px;
            color: red;
        }

        #leap-pointer {
            width: 12px;
            height: 12px;
            background-color: blue;
            z-index: 10000;
        }

        .view-panel-span {
            position: absolute;
            cursor: pointer;
            font-size: 16px;
            text-align: center;
            /*font-weight: bold;*/
            /*border: 2px solid black;*/
            display: inline-block;
            line-height: 0px;
            z-index: 1000;
            opacity: 0.2;
        }

        .view-panel-span:hover {
            opacity: 1;
        }

        .node {
          stroke: #fff;
          stroke-width: 0.5px;
          /*stroke-opacity: .5;*/
          /*opacity: 0.5;*/
        }

        .nodeLable {
            font: 10px "Helvetica Neue", Helvetica, Arial, sans-serif;
        }

        .link {
            stroke: #999;
          /*stroke-opacity: .8;*/
        }

        .nodeCircular {
            font: 11px "Helvetica Neue", Helvetica, Arial, sans-serif;
        }

        .linkCircular {
            stroke: steelblue;
            stroke-opacity: .4;
            fill: none;
        }

        .rect1Circular {
            fill: steelblue;
        }

        .rect2Circular {
            fill: #FF7F0E;
        }

        .network-type-appended-element {
            z-index: 1000;
            position: relative;
        }

    </style>
    <link rel="stylesheet" href="../extern/jquery-ui-1.10.4.custom/css/sunny/jquery-ui-1.10.4.custom.css" />
</head>
<body>
    <!-- Page structure -->
    <div id="control-panel">
        <ul>
            <li><a href="#tab-1">Surface</a></li>
            <li><a href="#tab-2">Data</a></li>
            <li><a href="#tab-3">Attribute</a></li>
            <!--<li><a href="#tab-4">Help</a></li>-->
        </ul>
        <div id="tab-1" class="tab">
            <div style="margin-bottom: 30px;">
                <p style="margin-bottom: 0;">
                    color:
                    <input id="input-surface-color"
                           class="color {pickerFace:3,
                                         pickerFaceColor:'#feeebd',
                                         styleElement:'input-surface-color-style'}"
                           value="E3E3E3"
                           style="width: 80px; background-color: #feeebd; border: 1px solid grey"
                           onchange="setBrainSurfaceColor(this.color);">
                    <input id="input-surface-color-style" style="width: 11px; height: 11px; border: 1px solid #000000" readonly>
                </p>
                <p style="margin-top: 5px; margin-bottom: 0;">
                    model:
                    <select id="brain3d-model-select" style="background-color: #feeebd; margin-bottom: 10px;">
                        <option value="icbm">ICBM152</option>
                        <option value="ch2">CH2</option>
                        <option value="ch2_inflated">CH2 Inflated</option>
                        <option value="ch2_cerebellum">CH2 Cerebellum</option>
                        <option value="none">None</option>
                    </select>
                </p>
                <div id="brain3d-icon-back" class="icon"></div>
            </div>
            <div style="margin-bottom: 30px; margin-left: 0px;">
                <input type="checkbox" id="checkbox_yoking_view" style="width: 12px;">Yoking View Orientation
            </div>
            <div>
                <form id="form_sumbit_file" method="post" runat="server" enctype="multipart/form-data">
				    <label>File:</label>
				    <input id="input_select_file" type="file" runat="server" />
                    <br />
				    <asp:button id="button_submit_file" runat="server" Text="Submit"/>
		        </form>
            </div>
        </div>
        <div id="tab-2" class="tab">
            <div id="accordion">
                <h2>Shared Data</h2>
                <div class="fold">
                    <h3>Coordinates</h3>
                    <input id="select-coords" type="file" />
                    <button id="upload-coords">Upload</button>
                    <h3>Labels</h3>
                    <input id="select-labels" type="file" />
                    <button id="upload-labels">Upload</button>
                    <!--
                    <h3>Surface (Hardcoded)</h3>
                    <input id="select-surface" type="file" />
                    <button id="upload-surface">Upload</button>
                    -->
                    <br />
                    <br />
                </div>
                <h2>Data Set 1</h2>
                <div class="fold">
                    <h3>Similarity Matrix</h3>
                    <input id="select-matrix-1" type="file" />
                    <button id="upload-matrix-1">Upload</button>
                    <h3>Attributes</h3>
                    <input id="select-attr-1" type="file" />
                    <button id="upload-attr-1">Upload</button>
                    <br />
                    <br />
                </div>
                <h2>Data Set 2</h2>
                <div class="fold">
                    <h3>Similarity Matrix</h3>
                    <input id="select-matrix-2" type="file" />
                    <button id="upload-matrix-2">Upload</button>
                    <h3>Attributes</h3>
                    <input id="select-attr-2" type="file" />
                    <button id="upload-attr-2">Upload</button>
                    <br />
                    <br />
                </div>
            </div>
            <button id="load-example-data">Load Example Data</button>
            <h2>Shared Data</h2>
            <p id="shared-coords" class="dataset-component">Coordinates</p>
            <p id="shared-labels" class="dataset-component">Labels</p>
            <br />
            <div class="dataset-info">
                <div id="dataset1-icon-back" class="icon"></div>
                <p id="d1-mat" class="dataset-component">Similarity Matrix</p>
                <p id="d1-att" class="dataset-component">Attributes</p>
            </div>
            <div class="dataset-info">
                <div id="dataset2-icon-back" class="icon"></div>
                <p id="d2-mat" class="dataset-component">Similarity Matrix</p>
                <p id="d2-att" class="dataset-component">Attributes</p>
            </div>
        </div>
        <div id="tab-3" class="tab" style="height: 95%; overflow-x: hidden; overflow-y: auto;">
            <div id="barCharts"></div>
            <div style='clear:both'></div>
            <div class="dc-data-count">
                <button id="button-apply-filter" title="Show only nodes that are selected above" style="font-size:10px;" disabled="true">Apply</button>
                <span class="filter-count"></span> selected out of <span class="total-count"></span> | <a href="javascript:dc.filterAll();dc.renderAll();">Reset</a>
                <div id="div-set-node-scale" style="visibility:hidden; margin-top: 10px; margin-bottom: 5px; margin-left: 5px;">
                    <!--button id="button-set-node-size-color" title="Set node size/color based on its attributes" style="font-size:10px;">Set</button-->
                    Set
                    <select id="select-node-size-color" style="background-color: #feeebd;">
                        <option value="node-size">size</option>
                        <option value="node-color">color</option>
                        <option value="node-default">default</option>
                    </select> by
                    <select id="select-attribute" style="background-color: #feeebd"></select>
                </div>
            </div>
            <div id="div-node-size" style="visibility:hidden; margin-top: 30px; margin-left: 40px;">
                <p>
                    <label>range:</label>
                    <label id="label_node_size_range"></label>
                </p>
                <div id="div-node-size-slider"></div>
            </div>
            <div id="div-node-color-pickers-discrete" style="visibility:hidden; margin-top: 30px; margin-left: 40px;">
                <p>
                    key:
                    <select id="select-node-key" style="background-color: #feeebd"></select>
                    <input id="input-node-color"
                           class="color {pickerFace: 3,
                                         pickerFaceColor: '#feeebd',
                                         styleElement: 'input-node-color-style',
                                         onImmediateChange: 'setSelectNodeKeyBackgroundColor(this); setNodeSizeOrColor();'}"
                           value="FFFF00"
                           style="width: 80px; background-color: #feeebd; border: 1px solid grey"
                           onchange="setSelectNodeKeyBackgroundColor(this.color); setNodeSizeOrColor();">
                    <input id="input-node-color-style" style="width: 11px; height: 11px; border: 1px solid #000000" readonly>
                </p>
            </div>
            <div id="div-node-color-pickers" style="visibility:hidden; margin-top: 30px; margin-left: 40px;">
                <p style="margin-bottom: 0;">
                    min:
                    <input id="input-min-color"
                           class="color {pickerFace:3,
                                         pickerFaceColor:'#feeebd',
                                         styleElement:'input-min-color-style',
                                         onImmediateChange: 'setNodeSizeOrColor();'}"
                           value="FFFF00"
                           style="width: 80px; background-color: #feeebd; border: 1px solid grey"
                           onchange="setNodeSizeOrColor();">
                    <input id="input-min-color-style" style="width: 11px; height: 11px; border: 1px solid #000000" readonly>
                </p>
                <p style="margin-top: 0;">
                    max:
                    <input id="input-max-color"
                           class="color {pickerFace:3,
                                         pickerFaceColor:'#feeebd',
                                         styleElement:'input-max-color-style',
                                         onImmediateChange: 'setNodeSizeOrColor();'}"
                           value="FF0000"
                           style="width: 80px; background-color: #feeebd; border: 1px solid grey"
                           onchange="setNodeSizeOrColor();">
                    <input id="input-max-color-style" style="width: 11px; height: 11px; border: 1px solid #000000" readonly>
                </p>
            </div>
        </div>
        <!--div id="tab-4" class="tab">
            <h3>How to use this application</h3>
            <p>
                In the data tab, select the data files from the local machine. In the visualisation tab,
                you can drag one of the available visualisations into any of the four views. The visualisation
                won't display until you drag one of the data sets (the blue boxes in the data tab) into the view as well.
                All the necessary data for a visualisation must have been loaded, or else it will not be
                displayed.
            </p>
            <p>
                To resize the views, drag the black pin around.
            </p>
            <p>
                To direct keyboard / Leap input to a particular view, you must select it with the mouse.
                The currently-selected view has a black border around it.
            </p>
            <br />
            <h3>"Brain 3D" application controls</h3>
            <p>
                Drag the slider to select the number of edges you want in the thresholded graph. Then press space
                to view the graph. You can rotate the view with the WASD keys, and moving the mouse over a node will
                enlarge that node in both graphs.
            </p>
            <p>
                There is very limited Leap Motion support available. You can pan your hand around to rotate the view,
                and you can point at a node to enlarge it.
            </p>
        </!--div-->
    </div>

    <div id="outer-view-panel">
        
        <div id="view-panel">
            <div id="view-top-left" class="view"></div>
            <div id="view-top-right" class="view"></div>
            <div id="view-bottom-left" class="view"></div>
            <div id="view-bottom-right" class="view"></div>
        </div>
        <div id="pin"></div>
    </div>

    <div id="leap-pointer"></div>

    <!-- Draggable icons -->
    <div id="dataset1-icon-front" class="icon icon-front">Data Set 1</div>
    <div id="dataset2-icon-front" class="icon icon-front">Data Set 2</div>
    <div id="brain3d-icon-front" class="icon icon-front">3D Brain</div>

    <div id="div-context-menu-color-picker" style="visibility:hidden;">
        color:
        <input id="input-context-menu-node-color"
               class="color {pickerFace:3,
                             pickerFaceColor:'#feeebd',
                             styleElement:'input-context-menu-node-color-style',
                             onImmediateChange: 'setNodeColorInContextMenu(this);'}"
               value="FFFF00"
               style="width: 80px; background-color: #feeebd; border: 1px solid grey"
               onchange="setNodeColorInContextMenu(this.color);">
        <input id="input-context-menu-node-color-style" style="width: 11px; height: 11px; border: 1px solid #000000" readonly>
    </div>

    <!-- Required scripts -->

    <script src="../extern/jquery-1.10.2.min.js"></script>
    <script src="../extern/jquery-ui-1.10.4.custom/js/jquery-ui-1.10.4.custom.min.js"></script>

    <script src="../extern/three.js"></script>
    <script src="../extern/OBJLoader.js"></script>
    <script src="../extern/leap.js"></script>

    <!-- Used for resource loading -->
    <script src="../extern/d3.v3.js"></script>

    <script src="../extern/crossfilter.js"></script>
    <script src="../extern/dc.js"></script>
    <script src="../extern/jscolor/jscolor.js"></script>

    <script src="../extern/numeric-1.2.6.js"></script>
    <script src="../extern/packages.js"></script>

    <script src="../cola.v3.min.js"></script>
    <script src="../src/descent.js"></script>
    <script src="../src/d3adaptor.js"></script>

    <!-- The main application script -->
    <script src="input.js"></script>
    <script src="brain3d.js"></script>  
    <script src="brainapp.js"></script>

</body>
</html>

