resolvers ++= Seq(
  "Sonatype OSS Releases" at "https://oss.sonatype.org/content/repositories/releases/",
  "Sonatype OSS Snapshots" at "https://oss.sonatype.org/content/repositories/snapshots/"
)

addSbtPlugin("net.ceedubs" %% "sbt-ctags" % "0.3.0")
addSbtPlugin("org.ensime" % "sbt-ensime" % "2.6.1")
addSbtPlugin("org.scalameta" % "sbt-metals" % "0.5.1")
addSbtPlugin("ch.epfl.scala" % "sbt-bloop" % "1.2.5")
