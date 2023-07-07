Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD1AEB64D9
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Jul 2023 01:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjGGBZS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Jul 2023 21:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGGBZR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Jul 2023 21:25:17 -0400
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Jul 2023 18:25:14 PDT
Received: from mfwd28.mailplug.co.kr (mfwd28.mailplug.co.kr [14.63.195.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF248113
        for <linux-security-module@vger.kernel.org>; Thu,  6 Jul 2023 18:25:14 -0700 (PDT)
Received: (qmail 4288 invoked from network); 7 Jul 2023 10:18:32 +0900
Received: from m41.mailplug.com (121.156.118.41)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        7 Jul 2023 10:17:31 +0900
Received: (qmail 3760765 invoked from network); 7 Jul 2023 10:17:31 +0900
Received: from unknown (HELO sslauth30) (lsahn@wewakecorp.com@211.252.85.189)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        7 Jul 2023 10:17:31 +0900
Message-ID: <028adc9c-c3d4-9135-656d-497b5b0c56ce@wewakecorp.com>
Date:   Fri, 7 Jul 2023 10:17:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [LSM Stacking] SELinux policy inside container affects a
 processon Host
To:     "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
References: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com>
 <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com>
 <20230707003547.GA507352@mail.hallyn.com>
From:   Leesoo Ahn <lsahn@wewakecorp.com>
In-Reply-To: <20230707003547.GA507352@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



2023-07-07 오전 9:36에 Serge E. Hallyn 이(가) 쓴 글:
> On Thu, Jul 06, 2023 at 09:43:01AM -0400, Paul Moore wrote:
>  > On Thu, Jul 6, 2023 at 1:20 AM Leesoo Ahn <lsahn@wewakecorp.com> wrote:
>  > >
>  > > Hello! Here is another weird behavior of lsm stacking..
>  > >
>  > > test env
>  > > - Ubuntu 23.04 Ubuntu Kernel v6.2 w/ Stacking patch v38
>  > > - boot param: lsm=apparmor,selinux
>  > > - AppArmor (Host) + SELinux (LXD Container Fedora 36)
>  > >
>  > > In the test environment mentioned above and applying selinux policy
>  > > enforcing by running "setenforce 1" within the container, executing the
>  > > following command on the host will result in "Permission denied" 
> output.
>  >
>  > SELinux operates independently of containers, or kernel namespacing in
>  > general. When you load a SELinux policy it applies to all processes
>  > on the system, regardless of where they are in relation to the process
>  > which loaded the policy into the kernel.
>  >
>  > This behavior is independent of the LSM stacking work, you should be
>  > able to see the same behavior even in cases where SELinux is the only
> 
> The real question might be what kind of container was this? Since it
> was allowed to setenforce 1, it must not have been in a user namespace?
> Did you do "lxc config set c1 security.privileged true" ?

Yes, I did. For a reason that I wanted to use SELinux policy in 
Enforcing mode inside container and expected it applied to only 
container side.
