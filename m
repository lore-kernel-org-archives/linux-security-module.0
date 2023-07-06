Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D11EB64D9
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Jul 2023 05:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjGFFUa (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Jul 2023 01:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjGFFU3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Jul 2023 01:20:29 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Jul 2023 22:20:25 PDT
Received: from mfwd25.mailplug.co.kr (mfwd25.mailplug.co.kr [14.63.174.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85C618B
        for <linux-security-module@vger.kernel.org>; Wed,  5 Jul 2023 22:20:25 -0700 (PDT)
Received: (qmail 2403 invoked from network); 6 Jul 2023 14:13:41 +0900
Received: from m41.mailplug.com (121.156.118.41)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        6 Jul 2023 14:12:41 +0900
Received: (qmail 3650354 invoked from network); 6 Jul 2023 14:12:41 +0900
Received: from unknown (HELO sslauth30) (lsahn@wewakecorp.com@211.252.85.189)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        6 Jul 2023 14:12:41 +0900
Message-ID: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com>
Date:   Thu, 6 Jul 2023 14:12:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
From:   Leesoo Ahn <lsahn@wewakecorp.com>
Subject: [LSM Stacking] SELinux policy inside container affects a process on
 Host
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello! Here is another weird behavior of lsm stacking..

test env
- Ubuntu 23.04 Ubuntu Kernel v6.2 w/ Stacking patch v38
- boot param: lsm=apparmor,selinux
- AppArmor (Host) + SELinux (LXD Container Fedora 36)

In the test environment mentioned above and applying selinux policy 
enforcing by running "setenforce 1" within the container, executing the 
following command on the host will result in "Permission denied" output.

root@stack-v6:/home/lsahn# insmod 
/lib/modules/6.2.0-20-generic/kernel/net/netfilter/nft_ct.ko
insmod: ERROR: could not insert module 
/lib/modules/6.2.0-20-generic/kernel/net/netfilter/nft_ct.ko: Permission 
denied

In dmesg, the following kernel log is displayed,

[  +0.000003] audit: type=1400 audit(1688619411.654:1072): avc:  denied 
{ module_load } for  pid=67703 comm="insmod" 
path="/usr/lib/modules/6.2.0-20-generic/kernel/net/netfilter/nft_ct.ko" 
dev="sda2" ino=1444804 scontext=system_u:system_r:kernel_t:s0 
tcontext=system_u:object_r:unlabeled_t:s0 tclass=system permissive=0

I have the following questions by the results:
- Why the policy applied within the container affects the host? and 
whether it is a bug or not.
- If this is a bug, I'm curious about where to start the analysis. It 
would be helpful if you could provide relevant resources or links.

best regards,
Leesoo
