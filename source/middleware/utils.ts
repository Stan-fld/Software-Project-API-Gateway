import _ from "lodash";
import ipBlackListed from '../blacklist-ip.json'

/**
 * Create once the defaults object with undefined values and add the data to it.
 * This allows the validator to work during FindOneAndUpdate.
 * Because without the defaults values the validator does not work in a FindOneAndUpdate.
 * @param {string[]} dataToPick
 * @param {any} data
 */
export function bodyPick(dataToPick: string[], data: any) {
    /** create once the defaults object with undefined values from the headerKeys **/
    const defaultObj = _(dataToPick)
        .mapKeys()
        .mapValues(() => {
            return undefined;
        })
        .value();

    return _(data)
        .pick(dataToPick)
        .defaults(defaultObj)
        .value();
}

export function isBlackList(ip: string): boolean {
    return ipBlackListed.includes(ip);
}
