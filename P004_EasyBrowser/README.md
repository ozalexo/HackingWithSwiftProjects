# PRoject 004: Easy Browser

## Issues

1. The method `WKWebView::didFinish` does not set title at first time. But title is updated after changing page in the second time.
```
func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    title = webView.title
}
```

