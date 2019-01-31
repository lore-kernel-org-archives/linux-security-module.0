Return-Path: <SRS0=hRTQ=QH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D50C282C7
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Jan 2019 10:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB84218AF
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Jan 2019 10:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfAaKVJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:21:09 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37417 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfAaKVJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 Jan 2019 05:21:09 -0500
Received: by mail-oi1-f195.google.com with SMTP id y23so2284292oia.4
        for <linux-security-module@vger.kernel.org>; Thu, 31 Jan 2019 02:21:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m0SuNou7yDS+3D1wYaKFTHEBe7Ne+CO8BHGdPi4i8lg=;
        b=mh2AwQ2loAOXdBQ+eSZQrI+fYxKlE1oxb6cJSN6hgSw08TyS6BtrMfbhUcfs9oGLC5
         mHIrqrQNEhJxZqqQtRnp13EDbAy66f7KJLFSryuXXG4CRW4IgBGf1wTWBuAmFJo20YV0
         s/s365wOynX48kx40YRBfrWY3zj46Sp972Un9M1RBmkod9FF/qKw0c52wUDj5FPGcQBC
         e6sOJpZ8QINJn7fd/Z1Blf4iZN0Y4SPtdzWlfKduwMKr1IcxOh5DtEZnFd66z5yX/I8q
         FAqhffguP+kaUrs4b0Bk92qQW9AOyasSvYCVdF2Xq1O2sOa8KPFvXuaEDED2FDvcX+Zn
         woQg==
X-Gm-Message-State: AHQUAuaY6GCEptOqOr0VtzvZN1gsHcSXMcag9U9EtzYdgi1hur20zDtm
        mQKwlEgJ3AM7sDmVpejyf4IJZCiiEGEUZKr3ITRRAg==
X-Google-Smtp-Source: AHgI3IbC5A8FjeSM6t+zqElCrlOi/AmHx+JTKGjcCe/AGqytjqX+Jci3QX3z+Let7pLVO/WyG1NRGykj83KC1lYAL4g=
X-Received: by 2002:aca:2403:: with SMTP id n3mr2857487oic.328.1548930068092;
 Thu, 31 Jan 2019 02:21:08 -0800 (PST)
MIME-Version: 1.0
References: <20190130114150.27807-1-omosnace@redhat.com> <20190130114150.27807-6-omosnace@redhat.com>
 <20190130170911.GZ50184@devbig004.ftw2.facebook.com>
In-Reply-To: <20190130170911.GZ50184@devbig004.ftw2.facebook.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 31 Jan 2019 11:20:57 +0100
Message-ID: <CAFqZXNt0jNg2-bNbtsCX2=7bcb_GaxCnHfSyck=GksXBTkWJ-g@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] kernfs: initialize security of newly created nodes
To:     Tejun Heo <tj@kernel.org>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Tejun,

On Wed, Jan 30, 2019 at 6:09 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Jan 30, 2019 at 12:41:50PM +0100, Ondrej Mosnacek wrote:
> > @@ -673,6 +698,12 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
> >                       goto err_out3;
> >       }
> >
> > +     if (parent) {
> > +             ret = kernfs_node_init_security(parent, kn);
> > +             if (ret)
> > +                     goto err_out3;
> > +     }
>
> So, doing this unconditionally isn't a good idea.  kernfs doesn't use
> the usual dentry/inode because there are machines with 6, even 7 digit
> number of kernfs nodes and some of them even failed to boot due to
> memory shortage.  Please don't blow it up by default.

Hm, I see... basically the only thing that gets allocated in
kernfs_node_init_security() by default (at least under SELinux/ no
LSM) is the kernfs_iattrs structures, so I assume you are pointing at
that. I think this can be easily fixed, if we again use the assumption
that whenever the parent node has only default attributes
(parent->iattrs == NULL), then the child node should also have just
default attributes (and so we don't need to call kernfs_iattrs() on it
nor call the security hook). Something along these lines:

[...]
+static int kernfs_node_init_security(struct kernfs_node *parent,
+                                    struct kernfs_node *kn)
+{
+       struct kernfs_iattrs *attrs, *pattrs;
+       struct qstr q;
+
+       pattrs = parent->iattrs;
+       if (!pattrs)
+               return 0;
+
+       attrs = kernfs_iattrs(kn);
+       if (!attrs)
+               return -ENOMEM;
+
+       q.name = kn->name;
+       q.hash_len = hashlen_string(parent, kn->name);
[...]

Technically this might make some LSMs unhappy, if they want to set
some non-default context even if parent is all default, but this is
already impossible now and in this case I think we have no better
choice than sacrificing a bit of flexibility for memory efficiency,
which is apparently critical here.

Tejun, Casey, would the above modification be fine with you?

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
