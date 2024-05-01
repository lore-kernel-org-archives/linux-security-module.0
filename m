Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3E8163A80
	for <linux-security-module@vger.kernel.org>; Wed,  1 May 2024 20:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596471; cv=none; b=XXvBdSTKq5FSOOE2EL7OgZoi99+aLvVc1SIsPGVZV4SRSGaK9I4oBUmy5visIIZ+kWmAwUrHWTuPu2VfVMqEwNgYIVqTsskc2jOB73J8Hrtw9ShrkvxliUzNQA20HL4LWISYeusAbB3G3cnxd4yzJat7+L0VVObyr7smjCIvUME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596471; c=relaxed/simple;
	bh=ra1d6k+dPLwUnrnNIckVGDJJ8lliajlQVTK90DkxH3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jpvo+Be/WtAndBmcAuJAiyhLmj7bBWIQTfzLRL+pamW3vErLmCtAmlq+ctY8VtbleZ+1g9a75IR+CzGvlDYDL9YcUQmnnCH6caht5r7WekgBO/AR68iEr233iBCZrs+9VlASSd+QZLB4OgRKI996WH69lnt2MOYdtHCt6Tozapc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gpgH3Rvt; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gpgH3Rvt"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61bed5ce32fso24361757b3.2
        for <linux-security-module@vger.kernel.org>; Wed, 01 May 2024 13:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714596468; x=1715201268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+PTRDKy8eCh7IoM5KV0mi1ceXwqoykRHY4lJtZB0kY=;
        b=gpgH3RvtZYGw+ehS9sDjZywyTGvxgtr+CsG/iYIp1RP2kH9I5ZGN4Iirt8M6IbLEDd
         bS0N+UYIhG6F/JmgoaA1EyvpyN7jV/5HCgLSVhOSbcgJqIP1RhEOHICKCUY/gbHVzta6
         nfw+cRGHAWNv/p5i2tsDwfk8Klj+48tJnTmK21WsKLMCcnIWDz6HCVEbX4NVX88Ps/fB
         oNPigxEi3/l14dujgguG9nykyLMMekTAuW9pyaRhQ5KMPIvVmYj8VIA5JHtxqhx7c8IR
         WRrNqZG4YPacFIV4AiN95uj8cBb94VRX9LK5BGKvSCOu5kMF+fb7ZLAm34Jmh1XvjFaR
         BDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714596468; x=1715201268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+PTRDKy8eCh7IoM5KV0mi1ceXwqoykRHY4lJtZB0kY=;
        b=gaYymAvOm6dm09wr6Zl3Sz1YR2GfrYQ6AjnENPfphxeHGW4uka40NUljU8LCupjHkJ
         nKX51y68uzPtbCoHSa2VcN+8na9DbjeO/oK1vsc1ppOGZS7zJ7L4zHgyKFwjWgIoqbzy
         3zLp9AD6Qh5xTShmQKZDY6Da8poAIcW+NDnq0JzKrFsE+jZQf7S2vjJlCMn+/jbuvjA/
         u1e0jbZV9sLY4T+38KcttxqVkOMZE3ZyV+fxdd/9Yh/UlEu4EaA9JmtyVGcd6qWduAYU
         OT+X3ACxmrTL5zEiTZW1K3LDHfx8rLa7iLJxioaWqm775ie7SD4l4XdGdKwIkhfd2n+k
         fOww==
X-Forwarded-Encrypted: i=1; AJvYcCU/NbcSVyO1hR6BmTxkPzJdOpmF4g65w7oxTEn5zao+NE0z3yYfkO3dWjW7X6/Ttjsl4ME7huecOdfCrMjBHtXaF4Xoly+d8Zdbv+L6NoYLmhcj7Nk6
X-Gm-Message-State: AOJu0YzkQ4RAuixWVlnyqzoVShmKfx6Atk08cBRzn/bppysYOHqSI/3U
	AZEFhq5i2uhgIzluPY0m40zSyz/YK9mg4n/SEq9PM9tBwDGd+kWX/jygXKjTUq2m7G8rzlB2FNV
	ZRcGPkuG7jzYsLEA6SZNg9EFk9P4BGMUx/3Pu
X-Google-Smtp-Source: AGHT+IHOwjK39aAkCf1U1a1zITPFDSZFgBnRkiLpnvhJSWgbMTwWHIaF/yZdq1CGwHLPTrZin8UvRonaWrA3BNBSiHg=
X-Received: by 2002:a05:690c:dc3:b0:61b:3356:a679 with SMTP id
 db3-20020a05690c0dc300b0061b3356a679mr69311ywb.17.1714596468387; Wed, 01 May
 2024 13:47:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429114636.123395-1-fuzhen5@huawei.com> <CAHC9VhTCFOCE0E-en3HnNkPVRumzWRPcrJMF-=dxke53dOv1Gg@mail.gmail.com>
In-Reply-To: <CAHC9VhTCFOCE0E-en3HnNkPVRumzWRPcrJMF-=dxke53dOv1Gg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 May 2024 16:47:37 -0400
Message-ID: <CAHC9VhT0=Useuop92s4J9CGNpXa54r4NYnY9DOTnGmoo0hNv5w@mail.gmail.com>
Subject: Re: [PATCH -next] lsm: fix default return value for inode_set(remove)xattr
To: felix <fuzhen5@huawei.com>, linux-security-module@vger.kernel.org
Cc: casey@schaufler-ca.com, roberto.sassu@huawei.com, stefanb@linux.ibm.com, 
	zohar@linux.ibm.com, kamrankhadijadj@gmail.com, andrii@kernel.org, 
	omosnace@redhat.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	xiujianfeng@huawei.com, wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 12:02=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Mon, Apr 29, 2024 at 7:47=E2=80=AFAM felix <fuzhen5@huawei.com> wrote:
> >
> > From: Felix Fu <fuzhen5@huawei.com>
> >
> > The return value of security_inode_set(remove)xattr should
> > be 1. If it return 0, cap_inode_setxattr would not be
> > executed when no lsm exist, which is not what we expected,
> > any user could set some security.* xattr for a file.
> >
> > Before commit 260017f31a8c ("lsm: use default hook return
> > value in call_int_hook()") was approved, this issue would
> > still happened when lsm only include bpf, because bpf_lsm_
> > inode_setxattr return 0 by default which cause cap_inode_set
> > xattr to be not executed.
> >
> > Fixes: 260017f31a8c ("lsm: use default hook return value in call_int_ho=
ok()")
> > Signed-off-by: Felix Fu <fuzhen5@huawei.com>
> > ---
> >  include/linux/lsm_hook_defs.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Adding the LSM list as that is the important list for this patch.

It's also worth noting the discussion below from earlier this year.  I
just spent a little bit of time working on a different solution which
I personally find more acceptable; I'm building a test kernel now,
assuming it works I'll post it as a RFC.

https://lore.kernel.org/linux-security-module/20240129133058.1627971-1-omos=
nace@redhat.com/

--=20
paul-moore.com
