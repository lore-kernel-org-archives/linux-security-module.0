Return-Path: <SRS0=bjmC=2X=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5548C2D0DC
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Jan 2020 09:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA87B20866
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Jan 2020 09:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1lcNw39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgABJYR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Jan 2020 04:24:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44817 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727801AbgABJYR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Jan 2020 04:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577957055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w0yxgCj7x4pc9yERVbuHZQvzkjGsk0Z6IDVMvhJ9yVI=;
        b=K1lcNw39V3FKT70xpp+wJflGjETUYr7Ds2DSsEOsoPr/S07SeIev/8TziNIMzRJsPgUv50
        Swn53rjaow1Q4OVRcBrUSM3Ob9OBDJlegFrJ4IHgTvOAo8OrogWzNCthgSxWr81ZujkQFx
        bR8l3MTugh5b78SHFtwzn/ZDCaNMgqE=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-xiGlCO8OPnatpjAVnpMswA-1; Thu, 02 Jan 2020 04:24:11 -0500
Received: by mail-oi1-f197.google.com with SMTP id m127so6034363oig.19
        for <linux-security-module@vger.kernel.org>; Thu, 02 Jan 2020 01:24:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whuG/U+N6Y9+q8wwXL79LugSztFqSgC9RqV9U6CbBE8=;
        b=AAvFsMR/DRzENS44i9Tc/d6uCIckLVXol8bAVxYjgcevUl2dRlg2I83HyhTIaPpfWL
         GAdgQp5ivR5N1oovK+Ifr5Poqsn2fHrZa3EI5U7nbo0k20FLy1Z5apfIwxN38e/H2/A1
         MDMixDLqTP48D1u3Q8nG/vdJU4qFUemOF4k0mxIvBdfxAv+nEpehzMgTbzJi3ajQqrSn
         U385atE7KnLUwdAsJRKeM4p6sOG9djD+Tkug/mMk+Z+kSWrTGaeebVpCXDk37rkvyHP3
         FKMIjp8Q2+62M93Wha23Z4TM2MCZ0yd+Ip6FFSDcq81Q0tQNSxbv3icGb3Vyvkuolaxc
         nAZw==
X-Gm-Message-State: APjAAAXAXd1M+hTWKxG1VG0fNKxg5aArxYQzIX8BwI693K7mIdXf0l0d
        4m8i28CglMiDExdfJ5t067RhERUb2JD/zKYUvgEkDf+GzjY7fFoCgVHr6WlGmEezXw1AbHlbzqO
        7X8KqHcj4Jc2DWxQpTpVmm/pXk8RLNP7I5IaoUU8LPfbc64ee3Ge3
X-Received: by 2002:a9d:53c2:: with SMTP id i2mr85974353oth.43.1577957050407;
        Thu, 02 Jan 2020 01:24:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqx4FwVw8BLuEOhq7uQNRYWjqQsyh9Td+JLV88qLv70pVkNgHCS1qeHGRY4EY28Femd1Y2lEze0N7Uu7dO3pG9c=
X-Received: by 2002:a9d:53c2:: with SMTP id i2mr85974333oth.43.1577957050151;
 Thu, 02 Jan 2020 01:24:10 -0800 (PST)
MIME-Version: 1.0
References: <157678334821.158235.2125894638773393579.stgit@chester>
In-Reply-To: <157678334821.158235.2125894638773393579.stgit@chester>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 2 Jan 2020 10:23:59 +0100
Message-ID: <CAFqZXNvXuWx-kCJeZKOgx4NSesCvnC63kHf6-=_SrFLH4xubag@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: deprecate disabling SELinux and runtime
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
X-MC-Unique: xiGlCO8OPnatpjAVnpMswA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Dec 19, 2019 at 8:22 PM Paul Moore <paul@paul-moore.com> wrote:
> Deprecate the CONFIG_SECURITY_SELINUX_DISABLE functionality.  The
> code was originally developed to make it easier for Linux
> distributions to support architectures where adding parameters to the
> kernel command line was difficult.  Unfortunately, supporting runtime
> disable meant we had to make some security trade-offs when it came to
> the LSM hooks, as documented in the Kconfig help text:
>
>   NOTE: selecting this option will disable the '__ro_after_init'
>   kernel hardening feature for security hooks.   Please consider
>   using the selinux=3D0 boot parameter instead of enabling this
>   option.
>
> Fortunately it looks as if that the original motivation for the
> runtime disable functionality is gone, and Fedora/RHEL appears to be
> the only major distribution enabling this capability at build time
> so we are now taking steps to remove it entirely from the kernel.
> The first step is to mark the functionality as deprecated and print
> an error when it is used (what this patch is doing).  As Fedora/RHEL
> makes progress in transitioning the distribution away from runtime
> disable, we will introduce follow-up patches over several kernel
> releases which will block for increasing periods of time when the
> runtime disable is used.  Finally we will remove the option entirely
> once we believe all users have moved to the kernel cmdline approach.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Looks reasonable, informal ACK from me.

> ---
>  security/selinux/Kconfig     |    3 +++
>  security/selinux/selinuxfs.c |    6 ++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> index 996d35d950f7..580ac24c7aa1 100644
> --- a/security/selinux/Kconfig
> +++ b/security/selinux/Kconfig
> @@ -42,6 +42,9 @@ config SECURITY_SELINUX_DISABLE
>           using the selinux=3D0 boot parameter instead of enabling this
>           option.
>
> +         WARNING: this option is deprecated and will be removed in a fut=
ure
> +         kernel release.
> +
>           If you are unsure how to answer this question, answer N.
>
>  config SECURITY_SELINUX_DEVELOP
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 278417e67b4c..adbe2dd35202 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -281,6 +281,12 @@ static ssize_t sel_write_disable(struct file *file, =
const char __user *buf,
>         int new_value;
>         int enforcing;
>
> +       /* NOTE: we are now officially considering runtime disable as
> +        *       deprecated, and using it will become increasingly painfu=
l
> +        *       (e.g. sleeping/blocking) as we progress through future
> +        *       kernel releases until eventually it is removed */
> +       pr_err("SELinux:  Runtime disable is deprecated, use selinux=3D0 =
on the kernel cmdline.\n");
> +
>         if (count >=3D PAGE_SIZE)
>                 return -ENOMEM;
>
>

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

