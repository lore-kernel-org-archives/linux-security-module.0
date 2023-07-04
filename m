Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D87BEB64DC
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Jul 2023 01:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjGDBXD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 3 Jul 2023 21:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjGDBXD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Jul 2023 21:23:03 -0400
Received: from mfwd11.mailplug.co.kr (mfwd11.mailplug.co.kr [14.49.36.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91A9186
        for <linux-security-module@vger.kernel.org>; Mon,  3 Jul 2023 18:22:59 -0700 (PDT)
Received: (qmail 701 invoked from network); 4 Jul 2023 10:22:56 +0900
Received: from m41.mailplug.com (121.156.118.41)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        4 Jul 2023 10:21:55 +0900
Received: (qmail 4165376 invoked from network); 4 Jul 2023 10:21:55 +0900
Received: from unknown (HELO sslauth31) (lsahn@wewakecorp.com@211.252.85.165)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        4 Jul 2023 10:21:55 +0900
Message-ID: <f48d0e35-7409-184b-8518-64a2d82dd6e9@wewakecorp.com>
Date:   Tue, 4 Jul 2023 10:21:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [LSM Stacking] new files fail to inherit SELinux security
 contextof the current directory
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     john.johansen@canonical.com, linux-security-module@vger.kernel.org
References: <c0ee001b-caf4-22ec-d1c5-d3d8d790760c@wewakecorp.com>
 <8ca4ccc3-0e54-ad50-7b9f-fd04708548f0@schaufler-ca.com>
From:   Leesoo Ahn <lsahn@wewakecorp.com>
In-Reply-To: <8ca4ccc3-0e54-ad50-7b9f-fd04708548f0@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


2023-07-03 오후 11:53에 Casey Schaufler 이(가) 쓴 글:
> On 7/2/2023 7:06 PM, Leesoo Ahn wrote:
>  > Test env
>  > - Ubuntu 23.04 Ubuntu Kernel v6.2 w/ Stacking patch v38
>  > - boot param: lsm=apparmor,selinux
>  > - AppArmor (Host) + SELinux (Container Fedora 36)
>  >
>  > Hello! I'm currently working on a project related to LSM Stacking, and
>  > a few days ago, I encountered a significant issue of SELinux in the
>  > container environment.
>  >
>  > When creating new files in the container using 'mkdir' and 'touch',
>  > the new files fail to inherit the security context of the current
>  > directory. This problem occurs by the following reason that
>  > 'security_inode_init_security' hook is called, which sequentially
>  > calls 'apparmor_inode_init_security' and 'selinux_inode_init_security'
>  > in order. 'apparmor_inode_init_security' always returns -EOPNOTSUPP,
>  > hence 'selinux_inode_init_security' is never called.
>  >
>  > Does 'return 0' in 'apparmor_inode_init_security' to call stacking
>  > hooks sequentially have no side-effects? if so, the solution would be
>  > easy though.
> 
> The correct fix is to security_inode_init_security(), not
> apparmor_inode_init_security(). The upstream Linus kernel
> does not have a hook in apparmor, so this problem wasn't
> detected there. I'll be sure to get this into v39.

Thank you for the answer and stacking works.

If you need some helps like tests, feel free to mail me.

best regards,
Leesoo
