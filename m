Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B60AC636D3
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Feb 2023 21:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjBIVGF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 Feb 2023 16:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjBIVGE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Feb 2023 16:06:04 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756BE6ADC6
        for <linux-security-module@vger.kernel.org>; Thu,  9 Feb 2023 13:05:59 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id g9so2203633pfo.5
        for <linux-security-module@vger.kernel.org>; Thu, 09 Feb 2023 13:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1675976759;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CAVkyD8Nx/y2ynXnSDseAghmgwxLpM4z5TAXS1lVdl4=;
        b=fsToE02Ydbw9AM0LhMk4fOKIsHvVkm870EKJvtvUsHlgdxofGdKjWtExVXrQcwqyOD
         SaJHwxPVUhVv+Zb8PdG9Cl7AkSweZegmZgJovsF60EdVp7XWUSfeDyRdOdh1BqrRM5N2
         Vi4N/kTKjg/T3MKWf9zptDhGtRkG3SMgQxag1fqnQPXX8xl2CMLbs3PoA2hsrFrGc/Ny
         03aku/22aS9evBeXGC+9QqOFU0n1VQzmcMeerqis2tI7xZt9hTTp8vbKnPNrpR0nwUEH
         m1og74/72VCF/OpMF8luJl9jkO5kXYh1wuIMTBwX+PKBuUN4pLSyfeTfeph7UYAu0/ty
         tIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1675976759;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAVkyD8Nx/y2ynXnSDseAghmgwxLpM4z5TAXS1lVdl4=;
        b=pxWu1W6nMFsnGqymK8hPc5plWa5zxXBTS3RYDIHwyvBZ6hTUScQfSjie2rvsh62gzG
         Q8sGzp96Fa3uPZJxZuTtaLCyB8CE9reXsuK9BU0U55TWXEVL8uCSKWID1UK9giJt7LWP
         iNWdG/V9g01rxy9Oe9b0vxeYQr9rxzx6dWZNpmgysuO9bPYiavdWUsb71Ncid1vU/GPi
         XXKzz48mZjgNeKEBxZnqGf2kBJ+20LYx4jrEXoCRO9uKTy5QJY2ei0G/afACqqWY2112
         dw2FSvFyT5JrlTGptUVwAZoEmXTGxD75vo+yz8kOA+m9Fg0GdODgD/ueX8yGs84kxwhf
         4pIA==
X-Gm-Message-State: AO0yUKVJaP3hW83MZgAIbmMztdmhK7847kRVkao9drS719h65qqzB+je
        ZBPiLbRqjglgoKDJTwtCtfwaFYBOMnsZcHI4uouC
X-Google-Smtp-Source: AK7set/gyzwIbVdcBNq34ovXolGAJFru/qdEdGqxzqLnB8dNXT0qLl/7mTz9ti+D2+MdSQqLp43XM5PhpV37m725smk=
X-Received: by 2002:a62:5f02:0:b0:5a8:5247:2589 with SMTP id
 t2-20020a625f02000000b005a852472589mr832403pfb.7.1675976759040; Thu, 09 Feb
 2023 13:05:59 -0800 (PST)
MIME-Version: 1.0
References: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
 <20221201104125.919483-3-roberto.sassu@huaweicloud.com> <6905166125130c22c244ebf234723d1587a01ae8.camel@huaweicloud.com>
 <CAHC9VhRu_pdEur4XDkwMETAQEd-8=13k+qvpMEgW=hiYMCKw2A@mail.gmail.com> <dc973294e5ad2d05705954b433bb550b04a86325.camel@huaweicloud.com>
In-Reply-To: <dc973294e5ad2d05705954b433bb550b04a86325.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 9 Feb 2023 16:05:47 -0500
Message-ID: <CAHC9VhQoGNWDOvLU8U3dEvdCa8-23O0JpaeVbUOAa2udEpcVqw@mail.gmail.com>
Subject: Re: [PATCH v7 2/6] ocfs2: Switch to security_inode_init_security()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com,
        ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Feb 8, 2023 at 9:33 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Thu, 2023-01-12 at 12:21 -0500, Paul Moore wrote:
> > On Tue, Jan 10, 2023 at 3:56 AM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On Thu, 2022-12-01 at 11:41 +0100, Roberto Sassu wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > >
> > > > In preparation for removing security_old_inode_init_security(), switch to
> > > > security_inode_init_security().
> > > >
> > > > Extend the existing ocfs2_initxattrs() to take the
> > > > ocfs2_security_xattr_info structure from fs_info, and populate the
> > > > name/value/len triple with the first xattr provided by LSMs.
> > >
> > > Hi Mark, Joel, Joseph
> > >
> > > some time ago I sent this patch set to switch to the newer
> > > function security_inode_init_security(). Almost all the other parts of
> > > this patch set have been reviewed, and the patch set itself should be
> > > ready to be merged.
> > >
> > > I kindly ask if you could have a look at this patch and give your
> > > Reviewed-by, so that Paul could take the patch set.
> >
> > I've been pushing to clean up some of the LSM interfaces to try and
> > simplify things and remove as many special cases as possible,
> > Roberto's work in this patchset is part of that.  I would really
> > appreciate it if the vfs/ocfs2 folks could give patch 2/6 a quick look
> > to make sure you are okay with the changes.
> >
> > I realize that the various end-of-year holidays tend to slow things
> > down a bit, but this patchset has been on the lists for over a month
> > now; if I don't hear anything in the next week or two I'll assume you
> > folks are okay with these patches ...
>
> Hi Paul
>
> is this patch set going to land in 6.3?

Hi Roberto,

I had really hoped the vfs/ocfs2 folks would have commented on this by
now, but it's been over two months now with no comments that I can see
so I think we have to do it ourselves via the LSM tree.  It's
obviously too late for the upcoming merge window, so no v6.3, but I
think we can merge it *after* the upcoming merge window closes,
assuming we get ACKs from Mimi on the EVM bits (I still need to review
it too, but I'm not expecting anything too bad).

-- 
paul-moore.com
