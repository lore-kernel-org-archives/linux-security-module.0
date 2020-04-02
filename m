Return-Path: <SRS0=1tMQ=5S=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA1FC43331
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Apr 2020 16:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AA220757
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Apr 2020 16:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cp/UrpKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbgDBQbe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:31:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51608 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732569AbgDBQbe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Apr 2020 12:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585845092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WmJvDE6tIUjYbNnLMH2FiH7kEbwg6hJX/9E4DYyHw6k=;
        b=Cp/UrpKUHkNuiBzI87K1Ra+oOVLiqYEFmud5S+CEBMvMJN7Y0vhP16Zv7x8ZDDN9/cGs/k
        L6uazuMdxP+6K1aavdi8Kz/CLVphW8enPE4ibzP6I6CULRAEh473o54RU3Un/N1OKyxPe3
        AoLXclvGqbsibgYeLZbVs9MaNG1nD2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-UZzm0zuSNEC8JpfdYVJXHQ-1; Thu, 02 Apr 2020 12:31:24 -0400
X-MC-Unique: UZzm0zuSNEC8JpfdYVJXHQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBC3A8010FD;
        Thu,  2 Apr 2020 16:31:22 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B5945C553;
        Thu,  2 Apr 2020 16:31:22 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id B2C5118089C8;
        Thu,  2 Apr 2020 16:31:21 +0000 (UTC)
Date:   Thu, 2 Apr 2020 12:31:21 -0400 (EDT)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Richard Guy Briggs <rgb@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        linux-audit@redhat.com, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1800109401.20260657.1585845081366.JavaMail.zimbra@redhat.com>
In-Reply-To: <2d7174b1-115f-b86f-8054-a5caef4b69ff@schaufler-ca.com>
References: <20200402141319.28714-1-vdronov@redhat.com> <2d7174b1-115f-b86f-8054-a5caef4b69ff@schaufler-ca.com>
Subject: Re: [PATCH ghak96] audit: set cwd in audit context for file-related
 LSM audit records
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.193.197, 10.4.195.11]
Thread-Topic: audit: set cwd in audit context for file-related LSM audit records
Thread-Index: 8e3qF2g6AHt9X4Hh2HYCY+d3jKkEsw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello, Casey, all,

----- Original Message -----
> From: "Casey Schaufler" <casey@schaufler-ca.com>
> Subject: Re: [PATCH ghak96] audit: set cwd in audit context for file-related LSM audit records
> 
> On 4/2/2020 7:13 AM, Vladis Dronov wrote:
> > Set a current working directory in an audit context for the following
> > record
> > types in dump_common_audit_data(): LSM_AUDIT_DATA_PATH,
> > LSM_AUDIT_DATA_FILE,
> > LSM_AUDIT_DATA_IOCTL_OP, LSM_AUDIT_DATA_DENTRY, LSM_AUDIT_DATA_INODE so a
> > separate CWD record is emitted later.
> >
> > Link: https://github.com/linux-audit/audit-kernel/issues/96
> 
> I don't have a problem with the patch, but it sure would be nice
> if you explained why these events "could use a CWD record".

(adding Richard Guy Briggs <rgb@redhat.com> which I should have been done earlier)

I would agree, adding "cwd=" field in the LSM record itself is simpler to me.

Unfortunately, all I can say for now is "The intent was a separate CWD record,
that is already defined" requirement from the ghak#96 issue.

Richard, could you, please, clarify since you've posted this requirement in
the ghak#96's description?
 
> > Signed-off-by: Vladis Dronov <vdronov@redhat.com>
> > ---
> > out-of-commit-message-note:
> >
> > Hello,
> > Honestly, I'm not sure about "if (!context->in_syscall)" check in
> > __audit_getcwd(). It was copied from __audit_getname() and I do
> > not quite understand why it is there and if __audit_getcwd() needs
> > it. If you have an idea on this, could you please, tell?
> >
> >  include/linux/audit.h |  9 ++++++++-
> >  kernel/auditsc.c      | 17 +++++++++++++++++
> >  security/lsm_audit.c  |  5 +++++
> >  3 files changed, 30 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index f9ceae57ca8d..b4306abc5891 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -268,7 +268,7 @@ extern void __audit_syscall_entry(int major, unsigned
> > long a0, unsigned long a1,
> >  extern void __audit_syscall_exit(int ret_success, long ret_value);
> >  extern struct filename *__audit_reusename(const __user char *uptr);
> >  extern void __audit_getname(struct filename *name);
> > -
> > +extern void __audit_getcwd(void);
> >  extern void __audit_inode(struct filename *name, const struct dentry
> >  *dentry,
> >  				unsigned int flags);
> >  extern void __audit_file(const struct file *);
> > @@ -327,6 +327,11 @@ static inline void audit_getname(struct filename
> > *name)
> >  	if (unlikely(!audit_dummy_context()))
> >  		__audit_getname(name);
> >  }
> > +static inline void audit_getcwd(void)
> > +{
> > +	if (unlikely(!audit_dummy_context()))
> > +		__audit_getcwd();
> > +}
> >  static inline void audit_inode(struct filename *name,
> >  				const struct dentry *dentry,
> >  				unsigned int aflags) {
> > @@ -545,6 +550,8 @@ static inline struct filename *audit_reusename(const
> > __user char *name)
> >  }
> >  static inline void audit_getname(struct filename *name)
> >  { }
> > +static inline void audit_getcwd(void)
> > +{ }
> >  static inline void __audit_inode(struct filename *name,
> >  					const struct dentry *dentry,
> >  					unsigned int flags)
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 814406a35db1..16316032ef9f 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -1890,6 +1890,23 @@ void __audit_getname(struct filename *name)
> >  		get_fs_pwd(current->fs, &context->pwd);
> >  }
> >  
> > +/**
> > + * __audit_getcwd - set a current working directory
> > + *
> > + * Set a current working directory of an audited process for this context.
> > + * Called from security/lsm_audit.c:dump_common_audit_data().
> > + */
> > +void __audit_getcwd(void)
> > +{
> > +	struct audit_context *context = audit_context();
> > +
> > +	if (!context->in_syscall)
> > +		return;
> > +
> > +	if (!context->pwd.dentry)
> > +		get_fs_pwd(current->fs, &context->pwd);
> > +}
> > +
> >  static inline int audit_copy_fcaps(struct audit_names *name,
> >  				   const struct dentry *dentry)
> >  {
> > diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> > index 2d2bf49016f4..7c555621c2bd 100644
> > --- a/security/lsm_audit.c
> > +++ b/security/lsm_audit.c
> > @@ -241,6 +241,7 @@ static void dump_common_audit_data(struct audit_buffer
> > *ab,
> >  			audit_log_untrustedstring(ab, inode->i_sb->s_id);
> >  			audit_log_format(ab, " ino=%lu", inode->i_ino);
> >  		}
> > +		audit_getcwd();
> >  		break;
> >  	}
> >  	case LSM_AUDIT_DATA_FILE: {
> > @@ -254,6 +255,7 @@ static void dump_common_audit_data(struct audit_buffer
> > *ab,
> >  			audit_log_untrustedstring(ab, inode->i_sb->s_id);
> >  			audit_log_format(ab, " ino=%lu", inode->i_ino);
> >  		}
> > +		audit_getcwd();
> >  		break;
> >  	}
> >  	case LSM_AUDIT_DATA_IOCTL_OP: {
> > @@ -269,6 +271,7 @@ static void dump_common_audit_data(struct audit_buffer
> > *ab,
> >  		}
> >  
> >  		audit_log_format(ab, " ioctlcmd=0x%hx", a->u.op->cmd);
> > +		audit_getcwd();
> >  		break;
> >  	}
> >  	case LSM_AUDIT_DATA_DENTRY: {
> > @@ -283,6 +286,7 @@ static void dump_common_audit_data(struct audit_buffer
> > *ab,
> >  			audit_log_untrustedstring(ab, inode->i_sb->s_id);
> >  			audit_log_format(ab, " ino=%lu", inode->i_ino);
> >  		}
> > +		audit_getcwd();
> >  		break;
> >  	}
> >  	case LSM_AUDIT_DATA_INODE: {
> > @@ -300,6 +304,7 @@ static void dump_common_audit_data(struct audit_buffer
> > *ab,
> >  		audit_log_format(ab, " dev=");
> >  		audit_log_untrustedstring(ab, inode->i_sb->s_id);
> >  		audit_log_format(ab, " ino=%lu", inode->i_ino);
> > +		audit_getcwd();
> >  		break;
> >  	}
> >  	case LSM_AUDIT_DATA_TASK: {

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

