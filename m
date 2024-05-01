Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D620812F5A9
	for <linux-security-module@vger.kernel.org>; Wed,  1 May 2024 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579360; cv=none; b=jShKWp8P354vnmS8ijjf0PZ/tKIabBuqqm/30u/QCSQQPA8QKz+2QDhpbYQEatg48W68MRk+p9GlSxIn1FllSIu20X1RQneHtJ7MVhii4v58w+N9AvxdLbNQVuIzWFQmcF3wvDABxSFiFZ6uFU0jelO+iLytNv3Q5uTgrGiUH/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579360; c=relaxed/simple;
	bh=GIg0qqxY8IGXzYWeoYuXFScFx99CyexVXC/du3NFi4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dS7bbog0U+XSFWcy+UuK4hidJ3ih8qvbVtfz6j8rcKAb0OMLn2rBLNyw+bqS+C7kscQnyOADKfwI0V9SwVjBWp8YX3e6EzwqY/oqqPcIw4UWYjfdIyeU8gtq724MkZ8Ga0DcaxO4wG4WdcN1SANOiIjrcyzqn/PHM2KmPjkBv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=P1YcI/de; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="P1YcI/de"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-617e42a3f94so75015367b3.2
        for <linux-security-module@vger.kernel.org>; Wed, 01 May 2024 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714579357; x=1715184157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuTSwyg4Duor6hNxagd4NLjWGY2C1Kh2NptH/U7fxFA=;
        b=P1YcI/dem4TRC4j5+FEOVVmy1k7Gt8gMWaFa6DR/9SVJeRjicoNaEQCQVMzn1oNHBD
         z0Dp8S6oBaPuxUEkhALGNvzdBHH0JrqKliWUoscGUAzGRGUp/e081f7qNDokqODU7uv/
         kYmCgiUJ/pMKp8EMeba/cDuDhEmbM7IcK2Ijk1NaflsxBqhQkSSkOy4QsFQjIJKl9zzr
         yz9A6wXnlqR84x+ayJ3AJ5YbdrEovDtmmHXOfI8OH1HdK17+3dI2FZLiUlaEszLexg9w
         ITtukCHBAu5jgQMhxyIDEIfiHcRciLu3OuHmC5ZMHQXm87dEKE/YAtz77jH7reGs1ZXa
         o56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714579357; x=1715184157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuTSwyg4Duor6hNxagd4NLjWGY2C1Kh2NptH/U7fxFA=;
        b=ujOkShzr+q9/SnkyvH9A8cTiDHpB5flVXYnWY9swuGc3FKaipzQdBVVYiXTYUDfIpg
         qaRovjOE6UTlgxDKvopPfZqpKI93Nn5nG7kxXE7lK85SC0MnfovZ2oHHZMHtG3sGik+5
         9XSFTNbbubMSf2dKBTuP3Jnr3u42tKj4540WMUx3toyptsjFS+IDh1BxMSIAtJ86Bc2G
         UlTMdrhVgrXpV7KY4rhVrfPFKiWP6s7XHvYTPXOrn7qtpqsmnNBndNhlUNcCTgZPDSxi
         cbCToagWtqUziikEAkSIMWl47yAIFYEgHFuZ8pXjwfmlovIRI6xkgm7e93JTcxBlU9Jo
         EWhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS4TmqT2SbhQ7RWOZHzCf/0+BMcnz+s7pJ5IYqSmQIURovcl2iI2y8PpxS5vDihEaXbVM83T93fMTlbtPyvDnweqDXg2+6IRMjmKl8llXkGPEgFvrc
X-Gm-Message-State: AOJu0YwLCJJCDyQINS47d3vSNR67tH1dRxQvvzm7sHVdaWXIGh+F/ySE
	+gWGhzDUU/hYeofF0lkKQhJCbp7TodLCU1zKbbMqmwG353/xnWfJVvTcdEDIBDA9loLLoAnhe9H
	Axn0dZu18dFedCsV9Ayk7GKYxLI+K+j94HMj2
X-Google-Smtp-Source: AGHT+IH43KKvgq5pfK+zLJrg5zNUpKsT1cly8y7M41qu+UjyduRLJHzscgOqbVjTe8DbGTiF22UP57FY9wim6c+i6ZY=
X-Received: by 2002:a05:690c:3586:b0:61a:edf1:da55 with SMTP id
 fr6-20020a05690c358600b0061aedf1da55mr2907562ywb.47.1714579356786; Wed, 01
 May 2024 09:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429114636.123395-1-fuzhen5@huawei.com>
In-Reply-To: <20240429114636.123395-1-fuzhen5@huawei.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 May 2024 12:02:25 -0400
Message-ID: <CAHC9VhTCFOCE0E-en3HnNkPVRumzWRPcrJMF-=dxke53dOv1Gg@mail.gmail.com>
Subject: Re: [PATCH -next] lsm: fix default return value for inode_set(remove)xattr
To: felix <fuzhen5@huawei.com>, linux-security-module@vger.kernel.org
Cc: casey@schaufler-ca.com, roberto.sassu@huawei.com, stefanb@linux.ibm.com, 
	zohar@linux.ibm.com, kamrankhadijadj@gmail.com, andrii@kernel.org, 
	omosnace@redhat.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	xiujianfeng@huawei.com, wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 7:47=E2=80=AFAM felix <fuzhen5@huawei.com> wrote:
>
> From: Felix Fu <fuzhen5@huawei.com>
>
> The return value of security_inode_set(remove)xattr should
> be 1. If it return 0, cap_inode_setxattr would not be
> executed when no lsm exist, which is not what we expected,
> any user could set some security.* xattr for a file.
>
> Before commit 260017f31a8c ("lsm: use default hook return
> value in call_int_hook()") was approved, this issue would
> still happened when lsm only include bpf, because bpf_lsm_
> inode_setxattr return 0 by default which cause cap_inode_set
> xattr to be not executed.
>
> Fixes: 260017f31a8c ("lsm: use default hook return value in call_int_hook=
()")
> Signed-off-by: Felix Fu <fuzhen5@huawei.com>
> ---
>  include/linux/lsm_hook_defs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Adding the LSM list as that is the important list for this patch.  I'm
also just realizing we don't include lsm_hook_defs.h in the LSM
MAINTAINERS entry, I'll submit a patch for that shortly.

> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index f804b76cde44..9c768b954264 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -144,14 +144,14 @@ LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *i=
dmap, struct dentry *dentry,
>  LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr, struct mnt_idmap *idmap=
,
>          struct dentry *dentry, int ia_valid)
>  LSM_HOOK(int, 0, inode_getattr, const struct path *path)
> -LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
> +LSM_HOOK(int, 1, inode_setxattr, struct mnt_idmap *idmap,
>          struct dentry *dentry, const char *name, const void *value,
>          size_t size, int flags)
>  LSM_HOOK(void, LSM_RET_VOID, inode_post_setxattr, struct dentry *dentry,
>          const char *name, const void *value, size_t size, int flags)
>  LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name=
)
>  LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
> -LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
> +LSM_HOOK(int, 1, inode_removexattr, struct mnt_idmap *idmap,
>          struct dentry *dentry, const char *name)
>  LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dent=
ry,
>          const char *name)
> --
> 2.34.1

--=20
paul-moore.com
