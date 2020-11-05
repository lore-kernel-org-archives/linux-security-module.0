Return-Path: <SRS0=docv=EL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD09C55178
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Nov 2020 18:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B4A7206D9
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Nov 2020 18:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1zSVUmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgKESzn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 5 Nov 2020 13:55:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43963 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727017AbgKESzm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Nov 2020 13:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604602541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D1JX91vyX0RMOSkxWirey7PqVagR00j9ZCCAeF7MViU=;
        b=H1zSVUmHQISbVpxLwNwxkJuvuckObB/tqG4Ova0xgXWuZQUO3Y5nsLvz8jMhEGRnXpzL77
        BOOWh7FJj5NQADUOQNjiWQwuLxlrRXFFz8N8EFuNt0qP3qIqfRS8t+DhpcCKafVyX5bjIK
        u7fJavvPjpUQPb+H4CxAmYyclOuKdQ4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-lZXVbRD3OguhddGM90WYBA-1; Thu, 05 Nov 2020 13:55:36 -0500
X-MC-Unique: lZXVbRD3OguhddGM90WYBA-1
Received: by mail-ed1-f69.google.com with SMTP id bc27so886051edb.18
        for <linux-security-module@vger.kernel.org>; Thu, 05 Nov 2020 10:55:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1JX91vyX0RMOSkxWirey7PqVagR00j9ZCCAeF7MViU=;
        b=tjfrcMfcs2yqbfwPUr44zfy3JsLHJhYJmHoVZ43nbcXF3vEmvzvrrun8zKBIuok7Yh
         1pcv2sm9Xr0wjV2TrMKn1RKJU07YSE59RibKjC6MMeTRiRsEK6BoYxdTpcv/vfYdX2Fb
         azsWBtme90LP8OYTfpdjgIUurxNZr96dp5cHClO8bsoHTqF+b+LDi9MRBiTZD+Cgi6aY
         Od1BxLE4ZQjbIq5f1SIEq0PqXg2ZWfWMmGZ3On0qlKgcxt+cx2+uDR4lhhlM6Gz9+qhz
         LwjmXhiAIu+teW2dEI1ujgcYC8JkqNTM6wWsfM6R30pPx5LUGdrhisPKFO39J+6lOqTk
         G6Ng==
X-Gm-Message-State: AOAM5319z0ggPUGnJDE+t+i6iq6WtNxnR4r6JN7445YJVcmJTem7JUeF
        2dLuBPwY+6rUQ6Xw4GtYKyWSty3B+DjdjpBYr1Loy3yVZdc9PPzDBYXqQ8PWSka8XOAXOAkvpYu
        MZ26yzTO2NzEbbcLn1Eu2Vp3qeqRHvdKym8A/ZMKEF3u5we0DpeIF
X-Received: by 2002:a50:cc48:: with SMTP id n8mr4234056edi.137.1604602534871;
        Thu, 05 Nov 2020 10:55:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOXq6TzFUWqo6exDgAAPj905PARZ/K8l6nKjmXIQeFt7uFPr3bqyHlefLfvjruhGYqgEaSuddfh2+AsqQlahU=
X-Received: by 2002:a50:cc48:: with SMTP id n8mr4234039edi.137.1604602534585;
 Thu, 05 Nov 2020 10:55:34 -0800 (PST)
MIME-Version: 1.0
References: <20201105173328.2539-1-olga.kornievskaia@gmail.com> <20201105173328.2539-2-olga.kornievskaia@gmail.com>
In-Reply-To: <20201105173328.2539-2-olga.kornievskaia@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 5 Nov 2020 19:55:23 +0100
Message-ID: <CAFqZXNtjMEF0LO4vtEmcgwydbWfUS36d8g24J6C-NDXORYbEJg@mail.gmail.com>
Subject: Re: [PATCH 2/2] NFSv4.2: condition READDIR's mask for security label
 based on LSM state
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-nfs@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 5, 2020 at 6:33 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
>
> Currently, the client will always ask for security_labels if the server
> returns that it supports that feature regardless of any LSM modules
> (such as Selinux) enforcing security policy. This adds performance
> penalty to the READDIR operation.
>
> Instead, query the LSM module to find if anything is enabled and
> if not, then remove FATTR4_WORD2_SECURITY_LABEL from the bitmask.

Having spent some time staring at some of the NFS code very recently,
I can't help but suggest: Would it perhaps be enough to decide whether
to ask for labels based on (NFS_SB(dentry->d_sb)->caps &
NFS_CAP_SECURITY_LABEL)? It is set when mounting the FS iff some LSM
confirms via the security_sb_*_mnt_opts() hook that it wants the
filesystem to give it labels (or at least that's how I interpret the
cryptic name) [1]. It's just a shot in the dark, but it seems to fit
this use case.

[1] https://elixir.bootlin.com/linux/v5.10-rc2/source/fs/nfs/getroot.c#L148

>
> Suggested-by: Scott Mayhew <smayhew@redhat.com>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/nfs4proc.c       | 5 +++++
>  fs/nfs/nfs4xdr.c        | 3 ++-
>  include/linux/nfs_xdr.h | 1 +
>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 9e0ca9b2b210..774bc5e63ca7 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -55,6 +55,7 @@
>  #include <linux/utsname.h>
>  #include <linux/freezer.h>
>  #include <linux/iversion.h>
> +#include <linux/security.h>
>
>  #include "nfs4_fs.h"
>  #include "delegation.h"
> @@ -4968,6 +4969,7 @@ static int _nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
>                 .count = count,
>                 .bitmask = NFS_SERVER(d_inode(dentry))->attr_bitmask,
>                 .plus = plus,
> +               .labels = true,
>         };
>         struct nfs4_readdir_res res;
>         struct rpc_message msg = {
> @@ -4977,10 +4979,13 @@ static int _nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
>                 .rpc_cred = cred,
>         };
>         int                     status;
> +       int sec_flags = LSM_FQUERY_VFS_XATTRS;
>
>         dprintk("%s: dentry = %pd2, cookie = %Lu\n", __func__,
>                         dentry,
>                         (unsigned long long)cookie);
> +       if (!security_func_query_vfs(sec_flags))
> +               args.labels = false;
>         nfs4_setup_readdir(cookie, NFS_I(dir)->cookieverf, dentry, &args);
>         res.pgbase = args.pgbase;
>         status = nfs4_call_sync(NFS_SERVER(dir)->client, NFS_SERVER(dir), &msg, &args.seq_args, &res.seq_res, 0);
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index c6dbfcae7517..585d5b5cc3dc 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -1605,7 +1605,8 @@ static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg
>                         FATTR4_WORD1_OWNER_GROUP|FATTR4_WORD1_RAWDEV|
>                         FATTR4_WORD1_SPACE_USED|FATTR4_WORD1_TIME_ACCESS|
>                         FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY;
> -               attrs[2] |= FATTR4_WORD2_SECURITY_LABEL;
> +               if (readdir->labels)
> +                       attrs[2] |= FATTR4_WORD2_SECURITY_LABEL;
>                 dircount >>= 1;
>         }
>         /* Use mounted_on_fileid only if the server supports it */
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index d63cb862d58e..95f648b26525 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -1119,6 +1119,7 @@ struct nfs4_readdir_arg {
>         unsigned int                    pgbase; /* zero-copy data */
>         const u32 *                     bitmask;
>         bool                            plus;
> +       bool                            labels;
>  };
>
>  struct nfs4_readdir_res {
> --
> 2.18.2
>


-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

