Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9347DEB64DD
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Jul 2023 03:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjGYDRv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Jul 2023 23:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjGYDRv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Jul 2023 23:17:51 -0400
Received: from mfwd01.mailplug.co.kr (mfwd01.mailplug.co.kr [14.63.160.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE6C10FD
        for <linux-security-module@vger.kernel.org>; Mon, 24 Jul 2023 20:17:44 -0700 (PDT)
Received: (qmail 11544 invoked from network); 25 Jul 2023 12:17:41 +0900
Received: from m41.mailplug.com (121.156.118.41)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        25 Jul 2023 12:16:41 +0900
Received: (qmail 508072 invoked from network); 25 Jul 2023 12:16:41 +0900
Received: from unknown (HELO sslauth11) (lsahn@wewakecorp.com@211.253.39.84)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        25 Jul 2023 12:16:41 +0900
Message-ID: <57747ff8-7433-9a76-0e76-c0c292acfd26@wewakecorp.com>
Date:   Tue, 25 Jul 2023 12:16:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [LSM Stacking] SELinux policy inside container affects
 aprocessonHost
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org
References: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com>
 <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com>
 <4ec9e7ae-e95e-a737-5131-0b57922e4fce@wewakecorp.com>
 <CAHC9VhQBbbSu6YBbnXOPMjpBxQxc1nmgA+icfN4x6s6FeQSeiw@mail.gmail.com>
 <6bd218f2-af8a-52c7-cc27-6fd6c27d4446@wewakecorp.com>
 <f21a05f9-249d-e362-6ae4-32499d190a21@schaufler-ca.com>
 <a05afacc-4c93-89ec-b7ab-0d26cc874eff@wewakecorp.com>
 <7ef141bc-8a02-4ef0-c970-8de3e0146139@schaufler-ca.com>
From:   Leesoo Ahn <lsahn@wewakecorp.com>
In-Reply-To: <7ef141bc-8a02-4ef0-c970-8de3e0146139@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

2023-07-25 오전 6:35에 Casey Schaufler 이(가) 쓴 글:
> On 7/23/2023 7:29 PM, Leesoo Ahn wrote:
>  > 2023-07-18 오전 12:51에 Casey Schaufler 이(가) 쓴 글:
>  >> On 7/17/2023 8:24 AM, Leesoo Ahn wrote:
>  >>  > 23. 7. 7. 23:20에 Paul Moore 이(가) 쓴 글:
>  >>  >> On Fri, Jul 7, 2023 at 4:29 AM Leesoo Ahn <lsahn@wewakecorp.com>
>  >> wrote:
>  >>  >>  > 2023-07-06 오후 10:43에 Paul Moore 이(가) 쓴 글:
>  > [...]>  >> If you are interested in stacking SELinux and AppArmor, I
>  > believe the
>  >>  >> only practical solution is to run SELinux on the host system
>  >> (initial
>  >>  >> namespace) and run AppArmor in the containers. Even in a world where
>  >>  >> SELinux is fully namespaced, it would likely still be necessary
>  >> to run
>  >>  >> some type of SELinux policy on the host (initial namespace) in order
>  >>  >> to support SELinux policies in the containers.
>  >>  >
>  >>  > Thank you for the reply. It really helped me to know the current
>  >>  > status of them and what to do now.
>  >>  >
>  >>  > Just a little information for who is interested in the stacking that
>  >>  > we decided to branch the LSM hooks by which lsm the current
>  >> process is
>  >>  > in instead of entirely calling them in order.
>  >>
>  >> Could you describe your approach more fully?
>  >
>  > As far as I know, the current stacking feature is implemented calling
>  > the entire hooks in order of 'lsm=' boot parameter. But our desire
>  > must be calling a proper hook at a time by a task's current LSM, for
>  > instance Apparmor 'or' SELinux instead of 'and'.
> 
> SELinux and Smack rely on the fact that they manage security attributes
> on all subjects and all objects. On a system where some objects are not
> labeled because they are being managed by AppArmor instead, you are
> going to have a security state that is muddled. How would you have a
> host system that uses SELinux handle files in a container that is using
> only AppArmor?

I think we could deal with that using origin call_ macro only if the 
following cases that alloc a task, socket, make a file and so forth 
which do newing objects and subjects that must have both security 
context for preventing a security state that would be muddled. On the 
other hands, in a case of operations that like read, load, mmap are to 
call the customized call_ macro with ilsm to conditionally branch.

[...]

> I would rather see a local copy of the hook lists for processes that
> use a different set than the base system.

Could you explain the latter one, please?

best regards,
Leesoo
