Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71542D6E7C
	for <linux-security-module@vger.kernel.org>; Fri,  3 Oct 2025 02:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759458980; cv=none; b=gOhtlhitWAbbJBBeGoKt6R4RaE9GSyjN/C37O0voPeBJd77Sl9PWtmEQ8J/Kz5XrEyH2fvTzSkTvz9A5gCZg1mxZDndQTcWre3rDJQM7W4BC0xYNCXtQhwRAXLyUky8PSxDeLEULHBZTOhNPBvPM5y4RjAFEcLOohAV5A/cudMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759458980; c=relaxed/simple;
	bh=PDczC1UG00DKnp6JOz+u1xrR4XnhBXDaIWAvmub58IM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9dMTDUWvg83bbRwSIH5mtINZca1ZeR8CCLcFW7CfKCKRKtVMb+GYgXf0XvodRwvDDmyuztGJ8hD9AIzBQwEhS8LS44WYL2bb14lFlYMGnXSCI3eDbrw7MN1SDr2xsdbM8I8213RvcxX8+ID+9vdsxzCW4Y8bvLYIwXU/L4PXbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=biJUscZv; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="biJUscZv"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so1924690a91.0
        for <linux-security-module@vger.kernel.org>; Thu, 02 Oct 2025 19:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1759458971; x=1760063771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbVUWWtfJTKo6/VAKXWaJ6AL71jAQxSRwAQukA729RI=;
        b=biJUscZvvNIKJCpLzURZQ6r1QAkRcRwrelgv4SpiUdSQ9LBWpoWUCXRKrTQpVmJjMb
         Iz0Pq6MiyENjlbFeywdBgvY9joRjgJgkvi0FJpSILzPwk6dPCMd4UTMxVikam82Ia437
         QRnMMGkj/KbsZ4CL+DM3EZna36333F0f55EOeD+RtR8Rd6sFOoI++YWk7ZMNS2dGi+k1
         ozVY03wm8/h7HTYFtEZrGRJtnvu+5xIXYzRp6KrPpt3qy59F/rKq+2BenX88qH35q0rO
         mmq5UmjoUUjk1VISpdPUPaWKkIEGvGm2fXWwMUiK8s4dLK/P+1CW+NKLt7k3JBGodC9/
         J0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759458971; x=1760063771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbVUWWtfJTKo6/VAKXWaJ6AL71jAQxSRwAQukA729RI=;
        b=ZEjOKTpnLrz0aEqCi7df2jz6mBHgP/EOyoH9ibNEjpC3BJ4TK+cTxcOmdQKdjHqSAE
         /Z1AWYAbpI+TysEB4L62cxpi3n4fo/TbtPaTOS1ld4FlfpqMvbV8Sd2IZ9CmPz8ZVQTK
         9xKGIZZRmQnPDLPNc2p6n5ZHp056Tn/dFF628/p7pZ18g8t/XenajUpmzpTRDmzGh3aP
         YRKROZTQD1oFCosL2yRtLupOtyGzEnQyRJbQDz9CxTR3vAOiO0u418pnwSpbH27LGqcZ
         KnzMoXFUNjOgkkpWyxd2aw4NettSoYNT1fkX6SDw6RNPeZTlou3WEC5ptMJEb+05HgAf
         LkOw==
X-Forwarded-Encrypted: i=1; AJvYcCWbQUr8pIwud1W7LtkPSyuSgiYss+J8PoPCb+J+NH+8pPwPXLAx54140kxQGs5mfAPSc1F0yt2/FhxAIMIijAUXBQ/65/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbiCDIRIUUxvlXuPJwL2We4WXwcUYASUkeP0yBiqKkIbClaDvd
	phtIvrcNDqQjpzMfHZ0L4OZu165acXgC6KTqbkoIPLWvEeUhZQsnazzqSBCJDExNH2QEEWj6TaJ
	X6OH9/0L8BZu2l8DBgkcMqBPPx2VgLVjwFg3a2pkjq0NPlNeYlyqlZQ==
X-Gm-Gg: ASbGncu+C6GdN9Q5LrAfEEBt5V/b++40YJJmfpIl3u6RBK6zlZgDqL3VMxiQ18qPCfp
	3g/zR+JqSDzubHBiCx+AfDC9YRIgsGXA801BOL2s8M7s7bJD9plQhn+cKoCeyB4uAEJkA8te9h6
	iQj1ynixeq7KP1Ss/8ldaY/M8+RFdGEKNi+nchWNYT3uBU5N4A82CNaESDcgR/5Jp806Sd3lhAu
	/A4VuyffiNwZS+fs6MGmrhMFj8TILPcaf3OqebaCg==
X-Google-Smtp-Source: AGHT+IGM7sxkAvHQCswLIRm1lmGJctyE4Z3LAYrg0SJpQyZKL7u/tjCU1lsl821OhhdvdwC72y4sBnfz78urQGkfowg=
X-Received: by 2002:a17:90b:33d0:b0:329:e4d1:c20f with SMTP id
 98e67ed59e1d1-339c270272cmr1798927a91.9.1759458971129; Thu, 02 Oct 2025
 19:36:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
 <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com> <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
In-Reply-To: <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 2 Oct 2025 22:35:59 -0400
X-Gm-Features: AS18NWA5VOquYItqewfcLw0X1EfuA0hKyUTOPc-IPXqDwZgNXrJXoVU9Q8aukJc
Message-ID: <CAHC9VhR2Ab8Rw8RBm9je9-Ss++wufstxh4fB3zrZXnBoZpSi_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: KP Singh <kpsingh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, ast@kernel.org, 
	james.bottomley@hansenpartnership.com, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kys@microsoft.com, 
	daniel@iogearbox.net, andrii@kernel.org, wufan@linux.microsoft.com, 
	qmo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 9:48=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote:
> On Wed, Oct 1, 2025 at 11:37=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > With the lack of engagement from the BPF devs, I'm now at the point
> > where I'm asking Linus to comment on the current situation around
>
> The lack of engagement is because Blaise has repeatedly sent patches
> and ignored maintainer feedback and continued pushing a broken
> approach.

I'm sorry you feel that way, but that simply does not appear to be the
case.  Looking at the archives from this year I see that Blase has
proposed three different approaches[7][8][9] to verifying signed BPF
programs, with each new approach a result of the feedback received.

> The community, in fact, prioritized the signing work to unblock your use-=
case.

As mentioned previously, many times over, while your signature scheme
may satisfy your own
requirements, it does not provide a workable solution for use cases
that have more stringent security requirements.  Blaise's latest
approach, a small patch on top of your patchset, is an attempt to
bridge that divide.

> Blaise's implementation ...

I think Blaise's response addressed your other comments rather well so
I'll just skip over those points.

> > To make it clear at the start, Blaise's patchset does not change,
> > block, or otherwise prevent the BPF program signature scheme
> > implemented in KP's patchset.  Blaise intentionally designed his
> > patches such that the two signature schemes can coexist together in
>
> We cannot have multiple signature schemes, this is not the experience
> we want for BPF users.

In a perfect world there would be a singular BPF signature scheme
which would satisfy all the different use cases, but the sad reality
is that your signature scheme which Alexei sent to Linus during this
merge window falls short of that goal.  Blaise's patch is an attempt
to provide a solution for the BPF use cases that are not sufficiently
addressed by your signature scheme.

> > Relying on a light skeleton to verify the BPF program means that any
> > verification failures in the light skeleton will be "lost" as there is
> > no way to convey an error code back to the user who is attempting the
>
> This is not correct, the error is propagated back if the loader program f=
ails.

The loader BPF program which verifies the original BPF program, stored
as a map as part of the light skeleton, is not executed as part of the
original bpf() syscall issued from userspace.  The loader BPF program,
and its verification code, is executed during a subsequent call.  It
is possible for the PKCS7 signature on the loader to pass, with the
kernel reporting a successful program load, the LSM authorizing the
load based on a good signature, and audit recording a successful
signature verification yet the loader could still fail the integrity
check on the original BPF program, leaving the system with a false
positive on the BPF program load and a "questionable" audit trail.

> You keep mentioning having visibility  in the LSM code and I again
> ask, to implement what specific security policy and there is no clear
> answer?

No one policy can satisfy the different security requirements of all
known users, simply look at all of the LSMs (including the BPF LSM)
which support different security policies as a real world example of
this.  Even the presence of the LSM framework as an abstract layer is
an admission that no one policy, or model, solves all problems.
Instead, the goal is to ensure we have mechanisms in place which are
flexible enough to support a number of different policies and models.

[7] https://lore.kernel.org/all/20250109214617.485144-1-bboscaccy@linux.mic=
rosoft.com/
[8] https://lore.kernel.org/linux-security-module/20250321164537.16719-1-bb=
oscaccy@linux.microsoft.com/
[9] https://lore.kernel.org/linux-security-module/87sei58vy3.fsf@microsoft.=
com/

--=20
paul-moore.com
