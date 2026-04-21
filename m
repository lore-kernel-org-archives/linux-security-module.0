Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3AC37AA9E
	for <linux-security-module@vger.kernel.org>; Tue, 21 Apr 2026 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776812914; cv=pass; b=EVcdJxAZXxHzaakjXaKn5N2cCz7tnOyVuLx2nnLLuF4aAgrOJmFiHL1tjXK5m4GK5vUi0LWsVrKTvDte/W1qhzmxGp2Z3BHYQjmxVR1Hg0sYfMjsiXecnCY/MUQxU6Y0S+mTdmaBmT+WAkSYf2Armyk2MGup7iLQGeCQc1g02gY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776812914; c=relaxed/simple;
	bh=TR8FfcO11p7vVa6RPRWvJwht4gBSEvxOdxbVlJmTMFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9gaGZMZUowD9ckpjfCG8TSfrR1R4KzAJqF+Fa2Lbrb2uOC5YWeuZy3OYc4LBWzyZTzD6kJ55SdMZ7IOaJY0Y+PtRl3pQG0U5MDkpkFvRAPIu9wDl2u5Zq+tnGaxrxf7X29zk/7dVLhvpc83I8YgBOibAyApVUFpxMgoKLPFFcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8ISN6my; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8ISN6my"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso27050405e9.2
        for <linux-security-module@vger.kernel.org>; Tue, 21 Apr 2026 16:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776812911; cv=none;
        d=google.com; s=arc-20240605;
        b=L2EVLEj3ZgGEqBmgfyrf2lYnWrX942NbRSDmf9sM6WM0UPOazE2NI1qtXpTolViphv
         qdv/jfM/nXeyQ61ga5KYrMfZgrfJhZxceXzIT5wstUPHElJZemt5FQI0WHmzEl7YIacA
         brxm8k7UV874KhwFzchOOacq5rYNvXGYCI4klKFNeKpPQPIXUGLyremFVyv6WjrYaUvy
         pz5N8GWMTDueiZRyKoAtmg74E0NeEFilfugGQsc18uWqzOVPs3TvIFxX7iD/mka3O+fG
         PVOTSK80cZhjwaYErLicFAw7rUkno9r75tnm8CYVFgme/eGCDcAUp1XY5ZbRXANgUdvT
         EsFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TR8FfcO11p7vVa6RPRWvJwht4gBSEvxOdxbVlJmTMFY=;
        fh=Daujsx4o1nxm8C/HWOTTV7r70L7byWCAHnx9C8gcXpw=;
        b=ZqWonEXB+VciOpYYsO3YmmsDKA5Iag8fVAciF+aj+dBDxSg3ChMJ5l8NeKuewoUx3Y
         WofZH+uNN8Bh0seWMDKRvjmN2lxFDD22Y944hGDpBxm8E2ClqeStOitoXpy6Zi97mz3Q
         TUCcUsaXJ+5tpP2u4QEYf5WsJivIlJ8E97JVc63TvlvvzdlsrLNFktBq/52WMCY/AElP
         6KOZOHjc4t42OxtZSAjE/IPYvlzc/4LQCX67AYfU+4BSaI3mSkEvCCzuUVEacvxnZRFH
         EcUsf/AhuTk4MwWx9eAB6lL8tcMovtDsgMpL83g5Jg4Km14fUJ3u7nbNMioaqTb59qcS
         L7Nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776812911; x=1777417711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TR8FfcO11p7vVa6RPRWvJwht4gBSEvxOdxbVlJmTMFY=;
        b=f8ISN6myN0HouaGClnTTEmtYdTHVXREC81ZsCdvw8OzsjdvhMDCIl/pHWuaWRc6yj7
         s8+QDhNUEOIRUrGGJPo4iXX+fXbI8ejZuYp6PAdrgZ8SCp/e8VyTkRt3kOChA0T7Ri3n
         JaJ4ay+KYNopVNKSHQxonn+n1eNDEjkSMxuvfy1eaDoWgO0tOwIegQO5Hs+UTIznTXMZ
         28iTByKLIpXNg/sfsHODU1wmZbBgJUfNVtH2u3+nU9aFevpzW1MEO6M+O1pJCAv7BqUh
         gkn4OBsbu30PqRPufkTbVSc5qXpWAkm6E3cZU6Gc3LcpcNS2EwMJHtnllscyw9Uwe4GL
         kr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776812911; x=1777417711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TR8FfcO11p7vVa6RPRWvJwht4gBSEvxOdxbVlJmTMFY=;
        b=ZDpBiOeQe/+MGEHcOm+E5Nd9xn0bWRJ9zChspwX8S+C5f/Yo6mhtKih/dnvBEovkKQ
         rnsEIqq6u0eS41+KgZRSLOBLMU5ov8BhvnAQFuiAhmWh/kKwZEAq8vp3DUGXjV2UPX6S
         DA/8lLToEOg2ywbTyIrNasrmn0zFoxZ+yZf6gRJsmKpccbl6FCLwNiER1IzYCuDoqLic
         cm7OWzXy2qCRxc9uRDMR19wUduYsr/5ppt92swdUB+Sn1jFKuRU4kz21i6tOgGgmHLnL
         jqRqbsn0KALrchUrIEC/u5luDfO9pR7Nw74wnlqJxT4nhMAM835tYaB4S3XVnb8dt0vo
         MgrA==
X-Forwarded-Encrypted: i=1; AFNElJ/aIvLkzPmq8OlILBVAao8801m40LvhetTMfwJ6ymFR7Qmv8BquZCHOvhXsAWe4csmd9si8sba3tumtdgfHQ89eztIGeEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFacAkyojdjZzqGgp58xouSWPj6bO9CgzsCiRi2uSz/2IZCrxO
	RS0NgBh5vioLAViDp5ijsnIKcPZp2FfSqgJovKykaCAXDsp1yaKJ9fqgPunvsXqJReP/r5KiTnl
	7mxlUMlDfihcHVevHiLMor8QMBRy1krU=
X-Gm-Gg: AeBDieu96l42h2MnWB8YSIdejtolhk0EwEJd2fvu1OTvI/34zFMTP0NxaheLLZZDYhO
	AJbC6rlbBCyDsLrJ0KZUwBFYdtrnKyg+H/bq2hQK15VDsUrZGb7+Xby2yTHG7VOdecXJeTqA4hO
	m+KVKCgiGfcpqJgtb0xMQsEJ/tD2goigGCh6GQBtJ3F/fbgsdTFRW31KcFJ9dLXGe7H+dcOpkc3
	+h2fJWQO4M+2vFt9Tz6baW+XfcbA1XGAcpzgy196SPbxMhMu5EceYjYEoFBIvEHDDYqeoG0gObK
	/g3c4Dn5RIR+wp67XLlvj+dCSjfqqqP6vQL59AyU8f9CRyWyNuiAJASJcVVVrLCF8j1yvOms7v7
	8J0Bl0RDjo5Tn9q7MY2KBtmu2tzT/klzauRb+
X-Received: by 2002:a05:600c:a314:b0:48a:58aa:523 with SMTP id
 5b1f17b1804b1-48a58aa059emr27059935e9.31.1776812911066; Tue, 21 Apr 2026
 16:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <aefnIw1Tx_2r5nkS@CMGLRV3> <CAADnVQJQxa+fHM9X8COc60ZMcxF0DMhWbtArg_gPynpbbg55TQ@mail.gmail.com>
 <CAHC9VhSo-M1wK2s2P0B+2F0pJqNguW7Kj-g63anp1xCMSBLa6Q@mail.gmail.com>
 <CAADnVQL33TOWFmxcWod3BCgmMXSQ=cEp6NCcxgQaJL0C7+Z9zA@mail.gmail.com> <CAHC9VhSKvC+p5j5Pe1YKB-=vRkRA81K3kp97Q6-H5K+kvYa0AQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSKvC+p5j5Pe1YKB-=vRkRA81K3kp97Q6-H5K+kvYa0AQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Apr 2026 16:08:19 -0700
X-Gm-Features: AQROBzCAY_2lHhQ1prWwPyLIfmaKNZadZdFGYpecw-J2REDrg4GAqC8BWUzx63I
Message-ID: <CAADnVQJBOk8w89kj95M3GH-eFdC7njZt=zMEU=skB-DTb3k-bw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF LSM
 programs via BPF kfuncs
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Frederick Lawler <fred@cloudflare.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, audit@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 3:50=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Apr 21, 2026 at 6:15=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Tue, Apr 21, 2026 at 3:10=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > > It's still Nack.
> > >
> > > Based solely on the diffstat and a quick look, this appears to be an
> > > LSM patchset, not necessarily a BPF patchset; yes, there are kfuncs,
> > > but they are LSM/audit kfuncs and not core BPF functionality.
> > > Regardless, I want to see how the LSS presentation is received before
> > > worrying about this too much, but your NACK has been noted.
> >
> > Paul,
> >
> > told you countless times LSM cannot touch BPF bits without
> > explicit Ack.
>
> Based on a quick glance it doesn't appear that Fred's patches touch
> BPF bits, they simply supply kfuncs for users to use in their BPF
> programs.
>
> > So, no, you cannot add bpf kfuncs in random places in the kernel
>
> I see plenty of places outside of kernel/bpf that define kfuncs.

We discussed this already.
All those places were explicitly acked by BPF maintainers.

Every time somebody adds a kfunc it breaks safety, because
people don't read or don't understand Documentation/bpf/kfuncs.rst.
kfuncs are not export_symbol.
Object ownership model needs to be thought through.
Calling context needs to be analyzed and so on.
Just because something "works for me" it doesn't mean
that it's safe.
