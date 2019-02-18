Return-Path: <SRS0=s2IT=QZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E408EC4360F
	for <linux-security-module@archiver.kernel.org>; Mon, 18 Feb 2019 10:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE53D21479
	for <linux-security-module@archiver.kernel.org>; Mon, 18 Feb 2019 10:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfBRKEK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:04:10 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44800 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfBRKEK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 Feb 2019 05:04:10 -0500
Received: by mail-ot1-f66.google.com with SMTP id g1so27243378otj.11
        for <linux-security-module@vger.kernel.org>; Mon, 18 Feb 2019 02:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WbwmO6eINsku+SH1cWb89Z9C7TTVkRiQSZp8dOH1tRc=;
        b=pXW61d81y+7J5Lo1RW4XKgH8KchEaGbfH7sd65agaSkuBh6wL6eGI9VJhJ+BEuYjCF
         YluGRmLVMxiMeucRSEhkr4GcL7ONlAbwFSyTLPU88chPrgiqOD9HLAx2r5KLocXmSE16
         A41p2MTQ7JHuETsIsBK203NV68h/pjeQiTqLEvikzvqGDUFPK+oZNhSLnzcNLzJWgBda
         Nw20FhlPybpvlcvUY/ft2D+TviqxlvkUicf+ATOlb9zcMRZT8LMpyZyNiU+3sFL6A76v
         Z40G2jgWsIHG0DVv4QhCGmer80D0IRbuxYDERKA0W7RyJWFpihhjJ3KjwqIjIENwoaNQ
         ti0g==
X-Gm-Message-State: AHQUAuboSJfXQWGV0OUW3u9gqDYSkzAfIMN9rrG2AeotosUE/ND4IyKw
        SLOS8ALHze+KD8XIp3csTuHpquWndj+KpiKNhvT+TQ==
X-Google-Smtp-Source: AHgI3IZcxOpohD0mbgzms0HNUj9nyRvF9sqx/UyoxKiQn6Zsb56/MCtfTJuTc0jtv79qS9JiMjhCHu0EoKkQFkyxrkk=
X-Received: by 2002:a9d:27e3:: with SMTP id c90mr13331306otb.21.1550484249182;
 Mon, 18 Feb 2019 02:04:09 -0800 (PST)
MIME-Version: 1.0
References: <20190214095015.16032-1-omosnace@redhat.com> <20190214095015.16032-6-omosnace@redhat.com>
 <20190214154854.GO50184@devbig004.ftw2.facebook.com> <CAFqZXNuOg9ex_WqCCKYzPQSeqbGmo-KP4Yh9TB4bbMZziG314A@mail.gmail.com>
 <20190215155014.GP50184@devbig004.ftw2.facebook.com>
In-Reply-To: <20190215155014.GP50184@devbig004.ftw2.facebook.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 18 Feb 2019 11:03:58 +0100
Message-ID: <CAFqZXNvVb75K9ZemVObcBB+rntL38_VfY5P6jyAbuwjymt6MQQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] kernfs: initialize security of newly created nodes
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

On Fri, Feb 15, 2019 at 4:50 PM Tejun Heo <tj@kernel.org> wrote:
> On Fri, Feb 15, 2019 at 04:45:44PM +0100, Ondrej Mosnacek wrote:
> > On Thu, Feb 14, 2019 at 4:49 PM Tejun Heo <tj@kernel.org> wrote:
> > > On Thu, Feb 14, 2019 at 10:50:15AM +0100, Ondrej Mosnacek wrote:
> > > > +static int kernfs_node_init_security(struct kernfs_node *parent,
> > > > +                                  struct kernfs_node *kn)
> > >
> > > Can we skip the whole thing if security is not enabled?
> >
> > Do you mean just skipping the whole part when CONFIG_SECURITY=n? That
> > is easy to do and I can add it in the next respin (although the
> > compiler should be able to optimize most of it out in that case).
>
> So the goal is allowing folks who don't use this to not pay.  It'd be
> better the evaulation can be as late as possible but obviously there's
> a point where that'd be too complicated.  Maybe "ever enabled in this
> boot" is a good and simple enough at the same time?

I don't think there is a way currently to check whether some LSM has
been enabled at boot or not. I suppose we could add such function for
this kind of heuristics, but I'm not sure how it would interplay with
the plans to allow multiple LSM to be enabled simultaneously...
Perhaps it would be better/easier to just add a
security_kernfs_needs_init() function, which would simply check if the
list of registered kernfs_init_security hooks is empty.

I propose something like the patch below (the whitespace is mangled -
intended just for visual review). I plan to fold it into the next
respin if there are no objections to this approach.

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 735a6d382d9d..5b99205da919 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -625,6 +625,9 @@ static int kernfs_node_init_security(struct
kernfs_node *parent,
        struct qstr q;
        int ret;

+       if (!security_kernfs_needs_init() || !parent)
+               return 0;
+
        if (!parent->iattr) {
                kernfs_iattr_init(&iattr_parent, parent);
                simple_xattrs_init(&xattr_parent);
@@ -720,11 +723,9 @@ static struct kernfs_node
*__kernfs_new_node(struct kernfs_root *root,
                        goto err_out3;
        }

-       if (parent) {
-               ret = kernfs_node_init_security(parent, kn);
-               if (ret)
-                       goto err_out3;
-       }
+       ret = kernfs_node_init_security(parent, kn);
+       if (ret)
+               goto err_out3;

        return kn;

diff --git a/include/linux/security.h b/include/linux/security.h
index 581944d1e61e..49a083dbc464 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -292,6 +292,7 @@ int security_inode_listsecurity(struct inode
*inode, char *buffer, size_t buffer
 void security_inode_getsecid(struct inode *inode, u32 *secid);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
+int security_kernfs_needs_init(void);
 int security_kernfs_init_security(const struct qstr *qstr,
                                  const struct iattr *dir_iattr,
                                  struct simple_xattrs *dir_secattr,
@@ -789,6 +790,11 @@ static inline int security_inode_copy_up(struct
dentry *src, struct cred **new)
        return 0;
 }

+static inline int security_kernfs_needs_init(void)
+{
+       return 0;
+}
+
 static inline int security_kernfs_init_security(
                const struct qstr *qstr, const struct iattr *dir_iattr,
                struct simple_xattrs *dir_secattr, const struct iattr *iattr,
diff --git a/security/security.c b/security/security.c
index 836e0822874a..3c8b9b5baabc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -892,6 +892,11 @@ int security_inode_copy_up_xattr(const char *name)
 }
 EXPORT_SYMBOL(security_inode_copy_up_xattr);

+int security_kernfs_needs_init(void)
+{
+       return !hlist_empty(&security_hook_heads.kernfs_init_security);
+}
+
 int security_kernfs_init_security(const struct qstr *qstr,
                                  const struct iattr *dir_iattr,
                                  struct simple_xattrs *dir_secattr,

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
