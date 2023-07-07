Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3650DEB64D9
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Jul 2023 08:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjGGIgp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Jul 2023 04:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbjGGIgi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Jul 2023 04:36:38 -0400
X-Greylist: delayed 438 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 Jul 2023 01:36:36 PDT
Received: from mfwd10.mailplug.co.kr (mfwd10.mailplug.co.kr [14.63.168.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980B390
        for <linux-security-module@vger.kernel.org>; Fri,  7 Jul 2023 01:36:36 -0700 (PDT)
Received: (qmail 13419 invoked from network); 7 Jul 2023 17:29:12 +0900
Received: from m41.mailplug.com (121.156.118.41)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        7 Jul 2023 17:28:39 +0900
Received: (qmail 1938872 invoked from network); 7 Jul 2023 17:28:39 +0900
Received: from unknown (HELO sslauth12) (lsahn@wewakecorp.com@211.253.39.85)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        7 Jul 2023 17:28:39 +0900
Message-ID: <4ec9e7ae-e95e-a737-5131-0b57922e4fce@wewakecorp.com>
Date:   Fri, 7 Jul 2023 17:28:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [LSM Stacking] SELinux policy inside container affects a process
 on Host
To:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org
References: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com>
 <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com>
From:   Leesoo Ahn <lsahn@wewakecorp.com>
In-Reply-To: <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

2023-07-06 오후 10:43에 Paul Moore 이(가) 쓴 글:
> On Thu, Jul 6, 2023 at 1:20 AM Leesoo Ahn <lsahn@wewakecorp.com> wrote:
>  >
>  > Hello! Here is another weird behavior of lsm stacking..
>  >
>  > test env
>  > - Ubuntu 23.04 Ubuntu Kernel v6.2 w/ Stacking patch v38
>  > - boot param: lsm=apparmor,selinux
>  > - AppArmor (Host) + SELinux (LXD Container Fedora 36)
>  >
>  > In the test environment mentioned above and applying selinux policy
>  > enforcing by running "setenforce 1" within the container, executing the
>  > following command on the host will result in "Permission denied" output.
> 
> SELinux operates independently of containers, or kernel namespacing in
> general. When you load a SELinux policy it applies to all processes
> on the system, regardless of where they are in relation to the process
> which loaded the policy into the kernel.
> 
> This behavior is independent of the LSM stacking work, you should be
> able to see the same behavior even in cases where SELinux is the only
> loaded LSM on the system.

Thank you for the reply!

So as far as I understand, the environment of LSM Stacking,
AppArmor (Host) + SELinux (Container) couldn't provide features "using 
SELinux policy inside the container shouldn't affect to the host side" 
for now.

If so, I wonder if you and Casey plan to design future features like 
that, because my co-workers and I are considering taking LSM stacking of 
AppArmor + SELinux in products that both policies must be working 
separately.

best regards,
Leesoo
