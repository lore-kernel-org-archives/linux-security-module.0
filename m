Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47A7C77B7F
	for <linux-security-module@archiver.kernel.org>; Sat, 20 May 2023 05:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjETFyZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 20 May 2023 01:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjETFyZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 20 May 2023 01:54:25 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753C2128
        for <linux-security-module@vger.kernel.org>; Fri, 19 May 2023 22:54:23 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 34K5sA3k056277;
        Sat, 20 May 2023 14:54:10 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Sat, 20 May 2023 14:54:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 34K5s9Vm056274
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 20 May 2023 14:54:10 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f5ada796-41ba-5cc8-b43d-efd639994f15@I-love.SAKURA.ne.jp>
Date:   Sat, 20 May 2023 14:54:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Stable backport of de3004c874e7 ("ocfs2: Switch to
 security_inode_init_security()")
Content-Language: en-US
To:     linux-security-module@vger.kernel.org
Cc:     Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        Paul Moore <paul@paul-moore.com>
References: <CAHC9VhRPvkdk6t1zkx+Y-QVP_vJRSxp+wuOO0YjyppNDLTNg7g@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhRPvkdk6t1zkx+Y-QVP_vJRSxp+wuOO0YjyppNDLTNg7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/05/20 6:51, Paul Moore wrote:
>    Finally, since security_inode_init_security(), unlike
>    security_old_inode_init_security(), returns zero instead of -EOPNOTSUPP if
>    no xattrs were provided by LSMs or if inodes are private, additionally
>    check in ocfs2_init_security_get() if the xattr name is set.
> 
>    If not, act as if security_old_inode_init_security() returned -EOPNOTSUPP,
>    and set si->enable to zero to notify to the functions following
>    ocfs2_init_security_get() that no xattrs are available.

Regarding security_inode_init_security(), similar problem was found on reiserfs.

https://lkml.kernel.org/r/a800496b-cae9-81bf-c79e-d8342418c5be@I-love.SAKURA.ne.jp

Is it really expected behavior that security_inode_init_security() returns 0 when
initxattrs is provided but call_int_hook(inode_init_security) returned -EOPNOTSUPP ?

