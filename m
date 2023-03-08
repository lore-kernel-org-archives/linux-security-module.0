Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37FCC6FD1E
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Mar 2023 17:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjCHRRC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Mar 2023 12:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjCHRQf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Mar 2023 12:16:35 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05D2CF0DC
        for <linux-security-module@vger.kernel.org>; Wed,  8 Mar 2023 09:15:23 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4PWzH045WYz9xFHH
        for <linux-security-module@vger.kernel.org>; Thu,  9 Mar 2023 01:06:04 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBHzwp9wghkgO6AAQ--.41184S2;
        Wed, 08 Mar 2023 18:14:42 +0100 (CET)
Message-ID: <8a899d7f5f68a9f602efa50c71505f05130eb383.camel@huaweicloud.com>
Subject: Re: [PATCH 00/22] Move LSM hook comments into security/security.c
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org
Date:   Wed, 08 Mar 2023 18:14:35 +0100
In-Reply-To: <CAHC9VhTdBTopwGeyfr9YrOPdvczTk3mSGtjoW3_CYKDHMGkf9g@mail.gmail.com>
References: <20230217032625.678457-1-paul@paul-moore.com>
         <CAHC9VhQnjmX9n2KJhj97SnQfuO50kaJxX3p8p4gHBC5mBkLfxg@mail.gmail.com>
         <d2fdf2baa635d3b301d54f07faadb5a440b87d46.camel@huaweicloud.com>
         <CAHC9VhRMcEDY88vfRQ8KM8apGgC-jZAygJ4gyb2_QoFx5vTthw@mail.gmail.com>
         <5871614020e20f3e529e6d1244c2e207c7ce6004.camel@huaweicloud.com>
         <CAHC9VhTdBTopwGeyfr9YrOPdvczTk3mSGtjoW3_CYKDHMGkf9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBHzwp9wghkgO6AAQ--.41184S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF15Jr4kGFWfJFW8Xr47Jwb_yoWrXw13pF
        Way3W3trs5JFy3Jr1IyF1xGayft393GryDXFs8WryrAw1qvryxtrWIyw1rCr9rXrZ5CF1S
        va17G343Cwn8Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
        rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4
        IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
        AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
        42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr
        1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
        daVFxhVjvjDU0xZFpf9x07jb_-PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj4pYHQABsw
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2023-03-08 at 12:09 -0500, Paul Moore wrote:
> On Tue, Mar 7, 2023 at 11:38 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Tue, 2023-03-07 at 11:33 -0500, Paul Moore wrote:
> > > On Tue, Mar 7, 2023 at 3:09 AM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > On Mon, 2023-03-06 at 13:49 -0500, Paul Moore wrote:
> > > > > On Thu, Feb 16, 2023 at 10:26 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > Hello all,
> > > > > > 
> > > > > > The LSM hook comment blocks are a in a rather sad state; separated from
> > > > > > the hook definitions they are often out of mind, and as a result
> > > > > > most of them are in varying levels of bit-rot, some severely.  This
> > > > > > patchset moves all of the comment blocks out of lsm_hooks.c and onto
> > > > > > the top of the function definitions as one would normally expect.
> > > > > > In the process of moving the comment blocks, they have been massaged
> > > > > > into the standard kernel-doc format for the sake of consistency and
> > > > > > easier reading.  Unfortunately, correcting all of the errors in the
> > > > > > comments would have made an extremely long and painful task even worse,
> > > > > > so a number of errors remain, but the worst offenders were corrected in
> > > > > > the move.  Now that the comments are in the proper location, and in the
> > > > > > proper format, my hope is that future patch submissions correcting the
> > > > > > actual comment contents will be much easier and the comments as a whole
> > > > > > will be easier to maintain.
> > > > > > 
> > > > > > There are no code changes in this patchset, although since I was
> > > > > > already adding a lot of churn to security.c, the last patch in this
> > > > > > patchset (22/22) does take the liberty of fixing some rather ugly
> > > > > > style problems.
> > > > > > 
> > > > > >  include/linux/lsm_hooks.h | 1624 +++++++++++++++++++++
> > > > > >  security/security.c       | 2702 +---------------------------------------
> > > > > >  2 files changed, 1710 insertions(+), 2616 deletions(-)
> > > > > 
> > > > > Seeing no objections, and the ACK from Casey, I've gone ahead and
> > > > > merged this patchset into the lsm/next branch.  There was some minor
> > > > > merge fuzz due to the mount idmap work and some IMA changes, but the
> > > > > vast majority of the patchset is exactly as posted.
> > > > 
> > > > Oh, I thought it was an intermediate version and didn't report some
> > > > issues:
> > > 
> > > If you don't see a "RFC" in the patch subject line it's safe to assume
> > > it is a "final" version.  Regardless, feedback is never bad, even if
> > > it is a RFC.
> > > 
> > > > scripts/kernel-doc security/security.c|grep warning
> > > > security/security.c:1236: warning: Function parameter or member 'mnt_opts' not described in 'security_free_mnt_opts'
> > > > security/security.c:1236: warning: Excess function parameter 'mnt_ops' description in 'security_free_mnt_opts'
> > > > security/security.c:1254: warning: Function parameter or member 'mnt_opts' not described in 'security_sb_eat_lsm_opts'
> > > > security/security.c:1254: warning: Excess function parameter 'mnt_ops' description in 'security_sb_eat_lsm_opts'
> > > > security/security.c:1423: warning: Function parameter or member 'oldsb' not described in 'security_sb_clone_mnt_opts'
> > > > security/security.c:1423: warning: Function parameter or member 'newsb' not described in 'security_sb_clone_mnt_opts'
> > > 
> > > Unsurprising.  Those patches were mostly just to relocate the comment
> > > blocks out of lsm_hooks.h and into security.c; while I did fix some of
> > > the really bad errors, fixing everything in the move wasn't really the
> > > goal, that's for future work.
> > > 
> > > Did you want to submit a patch to fix those?
> > 
> > I rebased the stacked IMA/EVM to your patch set, so that it is closer
> > to the final version. I expect there will not be too many conflicts.
> > 
> > It is also ok for me to fix those issues in the future.
> 
> That would be great, thanks.

I meant generically someone... (ok, I got the task).

Roberto

