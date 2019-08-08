#  Project P006B_AutoLayoutInCode

Create view and constraints by hand

## Questions and notes

- Note: wow, double space between label1 and label2 crashes the app:
    `withVisualFormat: "V:|[label1]--[label2]-[label3]-[label4]-[label5]"`
- Question ahead of schedule: what about SafeArea in VFL? Continue reading next chapter.

    Answer: use anchors, Luke!
    
- Question: may we use multiline strings in `withVisualFormat`?

    Answer is yes, we are, as usual with triple quotes.
    
- Question ahead of schedule: it is clear how to set metrics for "equal to", but what about ">="?

    Answer: easy enough, add additional metric to metrics and use it with ">=". Like `-(>=bottomEdge)-|`
