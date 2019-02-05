Return-Path: <SRS0=6WpB=QM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B90C282CB
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 14:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74605217F9
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 14:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbfBEOmi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:42:38 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46477 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfBEOmi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Feb 2019 09:42:38 -0500
Received: by mail-ot1-f68.google.com with SMTP id w25so5939533otm.13
        for <linux-security-module@vger.kernel.org>; Tue, 05 Feb 2019 06:42:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgbeXmEuf+/zO3G4Q0NoddL0iIJp0rOvR8w+B7ImoEg=;
        b=do6Wh5i+BQZ0A1HV/d99NaaBtpBQxW5HGaby5aTNIj4/SJ6Qm2npUJFhJocjGENQCi
         ZQl9qeFe5JwKN898VnBeT7eB4pcr6/iZuj/aWkfIJWmbMWtvNznknBMhKxpOC5ric6o+
         3TacwtmvJlMGzFDaNxIsofBU7deqMwAIQH/sUw/opSxhBw2b0e0wyDan4eRbRSmmpmH8
         g/90VNhugj1a8mZbcpkHeTvUaQI6LCNyyGwgKwKaGSKfbaT64mQUe2vGJhIXIquUuMZw
         upew68D1RB39QOoC1Lhqmyu90bfXAtJ9g+XIQotFqRrVEz0aIgm+OXTjmPDsyjvuMEtU
         3t5w==
X-Gm-Message-State: AHQUAubKCt6gYa3j3klakpnVktoN6nmxPXXmyY36d9h9HKl7rA/Ro+Iv
        Zcl2/c0kpZDl1z6GAHnQIZLIdqtntrnJEV2206OybQ==
X-Google-Smtp-Source: AHgI3IYODGgJMLDiwiS6SlzuAqxbvn20jcyls1GrVhc5W20WL/pKh6myHR7zrYjgo3bv+Iz4Tj2ZAxy++dMkgUltbis=
X-Received: by 2002:aca:5b43:: with SMTP id p64mr2582301oib.41.1549377757393;
 Tue, 05 Feb 2019 06:42:37 -0800 (PST)
MIME-Version: 1.0
References: <20190205110638.30782-1-omosnace@redhat.com> <20190205110638.30782-2-omosnace@redhat.com>
 <6e92a790-5e69-1462-d9e3-79fe48b67793@tycho.nsa.gov>
In-Reply-To: <6e92a790-5e69-1462-d9e3-79fe48b67793@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 5 Feb 2019 15:42:26 +0100
Message-ID: <CAFqZXNtukhucxdiv5y=82CrRXzbc7+f+DzrZ=mQaFqQbLfv2fQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] selinux: try security xattr after genfs for kernfs filesystems
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 5, 2019 at 3:23 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 2/5/19 6:06 AM, Ondrej Mosnacek wrote:
> > Since kernfs supports the security xattr handlers, we can simply use
> > these to determine the inode's context, dropping the need to update it
> > from kernfs explicitly using a security_inode_notifysecctx() call.
> >
> > We achieve this by setting a new sbsec flag SE_SBGENFS_XATTR to all
> > mounts that are known to use kernfs under the hood and then fetching the
> > xattrs after determining the fallback genfs sid in
> > inode_doinit_with_dentry() when this flag is set.
> >
> > This will allow implementing full security xattr support in kernfs and
> > removing the ...notifysecctx() call in a subsequent patch.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >   security/selinux/hooks.c            | 159 +++++++++++++++-------------
> >   security/selinux/include/security.h |   1 +
> >   2 files changed, 88 insertions(+), 72 deletions(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 81e012c66d95..758a99d1086e 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -793,11 +793,13 @@ static int selinux_set_mnt_opts(struct super_block *sb,
> >
> >       if (!strcmp(sb->s_type->name, "debugfs") ||
> >           !strcmp(sb->s_type->name, "tracefs") ||
> > -         !strcmp(sb->s_type->name, "sysfs") ||
> > -         !strcmp(sb->s_type->name, "pstore") ||
> > +         !strcmp(sb->s_type->name, "pstore"))
> > +             sbsec->flags |= SE_SBGENFS;
> > +
> > +     if (!strcmp(sb->s_type->name, "sysfs") ||
> >           !strcmp(sb->s_type->name, "cgroup") ||
> >           !strcmp(sb->s_type->name, "cgroup2"))
> > -             sbsec->flags |= SE_SBGENFS;
> > +             sbsec->flags |= SE_SBGENFS | SE_SBGENFS_XATTR;
> >
> >       if (!sbsec->behavior) {
> >               /*
> > @@ -1392,6 +1394,71 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
> >       return rc;
> >   }
> >
> > +static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
> > +                               u32 def_sid, u32 *sid)
> > +{
> > +#define INITCONTEXTLEN 255
> > +     char *context = NULL;
> > +     unsigned int len = 0;
> > +     int rc;
> > +
> > +     *sid = def_sid;
> > +
> > +     if (!(inode->i_opflags & IOP_XATTR))
> > +             return 0;
> > +
> > +     len = INITCONTEXTLEN;
> > +     context = kmalloc(len + 1, GFP_NOFS);
> > +     if (!context)
> > +             return -ENOMEM;
> > +
> > +     context[len] = '\0';
> > +     rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, context, len);
> > +     if (rc == -ERANGE) {
> > +             kfree(context);
> > +
> > +             /* Need a larger buffer.  Query for the right size. */
> > +             rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, NULL, 0);
> > +             if (rc < 0)
> > +                     return rc;
> > +
> > +             len = rc;
> > +             context = kmalloc(len + 1, GFP_NOFS);
> > +             if (!context)
> > +                     return -ENOMEM;
> > +
> > +             context[len] = '\0';
> > +             rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX,
> > +                                 context, len);
> > +     }
> > +     if (rc < 0) {
> > +             kfree(context);
> > +             if (rc != -ENODATA) {
> > +                     pr_warn("SELinux: %s:  getxattr returned %d for dev=%s ino=%ld\n",
> > +                             __func__, -rc, inode->i_sb->s_id, inode->i_ino);
> > +                     return rc;
> > +             }
> > +             return 0;
> > +     }
> > +
> > +     rc = security_context_to_sid_default(&selinux_state, context, rc, sid,
> > +                                          def_sid, GFP_NOFS);
> > +     if (rc) {
> > +             char *dev = inode->i_sb->s_id;
> > +             unsigned long ino = inode->i_ino;
> > +
> > +             if (rc == -EINVAL) {
> > +                     pr_notice_ratelimited("SELinux: inode=%lu on dev=%s was found to have an invalid context=%s.  This indicates you may need to relabel the inode or the filesystem in question.\n",
> > +                                           ino, dev, context);
> > +             } else {
> > +                     pr_warn("SELinux: %s:  context_to_sid(%s) returned %d for dev=%s ino=%ld\n",
> > +                             __func__, context, -rc, dev, ino);
> > +             }
> > +     }
> > +     kfree(context);
> > +     return 0;
> > +}
> > +
> >   /* The inode's security attributes must be initialized before first use. */
> >   static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry)
> >   {
> > @@ -1401,8 +1468,6 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
> >       u16 sclass;
> >       struct dentry *dentry;
> >   #define INITCONTEXTLEN 255
>
> This definition can also be removed, having been moved up above.

Right, staged for fixing in v6.

Thanks,

>
> > -     char *context = NULL;
> > -     unsigned len = 0;
> >       int rc = 0;
> >
> >       if (isec->initialized == LABEL_INITIALIZED)
> > @@ -1470,72 +1535,11 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
> >                       goto out;
> >               }
> >
> > -             len = INITCONTEXTLEN;
> > -             context = kmalloc(len+1, GFP_NOFS);
> > -             if (!context) {
> > -                     rc = -ENOMEM;
> > -                     dput(dentry);
> > -                     goto out;
> > -             }
> > -             context[len] = '\0';
> > -             rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, context, len);
> > -             if (rc == -ERANGE) {
> > -                     kfree(context);
> > -
> > -                     /* Need a larger buffer.  Query for the right size. */
> > -                     rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, NULL, 0);
> > -                     if (rc < 0) {
> > -                             dput(dentry);
> > -                             goto out;
> > -                     }
> > -                     len = rc;
> > -                     context = kmalloc(len+1, GFP_NOFS);
> > -                     if (!context) {
> > -                             rc = -ENOMEM;
> > -                             dput(dentry);
> > -                             goto out;
> > -                     }
> > -                     context[len] = '\0';
> > -                     rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, context, len);
> > -             }
> > +             rc = inode_doinit_use_xattr(inode, dentry, sbsec->def_sid,
> > +                                         &sid);
> >               dput(dentry);
> > -             if (rc < 0) {
> > -                     if (rc != -ENODATA) {
> > -                             pr_warn("SELinux: %s:  getxattr returned "
> > -                                    "%d for dev=%s ino=%ld\n", __func__,
> > -                                    -rc, inode->i_sb->s_id, inode->i_ino);
> > -                             kfree(context);
> > -                             goto out;
> > -                     }
> > -                     /* Map ENODATA to the default file SID */
> > -                     sid = sbsec->def_sid;
> > -                     rc = 0;
> > -             } else {
> > -                     rc = security_context_to_sid_default(&selinux_state,
> > -                                                          context, rc, &sid,
> > -                                                          sbsec->def_sid,
> > -                                                          GFP_NOFS);
> > -                     if (rc) {
> > -                             char *dev = inode->i_sb->s_id;
> > -                             unsigned long ino = inode->i_ino;
> > -
> > -                             if (rc == -EINVAL) {
> > -                                     if (printk_ratelimit())
> > -                                             pr_notice("SELinux: inode=%lu on dev=%s was found to have an invalid "
> > -                                                     "context=%s.  This indicates you may need to relabel the inode or the "
> > -                                                     "filesystem in question.\n", ino, dev, context);
> > -                             } else {
> > -                                     pr_warn("SELinux: %s:  context_to_sid(%s) "
> > -                                            "returned %d for dev=%s ino=%ld\n",
> > -                                            __func__, context, -rc, dev, ino);
> > -                             }
> > -                             kfree(context);
> > -                             /* Leave with the unlabeled SID */
> > -                             rc = 0;
> > -                             break;
> > -                     }
> > -             }
> > -             kfree(context);
> > +             if (rc)
> > +                     goto out;
> >               break;
> >       case SECURITY_FS_USE_TASK:
> >               sid = task_sid;
> > @@ -1586,9 +1590,20 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
> >                               goto out;
> >                       rc = selinux_genfs_get_sid(dentry, sclass,
> >                                                  sbsec->flags, &sid);
> > -                     dput(dentry);
> > -                     if (rc)
> > +                     if (rc) {
> > +                             dput(dentry);
> >                               goto out;
> > +                     }
> > +
> > +                     if (sbsec->flags & SE_SBGENFS_XATTR) {
> > +                             rc = inode_doinit_use_xattr(inode, dentry,
> > +                                                         sid, &sid);
> > +                             if (rc) {
> > +                                     dput(dentry);
> > +                                     goto out;
> > +                             }
> > +                     }
> > +                     dput(dentry);
> >               }
> >               break;
> >       }
> > diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> > index f68fb25b5702..6e5928f951da 100644
> > --- a/security/selinux/include/security.h
> > +++ b/security/selinux/include/security.h
> > @@ -58,6 +58,7 @@
> >   #define SE_SBINITIALIZED    0x0100
> >   #define SE_SBPROC           0x0200
> >   #define SE_SBGENFS          0x0400
> > +#define SE_SBGENFS_XATTR     0x0800
> >
> >   #define CONTEXT_STR "context="
> >   #define FSCONTEXT_STR       "fscontext="
> >
>


-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
