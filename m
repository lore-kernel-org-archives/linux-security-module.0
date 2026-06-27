Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9301F146D5A
	for <linux-security-module@vger.kernel.org>; Sat, 27 Jun 2026 01:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782523967; cv=pass; b=En4Ms0HoqShO+noXtp7bR7X8wFHmh5lCWT/bil/paKK8sn8hlAExB6G+8XH1ATn4M/hX2rg1PsvrIZtNXXOH9DBeCLBVWxDdXvMjW2wryBMPkZEo16BRDc0xzHW8erIGEiKdcVll2gfVsaQ0oFGfsEfgQ27zAUzcHy0pio4vDQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782523967; c=relaxed/simple;
	bh=bUMDHoIKujOnOaZazj3fPoB//ObbDdwwJzNxa7frPGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVfd9N+3xjnpGHioSq7WLiiAHke+jE0tkrfDQ+VbIREb3ABVja3B9VAUqnWWxh04e+yUB5AZ6Dx0uf4Rsorj3iPGwRd0lebdyZ6T01reqqPK0iWPrduyR58yYLCtfZExWe0ZFg5o16jlu//egz8ULsANSt7GqMUqtKnE7EUHOZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VgAcQEme; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VgAcQEme"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-37dedd62b90so980379a91.1
        for <linux-security-module@vger.kernel.org>; Fri, 26 Jun 2026 18:32:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782523966; cv=none;
        d=google.com; s=arc-20260327;
        b=F4I5h1M6v4SWab1sdO9PAYYDPI+t1PiezicpUdslQcNqmoWq/hEVA/0iReEpwlizRU
         dnHKegOb9QTXyEojxzcolmxVdWJ/NszPDfM/rLS+Gw0SFipagEXsF0Xuvp/UOYGLi+VJ
         JPkDfTkn3TeUKUgBp9+g2N30cN/STXtJ5pe10onG9+lHux19xCCgaW7yYqi38SvwEeI9
         AwC3daNg7ZOivzhqNhzXh4sIiSjoa8QpzgwSmH2I7DMoHkDjrqItxVdTcNhigL60P5oe
         zBQL5DWLRIecaQx6Okhj5nnRBKnFD0ZaKQXJ63irRAkEZ0m+d0iGl13Li5AnQSkFX/Eo
         wrQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+bEvYzgg+Vfi7exmIIvatnl8KhRhIaVVXCokIG/FjiM=;
        fh=8/IO4NpsEjN09ZX/don2g5nYwl5wQqJHkcaqjoMwy0g=;
        b=sWP0RvDZvzK1+1SmP23xn3h3AywtJtHM5q7D6IgtKTal8Xfz9v9ywMHjzlITx7jUtx
         t8/oNJxf8eHSwR/3MW8AwR9af8JA9lGEldW0uwDKNdKEr7U3tpIbTQuNi+Im5mS+wpIP
         irQ04PhjigyXnwOJlsP0QT0OL3GMnr3oKoQ2TiRLvLtS0M7b8GS3V/HPaMsKbVXYJvj5
         MAQ06AuI/M5owpsgb8ouyH5/SZffwnKUzKmvSjIfOrIpx5FDL3lCUTp8XcNgC9emsOgT
         JbAK9gR+tAOcl6c25eD5Qbec+yxbFJkNISZUBcOt1aa7707THxFsHVukWt7S6RuJKhNS
         YYPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782523966; x=1783128766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bEvYzgg+Vfi7exmIIvatnl8KhRhIaVVXCokIG/FjiM=;
        b=VgAcQEmeOjFH3EWHVrFyzhuzq4BVI6G1VrFA0CzMCffr8Uh/dbiwR/3iSFVRwUYcX8
         xTIsCLdPk+F5Z6Mncq30tgWAgkhXVOhATClIImAH4GEy5G8rB/RzsgKIhfiUoR/SyNBY
         R03AV5YZLIZK5WmZHwt7PCEGf9htzp+3ax4kWhwat9dmCi9/QqlofhFlmAtPuoHpGqeV
         uB3b+Ogp/2pfjzSxHTrrneheNn4HyqQt4kxewduJXdG+Oujf1ktCuqwxHN+pjJsRmuPK
         SC/XnNUjCkmWCLxeDR+UlXZT+FD+6MHwPsc8TXfGm3Rj1SCT0EJPW1shPr80ZzWGUI9A
         dtqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782523966; x=1783128766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+bEvYzgg+Vfi7exmIIvatnl8KhRhIaVVXCokIG/FjiM=;
        b=SV+VtT9vOaZgkx/uL9cKj4gzdvP9aNuI8YCzt3Uumf0Pzk6OAGO5Jrj5EFXA+mv1hX
         1btqf03i2uzMSql5HHjkQJ63BK5PrTvav+fbSgFDlFb9p6WtY+EQJscTn3n8BfFSGEdt
         tNT/LjCm/30UmBaPOOe43K1t98bApYypGDVh6cI3+yrehMWKZoYojclldBsmPeLaM/a+
         iG2BOS2qdVE/7fX2zZWQEHZaajKBwyKf9AuxwcV/koPpX789ae7Q7oz3no8kBSANnP2g
         Sxe6yez4G4lM78p14n56K0XmK/rTjtxsbQgl9n+z32Bu9a06PIbycomx0qCKJ4Q0JX/I
         8zAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqc1q9RCVyNbygPuQach2UP6K7vAnGOpZYgaKL3E4DNsI3uErmQiDRoBM+uf9axaXdWxGJWilA44YXQQfUgLnmGuPBHVMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1K/3jBvkyqgP+X1fzdSzWIzfyBeQlacM0Bw7adjGAEfFEMK82
	+vNrEHmcxLPOEG3mRhDp2xsPrk16gbwEYHlP7lhAsyyPuexmQBOjwFX0CGhBx2uaxpzQEVU1/CT
	tm1MUbxs1Ov+tAeNmCmCupr264ZCXr4W9pm33cv60
X-Gm-Gg: AfdE7cmM9vjk8uRsI0TJ7uqg+3Gx5b8qfqNNZrP6dD8AnqnSYe+q+crMwxO4iY6rNGh
	SsWDIfqdmT9oFuaLl0UfODkBqK/MFQ9EwqMN8/sJ0//atc3+KU+lwITdsbxloNUUZjoKxabwCiG
	eQgiB/I0mN3FyK/ktpU3hjrKYWwlMQ01WHQmQh4ycmbd54kTvuSP9jvdRm4RCdQWNIjkeAsR0j0
	YG8j+6RSJm7S86AOmJOL0WXqX8rqsfLykGF1VjB02ZXSRjgGh7zkoF7yHZnWzUcda0mNgmK
X-Received: by 2002:a17:90a:e18d:b0:37d:a52a:ff12 with SMTP id
 98e67ed59e1d1-37df9142ba0mr6424100a91.10.1782523965668; Fri, 26 Jun 2026
 18:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624140301.93421-1-daniel@iogearbox.net> <20260624140301.93421-2-daniel@iogearbox.net>
 <CAHC9VhRar1x7kyjhgdmJ=Mfz4Msarv=wQ1821v723CaVdk1uTA@mail.gmail.com>
 <603d0f6f-bf02-48ec-af90-f16a239bad85@iogearbox.net> <CAHC9VhTF6_VaSm0uOjW1eV05CvsaaL+2jimVuPTXHeLGEQcMPg@mail.gmail.com>
 <c4dc3117-ad84-4c94-952a-cf0642cb42e7@iogearbox.net> <CAHC9VhRV9jW+dwNf7mW+1zTCsZ1xstBAugWL-TJ-DVNARdzC=Q@mail.gmail.com>
 <DJIL18C2F40B.39U9WHD43SDBR@gmail.com> <CACYkzJ64SxZj1Qvf1JRDfpoOWkg+bk_hpXcfGfPvecSfSu2jdA@mail.gmail.com>
In-Reply-To: <CACYkzJ64SxZj1Qvf1JRDfpoOWkg+bk_hpXcfGfPvecSfSu2jdA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 26 Jun 2026 21:32:33 -0400
X-Gm-Features: AVVi8CcSVFSQ9mVhPKRt5MUncLCLrJFUmMsLLB4PoeK8rOFzqfv4rkQMO_i5arI
Message-ID: <CAHC9VhTtaT_8AXSfNKiq4cGq7T=6Dh=huM8niBCwOP8kj+ugjQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Verify signed loader metadata at
 load time
To: KP Singh <kpsingh@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org, 
	James.Bottomley@hansenpartnership.com, bboscaccy@linux.microsoft.com, 
	memxor@gmail.com, torvalds@linux-foundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 6:01=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
> On Fri, Jun 26, 2026 at 3:16=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Thu Jun 25, 2026 at 5:59 PM PDT, Paul Moore wrote:
> > >
> > > For all the reasons I gave previously, I can't support moving the
> > > existing security_bpf_prog_load() hook at this point in time.
> >
> > Paul,
> > it's not up to you to approve or deny where security_bpf_prog_load()
> > is called within bpf subsystem as long as it doesn't affect behavior.
> > Daniel's patch doesn't change observable state from LSMs pov.
> > It merely moves the call from syscall.c to verifier.c.
> > So we're going to proceed.
> >
> > > I'm guessing you still haven't looked at Blaise's patchset from last
> > > September.
> >
> > Blaise approach was Nacked because you guys ignored TOCTOU issue.
> > I pointed it a year ago before AI was a thing. Then sashiko
> > pointed it again and the bot explained it in detail. It was again
> > ignored.
>
> Agreed, with Alexei: I like Daniel's solution because it avoids the
> complexity of machine independent BTF for loader programs and still
> addresses the signing goal, without the TOCTOU. I am okay with the
> current implementation as well. I think having kfuncs in loader
> programs would be useful, but we don't need to rush it or tie it to
> the signing effort.

As I've said a couple of times now in Daniel's approach, I like the
basic idea in Daniel's approach; it aligns with the same scheme we
have been advocating for all along: run the PKCS7 signature over both
the lskel loader and the maps.  I know you keep mentioning a TOCTOU
bug in that September patchset, but the main objection to all the
different variants of Blaise's patches was always the same basic idea:
you and Alexei wanted to verify the maps in the lskel loader BPF code,
while we wanted to directly verify the maps as part of the PKCS7
signature.  Any TOCTOU issues were implementation details; the
difference in the signature scheme was the sticking point in many of
the arguments.  For whatever it is worth, you and Alexei were not
immune to TOCTOU issues either.  The frozen map problem was mentioned
on-list and ignored.  We had to submit a PoC/report to security@kernel
to get it taken seriously and patched.

Regardless, of how we got here and whether or not you recognize
Daniel's signature scheme as a retread of Blaise's scheme, the point
is that you've come around to a concept we have advocated for over a
year.  If you plan to merge it, good (although I do wonder what Linus
will think of the userspace breakage caused by abandoning the
signature scheme that shipped in v6.18, maybe it's not a big deal, who
knows).  However, and this is important, we can't move the
security_bpf_prog_load() function to where Daniel proposed in his v2
patchset.  The issue is that non-trivial work happens, e.g. the
potential allocation of a buffer to hold up to one million eBPF
instructions, and we want to ensure we have an LSM access control
point before that happens.  If you, Daniel, and Alexei want to move
the bpf_prog_verify_signature() call into the verifier that's fine.
However, the security_bpf_prog_load() call needs to stay where it is.
It served an important purpose well before signed BPF programs were
supported, and adding BPF signatures doesn't invalidate that original
purpose.  If you want an LSM hook *after* the
bpf_prog_verify_signature() call and you oppose adding a new hook for
this new functionality, use the security_bpf_prog() hook.  It isn't
quite as conceptually clean of a solution as adding a new hook, but it
should work to allow you to control access to a BPF program based on
the signature verification result.

I'll support Daniel's patchset as long as you don't tamper with the
security_bpf_prog_load() hook.  If you move the hook to where it is
currently proposed in Daniel's v2 patchset I will have to object.  Do
we really want to keep going around on this stupid, petty carousel of
bickering and constant NACKs?

--=20
paul-moore.com
