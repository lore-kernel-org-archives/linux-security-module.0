Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794754132;
	b=44gl2VFgb/dShk0H6qt/39k3b0Zct6/ODfpchyjvqQCLSi8FGmM5chT0V9KVqSJx9uRq
	 Up/VzSl+VZR9G6xDqDZ4VIk/tkPh0DT2Io4O2qRQ65SXIooEjAAX9m4PT4g5qdZ1BK5c7
	 Qt49bap6Tc6WLAxJFYqmAeB/owke05GL9vlmKgOYnEaNw8PxbgT5pT6sLPQi9ZZGZNmMA
	 LwD25Lr/NW8IFGz1/1hKFzoVPVMvZ1p24S1UwUX9J37Lrm+uUvEOcahOoomRkVm44ZYLw
	 6RhjWtGkJlwCLfMQOezWoIvR3Pf6xeclj68vkjTPJYDT5yQqi2LAZhz5eJk1BxQxiYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=C4gZYNSTU3nUDa0BlNRCYypUaVksPX6JgKJOOi2udkU=;
	b=0lg+JN+6gYlsVM7ej8Y+KscjLeeABUy9FDs4GErLXXkfSOfe9V/6K4FIfmI0uYS3Y9Jn
	 dSh2wQSRAK/qKtExPqXLI5kl96wdt679zOqWC/U04gppVi6KJ3cOMxarvImsilng2OxQ2
	 9AMTRaTXAz7UW4jnXAbBa1Dc4v4pew8fOuik3w09CZsLInoIC1NxjZPLzulcai//97+Gr
	 NkAy7w1HbW9H7OSm/t5ZG9mqAjQuesK5fRxJxSwSKF5TrAkcFbQ0LWyNPqN7YiWAaEMYH
	 gEfsoB8qIx7PrOf9xw4HR0Zie9I30fLUleZol1Lql5XO+7PJLc4Yib4vnuICMAiBlHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="w5g/XQ3c";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716B1606A31F
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 716B1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w5g/XQ3c
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b587538a37so3898618a12.2
        for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 06:48:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794754131; cv=none;
        d=google.com; s=arc-20260327;
        b=YteVRHYT1iOO6FeRh/shWTp+fOxeOrHnfjOskITt6fNnh71IENzfdLQo49KIbYYNKt
         ejBDInLYFytzO18VDrkv0o/vzKePHdTZTrVjRHA7OF/yQbo3KTbwWyvRKCuOszlB0IeE
         Gb95I/ZxpK0KrWvQB8gbnZH1ZXUjAQRglChAqBntrq8ayBq+Ix5gLIQ3cHzVZDP0NoVT
         0wQdg9fSVO4/clqw3YVQnr2hlNfT2azyCuCUo4DDyCGMj/8x+CBc7OpnCbFOKU8dp9t0
         Ktjb5+BNl7RnGWaE7d9zv9DNnrzrP3zncWYHlr2Ez5IoS5uSIUgPiLe8QrJ8e8gzA40U
         W4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C4gZYNSTU3nUDa0BlNRCYypUaVksPX6JgKJOOi2udkU=;
        fh=Xkar+rfRS22zCiWvT0+O9qD89oRMAFz5liAj2TceJLc=;
        b=g/J5+cHsib1J0gXnkn8eKaK2UGYJVTj7KwSvtmY3RaW3Bov7EpE+L/VrxsPyI4kCI4
         28OIAq8In+HPaq78zxH7Paq+h4hpqL15c/jYHtc09zypyaA/zU1szpr0/WlqQs7WG1lH
         puf7UqqoHqRpuJxWSsBsAPrat86G1dYHlRlWoWYMzzurZvRHEI0CmfaYRJSh+6gLm/AR
         aqDFKIJ4hj/V3Fjo4VNoLCgEVKcTpeKvAzg04+WRXKUU742ots6IrUDgoQfbApop/jez
         KsyMuo1fffWnlz1JnpJIkXbm6c+nI/RV23MtYGhQqDpX8tgi7Vs+aRSgTE4/DMJg5kD1
         z3SQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794754131; x=1795358931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C4gZYNSTU3nUDa0BlNRCYypUaVksPX6JgKJOOi2udkU=;
        b=w5g/XQ3c9k+Vmzjr8H8faYY5EnV44gyfCeTqkUEnB7IDVxBorehzGxTmotRUcFMd2k
         yEd9UzOdm44dKGOB9vhvuqA14zDF0izirGlMHcIkPmvfAWV6oC7EWoZSr/n7pMgjOayy
         4XbbykfX2tOLXKQEY71fD4ubWMAf5smyh0PUCbn4ouKSDid+wdpti8tnvMNzC9U0omm7
         PfP/4oysMFjcZt/QSyQgeX6xWgKvlNh0WDaR4PRzqjFkBPghAucojPZwp0HxO1dsPk5w
         0TrSxGukXHJtQczzx+u36Zh+VEpUmtRmnvhCaIPp54UmNZzIkin7PEC6+n43usjPmyxQ
         Zqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794754131; x=1795358931;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C4gZYNSTU3nUDa0BlNRCYypUaVksPX6JgKJOOi2udkU=;
        b=XaVGIVKksuaQCXnQBDxsFbH8b6+qTmB7q1rc+DhI3fpp/qNic/xlbvq2jVA7Pan0f0
         WhWuE6HQPjJ0EEBr6iZrdAsyKiOjN2zmiiWf+HUzYMe7bfuEq2XHZElnBvqw3d0hB3D4
         rxrCfaeagKlMEzzTqBvk6GB02uMHkA8VGvYyabXK+M8SpjZhtqiGjX1um75CQR8VD/F2
         t6dFnKBF8xOs0lUzjLNpYmPIAy4rgHfH5caWx7151uGVDUytCCbJDEGCkgN1BGeDHJjn
         qE3FdUgvbSvK/W/5322u1F9Dxt67xGYw+gIOuHKP1hWjj6i56Yzn2eu2f2/+6CwcRBHr
         9Qsw==
X-Forwarded-Encrypted: i=1; AL+hErEq0oxAWnliO8DC/miTr8GhxILEeSXfytL91kyG/W+sqnVyMqrFr32YIjGNSb6/YmeN1067JO6nv/aADjuR+SZYG1lxLGs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/MEZCq7iMZ1n0osS/QfY2LRSLnS8c8Gp218zEf3WbFWRyZZegP
	83IfT4uAHzURc6KTBLlWak9fnPDCSfoLcnkyHYthwVMVTtUcrg8Uj2rVb3qRJQUo1ySqXajgKLi
	TpoRueBs2IFI7O++JOIS4FTi+fdFD9BU=
X-Gm-Gg: AYBFou1czHStqFatMWAhZ0yYDzEC0fISjgenmXZsQPJQEeqeDOuXUd8QIbKLfaIVDl1
	22YrDGPQXd8U36gQn/NSTOhWGkGbLMQHjoED48HaJgO4BKtQwE4or8rzccFg+RO+5qyNnTd/beo
	Lrh7BtobvUCxfXHtKPQrkP/joLIJK0jIEWKYK/GTfZyY/5TuIYdZO50rnP8Fct+MxJcIKEw/on6
	VULQ39CfduV7I+/aAusxFptrFKD5XXCWKr0aAvW7JNfVhp/CnBHwJyYRBFnkOwbrajfQlXn86tT
	LQ01cSoGdcqYUOHg0kEhObIM7wYOphppuzuu8819rRt3czZ8KznV4s2SsxkTfyX3jgEhqoxiKFl
	LAnJka+931QfNAZIFRRnf/sHAsb6xQJteQm4Ty+uTCe2yTBzc6Y718DuVTUkTlKLjCnTQ0w==
X-Received: by 2002:a05:6402:1944:b0:6b6:edd7:790c with SMTP id
 4fb4d7f45d1cf-6b7c0d2c969mr5932123a12.45.1794754130672; Sun, 15 Nov 2026
 06:48:50 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org> <20261115-work-ovl-d_real-v1-11-ca155efbcb2e@kernel.org>
In-Reply-To: <20261115-work-ovl-d_real-v1-11-ca155efbcb2e@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 15:48:39 +0100
X-Gm-Features: AclHuK_loWLpZnEsR5-ArAPNE_f3U8cZmm7GbEpqPveHBdFtxvcWfTtvtccYOKk
Message-ID: <CAOQ4uxgiwKsadtv1Me3ZkSsTawjNey3wDDWVAnx6U0+Oe+uoQg@mail.gmail.com>
Subject: Re: [PATCH 11/13] fs: remove d_real_inode()
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
> All callers have been converted to d_real_data_inode() or
> d_real_metadata_inode(). Remove d_real_inode() so that any user we
> missed, or one that gets added in another tree, fails to build instead
> of passing an ERR_PTR() from d_real() to d_inode().
>
> Add a porting.rst entry.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  Documentation/filesystems/porting.rst | 10 ++++++++++
>  include/linux/dcache.h                | 13 -------------
>  2 files changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesy=
stems/porting.rst
> index c38f5df755bb5..28a24b702f2a6 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1422,3 +1422,13 @@ helpers take a const struct mnt_idmap *. mnt_idmap=
() and file_mnt_idmap()
>  return one. The idmapping is immutable so nothing should have modified i=
t
>  anyway. References are taken and dropped via mnt_idmap_get() and
>  mnt_idmap_put() as before, both accept a const pointer.
> +
> +---
> +
> +**mandatory**
> +
> +d_real_inode() is gone. d_real() can fail for D_REAL_DATA now and return=
s an
> +ERR_PTR() then, e.g., when overlayfs can't look up the data of a metacop=
y file
> +in a data-only layer. Use d_real_data_inode(), which returns the inode h=
osting
> +the data or an ERR_PTR(), and handle the error. Use d_real_metadata_inod=
e() for
> +the inode hosting the metadata. That one never fails.
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 5b3b34d271bd0..2b15179e9baf9 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -654,19 +654,6 @@ static inline struct dentry *d_real(struct dentry *d=
entry, enum d_real_type type
>                 return dentry;
>  }
>
> -/**
> - * d_real_inode - Return the real inode hosting the data
> - * @dentry: The dentry to query
> - *
> - * If dentry is on a union/overlay, then return the underlying, real ino=
de.
> - * Otherwise return d_inode().
> - */
> -static inline struct inode *d_real_inode(const struct dentry *dentry)
> -{
> -       /* This usage of d_real() results in const dentry */
> -       return d_inode(d_real((struct dentry *) dentry, D_REAL_DATA));
> -}
> -
>  /**
>   * d_real_data_inode - Return the real inode hosting the data
>   * @dentry: The dentry to query
>
> --
> 2.53.0
>
