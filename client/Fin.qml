import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.10
import QtWebSockets 1.0
import "library"

Item {
    id : endwindow
    height : 400
    width : 700

    property alias endcolumnid : endcolumnid

    Rectangle {
        height : parent.height
        width : parent.width
        color : "transparent"
        border.color : "indianred"
        border.width : 3


        Rectangle {
            width : parent.width/4
            x : 95/100*(parent.width/2) 
            y : 40
            height : 100
            Row {
                width : parent.width
                height : parent.height
                spacing : 3
                Rectangle {
                    width : parent.width/3
                    height : parent.height/3
                    Text {
                        id : titleend
                        height : 50
                        width : 30
                        text : "Cerbere" 
                        font.pointSize: 24
			            font.family: "Stoneyard"
                    }

                }
            }
        }


        Rectangle {
            width : 8/10*parent.width
            height : 9/10*parent.height
            y : 1/10*height
            x : 1/10*width
            Column {
                id : endcolumnid
                width : parent.width
                height : parent.height
                Rectangle {
                    width : 9/10*parent.width
                    height : parent.height/3
                    border.color : "indianred"
                    border.width : 1

                    Column {
                        width : parent.width
                        height : parent.height
                        Rectangle {
                            width : parent.width/2
                            height : parent.height/5

                            Text {
                                text : "Aventurier : " 
                                font.pointSize: 24
                                font.family: "Stoneyard"
                            }
                        }

                        Rectangle {
                            width : parent.width/2
                            height : parent.height/5

                            Text {
                                text : "" 
                                font.pointSize: 24
                                font.family: "Stoneyard"
                            }
                        }
                    }
                    
                }

                Rectangle {
                    width : 9/10*parent.width
                    height : parent.height/3
                    border.color : "indianred"
                    border.width : 1

                    

                    Column {
                        width : parent.width
                        height : parent.height
                        Rectangle {
                            width : parent.width/2
                            height : parent.height/5

                            Text {
                                text : "Cerbere : " 
                                font.pointSize: 24
                                font.family: "Stoneyard"
                            }
                        }

                        Rectangle {
                            width : parent.width/2
                            height : parent.height/5

                            Text {
                                text : "" 
                                font.pointSize: 24
                                font.family: "Stoneyard"
                            }
                        }
                    }

                }
 

                Rectangle {
                    width : 9/10*parent.width
                    height : parent.height/3
                    border.color : "indianred"
                    border.width : 1

                    

                    Column {
                        width : parent.width
                        height : parent.height
                        Rectangle {
                            width : parent.width/2
                            height : parent.height/5

                            Text {
                                text : "Eliminer : " 
                                font.pointSize: 24
                                font.family: "Stoneyard"
                            }
                        }
                        Rectangle {
                            width : parent.width/2
                            height : parent.height/5

                            Text {
                                text : "" 
                                font.pointSize: 24
                                font.family: "Stoneyard"
                            }
                        }
                    }

                   
                }
            }
        }
    }
}