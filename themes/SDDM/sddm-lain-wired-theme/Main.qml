import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Qqc
import QtQuick.Window
import QtMultimedia
import SddmComponents

Rectangle {
	id: root
	color: "black"
	width: Window.width
	height: Window.height

	Connections {
		target: sddm

		function onLoginSucceeded() {
		}

		function onLoginFailed() {
			if (typeof primaryScreen === "undefined" || primaryScreen)
				denied.play()
			password.text = ""
			password.focus = true
		}
	}

	AnimatedImage {
		width: parent.width
		height: parent.height
		fillMode: Image.Tile
		source: "bgN5.gif"
	}

	ColumnLayout {
		anchors.fill: parent
		spacing: 6

		Item {
			Layout.fillHeight: true
			Layout.preferredHeight: 110
		}

		AnimatedImage {
			id: logo
			Layout.alignment: Qt.AlignCenter
			Layout.preferredWidth: Math.min(592, Math.max(220, root.height * 0.45))
			Layout.preferredHeight: logo.Layout.preferredWidth
			fillMode: Image.PreserveAspectFit
			source: "WiredLogIn.gif"
		}
		Qqc.Label {
			Layout.alignment: Qt.AlignCenter
			Layout.bottomMargin: Math.min(40, Math.max(12, root.height * 0.03))
			text: "Ｔｈｅ    Ｗｉｒｅｄ"
			color: "#c1b492"
			font.pixelSize: 30
		}
		Qqc.Label {
			Layout.alignment: Qt.AlignCenter
			text: "Ｕｓｅｒ ＩD:"
			color: "#c1b492"
			font.pixelSize: 20
		}
		Qqc.TextField {
			id: username
			Layout.alignment: Qt.AlignCenter
			Layout.preferredWidth: 200
			text: userModel.lastUser
			color: "#c1b492"
			background: Rectangle {
				color: "#000"
				implicitWidth: 200
				border.color: "#d2738a"
			}
			KeyNavigation.backtab: shutdownBtn; KeyNavigation.tab: password
			Keys.onPressed: (event) => {
				if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
					sddm.login(username.text, password.text, session.index)
					event.accepted = true
				}
			}
		}
		Qqc.Label {
			Layout.alignment: Qt.AlignCenter
			text: "Ｐａｓｓｗｏｒｄ："
			color: "#c1b492"
			font.pixelSize: 20
		}
		Qqc.TextField {
			id: password
			echoMode: TextInput.Password
			Layout.alignment: Qt.AlignCenter
			Layout.preferredWidth: 200
			color: "#c1b492"
			background: Rectangle {
				color: "#000"
				implicitWidth: 200
				border.color: "#d2738a"
			}
			KeyNavigation.backtab: username; KeyNavigation.tab: session
			Keys.onPressed: (event) => {
				if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
					sddm.login(username.text, password.text, session.index)
					event.accepted = true
				}
			}
		}
		Rectangle {
			Layout.alignment: Qt.AlignCenter
			Layout.topMargin: 20
			Layout.preferredWidth: 200
			Layout.preferredHeight: loginLabel.implicitHeight + 8
			color: "#d2738a"
			Qqc.Label {
				id: loginLabel
				anchors.centerIn: parent
				text: "Ｌｏｇｉｎ"
				color: "#c1b492"
				font.pixelSize: 20
			}
			MouseArea {
				anchors.fill: parent
				onClicked: sddm.login(username.text, password.text, session.index)
			}
		}

		Item {
			Layout.fillHeight: true
			Layout.preferredHeight: 150
		}
	}
	AnimatedImage {
		id: shutdownBtn
		height: 80
		width: 80
		y: 10
		x: Window.width - width - 10
		source: "VisLain.gif"
		fillMode: Image.PreserveAspectFit
		MouseArea {
			anchors.fill: parent
			onClicked: sddm.powerOff()
		}
	}
	AnimatedImage {
		id: rebootBtn
		anchors.right: shutdownBtn.left
		anchors.rightMargin: 5
		y: shutdownBtn.y + 10
		height: 70
		width: 60
		source: "lain_myese.gif"
		fillMode: Image.PreserveAspectFit
		MouseArea {
			anchors.fill: parent
			onClicked: sddm.reboot()
		}
	}
	ComboBox {
		id: session
		height: 30
		width: 200
		x: 15
		y: 20
		model: sessionModel
		index: sessionModel.lastIndex
		color: "#000"
		menuColor: "#000"
		arrowColor: "#000"
		borderColor: "#d2738a"
		focusColor: "#d2738a"
		hoverColor: "#d2738a"
		textColor: "#c1b492"
		arrowIcon: Qt.resolvedUrl("angle-down.png")

		KeyNavigation.backtab: password; KeyNavigation.tab: rebootBtn;
	}
	MediaPlayer {
		id: bgMusic
		source: Qt.resolvedUrl("bg_music.wav")
		loops: MediaPlayer.Infinite
		audioOutput: AudioOutput {}
	}
	MediaPlayer {
		id: welcome
		source: Qt.resolvedUrl("welcome.wav")
		audioOutput: AudioOutput {}
	}
	MediaPlayer {
		id: denied
		source: Qt.resolvedUrl("denied.wav")
		audioOutput: AudioOutput {}
	}

	Component.onCompleted: {
		if (typeof primaryScreen === "undefined" || primaryScreen) {
			bgMusic.play()
			welcome.play()
		}
		if (username.text == "") {
			username.focus = true
		} else {
			password.focus = true
		}
	}
}

