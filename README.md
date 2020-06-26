# codecards

Commit 3 - Colors Updated and folders made (Ishit works on Login ; Yash works on OnBoard)

Commit 5 - Basic OnBoard done; to be finished - Theme and Layout

Commit 9 - OnBoard 90% done

Commit 20 - Added Gradients in 2 places, Replaced Row with Stack in button layouts, improvised padding at 2 3 places. 

Commit 23 - Main App Navigation Added and removed Flexible from Login Page Stack widget beacuse of an error.

Commit 26 - Navigation Complete. Main Page is where we code swipe cards and settings, Ishit is doing.

Commit 29 - Notes Page in progress.


Date 6/24/2020 Added below code because of error(Plugin project :url_launcher_web not found. Please update settings.gradle. )
def flutterProjectRoot = rootProject.projectDir.parentFile.toPath()

def plugins = new Properties()
def pluginsFile = new File(flutterProjectRoot.toFile(), '.flutter-plugins')
if (pluginsFile.exists()) {
    pluginsFile.withReader('UTF-8') { reader -> plugins.load(reader) }
}

plugins.each { name, path ->
    def pluginDirectory = flutterProjectRoot.resolve(path).resolve('android').toFile()
    include ":$name"
    project(":$name").projectDir = pluginDirectory
}
