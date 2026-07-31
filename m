Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0733F7AA8
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512004; cv=pass; b=eNxg7B9/sGvkSHmfQFR1RISffid+F9srM3czi+SVqj45jKGIyeWQ7ZwdvsnIwKzJcoMSahBaUnFyc9z0hBKva+KHUKiDAZHKy5B4TZKKJlnchucYnwhXrRxR+K/dpT9FXqHd8i4Oy75xHWiqj6LL8+XRqNClRs8W1emlXnuqbtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512004; c=relaxed/simple;
	bh=VuFNcnIpHKuBE9TqXe/JfxuxV9DEEfYcH5BhOui7Tz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGyF2pbEe9CUPZ76hkip0gTX325Kb+Kn+7VZkB4LjpSXIcI16SnfHm4ZvS7ZxC2OJL1b8UrVaaa7T5pbQt8tGKJuh7CJlpNSjqYrZ/3EWrLVCY2q3zuFqD0e8pJlI9JyBERydeEKdFMubaZ2tWR3ZiL5xqu2UZLCesAsJcmmLGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WlLS7APe; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WlLS7APe"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so757364a91.1
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 08:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785512001; cv=none;
        d=google.com; s=arc-20260327;
        b=ByG5Dg1bll7wIC2GqvDgYTrL8wYfERasId6qqQpMkJCGzfXNOWjAfwpkrEBxK4iR/u
         otWLaScvM6APDyxwW+K6anatUoOjgN9K7uGuQcWpA6GA2Ubde4TV6Nbvwo1RXgOcjlTw
         op6sj2kmdZLxqSTaMI8eLKkJrNRWY+2DC3tfi6Rr5r3027RTnbhjGr1TBDZcpgmoH0Mc
         Tkm9+hGQTAqI9zeHIj/T9JUELndXPc3HAPUnS/CLQW2HHgGbb6yaVxg5PPRawat8ZOFB
         O3qldtkNnPTrUF7Hd20gVseXYAdldSeC7TuHORFCEiPZOcBw4uj5+nASX/ux1H4FHoBN
         2F+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XnQ75jYzm8moYl46g1ePyO1gywKf+IeSpDPhO/wg5nE=;
        fh=6n+j86gdvCoG2Y8J87ipaitwiDhRyWGL0895k656rQQ=;
        b=WDBhncPrhkW3fPlEbseXunUzAqtpewJQTJ1LEWD4DQ3eWe/KIUFgwin1+V7ajm3oL/
         3QZQV8+E63t9xd83XBNaoM2lB21o3/QO1MsfF2ZNoNH3/Tky7TVmC/jDR4vpr+bVd6X8
         yGGf+E8bCc+eTADT7/rswIqOijjwGmPYcK1V5CttZShnLs3y6IV/24NYY+QVt50Jbhkc
         Cu1drpMCjXIcBsFKcWg0uaDVtTqqblBacQF9bKO7hD9rJuuzikeRbzQ/DRrdubaciz7Q
         sjYmieMLy43AkYK9y9bdjvQXQejEGecPHuSZQOWxVlRJ/hBVXodFguy1tGpBXtbLaLiC
         QTBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785512001; x=1786116801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XnQ75jYzm8moYl46g1ePyO1gywKf+IeSpDPhO/wg5nE=;
        b=WlLS7APeX/hA7NEpMaOEESuBOy9fewR9hgrNZhDweuEfsAh/zoyTHKGTJF9U9J5tq/
         s847tazcBtQqqpEIPCZXBYyQ3TC7humVlzydKPbO8qx9opWFdjz7TCnoMEGa4QIO2Wi+
         Ahj5xFgBiGOukwhXTPUjJYDHwXCGm1hXlbLknTbkVQvxbQqL2OkPbu3WWjJxOCfQoua4
         v0rgXyVwMwKBUiPTrtFyuoJ3JH1JQYPFRfSarLn5gtHHWLOZnhRsC/r1ro+0psVHAY3z
         /saiuR+VjYl9I0MSElkym7L/BAmicvjWjbB3CcOZUS1cwve44tpIhC2lftzsyegxt5Ww
         Z7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512001; x=1786116801;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XnQ75jYzm8moYl46g1ePyO1gywKf+IeSpDPhO/wg5nE=;
        b=dcVZjAFkV0f6aG5LEy4XqEj4j5gM334IQebYsysjGpp5mReSGPZS5h9UvXy2D4Iu04
         JA6cSpcfw8q/UkRfx2fu35ILZ+d+t/itA5AE9Y26TYJ+NSBaM/lEcFCHoLWuSXg3+taa
         L+fVrsn3wQoMcfyUnrj8CEV59DKkqvcBFMYNO/tZom2u6yt5lLugAo3SPrLZk7Cx9iy1
         MlzPSYdJymHfTMcuBB5vBYQ8woQVqESD9r6ibtMsjGsQ5xECnya1b0Qaon+vv63OhJqg
         VYNu0O7On7FnBePEj1eI2cCx49JLdjdlTRD6VLYer9tCilviFb2++sTr9jIDVIb7hLUN
         5B5Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr/2CxSuFVbmqfRWlBdCVqojRrFWUNfosBO4ofOtLonhjCgmQBJG+C/g38row472fz/m/LQ+9f//5VDOjY0J8G3kLcnM7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhYUfSITdkR7+VYuoOy2WEi6t04raAEikt2F1Yn0qsSd8RCuIP
	lF8X+eU9Qnm58lyF0KI++NYLir4QpdkfByU9g/zen1duZqDz1ZiTj1MxbJzBeQckeGPxlu3AauD
	ov2lLQ0XcOkUrSwrJ6U6kNxPVxGdoAsH6DR6C72pn
X-Gm-Gg: AR+sD11+Wu3PVwuiUD8UUQdz3Vbkae+WaQleUamqBkv8XnpABAv5DF0IzD7LH2R/nOW
	R12WzytqH+07V1EVoTKGHKu4/ZlXtXYpH2lPjC/3RiyQZGOmqWtYaWBRvG6ZyRhZw5N/BpM2W8/
	i24Htf6JYJMtYPc46ofDIVjc0pLboCKZVsRe1KBDfmGoHZNLqEU3VNdqlr3Z+KeOI6nv7n5zrQe
	QbwqDX+AXSzCuWmklcDApQD6ijYkpG1Vqs/JdSPEVAPSPAqcpraz+ubabflkAyDpAunD+guKpC/
	0Kd+FfZpefWppg8q+PC/j1Hm+A2zq9ykwEw63QWh0pSs
X-Received: by 2002:a17:90a:dfd0:b0:387:e0db:bc24 with SMTP id
 98e67ed59e1d1-38fbc5225dbmr287131a91.36.1785512001460; Fri, 31 Jul 2026
 08:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com> <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
In-Reply-To: <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 11:33:09 -0400
X-Gm-Features: AUfX_myWZz1m6PowWXy7WcdAAbaku2QnixOSUt9yTgIUfLpwiNvXahY7xKnDbwo
Message-ID: <CAHC9VhQXtV_dGt_b5oD_LFNOygfx=37u6P_S32xo3A5aHvnj-g@mail.gmail.com>
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

On Fri, Jul 31, 2026 at 11:30=E2=80=AFAM David Windsor <dwindsor@gmail.com>=
 wrote:
> On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> >
> > Okay, it looks like there was some confusion/misunderstanding.
> >
> > My understanding of Kumar's comments was that he was referring to the
> > exisiting LSM related kfuncs that are located in fs/bpf_fs_kfuncs.c,
> > not necessarily the new kfunc you are proposing in this patchset.
> > Kumar is welcome to correct either one or both of us, if we read that
> > wrong :)
> >
>
> Yes, after another reading, that does appear to be the case =3D).
>
> We'll need v7 anyway to fix the ocfs-related UAF the bot found.
>
> > However, regardless of Kumar's intent, speaking as the LSM maintainer,
> > my stance on this is that the kfunc you are proposing must live in
> > security/bpf_lsm_kfuncs.c to be acceptable.
> >
>
> Ack, will do this in v7.
>
> The Landlock series currently up for discussion [1] is proposing
> placing its kfuncs in a new kernel/bpf/bpf_lsm.c. Should these maybe
> go there?

Nope.  That patchset has its own issues, one of which is the location
of the kfuncs outside of security/; I simply haven't had the time to
review that in full and reply.

--=20
paul-moore.com
