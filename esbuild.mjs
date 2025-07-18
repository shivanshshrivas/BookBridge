import esbuild from 'esbuild'
import { sassPlugin } from 'esbuild-sass-plugin'
// import babel from 'esbuild-plugin-babel'
import fs from 'fs'

const isProduction = ["production", "staging"].includes(
  process.env.RAILS_ENV
);

let context = await esbuild.context({
  entryPoints: fs.readdirSync("app/frontend/entrypoints").map((file) => `app/frontend/entrypoints/${file}`),
  assetNames: "[name]-[hash].digested",
  bundle: true,
  sourcemap: true,
  outdir: 'app/assets/builds',
  publicPath: '/assets',
  plugins: [
    sassPlugin(),
    // babel()
  ],
  loader: {
    ".locale.json": "file",
    ".json": "json",
    ".png": "file",
    ".jpeg": "file",
    ".jpg": "file",
    ".svg": "file",
    ".woff": "file",
    ".woff2": "file"
  },
  mainFields: ["browser", "module", "main"],
  logLevel: 'info',
  minify: isProduction,
  define: {
    global: "window",
    RAILS_ENV: JSON.stringify(process.env.RAILS_ENV || "development"),
  }
})

if (process.argv[2] === '--watch') {
  await context.watch()
} else {
  await context.rebuild()
  process.exit(0)
}