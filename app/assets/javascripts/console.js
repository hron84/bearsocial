/**
 Console helper library

 This library creates window.console if browser not supports it natively. It is required to avoid JS
 errors on older browsers, such as Firefox if no Firebug installed

 Copyright (c) Gabor Garami 2013. Some rights reserved.

 This file is licensed under the terms of CreativeCommons BY-SA 3.0 license.
 */
if (!window.console) window.console = {};
console.log = console.log || function () {
};
console.warn = console.warn || function () {
};
console.error = console.error || function () {
};
console.info = console.info || function () {
};
