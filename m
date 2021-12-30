Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03146C433F5
	for <linux-security-module@archiver.kernel.org>; Thu, 30 Dec 2021 06:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbhL3Gxl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 30 Dec 2021 01:53:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4329 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhL3Gxk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 30 Dec 2021 01:53:40 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JPf7g4nhQz67KxR;
        Thu, 30 Dec 2021 14:51:27 +0800 (CST)
Received: from [10.122.132.241] (10.122.132.241) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Thu, 30 Dec 2021 07:53:37 +0100
Message-ID: <ea95a881-c3c7-eba1-520d-992b680a6b49@huawei.com>
Date:   Thu, 30 Dec 2021 09:53:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH 0/2] Landlock network PoC implementation
Content-Language: ru
To:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
CC:     <mic@digikod.net>, <linux-security-module@vger.kernel.org>,
        <yusongping@huawei.com>, <artem.kuzin@huawei.com>
References: <20211210072123.386713-1-konstantin.meskhidze@huawei.com>
 <802be0d0-cb8c-7fda-dd4e-2eb83d228ead@schaufler-ca.com>
 <CAHC9VhTcbE0MYeNGwBYmWrk3NY4FQkDk33gzJjQv=wt6n6dJdw@mail.gmail.com>
From:   Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
In-Reply-To: <CAHC9VhTcbE0MYeNGwBYmWrk3NY4FQkDk33gzJjQv=wt6n6dJdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.132.241]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml704-chm.china.huawei.com (10.206.15.53)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi, Paul
Thanks for your comment.

12/11/2021 2:01 AM, Paul Moore wrote:
> On Fri, Dec 10, 2021 at 11:57 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> As I think you've realized, *sockets are not objects*. There
>> isn't a way to justify them as objects without introducing
>> ethereal or magical subjects that don't exist. Sockets are
>> part of a process. OK, it's not that simple, and it would be
>> foolish to deny that a socket may have security relevant
>> properties. But they aren't objects.
>>
>> I strongly recommend that you follow Smack's example and
>> use the sending task and receiving task attributes to make
>> the decision. You may find that storing that information
>> in the socket security blob is convenient.
>>
>> BTW - not everyone agrees with me on this topic. I'll leave
>> the misguided to make their own arguments. ;)
> 
> I'm running low on my lets-argue-on-the-internet motivation today, but
> I feel like I'm being goaded into some sort of comment so I will
> simply offer SELinux as a rebuttal to Casey's comments.  I think that
> either approach can be acceptable, it depends on how your security
> model works and your comfort level with the various tradeoffs
> associated with each approach.  I personally prefer the approach
> SELinux has taken (minus some of the compat cruft we are saddled with,
> not to mention that restrictions handed to use from netdev), but I'll
> admit a certain level of bias in this.
> 
I just tried to follow Landlock's implementation concept: attaching 
policy rules to kernel objects.
For filesystem "objects" are underlying inodes.
For socket the same approach could be used - using sockets' inodes as 
"object".
I also read about this concept from some LSM papers:
https://www.usenix.org/legacy/events/sec02/full_papers/wright/wright.pdf
https://elinux.org/images/0/0a/ELC_Inside_LSM.pdf

> --
> paul moore
> www.paul-moore.com
> .
