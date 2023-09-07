Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD5FEC873E
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Sep 2023 16:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjIGQLY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 Sep 2023 12:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbjIGQLC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 Sep 2023 12:11:02 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBF09EFA
        for <linux-security-module@vger.kernel.org>; Thu,  7 Sep 2023 09:07:05 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1c0db66af1bso8104015ad.2
        for <linux-security-module@vger.kernel.org>; Thu, 07 Sep 2023 09:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694102457; x=1694707257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPFmFtA9HH9evw2frRz9Ud3CX85+1w8DshCZu0M5cvI=;
        b=bHB+6Hwj8EB5mxZpCQ8jEtKCn+yMBnDRhwF1um/zjumulr9pXGD7kkfv6vmGxcpiKX
         IVenFSnjPHYe7KGzmAQ3AS4THkj8yAO7U41PYI8FPoFQcJIgQGpFc/s8/RuKoDtmtdI2
         rSroOfNZICbhYhbK+TDMsXE6KnuFptzsb7Opsz1Wvrn4Hq1K0xEn1SRUeWimPn5G1V1b
         EXFHgP9GgRAnN0EJu7vmnl3vLJN2uWpy6BHkC9UwgvLYLzOobP4aQNpcLZGc42Sx43T1
         TzGC60OqOz5GHshKDXJXxwHCJ8bS1FzY1Ew87NVnc95BrncGPj86V85EkWx36iJcL2ep
         Lr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694102457; x=1694707257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPFmFtA9HH9evw2frRz9Ud3CX85+1w8DshCZu0M5cvI=;
        b=Iuc1avtMcNx6hSF2dAJBqqWmrFMYfm6s0aKAB0oKFQrfr8LOMIBTdbp3ldO1WQQVoR
         jAMSY79lqAwpBl46WwSKVxb4QYRrovqZKPK6FDIXateG4WQzdR4Ibd/6cbN/rLqwkw8x
         PSM9O6nWTyXXHSygWR/Qw3gKrDEvp2ggg/ZHZXi7WR/xOXTg2ehAq5IMFCDRz5KiwigF
         9uYq+Eg5m4J9SARsJ94zEMTpeLq7gfJyLTyTY7ujA+3YxTv61XjX2I0ZYs+A8WRYcHmz
         90F8otq15wFuyZNude+ncTbTotWc+1kwy/xD6dBxsQNJiTIblVApn6BBiyTFkJno9S4m
         aNKA==
X-Gm-Message-State: AOJu0YxLckWb7KG0+fC0S3BfwL3C+z6o9BU9mqzWdHKDp+iqytn26jry
        7LyxUM9JHPoCvjN+/aeSYD3gc+pLCVTE38QVVTBu2CMJ6WmUESw=
X-Google-Smtp-Source: AGHT+IEXXpK1IgRaRwbQH/GiQGHD+POk8strud0/16z8Swy/D5DTl0hWL4ivTjqH7IUBgKBfJHVDcBvHZF0xaSnLKfw=
X-Received: by 2002:a25:aacd:0:b0:cf2:a664:688e with SMTP id
 t71-20020a25aacd000000b00cf2a664688emr21622816ybi.40.1694101373482; Thu, 07
 Sep 2023 08:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230828195802.135055-5-casey@schaufler-ca.com>
 <6bdfc1b73926b16fc4eea848f25275ed.paul@paul-moore.com> <fd1981c0-3f64-adb5-dece-a25494119992@schaufler-ca.com>
In-Reply-To: <fd1981c0-3f64-adb5-dece-a25494119992@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 7 Sep 2023 11:42:42 -0400
Message-ID: <CAHC9VhT-GVq1D-AKMv_R3uKNm_iDV8uA3pB1ky5ScBnEdoPuvg@mail.gmail.com>
Subject: Re: [PATCH v14 4/11] LSM: syscalls for current process attributes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 6, 2023 at 7:48=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 9/6/2023 4:22 PM, Paul Moore wrote:
> > On Aug 28, 2023 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Create a system call lsm_get_self_attr() to provide the security
> >> module maintained attributes of the current process.
> >> Create a system call lsm_set_self_attr() to set a security
> >> module maintained attribute of the current process.
> >> Historically these attributes have been exposed to user space via
> >> entries in procfs under /proc/self/attr.
> >>
> >> The attribute value is provided in a lsm_ctx structure. The structure
> >> identifies the size of the attribute, and the attribute value. The for=
mat
> >> of the attribute value is defined by the security module. A flags fiel=
d
> >> is included for LSM specific information. It is currently unused and m=
ust
> >> be 0. The total size of the data, including the lsm_ctx structure and =
any
> >> padding, is maintained as well.
> >>
> >> struct lsm_ctx {
> >>         __u64 id;
> >>         __u64 flags;
> >>         __u64 len;
> >>         __u64 ctx_len;
> >>         __u8 ctx[];
> >> };
> >>
> >> Two new LSM hooks are used to interface with the LSMs.
> >> security_getselfattr() collects the lsm_ctx values from the
> >> LSMs that support the hook, accounting for space requirements.
> >> security_setselfattr() identifies which LSM the attribute is
> >> intended for and passes it along.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> Reviewed-by: Kees Cook <keescook@chromium.org>
> >> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> >> Reviewed-by: John Johansen <john.johansen@canonical.com>
> >> ---
> >>  Documentation/userspace-api/lsm.rst |  70 +++++++++++++
> >>  include/linux/lsm_hook_defs.h       |   4 +
> >>  include/linux/lsm_hooks.h           |   1 +
> >>  include/linux/security.h            |  19 ++++
> >>  include/linux/syscalls.h            |   5 +
> >>  include/uapi/linux/lsm.h            |  36 +++++++
> >>  kernel/sys_ni.c                     |   2 +
> >>  security/Makefile                   |   1 +
> >>  security/lsm_syscalls.c             |  57 +++++++++++
> >>  security/security.c                 | 146 +++++++++++++++++++++++++++=
+
> >>  10 files changed, 341 insertions(+)
> >>  create mode 100644 Documentation/userspace-api/lsm.rst
> >>  create mode 100644 security/lsm_syscalls.c
> > ..
> >
> >> diff --git a/security/security.c b/security/security.c
> >> index 82253294069c..aa4ade1f71b9 100644
> >> --- a/security/security.c
> >> +++ b/security/security.c
> >> @@ -3798,6 +3798,152 @@ void security_d_instantiate(struct dentry *den=
try, struct inode *inode)
> >>  }
> >>  EXPORT_SYMBOL(security_d_instantiate);
> >>
> >> +/**
> >> + * security_getselfattr - Read an LSM attribute of the current proces=
s.
> >> + * @attr: which attribute to return
> >> + * @uctx: the user-space destination for the information, or NULL
> >> + * @size: pointer to the size of space available to receive the data
> >> + * @flags: special handling options. LSM_FLAG_SINGLE indicates that o=
nly
> >> + * attributes associated with the LSM identified in the passed @ctx b=
e
> >> + * reported.
> >> + *
> >> + * A NULL value for @uctx can be used to get both the number of attri=
butes
> >> + * and the size of the data.
> >> + *
> >> + * Returns the number of attributes found on success, negative value
> >> + * on error. @size is reset to the total size of the data.
> >> + * If @size is insufficient to contain the data -E2BIG is returned.
> >> + */
> >> +int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uc=
tx,
> >> +                     size_t __user *size, u32 flags)
> >> +{
> >> +    struct security_hook_list *hp;
> >> +    struct lsm_ctx lctx =3D { .id =3D LSM_ID_UNDEF, };
> >> +    u8 __user *base =3D (u8 __user *)uctx;
> >> +    size_t total =3D 0;
> >> +    size_t entrysize;
> >> +    size_t left;
> >> +    bool toobig =3D false;
> >> +    bool single =3D false;
> >> +    int count =3D 0;
> >> +    int rc;
> >> +
> >> +    if (attr =3D=3D LSM_ATTR_UNDEF)
> >> +            return -EINVAL;
> >> +    if (size =3D=3D NULL)
> >> +            return -EINVAL;
> >> +    if (get_user(left, size))
> >> +            return -EFAULT;
> >> +
> >> +    if (flags) {
> >> +            /*
> >> +             * Only flag supported is LSM_FLAG_SINGLE
> >> +             */
> >> +            if (flags & LSM_FLAG_SINGLE)
> >> +                    return -EINVAL;
> > Should this be something like the following?
> >
> >   if (flags & ~LSM_FLAG_SINGLE)
> >     return -EINVAL;
>
> Yes. I have a fix ready. There are a couple other touch-ups, too.

Great.  Since you are doing another revision, can you double check all
of the patch subject lines to ensure you don't have any double spaces?
 I see at least one, possibly two more.

--=20
paul-moore.com
