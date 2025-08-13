Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E2C302743
	for <linux-security-module@vger.kernel.org>; Wed, 13 Aug 2025 22:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755123444; cv=none; b=sGPJaUQMaTZBtIIBLh2vBzF42KaarCAGPbIDT8xxaU4fgud8gwEVcPb55i5RN5+A6JuixWHGw/Cew6X5C8KSv36Kff3PIEBCmLNKXJ1mMCcNYePIyemqf/gJ/G6395DzqIj3oxBnwBgo5s333t04azNoZHP6f4Te1S/j8XGceKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755123444; c=relaxed/simple;
	bh=7/qVQ0Dfi+F8FGoqdpVC+Er2VJfczbJ8z4znCUYW1gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2IuHXaVyVTpJaA8cz1y4AYlQBHEZzKvHps072prCrWpvkTR8dw+9oGGPD7SGd5e3lu74TVUDMzVCLae0I51jBT5AeBZNWpMfb9O9YyBo1H3LvAWoFQqX7gIFr+H42puzyaRSRwT4jPV1YR2E60R83SSh2OOodjvGxavlSRGink=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eGba5MS2; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eGba5MS2"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-323266d38c2so522620a91.0
        for <linux-security-module@vger.kernel.org>; Wed, 13 Aug 2025 15:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755123442; x=1755728242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGorcLMkH3QlG/ylkCQf/naoEUCFkupeIISGIHD6yrM=;
        b=eGba5MS2clABCj6ZtnsMl/e4RQE8kR/IQkak5lesQAjNDlsEbPSSSJK/TUMvTqPJFf
         L0rWEiiqwWZraZO7fOaRgjBElyqsttXypA3nP++E89P0yrFCmAHa6i2MrqXTS3lSJQX1
         iHJBeh3x13BqRH6JeAAbWek6s/nV0cryPQFBMu08HkYZ71I1TmuOm6YJh2v/T3TDvABO
         aGupkpY8ADby6gwRyXgH9CyPdQ0K477Mo58DQYUfBf9P1kSlz9jxum6ZQ+FFB7OE8IK0
         drxbqS2KZJ9/B0n7iRzDT/KOAJ5F+Aimi5YfHTKzyANmToJ8oUzzZRy8PSFqABbX/ZnH
         Zvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755123442; x=1755728242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGorcLMkH3QlG/ylkCQf/naoEUCFkupeIISGIHD6yrM=;
        b=gmkx8x+HU1GxMcOcYvrVzGrri4uz0/n7YF2hAYoH1N/9q8/kzRIoj4LzHqqXL0XEMY
         cFsQ4a3lENIE9wlRhAqgD4Snynz+qf72cXNvNTVk7M0BQg2yA3avrDyxM4I/o8lNhjhe
         AI+AV6T4M6twMqanXtU0oQJDgIQXmiSOu2SS71TrV17keaWiVZnc9iIaiQ84LO8ill7d
         xpt60TcN2KUyuYS1/iHgeIdYbypAOV+XOut6Fg3it9tFHRzG722OvuLt3aBar+MHSc3g
         HAxnurcGbGNV6SQfUNQXqCqWkZOuva7/nKGSAPnzSkOQtT3Ub0akmq45+qQXWLJBSPgv
         mu/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgJHM+WwIX9W6gXw2K4gZhlwqOVYxA7RgG1qh1ppNtMeRTXsyA2nP8gTinCDO8ZNTSYeXbpp5/lcoJUoN2Bkr8W6rx1rI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo3iyfRiU4yuoiF+DDnEgERtSRlqmj4Zz2QAiOldbtwQgdmHoB
	ZlQzZiIW6UFCtO1Qs1BXL23DJTZ05g2q4b+21NbIF8+iXNQxunZf4M4X5QjPMxDpqQNVBEpr54A
	dBPZXprnoHiJIYyHYaFU/S+cNsOKUcUiZpkMiARwJ
X-Gm-Gg: ASbGncue1iTIM5ttvJQMJgezfeanpJj3zXnPa54eDLnagvtkk7bhOqDP94sQ1dGRytn
	JEbXR8XhJJjL6SO+0I1PZP2OlDvoeWFtZsU3p3KHi/cz1p/uE+SJzUos3B26r6t2Xgu+bPrl8l1
	QvUum4rmLHmsdxj51ts21ilh3tx3JaLqLD15RwvM9X0HnMHhBt1lo52ZpvzpOdctLrJ4nrPoAMP
	KW5uRc=
X-Google-Smtp-Source: AGHT+IFV5GwceQPSXx/zKq6bM3b4LTYCAEfUuhLMxq4ITSdoKjsdF7W5ZnjCmvjdtzc/fzdyHvuxbwhnhfIeCsjfn+Y=
X-Received: by 2002:a17:90b:4985:b0:308:7270:d6ea with SMTP id
 98e67ed59e1d1-32327abc414mr1185449a91.30.1755123442415; Wed, 13 Aug 2025
 15:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813205526.2992911-1-kpsingh@kernel.org> <20250813205526.2992911-9-kpsingh@kernel.org>
 <CAHC9VhR=VQ9QB6YfxOp2B8itj82PPtsiF8K+nyJCL26nFVdQww@mail.gmail.com> <CACYkzJ7vBf3v-ezX1_xWp6HBJffDdUMHC3bgNUuSGUH-anKZKg@mail.gmail.com>
In-Reply-To: <CACYkzJ7vBf3v-ezX1_xWp6HBJffDdUMHC3bgNUuSGUH-anKZKg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 13 Aug 2025 18:17:10 -0400
X-Gm-Features: Ac12FXxrmR6UMr5zzOnbjrnnBe0Rsu1MlHVcGYGUo65gfWTyXTLY8-zPkRYoHRQ
Message-ID: <CAHC9VhT2Q4QOKq+mY9qWHz8pYg6GzUuhntg1Vd-cpGcQ7x6TLg@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] bpf: Implement signature verification for BPF programs
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, kys@microsoft.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:37=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
> On Wed, Aug 13, 2025 at 11:02=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > It's nice to see a v3 revision, but it would be good to see some
> > comments on Blaise's reply to your v2 revision.  From what I can see
> > it should enable the different use cases and requirements that have
> > been posted.
>
> I will defer to Alexei and others here (mostly due to time crunch). It
> would however be useful to explain the use-cases in which signed maps
> are useful (beyond being a different approach than the current
> delegated verification).

The use cases and requirements have been described quite a bit in
previous threads already, with both you and Alexei participating in
those discussions.  If you really can't find the threads on lore let
me know and I'll be happy to send you links to all of the various
threads from the past several months.

However, if I had to point to a single email that I felt best
summarized my requirements, I think it might be this:

<<< QUOTE >>>
The loader (+ implicit loader verification of maps w/original program)
signature verification scheme has been requested by Alexei/KP, and
that's fine, the code is trivial and if the user/admin is satisfied
with that as a solution, great.  However, the loader + map signature
verification scheme has some advantages and helps satisfy some
requirements that are not satisfied by only verifying the loader and
relying on the loader to verify the original program stored in the
maps.  One obvious advantage is that the lskel loader is much simpler
in this case as it doesn't need to worry about verification of the
program maps as that has already been done in bpf_check_signature().
I'm sure there are probably some other obvious reasons, but beyond the
one mentioned above, the other advantages that I'm interested in are a
little less obvious, or at least I haven't seen them brought up yet.
As I mentioned in an earlier thread, it's important to have the LSM
hook that handles authorization of a BPF program load *after* the BPF
program's signature has been verified.  This is not simply because the
LSM implementation might want to enforce and access control on a BPF
program load due to the signature state (signature verified vs no
signature), but also because the LSM might want to measure system
state and/or provide a record of the operation.  If we only verify the
lskel loader, at the point in time that the security_bpf_prog_load()
hook is called, we haven't properly verified both the loader and the
original BPF program stored in the map, that doesn't happen until much
later when the lskel loader executes.  Yes, I understand that may
sound very pedantic and fussy, but there are users who care very much
about those details, and if they see an event in the logs that
indicates that the BPF program signature has been verified as "good",
they need that log event to be fully, 100% true, and not have an
asterix of "only the lskel loader has been verified, the original BPF
program will potentially be verified later without any additional
events being logged to indicate the verification".
<<< /QUOTE >>>

The above was taken from this on-list email:
https://lore.kernel.org/linux-security-module/CAHC9VhQT=3Dymqssa9ymXtvssHTd=
VH_64T8Mpb0Mh8oxRD0Guo_Q@mail.gmail.com/

Of course I imagine Blaise might have a few things to add here, but
I'll let him comment on that if he has anything additional to add.

--=20
paul-moore.com
