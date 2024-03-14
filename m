Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ACB18E20
	for <linux-security-module@vger.kernel.org>; Thu, 14 Mar 2024 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710431371; cv=none; b=A2iKZnC76CpJJp9djS3p6Dxp4YzV5kubZRaNIRvxLZX5A0JrhMwj9uMe6TjyaPnWTA68poWC5+W8fOnTLuGkukUUF7/B46XgoLWhCsA9EYpcYRhU6oqOTEXa7NaRluR2JP+6sUAr0KzGUXC+ldccRrNaW56+Mkf6KZh/n/UjRV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710431371; c=relaxed/simple;
	bh=EnLejvn1yGLzbpO7xqXAOTpf/d/vM0Y9GRJqkpuQ+qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YvA6tBVdycwLgi0Stgw67Eco4PMgNgrmDmOG9uE3VWCD43UxA/8mdGgbbcgNqfjpU4w6RUikW4uMaHel33TvRf4WQ9IfrVYdVNVS5ZraPRfgfT/90MzAVDzKp6xCjrnp7RoNzNl+yu7Ta2GYUyNCXKqzQBM31q8t7Fli5307TR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=U74C0Lf/; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="U74C0Lf/"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso1090948276.1
        for <linux-security-module@vger.kernel.org>; Thu, 14 Mar 2024 08:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710431369; x=1711036169; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNOU8GKW7zz0PbL/9DVHX5LfQTI0aumrTWSRtVQSb74=;
        b=U74C0Lf/0+oQkynidIjrjv5VEsySV/ypixfl5rMsjO6ftgZzXrrmQbKBUbIpwbKYH8
         mPG9hiO1FZiVmw32K5+1pEcirNn1F/I8kV1pN/QI5V0J9ZE0idHHgBZ2CO/LUqVgY8HJ
         GxfPyqyGF6bBJCWiShnQOsJJrp2gaMItPOXiIpPbd9lHmuqXctHIj5tVrhkCSwZfKa3G
         r8MQjpYXJM7JvsNOdpee7vPP+mnEFNKJUTQ1gU5/uvEpD2LQ/y9aaikCdFzx3+XyP/RJ
         hOQLMo0Tt5gyRrBkL+YQGrzf5GkeppfRyAL4R5lpIyC3XYEh09XbxTwwOR+mn0W3vF2G
         0vXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710431369; x=1711036169;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNOU8GKW7zz0PbL/9DVHX5LfQTI0aumrTWSRtVQSb74=;
        b=DApQZWMiEfgRhsGEnQX7sH7kLgWRUZXAcYAWlm4T3t0Uay0KpJlzp8g9x7KYxGaJmU
         zLK5lrnH/BFJ0DBo0gRe1HswYqFb3XxX+dS3n5MOc1iBw+zGQBrLDxpk7QjkACHTGNnv
         iZxU/MrEhopn677krs3qLkpg0LoAT/p4DOOi+Z344uWg6rp9GSGiVxnIbIMOhkzTSEu6
         8vfNo5R8NdThh5qxioJvmhChZyeWJbQKgX8jtu0eFWXg30VpJ2vCmKslXdCrAxhOugFP
         y3aG84zlYM7yMyh7XnxgBr+gxQ0QlXMsUdwD7McFpU1CCebGJr8BpjiCrNT4H5sASnNT
         0upA==
X-Gm-Message-State: AOJu0YynE1noTGf5Byq1g+FUwoz47Gn2sA9seJEetjkt6aGMxKroeSOl
	B5OymaKNUimTnvlzgImAgvFiRsFrV8mBc8lidH6vEdW7rGcSlnL94yofQIqRZz2qbz0nZohbPTV
	vvTODRIuAOHysG1xDtVbMpXv1JR+NqugMzIIwSJJ9JxbW0S8=
X-Google-Smtp-Source: AGHT+IEONiT92AApBE4JPCp+KSGdUwK/+stoPbpfv/57SYB87IibSZ+yPbEBk+iISFVeNl/gtI2BhKgBUAUwuCbnnTg=
X-Received: by 2002:a25:a001:0:b0:dc6:b820:bb45 with SMTP id
 x1-20020a25a001000000b00dc6b820bb45mr1859612ybh.27.1710431368882; Thu, 14 Mar
 2024 08:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314022202.599471-2-paul@paul-moore.com>
In-Reply-To: <20240314022202.599471-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 Mar 2024 11:49:18 -0400
Message-ID: <CAHC9VhTV+daPgFpN_K1Sd-W6m6Vpuk0ZQXgYzymiyXsVYcmESw@mail.gmail.com>
Subject: Re: [PATCH] lsm: handle the NULL buffer case in lsm_fill_user_ctx()
To: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 10:22=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Passing a NULL buffer into the lsm_get_self_attr() syscall is a valid
> way to quickly determine the minimum size of the buffer needed to for
> the syscall to return all of the LSM attributes to the caller.
> Unfortunately we/I broke that behavior in commit d7cf3412a9f6
> ("lsm: consolidate buffer size handling into lsm_fill_user_ctx()")
> such that it returned an error to the caller; this patch restores the
> original desired behavior of using the NULL buffer as a quick way to
> correctly size the attribute buffer.
>
> Cc: stable@vger.kernel.org
> Fixes: d7cf3412a9f6 ("lsm: consolidate buffer size handling into lsm_fill=
_user_ctx()")
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/security.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Merged into lsm/stable-6.9, if anyone has any objections please make
them know soon.

> diff --git a/security/security.c b/security/security.c
> index 5b2e0a15377d..7e118858b545 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -780,7 +780,9 @@ static int lsm_superblock_alloc(struct super_block *s=
b)
>   * @id: LSM id
>   * @flags: LSM defined flags
>   *
> - * Fill all of the fields in a userspace lsm_ctx structure.
> + * Fill all of the fields in a userspace lsm_ctx structure.  If @uctx is=
 NULL
> + * simply calculate the required size to output via @utc_len and return
> + * success.
>   *
>   * Returns 0 on success, -E2BIG if userspace buffer is not large enough,
>   * -EFAULT on a copyout error, -ENOMEM if memory can't be allocated.
> @@ -799,6 +801,10 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u=
32 *uctx_len,
>                 goto out;
>         }
>
> +       /* no buffer - return success/0 and set @uctx_len to the req size=
 */
> +       if (!uctx)
> +               goto out;
> +
>         nctx =3D kzalloc(nctx_len, GFP_KERNEL);
>         if (nctx =3D=3D NULL) {
>                 rc =3D -ENOMEM;
> --
> 2.44.0

--=20
paul-moore.com
