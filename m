Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6713CC001DF
	for <linux-security-module@archiver.kernel.org>; Mon, 17 Jul 2023 15:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjGQPc1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 17 Jul 2023 11:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjGQPcZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 17 Jul 2023 11:32:25 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Jul 2023 08:32:03 PDT
Received: from mfwd01.mailplug.co.kr (mfwd01.mailplug.co.kr [14.63.160.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1541981
        for <linux-security-module@vger.kernel.org>; Mon, 17 Jul 2023 08:32:03 -0700 (PDT)
Received: (qmail 16551 invoked from network); 18 Jul 2023 00:25:05 +0900
Received: from m41.mailplug.com (121.156.118.41)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        18 Jul 2023 00:24:05 +0900
Received: (qmail 626394 invoked from network); 18 Jul 2023 00:24:05 +0900
Received: from unknown (HELO sslauth15) (lsahn@wewakecorp.com@211.253.39.89)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        18 Jul 2023 00:24:05 +0900
Message-ID: <6bd218f2-af8a-52c7-cc27-6fd6c27d4446@wewakecorp.com>
Date:   Tue, 18 Jul 2023 00:24:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [LSM Stacking] SELinux policy inside container affects a
 processon Host
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
References: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com>
 <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com>
 <4ec9e7ae-e95e-a737-5131-0b57922e4fce@wewakecorp.com>
 <CAHC9VhQBbbSu6YBbnXOPMjpBxQxc1nmgA+icfN4x6s6FeQSeiw@mail.gmail.com>
From:   Leesoo Ahn <lsahn@wewakecorp.com>
In-Reply-To: <CAHC9VhQBbbSu6YBbnXOPMjpBxQxc1nmgA+icfN4x6s6FeQSeiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

23. 7. 7. 23:20에 Paul Moore 이(가) 쓴 글:
> On Fri, Jul 7, 2023 at 4:29 AM Leesoo Ahn <lsahn@wewakecorp.com> wrote:
>  > 2023-07-06 오후 10:43에 Paul Moore 이(가) 쓴 글:
[...]
> 
> What you are looking for is a combination of LSM stacking and
> individual LSM namespacing. Sadly, I think the communications around
> LSM stacking have not been very clear on this and I worry that many
> people are going to be disappointed with LSM stacking for this very
> reason.
> 
> While stacking of LSMs is largely done at the LSM layer, namespacing
> LSMs such that they can be customized for individual containers
> requires work to be done at the per-LSM level as each LSM is
> different. AppArmor already has a namespacing concept, but SELinux
> does not. Due to differences in the approach taken by the two LSMs,
> namespacing is much more of a challenge for SELinux, largely due to
> issues around filesystem labeling. We have not given up on the idea,
> but we have yet to arrive at a viable solution for namespacing
> SELinux.
> 
> If you are interested in stacking SELinux and AppArmor, I believe the
> only practical solution is to run SELinux on the host system (initial
> namespace) and run AppArmor in the containers. Even in a world where
> SELinux is fully namespaced, it would likely still be necessary to run
> some type of SELinux policy on the host (initial namespace) in order
> to support SELinux policies in the containers.

Thank you for the reply. It really helped me to know the current status 
of them and what to do now.

Just a little information for who is interested in the stacking that we 
decided to branch the LSM hooks by which lsm the current process is in 
instead of entirely calling them in order.

Best regards,
Leesoo
