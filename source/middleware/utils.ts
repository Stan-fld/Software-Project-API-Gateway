import ipBlackListed from '../blacklist-ip.json'

export function isBlackList(ip: string): boolean {
    return ipBlackListed.includes(ip);
}
