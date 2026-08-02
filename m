Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C7C279DAF
	for <linux-security-module@vger.kernel.org>; Sun,  2 Aug 2026 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785682009; cv=pass; b=k2ktgn3cS5KkEdZb6g2RYmYYFXaRT5Oo6oXpA3OlSea2YEZquXrt/yXpiu0VGAQ0gpxru829Y2sdLTY2GIyI8j/pLxwOz8OF6EVIcYulUbSD7pWGGp2BJtkQbMfnLjgPSlvwPfQ4d/2c3UR1nrAOKDXHd7L7bMvvpNgi0IYl3Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785682009; c=relaxed/simple;
	bh=3unvZdJ58CLOkAcaen4xGd68kRpfBuVgdyrgLs/h+aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4OwTHnJ1kCingDNnbhC4k81pKyqhm0lTHBY49MnjVeetgGZzOWhhKe4VM7M3w5rVTtu3G4uJ7lCEdTAdZVzBdhN/rCT51zEm21aw4Kfqd7U9pJjmgZ5bj1B9YqQax/RzKPfPTro9QU8elL0+fQ208CUIXiszYmFGrCWs6XZOTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OHh8o+R/; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OHh8o+R/"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cca0c5799eso20566575ad.0
        for <linux-security-module@vger.kernel.org>; Sun, 02 Aug 2026 07:46:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785682007; cv=none;
        d=google.com; s=arc-20260327;
        b=TbX5bJ3HJB/Zt+FQvaB0254LIBYGaS/YUBcxFXiLUSDCG9IPAk5LLikKSuUnEtSwzm
         4b6UtU5NN06dhHcML+KhDXz0Ltwl791HFFgSZYfDxWrak+bT3sOWkaAWEtzMzhmScuhw
         YleCPDNfoizZ15Y4fAWE+A252kfZIy32W502wscJNQ/guh2cQqoMTeLKCXmq+6zm+G2B
         hg4WrVgbESI5rrpECFiO5j6i3gw4t0FmjFTULBFvjaU3NyZk7UkS5yBexlEg7yjTHOre
         qexCNXGoCPYGCWG+GHe/QEeh+Te0vsmt3HQZpYbKM12EwPjDbYsnfODE/o9cMk0AgokE
         bqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uVSDCq9XMkrzuk5PhsqP7Q4DHzK39AE8ZyylcX501n8=;
        fh=czP8LuXc/nfLRtlUCFnHZctmXoSGM76RcCUqo0kaI6M=;
        b=r+F55Ki0NthX9kBE9Gw6cH2fvhMreBsw69ZEu4ptO20blVWPwUiK4dBD3WJRBgNjpj
         DKTDESoLrRjHjhis36IRyI8JUCAeVMhblB8ufipjLQRCiw4mkF9U1tRwN4qOWh7YjAO1
         Dk60GVq8JX/PZSGbeLCAXbsKAi4A7hm96QQyBDwjsaJl7O4Tqpzyo/cv9BzSA0tmbM+2
         fsiJ3BYcROJ2mH7icg2MFTm0QqNVUYsmBdy9cIogWx62nxPqrHVOlIyWpMjouTMw7ku1
         qNn+oYg9niO48U8jwubvlZCAdGFRMbKd8Hd5L2XAsE4IHVYRT0MQXbEY9yB8zr53/meQ
         Av0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785682007; x=1786286807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uVSDCq9XMkrzuk5PhsqP7Q4DHzK39AE8ZyylcX501n8=;
        b=OHh8o+R/tCSle6ncNwe5Zl2ZTuRWkRzIVW5FRgDSu9sHRwcfWiw7vF3BdBCSpFujfQ
         iT6Q0XcNOPQB3QnTAA2NM0OjY2bob8+7mrMzP5QX0xUMkB6HheH18fW5MoiUvK+7OrBE
         L838tPiITkenCBRZ17LGUNM137tb5BQQiFgTagt+DXHI/y3TTENHznJK1bjVA8rf6wAv
         s3wLUbgloWCbz0Kz1ydBeXrzQnb2/LD4e7igtByLExt/fvjaBZk8Ch/zFrmu+NatX+2E
         GkQBz59t47FSYRIFEwDn9LBD66WAhJ2rHZPVJqw4wz6qd6ivtJ3WqRG3OTaWIMM590T1
         2YDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785682007; x=1786286807;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uVSDCq9XMkrzuk5PhsqP7Q4DHzK39AE8ZyylcX501n8=;
        b=ZXl7J6fbpFcCjjML34LsKhcHGzwgu9uPe0wT/2wHZPAj0w6HlKRMnXQiLur8KHXOyX
         qj7hr0lSaHZpsETyuR/h2Quxm2Y4Xeow7AXe8YQ9i6h3kQ5E2AK6ImbIvqP5pJGhqSiW
         ds4BG5OqKMIWJNbqnn8uIH4PaUA9p8ecU/mGuUe5h1Guwjf0h8lzD6jElUY8gqrpX0es
         ZQRRljJMs3ZIqcY7FwwELuLB0nPAOPBqF+bfc+U/9izDVPEA6KW+zJjiSyC3gyFCx8sS
         rlxigqMYRj714/TZ5l4tgV5UVncsYJTCrWhTz4AC/k/0HOafWMPFmKt1LRhZ0gX6zkey
         DKUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqy1vXtfp5IAA1Ocx+/zaHd07UTDqxUtzYJKVnhQLfgx5UhSd78RXKLWCREPVPc22ItjJ5KJnY4W2gyC7pxcwIDI0rmVv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4hg9HYz9yUA6HUBd1RQFlpGTDx1h5U4B7Wc0FeSvPB5RqNHIQ
	21ynxV6AD1n6Hw7QPlvdYKimr41eeJ3+UXXZ+vDg9QEe8pufnp155h7kikafWC/m1dO0LH5E8iR
	kQes7yZvufyBa2yknqPUmA8Rmjq1gtlyM5XRdk+Pc
X-Gm-Gg: AR+sD12d4+KyPJR8WuANqnKFza2Z+dkIJHwj+5pbMsgca9KIgbEo3uuDwBVvInlLfzu
	nPm0Y4C1OzEC+IVzNYQEO0BVXnQRNjrNxFbbKA6GDXuK3d7PdqULrd026r+OOZdZwrajUhhqLEC
	+pblIa1WE1DrhqUP5BILXeKr9/hZ6mG8y9L+rlr6e7b5YHzEcsoniKzkKN4hPP66aok3i/1nkD6
	qXr5tyGZDNoddFV49A5+JN8OlSORBztG3W0W92R/PffR7TEnNqg7UMDyBAprdOzjMlWAITj9MOd
	zKkfDYWx46sMnKEdEuUACWN0sO0ZmcP/70M5Rliq9673
X-Received: by 2002:a17:903:390c:b0:2ca:ce92:6e44 with SMTP id
 d9443c01a7336-2d05218984fmr66046745ad.8.1785682007361; Sun, 02 Aug 2026
 07:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
 <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com> <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
 <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com> <CAHC9VhRQWRKHi-hdtvSnYPD_dqgP7Q8RB_X4PEDLwPUe6EegYA@mail.gmail.com>
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com> <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
 <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com> <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>
 <DKD00NYVQQC9.OK8JEWHH1NUV@gmail.com> <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>
 <DKD17D5H7N95.2VI5IOQBNTHGX@gmail.com> <CAHC9VhQ24fp7_sy1=NiWkfzPLSM35ugSCOKDKxnm6H9W-pDa6Q@mail.gmail.com>
 <DKD2R5268G2C.TPLR4XMTZ91R@gmail.com> <CAHC9VhQNozNGH4o=8D6wxks4deZ2eVOHmxFK=fvjhkCC0JSCkw@mail.gmail.com>
 <DKD3I17NPS96.3G49BTZ4ZVUVV@gmail.com> <CAHC9VhQmb=v3-T5HZUzfr_me6S7bo6sX0Vs4nDFQZnMe+SQOMQ@mail.gmail.com>
 <CAEXv5_huGfd7u0tKW5Eq5bSH+rzkB=ThKOTLnfnxepqTmgcUPA@mail.gmail.com>
In-Reply-To: <CAEXv5_huGfd7u0tKW5Eq5bSH+rzkB=ThKOTLnfnxepqTmgcUPA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 2 Aug 2026 10:46:37 -0400
X-Gm-Features: AUfX_mwc3J6rwxlFv-87GN8bK5jLLOa8tHA5WdDBfhjyivOgLNhWYBAg0rZ3uGM
Message-ID: <CAHC9VhQxeNJ1U_cUX=4mdJT17jG2ZFY27YM2CXK8wcuRPQYtrQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, James Morris <jmorris@namei.org>, 
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

On Fri, Jul 31, 2026 at 7:11=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
> On Fri, Jul 31, 2026 at 6:23=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Fri, Jul 31, 2026 at 6:04=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > > On Fri Jul 31, 2026 at 11:49 PM CEST, Paul Moore wrote:
> > > > On Fri, Jul 31, 2026 at 5:29=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > > <memxor@gmail.com> wrote:
> > > >> On Fri Jul 31, 2026 at 10:48 PM CEST, Paul Moore wrote:
> > > >> > On Fri, Jul 31, 2026 at 4:16=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > >> > <memxor@gmail.com> wrote:
> > > >> >> On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
> > > >> >> > On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwive=
di
> > > >> >> > <memxor@gmail.com> wrote:
> > > >> >> >> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
> > > >> >> >> > On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dw=
ivedi
> > > >> >> >> > <memxor@gmail.com> wrote:
> > > >> >> >> >> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
> > > >> >> >> >> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya=
 Dwivedi
> > > >> >> >> >> > <memxor@gmail.com> wrote:
> > > >> >> >> >> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
> > > >> >> >> >> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Karti=
keya Dwivedi
> > > >> >> >> >> >> > <memxor@gmail.com> wrote:
> > > >> >> >> >> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wro=
te:
> > > >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Ka=
rtikeya Dwivedi
> > > >> >> >> >> >> >> > <memxor@gmail.com> wrote:
> > > >> >> >> >> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Winds=
or wrote:
> > > >> >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul =
Moore <paul@paul-moore.com> wrote:
> >
> > ...
> >
> > > As a consequence, everyone suffers because they first need to satisfy=
 your whims
> > > on how all code and kfuncs written thus far are wrong, and need to be=
 moved
> > > around ASAP, including the one being proposed.
> >
> > That's not a reasonble or truthful summary of things, I've only
> > requested that David locate his proposed kfunc in
> > security/bpf_lsm_kfuncs.c, I never suggested he move any others.
>
> Looking at what's left of the kfunc itself, it's basically nothing.
> Everything meaningful has been moved into security/ already.
>
> Aside from bpf dynptr ops, what's left is:
>
> if (!name__str)
>     return -EINVAL;
>
> if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX, sizeof(XATTR_BPF_LSM_SUFFIX)=
 - 1))
>     return -EPERM;
>
> if (!xattrs->xattrs)
>     return -EOPNOTSUPP;
>
> ... then a call to security_lsmxattr_add. Why not move this chunk into
> security_lsmxattr_add, and leave the remaining bits, which are pure
> bpf, in fs/ for now, and litigate the total placement of all of them
> once v7 lands?

Thanks David, but my comments and decision are based on the kfunc as a
whole, not necessarily how the work is divided between the kfunc and
the LSM hook it calls; shuffling bits of code between the two doesn't
change the character of the function.

--=20
paul-moore.com
