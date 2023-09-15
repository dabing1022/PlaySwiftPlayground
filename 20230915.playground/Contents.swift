import UIKit
import WebKit

let webview = WKWebView()
var js1 = """
class Cat {
  constructor() {
    this.age = 10;
    this.name = "miaomiao";
  }
}
class Dog {
  constructor() {
    this.age = 10;
    this.name = "bala";

    this.test_func = () => {
        console.log("hello world dog");
    }
  }
}
function onViewWillAppear() {
    var foo = 1;
    return new Dog();
}

function onViewWillAppear_SetTimeout() {
    setTimeout(() => {
       var foo = 1;
       return new Dog();
    }, 1000);
}

function onViewWillAppear2() {
    var foo = 1;
    return new Cat();
}

function onViewWillAppearWrapper() {
    onViewWillAppear();
}
"""
webview.evaluateJavaScript(js1) { result, error in
    print("js1 result: \(result), error: \(error)")
}

// ------------------------------
// 该函数执行 return new Dog，Dog 是一个复杂对象类型，内部包含了一个 test_func, 导致对象无法json 化，执行报错 "JavaScript execution returned a result of an unsupported type"
var js2 = """
onViewWillAppear();
"""

webview.evaluateJavaScript(js2) { result, error in
    let nserror = error as! NSError
    
    let errorDesc1 = nserror.userInfo
    let errorDesc2 = nserror.localizedDescription
    print("js2 result: \(result.debugDescription), error: \(errorDesc1) \(errorDesc2)")
}

// do try catch
func evaluatejs(wv: WKWebView, js: String) async {
    do {
        print("evaluate js with try catch")
        try await wv.evaluateJavaScript(js)
    } catch {
        print("catch! catch! catch!")
        print(error)
    }
}
await evaluatejs(wv: webview, js: js2)

// ------------------------------
// 该函数执行 return new Cat, Cat没有函数属性，可以被 json 化，执行不报错
var js3 = """
onViewWillAppear2();
"""
    
webview.evaluateJavaScript(js3) { result, error in
    print("js3 result: \(result.debugDescription), error: \(error)")
}

// ------------------------------
// 我们针对报错的函数onViewWillAppear（内部返回了复杂对象 Dog），做了一层 wrapper，忽略了返回值，此时执行 wrapper 不再报错
var js4 = """
onViewWillAppearWrapper();
"""

webview.evaluateJavaScript(js4) { result, error in
    print("js4 result: \(result.debugDescription), error: \(error)")
}

var js5 = """
onViewWillAppear_SetTimeout();
"""

webview.evaluateJavaScript(js5) { result, error in
    print("js5 result: \(result.debugDescription), error: \(error)")
}
