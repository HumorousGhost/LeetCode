//
//  Twitter.swift
//  LeetCode
//
//  Created by UED on 2021/10/20.
//

import Foundation

// 355. 设计推特
class Twitter {

    private struct User {
        // 关注人的id
        var followee: [Int] = [Int]()
        // 存储 tweetId
        var tweet: [Int] = [Int]()
    }
    
    // getNewsFeed 检索的推文的上限
    private let recentMax = 10
    // tweetId 的时间戳
    private var time: Int
    // tweetId 对应发送的时间
    private var tweetTime: [Int: Int]
    // 每个用户存储的信息
    private var user: [Int: User]
    
    init() {
        time = 0;
        user = [Int: User]()
        tweetTime = [Int: Int]()
    }
    
    func postTweet(_ userId: Int, _ tweetId: Int) {
        if !user.keys.contains(userId) {
            user[userId] = User()
        }
        // 到达限制，剔除链表末尾元素
        if user[userId]!.tweet.count == recentMax {
            user[userId]!.tweet.removeLast()
        }
        user[userId]!.tweet.insert(tweetId, at: 0)
        time += 1
        tweetTime[tweetId] = time
        
    }
    
    func getNewsFeed(_ userId: Int) -> [Int] {
        var ans = [Int]()
        guard let currUser = user[userId] else {
            return ans
        }
        ans.append(contentsOf: currUser.tweet)
        
        for followeeId in currUser.followee {
            if followeeId == userId { // 可能出现自己关注自己的情况
                continue;
            }
            var res = [Int]()
            let tweetSize = user[followeeId]!.tweet.count
            var it = user[followeeId]!.tweet
            var i = 0, j = 0, curr = -1
            // 线性归并
            if j < tweetSize {
                curr = it.removeFirst()
                while i < ans.count && j < tweetSize && curr >= 0 {
                    if tweetTime[curr]! > tweetTime[ans[i]]! {
                        res.append(curr);
                        j += 1
                        if it.count > 0 {
                            curr = it.removeFirst()
                        }
                    } else {
                        res.append(ans[i])
                        i += 1
                    }
                    // 已经找到这两个链表合起来后最近的 recentMax 条推文
                    if res.count == recentMax {
                        break
                    }
                }
            }
            
            while i < ans.count && res.count < recentMax {
                res.append(ans[i])
                i += 1
            }
            if j < tweetSize && res.count < recentMax {
                res.append(curr)
                while it.count > 0 && res.count < recentMax {
                    res.append(it.removeFirst())
                }
            }
            ans = res
        }
        
        return ans
    }
    
    func follow(_ followerId: Int, _ followeeId: Int) {
        if !user.keys.contains(followerId) {
            user[followerId] = User()
        }
        if !user.keys.contains(followeeId) {
            user[followeeId] = User()
        }
        if !user[followerId]!.followee.contains(followeeId) {
            user[followerId]!.followee.append(followeeId)
        }
    }
    
    func unfollow(_ followerId: Int, _ followeeId: Int) {
        if let index = user[followerId, default: User()].followee.firstIndex(of: followeeId) {
            user[followerId]!.followee.remove(at: index)
        }
    }
}

/**
 * Your Twitter object will be instantiated and called as such:
 * let obj = Twitter()
 * obj.postTweet(userId, tweetId)
 * let ret_2: [Int] = obj.getNewsFeed(userId)
 * obj.follow(followerId, followeeId)
 * obj.unfollow(followerId, followeeId)
 */
