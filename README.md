# cmake-cpp-presets
A simple repo-guide to help you setup your project and get started coding! 

I reserve myself for any future changes that might render this guide irrelevant. - Hugo. H

## TL;DR
You need the following four (4) files:
* `vcpkg.json`
* `CMakePresets.json`
* `CMakeUserPresets.json`
* `CMakeLists.txt`

### Quick info

>`vcpkg.json` will contain all the libraries/dependencies you want in your project.

```json
{
  "name": "...",
  "description": "...",
  "dependencies": [
    "...",
    "...",
    "..."
  ]
}
```

>`CMakePresets.json` is the base preset that tells `CMake` where it can find the toolchain file from the `vcpkg` directory.

```json
{
  "version": 2,
  "configurePresets": [
    {
      "name": "project-name",
      "generator": "Visual Studio 17 2022",
      "binaryDir": "${sourceDir}/build",
      "cacheVariables": {
        "CMAKE_TOOLCHAIN_FILE": "$env{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake"
      }
    }
  ]
}
```

>`CMakeUserPresets.json` caches/creates a variable of the full path to the `vcpkg` directory which is used when inheriting `CMakePresets.json`.

```json
{
  "version": 2,
  "configurePresets": [
    {
      "name": "...",
      "inherits": "project-name",
      "environment": {
        "VCPKG_ROOT": "C:/your/path/to/vcpkg"
      }
    }
  ]
}
```

>`CMakeLists.txt` Bruh

```text
cmake_minimum_required(VERSION 3.10)

project(your-project-name)

find_package(fmt CONFIG REQUIRED)
find_package(glm CONFIG REQUIRED)

add_executable(tncg15-raytracer main.cpp)

target_link_libraries(tncg15-raytracer PRIVATE fmt::fmt glm::glm)
```

## Setting up your project with CMake guide
The following sections contains some info about the different steps to ensure that your libraries/dependencies will be recognized by the compiler and linked properly. 

With this setup you can choose to code in Visual Studio Code (VS Code) or in Visual Studio (VS). If your choice is VS Code ensure you have the CMake Extension installed and 

## Step 1: Creating your manifest file (vcpkg.json)
The manifest file `vcpkg.json` will contain all the dependencies that you want to include in your project. 

This part will split in to two paths: [Command Line Interface (CLI)](#step-1-alternative-1---cli-editing) and  [Manual editing](#step-1-alternative-2---manual-editing). Choose the path that you feel most comfortable with.

### Step 1: Alternative 1 - CLI editing
>In the section [Manual editing](#step-1-alternative-2---manual-editing) file you can find another way of creating the manifest file if you're not comfortable with CLI.

Go to your directory and open the terminal (I recommend Windows Terminal or Command Prompt). 
#### Creating the vcpkg.json
Calling `vcpkg` with the `new` argument and changing the name of you manifest with what comes after the `--name=` arg. 

`vcpkg new --name=example --version=1.0`

This will create a ``vcpkg.json`` and ``vcpkg-configuration.json`` file in your current directory. 

#### Adding dependencies
Adding libraries such as `glm` or any library available through `vcpkg` is done with:

`vcpkg add port glm`

Executing the command add the dependency to the manifest file in the directory.


### Step 1: Alternative 2 - Manual editing
If you're not comfortable with creating and editing the manifest file with CLI (e.g. Command Prompt or PowerShell) you can copy n' paste the following `.json` file   
```json
{
  "name": "your-manifest-name",
  "description": "Here you can add some
  short description (e.g. to which project this manifest is used and so on)",
  "dependencies": [
    "fmt",
    "glm"
  ]
}
```
Change the `name` to something relatable (e.g. course code, idk) and add your different `dependencies` you wish to use in your project (e.g. `fmt` and `glm`).

(Optional): Write a short description for the manifest file at `description` or remove the variable.

## Step 2: Creating the CMakePresets.json
The `CMakePresets.json` can be seen as the "funnel" of the project that combines all the different developing environments into one. Assuming you have installed Visual Studio

This is the general structure of the `CMakePresets.json`:

```json
{
  "version": 2,
  "configurePresets": [
    {
      "name": "project-name",
      "generator": "Visual Studio 17 2022",
      "binaryDir": "${sourceDir}/build",
      "cacheVariables": {
        "CMAKE_TOOLCHAIN_FILE": "$env{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake"
      }
    }
  ]
}
```

## Step 3: Creating your own CMakeUserPresets.json
The CMakeUserPresets.json is custom to each device and should be added to the `.gitignore`. It will contain the full path to your `vcpkg` instance. 

While one could argue for it being included in the repo, adding additional presets for each user. It's like Aida would say:
>It's bad programming practice - Aida "The GOAT of Programming"

The general structure of the `CMakeUserPresets.json` looks like this:

```json
{
  "version": 2,
  "configurePresets": [
    {
      "name": "custom-preset-name",
      "inherits": "project-name",
      "environment": {
        "VCPKG_ROOT": "C:/your/path/to/vcpkg"
      }
    }
  ]
}
```

### Manual
Running the `create_CMakeUserPresets.bat` in your directory will start the process of creating the `CMakeUserPresets.json` for you. Follow its instructions and if you typed something wrong you can either edit the file or run the script again!

Make sure that the `inherit` variable you add to your `CMakeUserPresets.json` is the same as the `CMakePresets.json`. This can be changed manually or by running the script again!

### CLI
Calling the `create_CMakeUserPresets.bat` from the command line will initiate the script and following its instructions will create the `CMakeUserPresets.json` for you in the current directory.



## Step x: Creating the CMakeLists.txt
