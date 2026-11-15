Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794754078;
	b=4KD5cq/2CFAoRB0FaUa3olTjDPajZi3LVFpF9M2FYf8DAM+4UEtI3xk/5jwwwtJZvyRL
	 mKy1GvexOcvw0J0MxH2l3nqOuEErhH+nLQ4Rt5y9IZToqD8dT4Mbf4jUgDa2BbjZMHsOS
	 M4BxYh73xq+ET7PAWXcEE04F1RWcvK/Sqw9/cWobHt+PLxPcHjZlTfzy/UB+N3LgCh0yB
	 d7S7aBWpZEYtZRQxVZk0zIOFfIU/zlGYyROLDiCSjZu80hFqnbchdOYJV5GosgRGgyVTu
	 3XZy54amxp8X+CMxQKoE1ViINbSqHPbOtp3EP56/B/oXvGN+7qFN5P1paDS1psRoEow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=x7HykaAJlgnOpmpM8XJHQMzZjK2dm2wSOUdGIuC/Jng=;
	b=umCJmV0tptTxkqpkDivLqupNQ1wRdIMtN81QWOg35mzzM+ZPKLHdByYY0cqbdjfVAjAP
	 qQ0BC9MP01QXzZulZVbiUwaolTyCrHdQSQ6/lQU89XiUeajbh2tDpbiu7vCDURxDUYUKI
	 FuQFmnXS6S3AgdF0AM4Z11XASBOteMfNjq8kkE1Ri22fj4ZboJTagOGr4rbp93ueg//r9
	 M96QT419CKUBWVJ2BI3mjYPSjR3ocCU7NsW5QQNySayvJQ3+rn6lNe2Il/CssK8U/a3+c
	 n3jSaRzUK2IQR31SmkfJ747ABNyFHf7dxAW7PL3tUcPUPZosXE+6QrQKuuhASUvIiwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vdeJy6VC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F83F606A31D
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F83F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vdeJy6VC
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b56bbf8330so3508249a12.3
        for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 06:47:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794754076; cv=none;
        d=google.com; s=arc-20260327;
        b=nsv2UkhDjbpObAcSuKcW9TpityFTJygqj+sIi9gwUYIIgg5d/gBLSwEmaimWSnEFx/
         7A0MunIruZVGl4Qy16d8+WFPvOtzU8cGyGOOWcvDAo26bDpZEibFKSn8Rxny5denXzyN
         M/5cNJibpcmnfKJ35J7q2SYG2ZaT5Ka3oL+NaXtHd8Yt+fERBMaYRRRCcjrnC5K0iVlW
         fant+Mo+vRkg4fTRoeV6RUE1RNiUgBZYPKUNSJ9nu6EoNSlL1OJO9oxdURjCihWwcqby
         9FmMoVBiVeilAtb7Gh0B9Bh1sT1EpO3HMTpe/WcHTtxy2dgDO1jy6vWgS0zLyJIGCGb4
         arkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x7HykaAJlgnOpmpM8XJHQMzZjK2dm2wSOUdGIuC/Jng=;
        fh=6nVqP8aEYQ35EfJQakYGKUke6Iely4ZQEEF+MVm3bhY=;
        b=J3d+cnVhIpSUrsd1nhlY1xeFtZPlMbGngXzw38Yb76YEF7WYgvzLtl8aCcgcljSkfE
         PpkKzKycOaOTKiguNpB3wOoi/aLRiyEmomtmuxii6/A+vK+ILs4NXh4EWAaVLdlq3LIZ
         jN+r6ONESruWmPgvMiPfSC5ZWR/3zuNqb3/TEquE7JJUxeIezr3kyA3XptDylS827Cqx
         g2RRIGKFDoQKQmlBP6oY3g3x5Mfuk5kOmdjNIEbpYJ4nkP+K0KnZ7zXmvk+LXcB8lU0/
         5MNoiwT5a3jIFsLj0K0C90CvrQViTl+GD2916h9rKjnePXczATAdy+Z+DQ0z/Du8BK8M
         ufOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794754076; x=1795358876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x7HykaAJlgnOpmpM8XJHQMzZjK2dm2wSOUdGIuC/Jng=;
        b=vdeJy6VCk2IGRpnrLWlGo4pWLhKneS7IPoBk81bLTW0iD2g50lPI0We72sIkSM0SV6
         cyTbNZB4O3d6VzvDDG9DPV5xAXhxmw4YkAyPQvdWI1M8aVPLRajltXh2AQAOKJY1EPeA
         J/3fQzDOEdKdl4Og0NnAs1e+UKlTuJcD65e+vWcNglfpyVM0bRYj3j545Ccvj/p07kIf
         RJxqw4iAkOZDz6lvhqxGAdC4rSJXKnOPRkFB2PlSiergeTKJSozBYsIqbEfROUxsRiwA
         +nC6LR2BKa2t52tGscFSOG6fqqncSzV6SKT9uOygWHxo9fsmCNg/KFWBsER32dA/LqAU
         Q4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794754076; x=1795358876;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x7HykaAJlgnOpmpM8XJHQMzZjK2dm2wSOUdGIuC/Jng=;
        b=S8L41g8x+8W+csXG4DkYRv3OKRo/sTS0wUmrNc7xw5Xttplo6mJ2OUWjmnAikJyYU4
         Mv5zsOKH3WrRsuFt3fDMIekllPI0MPrdH6uZqeYyp2/xhGxfxtJDG9YE5qyoXkly1T77
         NIRSVfd3oVCaXO+PVH9ciZbsyqDbZsCuu4EPHGsKrNphEEWYjDioAvwcymZspJ13QXIg
         PYW+8ZTaSGWHxD+dLiGLS2waEK0dCazNWwZaDNQ8T0fRsV/LJEYjUEaOYuMO93XgG78o
         cBz8VgLzkeHHKI+Oy7HPmkREB6waJwOwa1+ZGvpGt2Z0zaKcyu9lCD2BhPcUBYNhKFs0
         2C2w==
X-Forwarded-Encrypted: i=1; AL+hErHt4y8b9bJETMGGZZsMwCoCM8fmTcFY2LPfU5abm2RTVQTLXtvhE/c5S/IkNOIRUGZv2rhogJoJz/vCNyCTlD36J8A5s50=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dn8Y9f5q5F4SlaMZqP9j7mf5+FXOgn563NzpQMmHnxzAz7bQW
	aiqfOqxmfABS/Y4nPCYIKF2VHozpO57Iu6E/rVNBPdAsNImCBqDFLLPEcdjV9PJaCwvQHS1cQE1
	OhWKKmlqb0s+Pq3palwJHB9jkQUl7i38=
X-Gm-Gg: AYBFou34mA4bTEnK0kNtSm88OCrBi6kbB2UJXhyJCaNZNbfyk5vxNAZFGuu7HR7TMA4
	zB87fSqKBSuG8CzpZp+2p6v2r4FwXpWGXSxuINpVz5NCm6VIbkvj7aAFJE8CJnNv9Ez7hlQFJL8
	HQXA2u85hXuX80uT0W7c4MxWVouQL5ZK4iFP+EC7yRdCSyuKUJxLHJdKendmOXpoEzO6RVvqj9q
	j53jfElGuDY5tiMriUu6F6hJUsRzD2/KyC5Q7syGFOoKb8Z0QtFDN9pIjKL074Kc8exb8gXRMVs
	/ktId8rQnbSVnlJ1tii62+vgvoYWNW51ERimibKy5ACbwhI32f2kL5iNUJiLNuL2k2TxWaP0h+y
	sErrKawN6LZa9etdELnJ+DqAv4RrRCSenOrfhIZA2uLmiv6VfBjjaOgsmD+uC7SKU8BLcYw==
X-Received: by 2002:a05:6402:1d4c:b0:6b7:e12e:7f1f with SMTP id
 4fb4d7f45d1cf-6b7e12e824fmr3426650a12.10.1794754076394; Sun, 15 Nov 2026
 06:47:56 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org> <20261115-work-ovl-d_real-v1-10-ca155efbcb2e@kernel.org>
In-Reply-To: <20261115-work-ovl-d_real-v1-10-ca155efbcb2e@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 15:47:45 +0100
X-Gm-Features: AclHuK_at8qVhKBNN0WXPGQ7F2lmyjSQgMjlfNE9nQtuQriTEXeBZE7dwGmSTD8
Message-ID: <CAOQ4uxggW+UifxBJDY8fAb+g5EWrsD+rELwXa1ngZ_5X_OZx0g@mail.gmail.com>
Subject: Re: [PATCH 10/13] ovl: return the error from the lazy lowerdata
 lookup in ovl_d_real()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Chris Down <chris@chrisdown.name>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 3:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> All callers have been converted to d_real_data_inode() and handle an
> error now. So return the error from ovl_verify_lowerdata() just like
> ovl_open() does. The lowerdata dentry missing after a successful
> ovl_verify_lowerdata() would be an overlayfs bug, so keep warning about
> that but return -EIO like ovl_open() does when it has no real path.
> D_REAL_METADATA never looks anything up and still can't fail.
>
> Update the comment in ovl_d_real() and the documentation of d_real() in
> dcache.h and vfs.rst accordingly.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo=
91QjJHH9T_Yw@mail.gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Nice!
Thanks for cleaning up this mess.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  Documentation/filesystems/vfs.rst |  6 ++++++
>  fs/overlayfs/super.c              | 17 +++++++++--------
>  include/linux/dcache.h            |  6 ++++++
>  3 files changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystem=
s/vfs.rst
> index 1824462a43711..6953f399672f3 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -1374,6 +1374,12 @@ defined:
>         for returning the real underlying dentry that refers to the inode
>         hosting the file's data or metadata respectively.
>
> +       For D_REAL_DATA the filesystem may have to look up the data first=
,
> +       e.g., for a file that was never opened.  If that fails an ERR_PTR=
()
> +       is returned and callers must handle it.  D_REAL_METADATA must not
> +       fail.  Most callers should use d_real_data_inode() or
> +       d_real_metadata_inode() instead of calling d_real() directly.
> +
>         For non-regular files, the 'dentry' argument is returned.
>
>  ``d_unalias_trylock``
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 1985b553a47b7..39d4d57dec230 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -42,7 +42,7 @@ static struct dentry *ovl_d_real(struct dentry *dentry,=
 enum d_real_type type)
>         }
>
>         if (!d_is_reg(dentry)) {
> -               /* d_real_inode() is only relevant for regular files */
> +               /* d_real() is only relevant for regular files */
>                 return dentry;
>         }
>
> @@ -57,17 +57,18 @@ static struct dentry *ovl_d_real(struct dentry *dentr=
y, enum d_real_type type)
>         }
>
>         /*
> -        * Best effort lazy lookup of lowerdata for D_REAL_DATA case to r=
eturn
> -        * the real lowerdata dentry. Callers may ask for files that were=
 never
> -        * opened, e.g. for uprobes or O_PATH files, so the lookup can fa=
il
> -        * here. Return the overlayfs dentry then.
> +        * Lazy lookup of lowerdata for the D_REAL_DATA case to return th=
e real
> +        * lowerdata dentry. Callers may ask for files that were never op=
ened,
> +        * e.g., for uprobes or O_PATH files, and the lookup or the verit=
y
> +        * validation can fail. Return the error then, just like ovl_open=
()
> +        * would. Callers of d_real() have to deal with that.
>          */
>         err =3D ovl_verify_lowerdata(dentry);
>         if (err)
> -               return dentry;
> +               return ERR_PTR(err);
>         lower =3D ovl_dentry_lowerdata(dentry);
> -       if (!lower)
> -               goto bug;
> +       if (WARN_ON_ONCE(!lower))
> +               return ERR_PTR(-EIO);
>
>  real_lower:
>         /* Handle recursion into stacked lower fs */
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 674bc50b81827..5b3b34d271bd0 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -638,7 +638,13 @@ static inline struct inode *d_backing_inode(const st=
ruct dentry *upper)
>   * If dentry is on a union/overlay, then return the underlying, real den=
try.
>   * Otherwise return the dentry itself.
>   *
> + * For D_REAL_DATA the union/overlay may have to look up the data first.=
 This
> + * can sleep and it can fail. D_REAL_METADATA never fails.
> + *
>   * See also: Documentation/filesystems/vfs.rst
> + *
> + * Return: The real dentry, or an ERR_PTR() for D_REAL_DATA if the data =
can't
> + * be resolved.
>   */
>  static inline struct dentry *d_real(struct dentry *dentry, enum d_real_t=
ype type)
>  {
>
> --
> 2.53.0
>
