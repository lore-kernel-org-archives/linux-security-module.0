Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CBC67C43
	for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2024 21:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400948; cv=none; b=tac+GeNdr4FNHt/B+4MrEoFnoqz85oFx40tvf5Wawgoiv5R/7UR+8XAzD/Rb/KqriRpfG14eSQDAnwwh3ExTHwe/i/9hwCjRC7GCiIDWbYvTFjFxQu1dqhVl21IXG/AxB0SVDrljHZDZt9+HeFWNp/7mXWa2Xp0d8XyNsxtGywM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400948; c=relaxed/simple;
	bh=QHxLO8nLmdB2FFuOUlYmLDoZj8rVmsKXpvRRaVtwG2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdGjfcD2acIGXccRnu6S1e63HeVK0NZ0pWnDvjMC2oEdPO4REedAigk8lz+k3W8gbDXyHTK+J/90cZQJp+H7UE6Y7uW49sFMPmi1lVni07B0phS38sEIx6mhouPXocxfOhQrXFTV1Wa4zPa4JG2ujFdHGwf2ne2orHk3B9woyjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dkn3IdHM; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dkn3IdHM"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60a15449303so47418927b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2024 14:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711400945; x=1712005745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dvd0vpxYIMiBSH18jkIvFIZ4BeCT3c9KLLiJ6njP8iM=;
        b=dkn3IdHM9CYWiXzQuu+XeeKMtsBEoASUcpfWl8wg64rXNLlGAccgQeeVLjvrI928nD
         9uF0kzNS5NK5EdGNusdgn8xtOG8jQHz9MgeKlC1sUG3++QyKPqMJ8FGI6eaVMxC85c3n
         E64H+zo/VwiCvObaki/G/ofRnR24eelRlggYgZ9BOeS10lFuYWiDmTXhJ5hzpAqer8e2
         uzFesXhoV0xjVZbofD6Y2IYPj6GSJmpNULuYFTYBzy1mnoJYxIfh3Hk9EduFsqzPC2EO
         c162xFU8XgPjt7Bu7bLH7U49H2kdb2ULT0RJhxw5RXpy12jeegdpo4vJxmWPbyO/eXJ4
         bKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711400945; x=1712005745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dvd0vpxYIMiBSH18jkIvFIZ4BeCT3c9KLLiJ6njP8iM=;
        b=Y/JcUZmZ4c87MFSUOBuIBLoFnFvcyVTHyil4qqAor9tfLGUNfwnp+PUEXTUb6luux3
         Ep63QhuUDz1I3OVVt392Kkk4XgNK5hkqwH66/vCT4B0kWzHXUB45Gt/+GVH5b78juvTi
         SS455C7CqalmrbyuED2Wbm8rHX2sHwvF6m24aEsAjm+wzEzoGrNYQZXGdOM9L8fPhPxn
         d5CIYAGRP4t6GqcdNVUw761jQXTplOi/0RDHFfjNfUrcBuZASVnYWkZ0A5xNA48DVFxH
         NJ+dgiyH/bZvTwM2m6mvi2ty1MaKPqs5uZbVGWejksB8KDR9pdP+xQWi2DeYNpgkGx/d
         Nbfg==
X-Gm-Message-State: AOJu0YwTbh5Tljo7Z1i7MHZ8hIpMJP+jAc5BJd4sJJHfVcOYafqJO+E1
	CiDXHyxMjTyXUM6ZB3omd9QlUyX6S9yIjt+6Lbn4drYCz1w6TCRKL3bPzRJSUyk0FmRGio6f5ZF
	mrxAz1CnCSLrEEnJQI6HlO5Oy62w49PVP0c7xjJqyv+6AkyiTOA==
X-Google-Smtp-Source: AGHT+IGcl2/fmqiWpRNTBm48ipQBfmzCwf0ObX4Vdg0bnCBNo56mMtRyh4MtOp2+w+W6FzxmaxUM6sEydtoyjnJZlOQ=
X-Received: by 2002:a0d:d694:0:b0:60a:16f:4c94 with SMTP id
 y142-20020a0dd694000000b0060a016f4c94mr6268919ywd.17.1711400945346; Mon, 25
 Mar 2024 14:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324223231.6249-1-greg@enjellic.com>
In-Reply-To: <20240324223231.6249-1-greg@enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 25 Mar 2024 17:08:54 -0400
Message-ID: <CAHC9VhQ22ef_o_OYue93RZfff70LPuOaCuN7Czv7HiEy346Svw@mail.gmail.com>
Subject: Re: [PATCH] Do not require attributes for security_inode_init_security.
To: Greg Wettstein <greg@enjellic.com>
Cc: linux-security-module@vger.kernel.org, roberto.sassu@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 6:33=E2=80=AFPM Greg Wettstein <greg@enjellic.com> =
wrote:
>
> The integration of the Integrity Measurement Architecture (IMA)
> into the LSM infrastructure introduced a conditional check that
> denies access to the security_inode_init_security() event handler
> if the LSM extended attribute 'blob' size is 0.
>
> This changes the previous behavior of this event handler and
> results in variable behavior of LSM's depending on the LSM boot
> configuration.
>
> Modify the function so that it removes the need for a non-zero
> extended attribute blob size and bypasses the memory allocation
> and freeing that is not needed if the LSM infrastructure is not
> using extended attributes.
>
> Use a break statement to exit the loop that is iterating over the
> defined handlers for this event if a halting error condition is
> generated by one of the invoked LSM handlers.  The checks for how
> to handle cleanup are executed at the end of the loop regardless
> of how the loop terminates.
>
> A two exit label strategy is implemented.  One of the exit
> labels is a target for the no attribute case while the second is
> the target for the case where memory allocated for processing of
> extended attributes needs to be freed.
>
> Signed-off-by: Greg Wettstein <greg@enjellic.com>
> ---
>  security/security.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index 7035ee35a393..a0b52b964688 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1717,10 +1717,7 @@ int security_inode_init_security(struct inode *ino=
de, struct inode *dir,
>         if (unlikely(IS_PRIVATE(inode)))
>                 return 0;
>
> -       if (!blob_sizes.lbs_xattr_count)
> -               return 0;
> -
> -       if (initxattrs) {
> +       if (blob_sizes.lbs_xattr_count && initxattrs) {
>                 /* Allocate +1 for EVM and +1 as terminator. */
>                 new_xattrs =3D kcalloc(blob_sizes.lbs_xattr_count + 2,
>                                      sizeof(*new_xattrs), GFP_NOFS);
> @@ -1733,7 +1730,7 @@ int security_inode_init_security(struct inode *inod=
e, struct inode *dir,
>                 ret =3D hp->hook.inode_init_security(inode, dir, qstr, ne=
w_xattrs,
>                                                   &xattr_count);
>                 if (ret && ret !=3D -EOPNOTSUPP)
> -                       goto out;
> +                       break;
>                 /*
>                  * As documented in lsm_hooks.h, -EOPNOTSUPP in this cont=
ext
>                  * means that the LSM is not willing to provide an xattr,=
 not
> @@ -1742,19 +1739,22 @@ int security_inode_init_security(struct inode *in=
ode, struct inode *dir,
>                  */
>         }
>
> -       /* If initxattrs() is NULL, xattr_count is zero, skip the call. *=
/
> -       if (!xattr_count)
> -               goto out;
> +       /* Skip xattr processing if no attributes are in use. */
> +       if (!blob_sizes.lbs_xattr_count)
> +               goto out2;
> +       /* No attrs or an LSM returned an actionable error code. */
> +       if (!xattr_count || (ret && ret !=3D -EOPNOTSUPP))
> +               goto out1;
>
>         ret =3D evm_inode_init_security(inode, dir, qstr, new_xattrs,
>                                       &xattr_count);
> -       if (ret)
> -               goto out;
> -       ret =3D initxattrs(inode, new_xattrs, fs_data);
> -out:
> +       if (!ret)
> +               ret =3D initxattrs(inode, new_xattrs, fs_data);
> + out1:
>         for (; xattr_count > 0; xattr_count--)
>                 kfree(new_xattrs[xattr_count - 1].value);
>         kfree(new_xattrs);
> + out2:
>         return (ret =3D=3D -EOPNOTSUPP) ? 0 : ret;
>  }
>  EXPORT_SYMBOL(security_inode_init_security);
> --
> 2.39.1

Looking at this quickly, why does something like the following not work?

[WARNING: copy-n-paste patch, likely whitespace damaged]

diff --git a/security/security.c b/security/security.c
index 7e118858b545..007ce438e636 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1712,10 +1712,7 @@ int security_inode_init_security(struct inode *inode=
, str
uct inode *dir,
       if (unlikely(IS_PRIVATE(inode)))
               return 0;

-       if (!blob_sizes.lbs_xattr_count)
-               return 0;
-
-       if (initxattrs) {
+       if (initxattrs && blob_sizes.lbs_xattr_count) {
               /* Allocate +1 as terminator. */
               new_xattrs =3D kcalloc(blob_sizes.lbs_xattr_count + 1,
                                    sizeof(*new_xattrs), GFP_NOFS);

--=20
paul-moore.com
