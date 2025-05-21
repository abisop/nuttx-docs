# NUTTX User Guide

> [!NOTE]
> Planned to be added in nuttx codebase

## How to use locally
* Prerequisite (for Ubuntu)  
~~~sh
sudo apt install yarnpkg -y
sudo apt remove nodejs -y
sudo snap install node --classic
~~~
> [!NOTE]
> Yarn is a tool used for maintaining dependencies
1. Install dependencies (including Vitepress):

   ```sh
   yarn install
   ```
1. Preview and serve the library:

   ```sh
   yarn start
   ```

   - Once the development/preview server has built the library (less than a minute for the first time) it will show you the URL you can preview the site on.
     This will be something like: `http://localhost:5173/px4_user_guide/`.
   - Stop serving using **CTRL+C** in the terminal prompt.

1. Open previewed pages in your local editor:

   First specify a local text editor file using the `EDITOR` environment variable, before calling `yarn start` to preview the library.
   For example, on Windows command line you can enable VSCode as your default editor by entering:

   ```sh
   set EDITOR=code
   ```

   The **Open in your editor** link at the bottom of each page will then open the current page in the editor (this replaces the _Open in GitHub_ link).

1. You can build the library as it would be done for deployment:

   ```sh
   # Ubuntu
   yarn docs:build

   # Windows
   yarn docs:buildwin
   ```

Use `yarn start` to preview changes _as you make them_ (documents are updated and served very quickly).
Before submitting a PR you should also build it using `yarn docs:build`, as this can highlight issues that are not visible when using `yarn start`.



