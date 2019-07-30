# PRoject 004: Easy Browser

## Issues

1. The method `WKWebView::didFinish` does not set title at first time. But title is updated after changing page in the second time.
```
func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    title = webView.title
}
```

Solved after implementing of progress bar. Root cause: due to DNS adblock on my server some requests are blocked (redirect to incorrect IP address), so, full loading of web page was delayed by timeout. That's why title was not updated immidiately. But in few seconds (approx ~1 minute) title was updated.

## Question

Challenge 002: "Try making two new toolbar items with the titles Back and Forward. You should make them use webView.goBack and webView.goForward."

Q: How to implement buttons with native "<" and ">" icons? I mean, is it possible to use buttons' icons embedded into SDK?