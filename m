Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A704C001B0
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Jul 2023 02:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjGXCg2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 23 Jul 2023 22:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjGXCg1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 23 Jul 2023 22:36:27 -0400
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 23 Jul 2023 19:36:24 PDT
Received: from mfwd27.mailplug.co.kr (mfwd27.mailplug.co.kr [14.63.193.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D74983
        for <linux-security-module@vger.kernel.org>; Sun, 23 Jul 2023 19:36:24 -0700 (PDT)
Received: (qmail 16688 invoked from network); 24 Jul 2023 11:29:41 +0900
Received: from m41.mailplug.com (121.156.118.41)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        24 Jul 2023 11:29:28 +0900
Received: (qmail 90660 invoked from network); 24 Jul 2023 11:29:27 +0900
Received: from unknown (HELO sslauth36) (lsahn@wewakecorp.com@211.252.87.51)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        24 Jul 2023 11:29:27 +0900
Message-ID: <a05afacc-4c93-89ec-b7ab-0d26cc874eff@wewakecorp.com>
Date:   Mon, 24 Jul 2023 11:29:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [LSM Stacking] SELinux policy inside container affects aprocesson
 Host
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org
References: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com>
 <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com>
 <4ec9e7ae-e95e-a737-5131-0b57922e4fce@wewakecorp.com>
 <CAHC9VhQBbbSu6YBbnXOPMjpBxQxc1nmgA+icfN4x6s6FeQSeiw@mail.gmail.com>
 <6bd218f2-af8a-52c7-cc27-6fd6c27d4446@wewakecorp.com>
 <f21a05f9-249d-e362-6ae4-32499d190a21@schaufler-ca.com>
From:   Leesoo Ahn <lsahn@wewakecorp.com>
In-Reply-To: <f21a05f9-249d-e362-6ae4-32499d190a21@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

2023-07-18 오전 12:51에 Casey Schaufler 이(가) 쓴 글:
> On 7/17/2023 8:24 AM, Leesoo Ahn wrote:
>  > 23. 7. 7. 23:20에 Paul Moore 이(가) 쓴 글:
>  >> On Fri, Jul 7, 2023 at 4:29 AM Leesoo Ahn <lsahn@wewakecorp.com> wrote:
>  >>  > 2023-07-06 오후 10:43에 Paul Moore 이(가) 쓴 글:
[...]>  >> If you are interested in stacking SELinux and AppArmor, I 
believe the
>  >> only practical solution is to run SELinux on the host system (initial
>  >> namespace) and run AppArmor in the containers. Even in a world where
>  >> SELinux is fully namespaced, it would likely still be necessary to run
>  >> some type of SELinux policy on the host (initial namespace) in order
>  >> to support SELinux policies in the containers.
>  >
>  > Thank you for the reply. It really helped me to know the current
>  > status of them and what to do now.
>  >
>  > Just a little information for who is interested in the stacking that
>  > we decided to branch the LSM hooks by which lsm the current process is
>  > in instead of entirely calling them in order.
> 
> Could you describe your approach more fully?

As far as I know, the current stacking feature is implemented calling 
the entire hooks in order of 'lsm=' boot parameter. But our desire must 
be calling a proper hook at a time by a task's current LSM, for instance 
Apparmor 'or' SELinux instead of 'and'.

And so we have been considering adding two new hooks which work as the 
same as the origin hooks but additionally branch to a proper hook 
function with the information of current LSM by calling lsm_task_ilsm().

The following changes are a part of our approach,

------ code part ------
#define call_int_hook_by_ilsm(FUNC, ILSM, IRC, ...) ({                 \
        int RC = IRC;                                           \
        do {                                                    \
                struct security_hook_list *P;                   \
                int id; \
                                                                \
                id = (ILSM == LSMBLOB_INVALID) \
                        ? lsm_slotlist[0]->id \
                        : lsm_slotlist[ILSM]->id; \
                hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
                        if (P->lsmid->slot != LSMBLOB_NOT_NEEDED && id 
!= P->lsmid->id) \
                                continue; \
                        RC = P->hook.FUNC(__VA_ARGS__);         \
                        if (RC != 0)                            \
                                break;                          \
                }                                               \
        } while (0);                                            \
        RC;                                                     \
})

[...]

int ilsm = lsm_task_ilsm(current);
ret = call_int_hook_by_ilsm(mmap_addr, ilsm, 0, addr);
------------

We are still worrying about the part of calling lsm_task_ilsm() with 
'current', it seems dangerous in some unknown cases.

What do you think about this approach, Casey?

Best regards,
Leesoo
