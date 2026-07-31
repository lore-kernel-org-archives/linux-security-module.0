Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD86E442B1E
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511855; cv=pass; b=QdILxv/oTdKA3onAq2gWUCT44rjuIXbkR3xAryEamhuYTVfMo132uet7zqp5n08ibl4sqB7qofco8uCpQMi+JegUkQn6AQZOvL34sLzdpN6/N7gEcc/VkwwmpEqBBP8I+LLpej8wWXIEiNmSQBYdxDBTqlNhA2/YCbAkeg+ugMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511855; c=relaxed/simple;
	bh=ewX5vll4eCT221KLiCyTQCA4KARdLxwkCYF4FuZzmvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bev1DAMh3QlUnKW7+7rkEndKBM1j+/5tKo+F4xVrqy4Doshcfn0nTCv0FrKMkiT8zMIcu6PSmLB6byTHt0S+kP62m/hK0f7CQMNa5W9ICQkUHkYKzxqWEQa5jR5KD/36t4xVow9nQAl772YGf2QCj/XJ8h3/frlPpDlV2RsihJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dv7almrz; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dv7almrz"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51bfe810293so5324951cf.1
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 08:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785511851; cv=none;
        d=google.com; s=arc-20260327;
        b=o05ke2N/BQ0eNQ0rYmfVvgazmqLpkXP/vJRReGxDgOKqRYaPHxD7kwZW2eZvTK1uW+
         Yw2CScPeRZkxH4/K7rMuROsJzmmGwOiLt0yyA5dgQdNylyKZfWafBLOT6Yv703VxpjP7
         5stIBQM/Cm1u12e5U2ubNeDzrAbuWA3r0N8300GCdUe3KPn1ashRa9SGLKCLFnbfnhxO
         4LPk4BQRVNyuoy2C0GvBL/J7A6zpuZPIdcFOoEjNEpTF3t0V7SqtJD8t3Q+U1+6BAPy/
         KAE/yCjLDW3pjBFlp4BRkYqnLjtbnfIotW675ddOGG8fSR3GtNSIALg0Ameebdc7mbJZ
         Xx+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ewX5vll4eCT221KLiCyTQCA4KARdLxwkCYF4FuZzmvE=;
        fh=AE30Dk9efssh1y84lLOnktdu6gjMjDTPjtCzjjSWYG8=;
        b=ZC7Lov81NgLNbbrqCB7wx4Y00zPq+nRDjG/zxzQicmW3ScOC5BcsDvTkHv/tptR9tf
         lSzpI5Ypj3v0HecD6iax+AVog0pEqhwzSplJzbY9Hzmgg5F7NyAgCfZiK2toU5wX7Vdq
         2RIUjBBhp1dF8nPCjhwZ37Gzd6pS4HEqdmazX7TaGuYNAc5jH+izMajBWKyttW4Kge3B
         XHMMO7LJSFXQmePMQLCuy+SkmNiEzYdIaqv1e/qrEdVSFQTfLHHgy5oJF+/UHSK1doml
         Em4qZ/3Z87EFVQqwBVZylY7Um8CpGBGUu8bVNlNgSstoxTv9g+xDDooKKbi4SEv9R9rg
         DYKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785511851; x=1786116651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ewX5vll4eCT221KLiCyTQCA4KARdLxwkCYF4FuZzmvE=;
        b=Dv7almrzLgInu2aUvUTgDuu+AvSYoQPoJXwtqMKfNk2NvNgNV0ChgtOEbKITkDLxY+
         IK3lol9An0jJKwGRheMIA+9coU1UPxmoAQXv745nA3ijvQYWSKJZRN8CRoniQeol38ty
         TMd53QOjEyExUV3Dj2NhzYMcIEB2SYh1p/oTzzwX2fZkKSSZpAtVpZs4neDvUFx3FpTD
         vXMdnAtoW/r+VnbMyBqM44EFfSx+s6qUJbqq9+5447JTkLT55aJd+QYldBMRk5bXcXUS
         vDUN4pPibTIVAwUfmZ6U2mv9dGMTQrLPcQD1aCC+5XDH/zI3oiiwu0b/0yey5Qx8xxjK
         0a5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511851; x=1786116651;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ewX5vll4eCT221KLiCyTQCA4KARdLxwkCYF4FuZzmvE=;
        b=EImOZwUDMYvmpgNXchkTqNqx2RLL3/Rt22P+sDn96vsz3QMjFwZZYTpZlyDwgc9f+X
         sXEwGESrOSfn0+hTYZDN5T82hlRmhh7mtu/cYDPd408I8ETwFmsuq6j9aSZs5aFthDdE
         J65UhT1lscq1TQtwhmjPKBpBuKL7xj3cNGKGNpv2HgXzZZaxZpI33lw3tY7d2+WcS7Ih
         S6vP/sMDj/nNf27sVH3c9BpxgNHjBhtinrh5jWShyXTEHzbkG2ygIiUrc7JGp2C6ryX7
         UDUYLnHzDuJYhGjV1xK/LqM0d3UYwxjWWPfs5jn03IvGOA1ACQJ/3TZcubUx2/1MZVV0
         k7DA==
X-Forwarded-Encrypted: i=1; AHgh+RqiVC7gYzMZY9b3rQhAdKBA6SsJZaaHCM05SK7IMtI85J1IK+YZVWOOX6BE6kibqixz7vDr01abMst10WpovUVwxCgQUpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLXMhGG3r6tY9N4fmeQw+TnXiRZ9//aM+NZxjZX7NePG1OshKs
	RyZ3eVEr0qMaCsPka8O4cAgLJRWH3MDhK1WP9WNJ7IfClIMJk7Dus0gK1lgZSrw/dVhShQ5PaKC
	FPaEMyWNHFUoBVAD3nJUgO4AjYdJdSWg=
X-Gm-Gg: AR+sD12cu5TCGBCVtr/XM++RCguXtZhAu+5IVyIwFjstfYOpgsZz94fr4JcS0q4T3fC
	M/PxcbBR3FhPAqg1eLD9HN2so9SPlWZT5wYXiNcofSNSdkvwU9p/E8PYcujvBu18BmNPmiT8IG1
	MtMF1NBH3N2VsqE1TYvKRr3OI3NNtHZwgy1mcQxiuf2Mjt59wARVCHkUzPkuDYtCfC1ZgbJfYZX
	sQGAMjX5dMAOhDKIf+2vcsUYcyNdlar6BDReQblC2EGqOXhGm452e4KCHOHE4SDDV+JXrehedPX
	qHVCvyaonyvvjDfgLtwOk1OErFYKCl8nXx/nexsq8WTI+Y+Hm5G5hciE6syjtV6RYoGUUjHbsZ0
	=
X-Received: by 2002:a05:622a:2590:b0:51a:8c79:a2d with SMTP id
 d75a77b69052e-52b56673ed7mr13843131cf.1.1785511851030; Fri, 31 Jul 2026
 08:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com> <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
In-Reply-To: <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Fri, 31 Jul 2026 11:30:39 -0400
X-Gm-Features: AUfX_mwCzstzsX_jENhs2p3EGP2HH7m68AkpKrdRcMR6AmexYou-kWEv9wNOVLk
Message-ID: <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Paul Moore <paul@paul-moore.com>
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

On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
>
> Okay, it looks like there was some confusion/misunderstanding.
>
> My understanding of Kumar's comments was that he was referring to the
> exisiting LSM related kfuncs that are located in fs/bpf_fs_kfuncs.c,
> not necessarily the new kfunc you are proposing in this patchset.
> Kumar is welcome to correct either one or both of us, if we read that
> wrong :)
>

Yes, after another reading, that does appear to be the case =3D).

We'll need v7 anyway to fix the ocfs-related UAF the bot found.

> However, regardless of Kumar's intent, speaking as the LSM maintainer,
> my stance on this is that the kfunc you are proposing must live in
> security/bpf_lsm_kfuncs.c to be acceptable.
>

Ack, will do this in v7.

The Landlock series currently up for discussion [1] is proposing
placing its kfuncs in a new kernel/bpf/bpf_lsm.c. Should these maybe
go there?

[1] https://lore.kernel.org/bpf/20260731022047.189137-1-utilityemal77@gmail=
.com/

> --
> paul-moore.com
