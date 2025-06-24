Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4ED26CE03
	for <linux-security-module@vger.kernel.org>; Tue, 24 Jun 2025 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750780104; cv=none; b=Hjez0RIAReUWHZIHbAysB9dP2ogsMb7vTnvUGuNlmIbocQGDQDii6GainYPPyWQj/aKqxn9Y2J+WxG8GFpGNWWeY4O/IDbmO7h86JedQshFSvA1q/U4be8w2j3gOhO89lnvDkBAYOOVX6dRF80SPuai/Ifc6tuaLeko4n1Gr9Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750780104; c=relaxed/simple;
	bh=rqei9qBreDzFSqhyPq1Txm+8zbw8z7r1ww2hWrMKJh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQI/F10cNJ9+Q3KlkqnkTpAyxReoZH5pcOltBvclZm1b4tqfQt3kA9VUIiv0dn4SIhHaSlgzctPN3U+883ULzMcDBsRkZ2t836Bm/Qikl//I73YFqebqSqEAGhVCJciRwR0UkUKI4XGqSAP2e94Jg3MxC8eqrBjKVvPC7U+4szE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BhHSA2zl; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BhHSA2zl"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e81877c1ed6so4555387276.0
        for <linux-security-module@vger.kernel.org>; Tue, 24 Jun 2025 08:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750780101; x=1751384901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRkzc87wo0o4+fEkDS/rWH1wXvAXrHEHezkVOh191HE=;
        b=BhHSA2zlXOnHP1d+OBpbvliqHEb/R4UbyTKaLTYSLe5qun23JSomAs3HcV8dyuFrc4
         j/B+wiMipVBz5QTW0lzYvsF3iD6+x7IXyFMYxW0fk9A3cUnjBHfncBbAh3LzW++0G8Uq
         GI15R4dP6hQmvJdwLfBcMIX3CepUGLwhrFTZGBfU6whn68MS6JZPj8J+UtgJmQfTOVfb
         lE1Kur3f2QwWAuZL4HLzmvrdOra5JMqid01VXgCafnB67lXUwnbI7IpR1oAw50D2xpfL
         5NNPlUuQEPcplxs1q9JGWSlQrf4tHa9zwgRY5nQe+EWmOZ9+liZrstyaamJLYJQRN3B6
         0XHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750780101; x=1751384901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRkzc87wo0o4+fEkDS/rWH1wXvAXrHEHezkVOh191HE=;
        b=s1eWR+C2MHqs+6eXzU1IvL2H5SbokEwO70OBBBGXYnUSmqI9J+TLES8jGyT3hpEVaO
         cReKnoBkGTFsT3Uw6arGSxECOcsNyxt6ciG2ktXs3uunjZEvC5PKCOloZ2wpCx43Ld07
         784OKbz6/HXXZJRVTQUsm4pUtNcPUhdDhzGuXe5Ay2o3qhCDtCLeMFjqOAF4l0rRL/bi
         FDTl2cx3Z2Co9oWdLDLqD49WdZ7OcnusWGX4LZ/cM+pyp66wOiQua4eXGd8U2I6FtQdY
         wCM/6hxouDcfnUcfY71f4bdG3NwHZlGIaolB2RhArGhuobIxGht6nma81Ho4tQyvA7UL
         3XFw==
X-Forwarded-Encrypted: i=1; AJvYcCUyiCvfpMP1J5rIRTtu1OUxsk7n9Onwna0+hH79HtYjN8SgHH93RnH0G2jwsXuliR6A26X9N1xslEab8RxdehYsSMKn7pI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+N1fXoGel6ORaiLoBMjWIqov72+Im7FR4KM4HTjs1+FmcNM0m
	Nf9l5YgzRTIzayBy3fktCu8sn62TZmIfueTaTxmGcv2B4L31oDVjjibBWYFrO8YPNzK1oa7K69x
	wTnbBPHvNPRBAqgS4N1NTOWS+ZJFV/5b+H1jwocka
X-Gm-Gg: ASbGncv3xpgIIdRxoaKLiMLRRWtICyY0d5IvbPexaT/DyhqsKWLAuYrYsGXiAmrnsX+
	e3XLVbQIYYmRWWXuhhJtXsX9Ee20Z8U73kOxSXCCF/KqiZIHgGL+kVhuOT+kiCUNGzQTWMqu1f3
	skCk5J9UzM+6ASRQVhN7tGyg+8IyRg4TZ7SfODrd1yUAM=
X-Google-Smtp-Source: AGHT+IGCpAeeUvZuZrw41qBq6J0MfQKxEfqrEfdYhhQKITSwhrGmgEUBNlv5e3NpZvf1rvm31aCzNc2JqujqgB8FjeI=
X-Received: by 2002:a05:6902:1501:b0:e81:4f52:9983 with SMTP id
 3f1490d57ef6-e85f1e276e5mr4942310276.19.1750780101225; Tue, 24 Jun 2025
 08:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624014108.3686460-1-yuehaibing@huawei.com> <aFqZxu_Slzmux6jj@lei>
In-Reply-To: <aFqZxu_Slzmux6jj@lei>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Jun 2025 11:48:10 -0400
X-Gm-Features: Ac12FXyLFEZgUbk_F14XoflEPfnghAr6Ptvan38PrR4N4Rw4pEnI3vksc5gaw-o
Message-ID: <CAHC9VhQ50UM6LxnUT7PSrGKNdbuUFJmZQmir1HtrQg_C9j6x2Q@mail.gmail.com>
Subject: Re: [PATCH -next] security: Remove unused declaration cap_mmap_file()
To: sergeh@kernel.org
Cc: Yue Haibing <yuehaibing@huawei.com>, jmorris@namei.org, serge@hallyn.com, 
	casey@schaufler-ca.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 8:27=E2=80=AFAM <sergeh@kernel.org> wrote:
> On Tue, Jun 24, 2025 at 09:41:08AM +0800, Yue Haibing wrote:
> > Commit 3f4f1f8a1ab7 ("capabilities: remove cap_mmap_file()")
> > removed the implementation but leave declaration.
> >
> > Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>
> Hm, how did I not catch that?  Thanks.

At least you weren't the idiot who wrote the original patch ;)

I'll grab this for the LSM tree in a bit unless you want to take it.

> Reviewed-by: Serge Hallyn <serge@hallyn.com>
>
> > ---
> >  include/linux/security.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index dba349629229..e8d9f6069f0c 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -193,8 +193,6 @@ int cap_inode_getsecurity(struct mnt_idmap *idmap,
> >                         struct inode *inode, const char *name, void **b=
uffer,
> >                         bool alloc);
> >  extern int cap_mmap_addr(unsigned long addr);
> > -extern int cap_mmap_file(struct file *file, unsigned long reqprot,
> > -                      unsigned long prot, unsigned long flags);
> >  extern int cap_task_fix_setuid(struct cred *new, const struct cred *ol=
d, int flags);
> >  extern int cap_task_prctl(int option, unsigned long arg2, unsigned lon=
g arg3,
> >                         unsigned long arg4, unsigned long arg5);
> > --
> > 2.34.1

--=20
paul-moore.com
