Return-Path: <SRS0=EAti=ZO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA92C43215
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Nov 2019 00:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2574F206DA
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Nov 2019 00:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="fFffJpBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKVAbF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 21 Nov 2019 19:31:05 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40925 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfKVAbF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 21 Nov 2019 19:31:05 -0500
Received: by mail-lj1-f194.google.com with SMTP id q2so5305674ljg.7
        for <linux-security-module@vger.kernel.org>; Thu, 21 Nov 2019 16:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+m1pwplJ30Bep93aDbdfEJ9vAZLrZyvHM6LLGil5DrE=;
        b=fFffJpBcNP5KlCoPJyVS7leFtzwDcxucbvD1eA/+wCzFq/UVoYR9h4skO0sWRXOzk0
         YjucFEffwXOALFPXM+Qm81wUnorR8diHqxUmKa6e53Y913DMkacDQ0onN/N4d2vd2s0K
         lisJOgcU1GkuEdZyq6bTCfho2o0kvp2W8h2UVa5dJPbBnrJLhSEXbPaWIE9K/dqEVl3e
         3ZZxuGbq3mV9rhdiJe9ZXjiCXqQrjn7TVoi8N/hTR41Aa7/gDeC1d3jVsDbnrOszjLtE
         ZZPVigF5U9YWC2w/H+ANkccYCT1tIDQhMdpUyCzt0AYg9qT+f/B5ELMo36krcHIBuzR8
         rOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+m1pwplJ30Bep93aDbdfEJ9vAZLrZyvHM6LLGil5DrE=;
        b=m2DjnYueXgdotqN5eGWvFyqEUt+z7YhpH5g8uFgwYCKnmpxGyDrvJ174wMHwZZ4U+M
         RLinjdwuYIHRvBtg52M1oxdpFQ7kBGqdPPvMUu5CYGPTVC5csOghOjj1fUOYuv7bvarQ
         L0JfBP2NhdkgD3QPDDl/yt3+7hrMylpcmoaAMOZiCAz/1ZR3J5OP+GUkzS9BsZvu/yUD
         18dsFc6F6Glgor1vZnGhFb95WrJBjrjzThJIaZi4aNX1scKjARoJ27J5ivB7pvZWvOrF
         JpbnTio+9iKKVdKhY4zwP4r+IR4XJ+y7Ak3ntoKyClpAG/Lxx5ZzaQOat0gKEzkkp+8S
         EeVw==
X-Gm-Message-State: APjAAAUqcx+7o+In8xHFYycPNy9KB8y3GyJzND/1tUr7epzLL4jvy8ZS
        653//JhFZoUxmY/SvZaz3UrW/0DPd3iZjuyXXZCdphmIGQ==
X-Google-Smtp-Source: APXvYqwEsdAd8hHuUJzIbcSqXw20Xq2weLP0O5hIyGKfwgyHFNsSbMRg+jC9chn67A8MoGbc6uXiErxWFAcTbMtMI/A=
X-Received: by 2002:a2e:95c5:: with SMTP id y5mr10020421ljh.184.1574382663070;
 Thu, 21 Nov 2019 16:31:03 -0800 (PST)
MIME-Version: 1.0
References: <20191121145245.8637-1-sds@tycho.nsa.gov> <20191121145245.8637-2-sds@tycho.nsa.gov>
 <CAHC9VhTAq7CgcRRcvZCYis7ELAo+bo2q8pCUXfHUP9YAcUhwsQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTAq7CgcRRcvZCYis7ELAo+bo2q8pCUXfHUP9YAcUhwsQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 21 Nov 2019 19:30:51 -0500
Message-ID: <CAHC9VhRURZMtEDagtSKEuuOLEJen=4PQZig3iGNomzXC1HTNSA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] selinux: fall back to ref-walk upon
 LSM_AUDIT_DATA_DENTRY too
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, will@kernel.org, viro@zeniv.linux.org.uk,
        neilb@suse.de, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 21, 2019 at 7:12 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Nov 21, 2019 at 9:52 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > commit bda0be7ad994 ("security: make inode_follow_link RCU-walk aware")
> > passed down the rcu flag to the SELinux AVC, but failed to adjust the
> > test in slow_avc_audit() to also return -ECHILD on LSM_AUDIT_DATA_DENTRY.
> > Previously, we only returned -ECHILD if generating an audit record with
> > LSM_AUDIT_DATA_INODE since this was only relevant from inode_permission.
> > Return -ECHILD on either LSM_AUDIT_DATA_INODE or LSM_AUDIT_DATA_DENTRY.
> > LSM_AUDIT_DATA_INODE only requires this handling due to the fact
> > that dump_common_audit_data() calls d_find_alias() and collects the
> > dname from the result if any.
> > Other cases that might require similar treatment in the future are
> > LSM_AUDIT_DATA_PATH and LSM_AUDIT_DATA_FILE if any hook that takes
> > a path or file is called under RCU-walk.
> >
> > Fixes: bda0be7ad994 ("security: make inode_follow_link RCU-walk aware")
> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> > ---
> >  security/selinux/avc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> > index 74c43ebe34bb..f1fa1072230c 100644
> > --- a/security/selinux/avc.c
> > +++ b/security/selinux/avc.c
> > @@ -779,7 +779,8 @@ noinline int slow_avc_audit(struct selinux_state *state,
> >          * during retry. However this is logically just as if the operation
> >          * happened a little later.
> >          */
> > -       if ((a->type == LSM_AUDIT_DATA_INODE) &&
> > +       if ((a->type == LSM_AUDIT_DATA_INODE ||
> > +            a->type == LSM_AUDIT_DATA_DENTRY) &&
> >             (flags & MAY_NOT_BLOCK))
> >                 return -ECHILD;

With LSM_AUDIT_DATA_INODE we eventually end up calling d_find_alias()
in dump_common_audit_data() which could block, which is bad, that I
understand.  However, looking at LSM_AUDIT_DATA_DENTRY I'm less clear
on why that is bad?  It makes a few audit_log*() calls and one call to
d_backing_inode() which is non-blocking and trivial.

What am I missing?

> Added the LSM list as I'm beginning to wonder if we should push this
> logic down into common_lsm_audit(), this problem around blocking
> shouldn't be SELinux specific.
>
> For the LSM folks just joining, the full patchset can be found here:
> * https://lore.kernel.org/selinux/20191121145245.8637-1-sds@tycho.nsa.gov/T/#t

--
paul moore
www.paul-moore.com
