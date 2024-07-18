Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603C7110A
	for <linux-security-module@vger.kernel.org>; Thu, 18 Jul 2024 01:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264592; cv=none; b=rosX/TofeY7wp7oGo+Asgns9o2IMKs32bBADCdF6nCoxqa7kjvXLHOzvxmCxcomqfBCQmt+pTb4DEhC39YO+5p+G33MymM7PLJHwpr/qhGtHxUk+RdBdBuXxPMKhxt+eZc4/Quq5PlokKNpuGy8orvB4J3/sn5fMmELMGVtnT+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264592; c=relaxed/simple;
	bh=wM0kktGn47Y6sE5nEErkw1T11AYqer5jFZMgYakKxfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7dgHqbMs0DnO5OyCLqVp6xq91TdREauRQirZQ5lfXTZ6uwx8LqSh0fI54iO2xltUC3Y4E8Ml45xnGZC3yaGHx5I45Lbc+8B/tfY8vRy3m4Bj6kktjwPxEWZ6ymknW6ebwo0CgvieHlGXsTJ2hcikUa26sZQ9astPa70FKZwPJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=DxOXamwl; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="DxOXamwl"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58e76294858so2608188a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 17 Jul 2024 18:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1721264589; x=1721869389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DvCNFOJURn8U74iwm+vc54yZXB4520PPHveux2N1NI=;
        b=DxOXamwlYccCzdYOacDuUCnh9IPgIzkn/QABRrTOes7bNtzLBTmAd5yp28XrEiwacu
         W482D/ld89nlgnHPWJBJ8cgvz4opDGbuAPBm2ZnkB448ktUMw0DWbSJdUp3X3W6mNWDo
         ZKB9Aq8q8NU4/9bAcDxAKuyE9T+QKA94QwFbwlIQ9BJbsxYUW0FRMF+tAcQsorSh9wLP
         gWCwhCZMnOGxFi/kpmEaQYSbrSpewOCL4JuI0JTygp4Y28owKSi8JYZD40AS5L6uu6r+
         Yhbv7Rvp69IDxAGUqIC9eDEMjx8TSIaliPfjiWIXTCqkUZECf7qUT24otGY84y4YkEts
         ZC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264589; x=1721869389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DvCNFOJURn8U74iwm+vc54yZXB4520PPHveux2N1NI=;
        b=UDijDmElnl6y3pjf5Kw4UjTFVhv9+sIPlzznPpyyLfjRGXZqI6U01PVb36fsqC3Okp
         xGNNcfIs2O2nDBz/1p+OKiWeSlvr+z/X4a8xFdtVGvcodq5fK+7pSxpaLVMgm7fyHMoJ
         3jJ9zDadw1VzdN5v4OvexBOMYIJRbKBK8S2RjWbsM9A376jcp2dW2LOVmq7tme+qJuaR
         vBS+n/PDoKnbBqz2WrCQzTJ2+n8B9jfIGaluQheIY1T2RYt884kDdDs1YrbHP6Yl9CC/
         eqY9/M9mBOkBieb4M76Lfzj6iutvPCGBrs56bffwox3waDt+0PgsWRCTH5XeQs/oESec
         VPng==
X-Forwarded-Encrypted: i=1; AJvYcCWeoGwsE2ovEqxNaC7xPmqpWKXJJBjWhDv5cNTBKPS+kEeq0TJ5U5sLOSrYiUItoc/ObdAW/SQugOduJXGo9pEVQFop5vY85TcG8Z+keAkmNg7VISS9
X-Gm-Message-State: AOJu0YyBS2YoXuhAdEbNxr4Fe2R8ocRa4HCtRG+TBYXkighhUSzaEhYk
	wFwXSQvh+b206+AJZcJaAJwJwco6Zvp2ROdFSFlDMFQNHNDBLPNK3jpGdI0VfEOYf+TApd6ToLU
	9IRWBcRMMwHbuoaSmzNyAYFNL3O1jTUqjX4lx
X-Google-Smtp-Source: AGHT+IE7SBwV2lQaXPjuvVAVH1UzPNTxYBnnea3hS+FDItUKjfyoEirYJPBEWFBIzD4Kcr81i9vTbZRgtB1tPcSWRYA=
X-Received: by 2002:a50:f617:0:b0:57c:9eef:e54 with SMTP id
 4fb4d7f45d1cf-5a155e8f87cmr1229866a12.5.1721264588545; Wed, 17 Jul 2024
 18:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704190137.696169-1-mic@digikod.net> <20240704190137.696169-2-mic@digikod.net>
 <CALmYWFss7qcpR9D_r3pbP_Orxs55t3y3yXJsac1Wz=Hk9Di0Nw@mail.gmail.com>
 <a0da7702-dabe-49e4-87f4-5d6111f023a8@python.org> <20240717.AGh2shahc9ee@digikod.net>
In-Reply-To: <20240717.AGh2shahc9ee@digikod.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 18 Jul 2024 09:02:56 +0800
Message-ID: <CALCETrUcr3p_APNazMro7Y9FX1zLAiQESvKZ5BDgd8X3PoCdFw@mail.gmail.com>
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Steve Dower <steve.dower@python.org>, Jeff Xu <jeffxu@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, "Theodore Ts'o" <tytso@mit.edu>, Alejandro Colomar <alx@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Jul 17, 2024, at 6:01=E2=80=AFPM, Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> =EF=BB=BFOn Wed, Jul 17, 2024 at 09:26:22AM +0100, Steve Dower wrote:
>>> On 17/07/2024 07:33, Jeff Xu wrote:
>>> Consider those cases: I think:
>>> a> relying purely on userspace for enforcement does't seem to be
>>> effective,  e.g. it is trivial  to call open(), then mmap() it into
>>> executable memory.
>>
>> If there's a way to do this without running executable code that had to =
pass
>> a previous execveat() check, then yeah, it's not effective (e.g. a Pytho=
n
>> interpreter that *doesn't* enforce execveat() is a trivial way to do it)=
.
>>
>> Once arbitrary code is running, all bets are off. So long as all arbitra=
ry
>> code is being checked itself, it's allowed to do things that would bypas=
s
>> later checks (and it's up to whoever audited it in the first place to
>> prevent this by not giving it the special mark that allows it to pass th=
e
>> check).
>
> Exactly.  As explained in the patches, one crucial prerequisite is that
> the executable code is trusted, and the system must provide integrity
> guarantees.  We cannot do anything without that.  This patches series is
> a building block to fix a blind spot on Linux systems to be able to
> fully control executability.

Circling back to my previous comment (did that ever get noticed?), I
don=E2=80=99t think this is quite right:

https://lore.kernel.org/all/CALCETrWYu=3DPYJSgyJ-vaa+3BGAry8Jo8xErZLiGR3U5h=
6+U0tA@mail.gmail.com/

On a basic system configuration, a given path either may or may not be
executed. And maybe that path has some integrity check (dm-verity,
etc).  So the kernel should tell the interpreter/loader whether the
target may be executed. All fine.

 But I think the more complex cases are more interesting, and the
=E2=80=9Cexecute a program=E2=80=9D process IS NOT BINARY.  An attempt to e=
xecute can
be rejected outright, or it can be allowed *with a change to creds or
security context*.  It would be entirely reasonable to have a policy
that allows execution of non-integrity-checked files but in a very
locked down context only.

So=E2=80=A6 shouldn=E2=80=99t a patch series to this effect actually suppor=
t this?
