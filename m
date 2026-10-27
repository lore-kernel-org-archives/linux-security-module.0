Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793140676;
	b=vKkbCJUVEKC1tKCfJA+o/acZVCdJEvWYpOcBuOHS347jEG8RfEd0zArIVztnnlnBjp4g
	 5BAuwEgd/UoYc6vlXiXQPospsEFYiAihfaMA293M6ebpSsxM+o8NH+eTyjGPwB07+eaI5
	 sAQp5jRXDPdhIpfq1WEpo5PKsQBwVbGFOsZY9TCEXrGr/wPKsQ/dfKNmKz/Hdtpau+n4T
	 DBrLliid5o7UmyYGjTvDfxCQxGL2X0hNKh9E0MlI5Otzc258A4ZYU/SyjMviq/EyTGLek
	 aIRky1lAZ+Do1HPXzKRlftH5GSDxuquLBF/Z6jpx5+T+/uwEgX/gRYJd0BB/SKIubrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=t5xhlGartaiIZUAGJb1P17Ap9eQ10+LChVLHP/V0nA0=;
	b=JqenUBl1Z1C2VmfQNwQAgsLApX9tVs91TxYUNJEVVY51LV3ZtMg1djZR+een9rTvEmWp
	 ZbkMPYv/zVxwxzC+e8+x0gIGuaIjgNwth5JyT+a9+rnKNZtdWtNHxqQQTorRpsOJpkgdb
	 i0ekL1KUZOFeNIPsnsCXYqaBa5Dr/eedz6cMMgDn8vtZIZNt0wX+OpDC+O2JAKnqN0mV5
	 mPWTbN6+2e6Ns9+zWg5HMqQkYSOvb+4Ns9yE8KA6EDoEcf+vXKkqJXtoZNDyUDdZBbiiP
	 UEXiZzVJZlwGH32ehGtEVKacfD3hYRmV1SxbX9U+y5KeqNQPKMpE4PplDL9QTPK6sQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=CmmfcGZ7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC14606A31E
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 22:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EC14606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=CmmfcGZ7
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a39e5161c1so284736b3a.3
        for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 15:37:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793140675; cv=none;
        d=google.com; s=arc-20260327;
        b=VEfnGUNoUi4fVkwyIU8IBcTF6lk8NfTbcF8yVTYQBcnmgxNOA9OB4UIoifNIN9pI+f
         Nb9SugRwJPgAkiFl214ZMXgf/60PZ7G9qvHWdXu3m/fHTylH3WBP6ecGi33aPdiNnKgV
         cLQtxHwjpcY0MXvg9Gb3rx1hN6VXBvE2j4JTdreBJ3n/y+eRxe8HtSKjq9G4Rd6BZBkl
         /rzOSuHz/X4FZLM4im/B1gK3RAZYt3jAhRNx4w7z8AqQp3l41E2HIHxzGYb4pe+LoryQ
         b8AOvK9uZc1HQrou+E+9OkNUnhozIIZQSvk6Zgcva++x+gMO5ASmdhBTDLic2wXn3DJz
         nbHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t5xhlGartaiIZUAGJb1P17Ap9eQ10+LChVLHP/V0nA0=;
        fh=It5why+hjAeOgJqILWbywhW/AXgSxMCWpF2PG56f6Do=;
        b=bYlNFsc0YOzMXHsyLlmHmgJJTPF3Xgp0rG2+sUg1uCOp6nWaVd1U6owDNqKbqiFKuq
         0GFDOfiRNDgrwZZ55HZAUX9lJT6E+kfETS5sdmeGRwoxKkpmLz5naTlq5uzQoFDmsKiH
         lL/YvsS/5+wADKYSZENTX2hmf+4z5hOvUlegnnBWWjQw031QtzQ6sFGRrN9UlPZ3eSAk
         FzoCXMnJFB5MiEIsumu8qyf4D4U5i0AFek9clmRNBLlPyDVO6A7981wjyZmPEdbB8K4o
         YJLO/aa7hkxULt47xqGNi6yKe/38/ObqQtNDJHbcvxJGIe4g2/93Kp3HmNGB55Cz4sA1
         47jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793140675; x=1793745475; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t5xhlGartaiIZUAGJb1P17Ap9eQ10+LChVLHP/V0nA0=;
        b=CmmfcGZ7nENUuOJDqfOA+U+yawbLWPNguEYYehiaT86nUJPExK4LIUr0b+k1BDuc26
         I6hx3Xfzp7YLAMCi0JlAztaJL1LJ07peoMRn4mvEVYQV9ao935CKi7xkqxxr8DV6Yock
         rxkAlWa6dKfZUDSA/ldivMN/wB1R2F6oZJ/Z+KQbMx5hox/gtEbE+yCicUOTZpRrKE4P
         T+53go7ZXNYLqMuC/UuR39tYwAuemgUaV9GLdZTVfA4cl0AKkhPeDhUFFxNVxK9mTwol
         FatP7g9VML/VQBnIOClMGPtwnF6f1eMMmXa3sADMNe6RaLLPzr5XUkxKolK7HPzqhrTk
         WZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140675; x=1793745475;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t5xhlGartaiIZUAGJb1P17Ap9eQ10+LChVLHP/V0nA0=;
        b=zSGSdLcCgqTebyd1Bragi074gHx1NJdKJ2IL1YuiyqkcjUPiY0XFs+Cr7DapAqIajp
         GfiMP00ykgXeXLYoEEomFmvP8SM93oACgmFKKEUE6zA/rqy9Keumh51RXyVxokULH2Ri
         +73nohXM16XbuJzTke9DLHjcJXGPsqSX4q1h0GcTiU4sUVFgQBzu3I/+y6TBMeK/WvQh
         Dqp7KkFOgHrY5cazBoXSIBszlxZTY4LilJPNpVF6rDjdF7kZH7NRQMXtOHi6ursjsGFw
         rHmW7YQSVMgsHATaIU9aRviMfWod71muBz4O0l7EB7r8WIZ6rehq2zBrCDNEulnYsKOq
         ymiA==
X-Forwarded-Encrypted: i=1; AKwUvBw610HeJR4UnRI5+iyUTx9m0Asyi7+AFcuwgNmyJaAH3hwkFKi3cGDb8NxJeBMj6NiEDysIWoecqNH3NRvq2yMtZKw92N4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0a6/S8g4hIkxOpSXRS8ELU2IYW3yjIeb1VhHZ/Ul4ZH6a5sIS
	0Q0IQpzgEbC9yrWspdG6WILoCzaQBRtybzoZY0EjDLXaXELfy9BLLBWFUfFv0CPq56r+98aUzx/
	HFGZmfDMfKZArJYLmnytC6rVLGw9ppBw8DhOETmZR
X-Gm-Gg: AYBFou2cL5uyFXYHmggHwlZKGy1oy+PuhWcn8Y+aHr5F+tMWiZ1vxwjsy1iwCr0zC9i
	4Dd6/Ijs/fDpuMddNp4e2G7Q7lnwzagnnQAk4HlTSkNWt3DcnuOhU9APj7hHLmc4zvyImubfN1K
	BxhEWOzgpLrt/fr68xIQHt06AOY5JlpQ1zT6G6lRMXaRbp+Ihh49RB0UlbcdaRZPjDfwBRtHX9U
	1MAXOZpOuypPWODJCe0u3Vf3302d9I6XNtuOIIvhlYgvhsdfc15wFXiOfRYcTO6AssopjMFiQnB
	EQiDIOhV9AaPB2IThGfnX5oMuxu8X6tLZx5ZsjANyPTkuMVnZurINGxMUS5GwrgnM6ucY+TunLn
	q/y6NYK8GHhek726Hyz2mrqQS5RcdNoY8epG1WGKEnD8+D6PwjF1rtFhfvqKTh3x7PUZq
X-Received: by 2002:a05:6a00:909d:b0:8a0:3ed7:93a1 with SMTP id
 d2e1a72fcca58-8a6e7ccf00cmr440746b3a.50.1793140675521; Tue, 27 Oct 2026
 15:37:55 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
 <CAHC9VhR4rMydWiD-RFv-ABiYSG_txJuyrtdaowEXPY=CHEvFXA@mail.gmail.com> <20261027-heckklappe-halbmarathon-vorsorgen-849ffdc42aac@brauner>
In-Reply-To: <20261027-heckklappe-halbmarathon-vorsorgen-849ffdc42aac@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 27 Oct 2026 18:37:43 -0400
X-Gm-Features: AclHuK_35bukQeeBWCt3UKqoCps6Vj2Zz_3Ju5zoX-GW6fl3dw3mrid-lC1zJpA
Message-ID: <CAHC9VhSJMPOY4X78ENEkAiNeVTCpvP76PgVDqTQfwaYfwnYwAQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] ns: fixes for the namespace LSM hooks
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>, netdev@vger.kernel.org, 
	stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 5:24=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Mon, Oct 26, 2026 at 04:31:25PM -0400, Paul Moore wrote:
> > From what I'm reading the LSM framework patches don't meet the typical
> > LSM criteria for stable/RC fixes: there is no serious bug/panic, and
> > there is no functional regression from a previous release.
> > This looks like one of those unfortunate circumstances where a new use
> > case wasn't tested thoroughly enough before the merge window, so it
> > can wait for the next one.
>
> My original patchset had a selftest that excercised the BPF LSM usability
> extensively. The hooks are new this cycle and broken for the main use-cas=
e I
> wrote the patchset for.

The hooks were merged into the LSM tree on August 31st, and due to
timing I'm guessing they appeared in linux-next the next day,
September 1st.  Considering the merge window opened on October
18th/19th, that's conservatively a month and a half during which
testing could have uncovered this issue and the behavior of the hook
could have been changed to accommodate your use-case.  I know the
Landlock folks were testing the hooks for their usage, but I've gone
back through my inbox and I don't see any reports of BPF LSM failures
using these new hooks in v7.4 until you posted this patchset during
the merge window.

> Curiously, your pull request told Linus "I expect that BPF LSM developers=
 will
> also be making use of the namespace hooks, if they haven't already". So i=
t
> seems very strange to claim this as a new use-case.

The LSM namespace hooks are new to Linux v7.4, they did not exist in
Linus' tree prior to this merge window which is why I consider both
the BPF LSM and Landlock usage of these hooks to be "new".

> >From my perspective the timeline looks like this - I'm sure yours differ=
s:
>
>   I wrote an implementation for the BPF LSM to use a set of new hooks in =
a
>   subsystem I maintain months ago.
>
>   You rejected the hooks because BPF LSM programs cannot serve as justifi=
cation
>   to introduce new hooks. Only in-tree LSM (selinux, apparmor, landlock, =
etc) can.
>
>   I cannot fulfill this requirement because I neither have the expertise =
nor
>   the use-case for any in-tree LSMs.
>
>   Landlock wants to make use of this by pure chance. So the maintainer of=
fers
>   to take over the patchset. He does.
>
> End result after more than two kernel releases: The patchset that ends up
> merged into upstream doesn't work with the original motivating use-case b=
ecause
> all the BPF LSM bits got dropped. So far, no problem. That may happen as =
long
> as we can the fix it rapidly.

As mentioned previously, I'm pretty consistent about what goes up to
Linus once the merge window opens: there is the initial pull-request
with the changes from the last development cycle and then after that
I'm pretty strict about only serious bugs/panics and regressions.  In
this case there is no existing LSM support for namespace controls in
any of the tagged releases from Linus so there are no regressions, and
by all accounts there are no panics related to these new hooks as-is.

Holding this change for Linux v7.5 will give you and others a chance
to fully test the new LSM hooks from a BPF LSM perspective, something
that evidently didn't happen during the Linux v7.4 development cycle.
Disabling the BPF LSM support for the new hooks in Linux v7.4 should
be relatively easy, much simpler than this patchset, and eliminate any
claimed harm.

Also, as the ongoing friction between the LSM and BPF developers was
brought up, I want to point out that SELinux support for the new LSM
namespace hooks was delayed to Linux v7.5 due to issues uncovered with
these new hooks during the Linux v7.4 development cycle (well before
the merge window opened).

> Then I take the time to send this series of fixes to actually restore the
> original use-case so we don't release a kernel with a new api that doesn'=
t work
> for the main use-case I developed this for.
>
> Once again, I get told no. This time because the functionality isn't brok=
en the
> right way to justify a merge-window follow-up. Instead, we'll release
> half-working functionality.

I told you "next merge window", which is far from "no".  Considering
no one tested the BPF LSM support for these new hooks during the v7.4
development cycle, that seems pretty reasonable to me.

> I'm really on the fringes of this endless debacle but this seems to be an=
other
> iteration of "BPF people don't get along with LSM people" therefore they =
make
> each other's lifes and that of innocent bystanders that just want to get =
work
> done difficult.

First, please read what I wrote above about SELinux being in a similar
situation.  If a LSM which identified an issue with the hooks well
before the merge window is being pushed to Linux v7.5, I'm not going
to make an exception and rush a functional change for a LSM that
didn't identify an issue until *after* the merge window opened when it
could have been easily identified with testing during the Linux v7.4
dev cycle.

I'm not going to argue that there isn't ongoing friction between the
BPF and LSM devs, and I'll admit to finding it odd that you seem to
keep inserting yourself into that friction point, but my approach here
is the same as what I would have taken with any other LSM (and have in
this particular case).

--=20
paul-moore.com
