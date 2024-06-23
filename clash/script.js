function main(config) {
    check();
    config = rename(config);
    config = filter(config);
    return config;
}

function check() {
    for (let str of namesToFilter) {
        if (str.includes("change-me-or-error")) {
            let msg = `Substring "change-me-or-error" found in string: "${str}"`;
            console.error(msg);
            throw new Error(msg);
        }
    }
}

// mute domain
const namesToFilter = [
    "1 备用登录 change-me-or-error",
    "1 备用面板 change-me-or-error",
    "1 忘记登录需联系客服",
    "1 此计划禁止工作室使用 禁止任何商业使用",
    "1 请使用全局代理访问官网，非全局会拦截报1020",
    "change-me-or-error",
    "（看这里）每月刷新订阅获取新节点",
    //"change-me-or-error"
];

function rename(config) {
    console.info("Original Name")
    config['proxy-groups']?.forEach(e => console.debug(e.name));

    config['proxy-groups'] = config['proxy-groups']?.map(e => {
        e.name = e.name.replace("一元机场", "Proxy").replace("🔰国外流量", "Proxy");

        // ssrcloud 存在分流 如：Telegram->🔰国外流量
        e.proxies = e.proxies.map(proxy => proxy.replace("🔰国外流量", "Proxy"));

        return e;
    });
    config['rules'] = config['rules']?.map(

        // 一元机场存在 smartproxy一元机场.com,一元机场 这种诡异的 rule
        e => e.replace(",一元机场", ",Proxy").replace(",🔰国外流量", ",Proxy")
    );
    return config;
}

function filter(config) {
    config.proxies = config.proxies.filter(
        proxy => !namesToFilter.includes(proxy.name)
    );

    config['proxy-groups'] = config['proxy-groups'].map(
        group => {

            // proxy-groups[].proxies[] 里还有残余
            group.proxies = group.proxies.filter(it => !namesToFilter.includes(it))
            return group;
        }
    );

    return config;
}