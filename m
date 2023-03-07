Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93782C678D5
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Mar 2023 17:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjCGRC3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 Mar 2023 12:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjCGRCF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 Mar 2023 12:02:05 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F1454CA1
        for <linux-security-module@vger.kernel.org>; Tue,  7 Mar 2023 08:57:47 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PWLWG689Fz9xFrH
        for <linux-security-module@vger.kernel.org>; Wed,  8 Mar 2023 00:29:30 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwC3PAiLaAdkzXx8AQ--.38284S2;
        Tue, 07 Mar 2023 17:38:40 +0100 (CET)
Message-ID: <5871614020e20f3e529e6d1244c2e207c7ce6004.camel@huaweicloud.com>
Subject: Re: [PATCH 00/22] Move LSM hook comments into security/security.c
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org
Date:   Tue, 07 Mar 2023 17:38:33 +0100
In-Reply-To: <CAHC9VhRMcEDY88vfRQ8KM8apGgC-jZAygJ4gyb2_QoFx5vTthw@mail.gmail.com>
References: <20230217032625.678457-1-paul@paul-moore.com>
         <CAHC9VhQnjmX9n2KJhj97SnQfuO50kaJxX3p8p4gHBC5mBkLfxg@mail.gmail.com>
         <d2fdf2baa635d3b301d54f07faadb5a440b87d46.camel@huaweicloud.com>
         <CAHC9VhRMcEDY88vfRQ8KM8apGgC-jZAygJ4gyb2_QoFx5vTthw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwC3PAiLaAdkzXx8AQ--.38284S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF43Ww48Xr1UWF48Xr47Jwb_yoW5KFWUpF
        Way3W3trs5JFy3JF1IvF4xGayfK393GryDJFs8WryrZwn8Zr1xtFWIyw1rCr9rJryrCF1S
        va17Gw13Cwn0y37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
        xhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAJBF1jj4pMeQAAsC
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 2023-03-07 at 11:33 -0500, Paul Moore wrote:
> On Tue, Mar 7, 2023 at 3:09 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Mon, 2023-03-06 at 13:49 -0500, Paul Moore wrote:
> > > On Thu, Feb 16, 2023 at 10:26 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > Hello all,
> > > > 
> > > > The LSM hook comment blocks are a in a rather sad state; separated from
> > > > the hook definitions they are often out of mind, and as a result
> > > > most of them are in varying levels of bit-rot, some severely.  This
> > > > patchset moves all of the comment blocks out of lsm_hooks.c and onto
> > > > the top of the function definitions as one would normally expect.
> > > > In the process of moving the comment blocks, they have been massaged
> > > > into the standard kernel-doc format for the sake of consistency and
> > > > easier reading.  Unfortunately, correcting all of the errors in the
> > > > comments would have made an extremely long and painful task even worse,
> > > > so a number of errors remain, but the worst offenders were corrected in
> > > > the move.  Now that the comments are in the proper location, and in the
> > > > proper format, my hope is that future patch submissions correcting the
> > > > actual comment contents will be much easier and the comments as a whole
> > > > will be easier to maintain.
> > > > 
> > > > There are no code changes in this patchset, although since I was
> > > > already adding a lot of churn to security.c, the last patch in this
> > > > patchset (22/22) does take the liberty of fixing some rather ugly
> > > > style problems.
> > > > 
> > > >  include/linux/lsm_hooks.h | 1624 +++++++++++++++++++++
> > > >  security/security.c       | 2702 +---------------------------------------
> > > >  2 files changed, 1710 insertions(+), 2616 deletions(-)
> > > 
> > > Seeing no objections, and the ACK from Casey, I've gone ahead and
> > > merged this patchset into the lsm/next branch.  There was some minor
> > > merge fuzz due to the mount idmap work and some IMA changes, but the
> > > vast majority of the patchset is exactly as posted.
> > 
> > Oh, I thought it was an intermediate version and didn't report some
> > issues:
> 
> If you don't see a "RFC" in the patch subject line it's safe to assume
> it is a "final" version.  Regardless, feedback is never bad, even if
> it is a RFC.
> 
> > scripts/kernel-doc security/security.c|grep warning
> > security/security.c:1236: warning: Function parameter or member 'mnt_opts' not described in 'security_free_mnt_opts'
> > security/security.c:1236: warning: Excess function parameter 'mnt_ops' description in 'security_free_mnt_opts'
> > security/security.c:1254: warning: Function parameter or member 'mnt_opts' not described in 'security_sb_eat_lsm_opts'
> > security/security.c:1254: warning: Excess function parameter 'mnt_ops' description in 'security_sb_eat_lsm_opts'
> > security/security.c:1423: warning: Function parameter or member 'oldsb' not described in 'security_sb_clone_mnt_opts'
> > security/security.c:1423: warning: Function parameter or member 'newsb' not described in 'security_sb_clone_mnt_opts'
> 
> Unsurprising.  Those patches were mostly just to relocate the comment
> blocks out of lsm_hooks.h and into security.c; while I did fix some of
> the really bad errors, fixing everything in the move wasn't really the
> goal, that's for future work.
> 
> Did you want to submit a patch to fix those?

I rebased the stacked IMA/EVM to your patch set, so that it is closer
to the final version. I expect there will not be too many conflicts.

It is also ok for me to fix those issues in the future.

Roberto

