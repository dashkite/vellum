import puppeteer from "puppeteer"
import express from "express"

const app = express()
app.use(express.static("."))

const server = app.listen(0, async () => {
  const { port } = server.address()
  console.log(`Server listening on port ${port}`)

  const browser = await puppeteer.launch({ headless: true })
  const page = await browser.newPage()

  page.on("console", msg => console.log(`BROWSER CONSOLE: [${msg.type()}] ${msg.text()}`))
  page.on("pageerror", err => console.error(`BROWSER ERROR:`, err))
  page.on("request", req => console.log(`REQ: ${req.url()}`))
  page.on("requestfailed", req => console.log(`REQ FAILED: ${req.url()} - ${req.failure().errorText}`))
  page.on("response", res => console.log(`RES: ${res.status()} ${res.url()}`))

  try {
    await page.goto(`http://localhost:${port}/build/browser/test/client/index.html`, { waitUntil: "networkidle0" })
  } catch (err) {
    console.error("Navigation error:", err)
  }

  await browser.close()
  server.close()
})
