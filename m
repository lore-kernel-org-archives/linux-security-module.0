Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC363AEF56
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511039; cv=pass; b=AEI8E4zszbcjoOwby3pdVdgMLm72Q60tksd8rYYtM4YO/+sSARALolFH4PnNtMrxIG+LGNOWKVXcIldH9Op3/SJtLV1xphZoFoKBQXJkuhHcf6SO41eTuQkq4EcVmV70k5TrZU8/282iF+G0BWEcvUkWb1qy9DLXY3L1ggigalI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511039; c=relaxed/simple;
	bh=MaagnOxntbuxGRXITbLMVGEEGsWlGpeYqyeDM+L3JQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8E+0ChGwmlDWjKvFwCGkFmSS/PSB/kYsKZ2KolZ/vEERALCySAVCjSSDlwbu0UMNIPXt4xualpJKCLpOMvw7fQOHYzLUdY75b9nKzpKdlzhksqviBlZtqN8O+F+5IbMxeBV4amuJV4bajsp7KPwNPa8v21VY9+aYfs42dgrpaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=C5URBVxJ; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="C5URBVxJ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so14409625ad.0
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 08:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785511036; cv=none;
        d=google.com; s=arc-20260327;
        b=lIHw66iueuo1V72vNG6ek2JeWkudmA2m+A2Ryka2swFtL1MREBzNWDIIrlExd7urEB
         XwleC55/v9JL2vXdcBAYhw4S6yhECs4UOqbk22o8yTq4URW2PMTzY8Fv8esCek8tgF43
         SPN64MYRriYnhj9vT51jdrkguXlXl9CSoIdDrSQxDE2i6I4V3plzP95UBgV0N2qRxqQy
         8cG+I2xIc9EDS32A02C6+8HqPlHP91yetFDiHwr1KInJUSRNBuyQVpMWgu7DPblMR2Uy
         hBNDSkFUxbVRN4OvdsTpR/6FKXXEi3j4nVJ1o4LcPrLsRiqN4bis1Q0H+0ORSYJ7ehLO
         yjqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MaagnOxntbuxGRXITbLMVGEEGsWlGpeYqyeDM+L3JQ0=;
        fh=EGT9jkK7VR2VjJNHJyFDak1T3pA5CGAjHGPAhps5660=;
        b=kEgZB664qyw41sPV3iYiJjzg1Algm3dIOjsmUWAXpZI5Dqt4PDOCz3IR2oeYqI+kY3
         AVEluoeLG3sSJSUKSPqvGwjF6nmPNKBEGx+HUV+siltuYUqPxyinO1Zjy6nuNUedGZcc
         bqQK+OtMhQNtdIJJwU7SHlp2B6FdVVJv7BQbWoxXUsP9UJAd9wQk7L1vbU07NIJHUDJh
         E+Fzuu6v0w4w+wO9G5DyQct+UnTAgnbDRwD5Gw+hjJmRP4Q6QsunH4bVr5A32llzUIq0
         KUx/lTyDqfiiKD8SXKi+0imM3jC+lWjjQwzEtb7pKj/ZSolrdyRhavn2vWEH2tEG3sJW
         NAgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785511036; x=1786115836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MaagnOxntbuxGRXITbLMVGEEGsWlGpeYqyeDM+L3JQ0=;
        b=C5URBVxJ5tERBLgnpI1F6Uk1I8wczA1DgsZx6wU5E29TDJD9OlexQVboj2ikm7m4Vo
         G+DVy29rCfY3z8DteBOBZrGBt0A6NzbErXM1yBfFloMA1eBgxFG47mHi78CJI7hh5MTS
         Kajg4htZS9wNxXJmoOulS7kZUqkRiOhQe3zOkrQpebhQd9lt9YZIF1/aHmfGmxtjhxGa
         rD/2gv7lce/d0vipnWSBIgY6IZW6n4Z1DEk+Iv3wdUrZyhATZdXzysAX6p/yE0ZA9PHy
         G4lifiyT6/Kvh4p2Q7Ogfwx4NUJ17PuYzIPlojAjBifCDzNPoMo0FU5DWkCLgTqj15n3
         ZXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511036; x=1786115836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MaagnOxntbuxGRXITbLMVGEEGsWlGpeYqyeDM+L3JQ0=;
        b=guOY89jbbncf/xA4n5VF+YYjM1IGdAjBeAkzVOch25Yn+FZefuVoQf+O1d9iMdjytZ
         Ii2O/7/UrsPuLBbR4LyUsd4gJX3BiUS7X5Rgk6zS7kyotik4mWzXEt2Nhvep+N8fY6Ys
         mkh5Ke6bv2P1e1/AVe5cgRNlc0Yp1g9o0eLFYGGGkIns3W1rlWx3FCDCHWNZCfpl+82v
         25e208nIUNHSUD02RTTzQINE3i+MKhmMiYnOENBe1feOGm1YLQ46HReUTq2CIt7eKL3b
         vswXoPYfVHFECPd73av9nJq+QpyLMiS7h/0sM3p7+2pQ4dXGXfCtI5DoqE6SgBHDbzmF
         nVvw==
X-Forwarded-Encrypted: i=1; AHgh+RqLz4XIc/IyZousG1c5bBG6iir+7So8YrYXLo2esXV3vl4KC8OfcRHj9MOGM+noKtRU+CkJ2Pw5HmFR2vSAStTnVGuRiGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQrnxCvFvbOEbdhNMq64O6AJV6urDvWIb+vdnQ4izuvaV3fLtE
	B0QStGtgjEqS4VOALMbJ2h4S3RdBbe54DYG63PiL10rJ5dmq8bar7S1tOxjCpv0eyQ0pWlDm9sD
	TCYwJQubYGaYaA7unjtmwNOqhPdKlbB+GRw3IBFoY
X-Gm-Gg: AR+sD13cT0bNGxWTV77Bme4Ef4he9MZ5RqsKGl/4G6EFcvPmkx/cYRdjyTbe2GzvoHZ
	bVLa8ynZMJ0aH9Rr2DCKuWDdm/hU6VA09fy5Tfc5zmsIe8ANnFvRHwLnrFbfGLi/a3GLM7vyzbk
	v0gR9IP73TAYSEBoy1kQQ0hkLooPbGnbLJBF7UjFDZDz+8XeXOVvID6d7D6g+dxEHs26/Jd+OI5
	VvRwx/zc88XHbVjxpgwHJSh+wGussYK+UmthZnytD538+5sJcwcurrCTrnw7Y4UnpMKV7b1DicQ
	UQwvaP5+EUbkIRl3Wa/J3QhReFDm2yhAWXN/00t6LWJy
X-Received: by 2002:a17:902:ecd1:b0:2ca:b89:7bcf with SMTP id
 d9443c01a7336-2d0523b96d8mr3879785ad.22.1785511036384; Fri, 31 Jul 2026
 08:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com> <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
In-Reply-To: <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 11:17:04 -0400
X-Gm-Features: AUfX_my_07XA5O156m3d-t8I3fv7r1HuUVA6nIPOKrM8LOdCX7kqs7sLBvl0mUM
Message-ID: <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 8:01=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
> On Thu, Jul 30, 2026 at 7:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > Based on our discussion in the v5 patchset, I was expecting to see
> > this under security/; did something happen, or was there some
> > confusion?
> >
>
> Nothing happened, perhaps some confusion. I was basing the placement
> off of Kumar's comment in v5:
>
> > I don't think we should do that in v6 though. What you're describing af=
fects all
> other xattr kfuncs. That's a broader discussion we should have separately=
 when
> folks are back from vacation, and more importantly involve FS folks where=
 the
> code currently lives. As you say yourself, the lines are blurry, xattrs a=
re as
> much a filesystem concept.
>
> My take on this was, leave it in fs/ for now and then litigate the
> placement of all of the fs-related kfuncs after bpf_init_inode_xattr
> lands.
>
> Happy to place this in security/ in v7, if that's preferred. Apologies
> if I misread the thread.

Okay, it looks like there was some confusion/misunderstanding.

My understanding of Kumar's comments was that he was referring to the
exisiting LSM related kfuncs that are located in fs/bpf_fs_kfuncs.c,
not necessarily the new kfunc you are proposing in this patchset.
Kumar is welcome to correct either one or both of us, if we read that
wrong :)

However, regardless of Kumar's intent, speaking as the LSM maintainer,
my stance on this is that the kfunc you are proposing must live in
security/bpf_lsm_kfuncs.c to be acceptable.

--=20
paul-moore.com
