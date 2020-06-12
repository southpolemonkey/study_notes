```scala
// get current directory
val currentDirectory = new java.io.File(".").getCanonicalPath
```

java standard directory layout
http://maven.apache.org/guides/introduction/introduction-to-the-standard-directory-layout.html

## build tool

[bazel](https://bazel.build/)

## Scala type system

object
trait
implicit
type class

## Functino Programming

two basic rules underlies the definition of `Monoid`
- associative law
- identity law

## Nix

Term
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

`settings`
- show name
- show dependencies

`tasks`
- runMain
- test

