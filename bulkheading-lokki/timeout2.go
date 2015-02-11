package main

import "time"
import "fmt"

func main() {
    c2 := make(chan string, 1)
    go func() { time.Sleep(time.Second * 2)
        c2 <- "result 2"
    }()
    select {
    case res := <-c2:
        fmt.Println(res)
    case <-time.After(time.Second * 3):
        fmt.Println("timeout 2")
    }
}

