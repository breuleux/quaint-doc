
importScripts('jspm_packages/system.js', 'config.js');

console.log("worker loaded");

var u = null;

System.import("edit2").then(function (m) {
    console.log("quaint loaded");
    u = m.UpdaterWorker();
    u.work();
});

onmessage = function (m) {
    if (u) {
        u.onmessage(m.data);
    }
}
