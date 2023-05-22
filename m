Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C566C7EE26
	for <linux-security-module@archiver.kernel.org>; Mon, 22 May 2023 07:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjEVH5f (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 May 2023 03:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjEVH5H (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 May 2023 03:57:07 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF15188
        for <linux-security-module@vger.kernel.org>; Mon, 22 May 2023 00:56:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4QPqJJ3CJyz9v7Vc
        for <linux-security-module@vger.kernel.org>; Mon, 22 May 2023 15:46:08 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDHjFMLIGtkNCnJAg--.1616S2;
        Mon, 22 May 2023 08:56:04 +0100 (CET)
Message-ID: <46825987ddde217cd60b144888171cf3fe113152.camel@huaweicloud.com>
Subject: Re: Stable backport of de3004c874e7 ("ocfs2: Switch to
 security_inode_init_security()")
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org
Cc:     Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 May 2023 09:55:36 +0200
In-Reply-To: <f5ada796-41ba-5cc8-b43d-efd639994f15@I-love.SAKURA.ne.jp>
References: <CAHC9VhRPvkdk6t1zkx+Y-QVP_vJRSxp+wuOO0YjyppNDLTNg7g@mail.gmail.com>
         <f5ada796-41ba-5cc8-b43d-efd639994f15@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDHjFMLIGtkNCnJAg--.1616S2
X-Coremail-Antispam: 1UD129KBjvJXoW7XF1DtFWUZr1UGFW5ZF1DKFg_yoW8Jr13pF
        40k3Wjkrn8ta4kAr4kXF98ua1IgFW3GrZrJwn3Ar97ZF4DAF1Fqr40k343uFyfJrWDJ348
        tw4xZrnxWr1DZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAFBF1jj4l4PAACs9
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, 2023-05-20 at 14:54 +0900, Tetsuo Handa wrote:
> On 2023/05/20 6:51, Paul Moore wrote:
> >    Finally, since security_inode_init_security(), unlike
> >    security_old_inode_init_security(), returns zero instead of -EOPNOTSUPP if
> >    no xattrs were provided by LSMs or if inodes are private, additionally
> >    check in ocfs2_init_security_get() if the xattr name is set.
> > 
> >    If not, act as if security_old_inode_init_security() returned -EOPNOTSUPP,
> >    and set si->enable to zero to notify to the functions following
> >    ocfs2_init_security_get() that no xattrs are available.
> 
> Regarding security_inode_init_security(), similar problem was found on reiserfs.
> 
> https://lkml.kernel.org/r/a800496b-cae9-81bf-c79e-d8342418c5be@I-love.SAKURA.ne.jp
> 
> Is it really expected behavior that security_inode_init_security() returns 0 when
> initxattrs is provided but call_int_hook(inode_init_security) returned -EOPNOTSUPP ?

It is going to change with this upcoming patch:

https://lore.kernel.org/linux-integrity/20230331123221.3273328-3-roberto.sassu@huaweicloud.com/

There will be only one loop, and error handling would be the same.

Thanks

Roberto

