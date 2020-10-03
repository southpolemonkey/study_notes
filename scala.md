# scala 

```scala
// get current directory
val currentDirectory = new java.io.File(".").getCanonicalPath
```

[java standard directory layout](http://maven.apache.org/guides/introduction/introduction-to-the-standard-directory-layout.html)

## build tool

[bazel](https://bazel.build/)

## Scala type system

- object
- trait
- implicit
- type class

## Functional Programming

two basic rules underlies the definition of `Monoid`

- associative law
- identity law

https://bartoszmilewski.com/2014/10/28/category-theory-for-programmers-the-preface/

## Nix

Concepts

- an immutable package manager
- store
- profile
- derivation(name, system which derivation can be built, builder)


```bash

# query the store
$ nix-store -q --references `which hello`

nix-repl> d = derivation { name = "myname"; builder = "mybuilder"; system = "mysystem"; }

$ nix show-derivation /nix/store/z3hhlxbckx4g3n9sw91nnvlkjvyw754p-myname.drv

$ nix-store -r /nix/store/z3hhlxbckx4g3n9sw91nnvlkjvyw754p-myname.drv

```

[nix-wiki-cheatsheet](https://nixos.wiki/wiki/Cheatsheet)

## sbt

Concepts

- scala built tool
- similar tools:
  - maven
  - bloop
  - gradle

`settings`

- show name
- show dependencies

`tasks`

- runMain
- test

## Notes for essential-scala book

chap3 modelling data with traits

- algebraic data types: sum type, product type
- Working with data, the book mentions `structural recursion`, and three ways to implement (ploymorphism, pattern matching in the base trait, pattern matching in an external object). Review and do exercises.

## Common pattern faq

```scala
// companion object pattern
sealed trait MetaGcs2BqError
object MetaGcs2BqError {
  final case class ExceptionEncountered(message: String) extends MetaGcs2BqError
  final case class StorageErrorEncountered(error: StorageError) extends MetaGcs2BqError
  final case class FileOpsErrorEncountered(error: FileOpsError) extends MetaGcs2BqError
  final case class ScioErrorEncountered(error: ScioError) extends MetaGcs2BqError

  def exception(e: Throwable): MetaGcs2BqError =
    ExceptionEncountered(s"Exception: ${Apps.stackTrace(e)}")
}
```

## Scala Cats

https://www.scala-exercises.org/cats/traverse
