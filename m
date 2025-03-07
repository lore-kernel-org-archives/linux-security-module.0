Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3014623E35E
	for <linux-security-module@vger.kernel.org>; Fri,  7 Mar 2025 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741367603; cv=none; b=KZq0GXNrTnS3CPm0gk5PqXkVJfZOHbnTskgJPCKV81s6PyNnRkuP2gBMdU04KxTh+qeDi7myQK1J75DQArSeE+sop88tiDU+kHR2ToXcu26pMMIFsn8bWhqGutXEA4cM6V1U4M+Pm/BF/MXn2z2TPjGg7eJOKRqsKXgWuHcR5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741367603; c=relaxed/simple;
	bh=zyEda87EiO9SZgXcIrtFswmtuewymM+H3mdqEU1aE4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=EcLPbKrwzElgW1VqgdiCehjcXLf4nTZ7D923+5vnWWd2uNJA5vg1CpUOCNsryNDYS4lmQD09eSXVMcMxoQogKo5aJdu/QiySgeZ94y3+VBiAsgLUUzqq3KNwmwQEA+2HT0IM1i+WSZHAHFw17z8Aq4vumJaAM1LgvB4aFXqXIgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bKNoPmce; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bKNoPmce"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e549be93d5eso1894612276.1
        for <linux-security-module@vger.kernel.org>; Fri, 07 Mar 2025 09:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741367601; x=1741972401; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1S49FbAWmDPAgJE/oAbV68GaShaPYtOqhE7rqbBh7qI=;
        b=bKNoPmceUmxNFSHjD5fH5HTaD/MDGfaUg/fQhcNpc22QIHKsBMFwttyIC16BStf15q
         ffFL2NlEWdpnRYQAg3kaqDYHIJf26zXB5ZOJ0YjjIDArBz7mHrAXRb+CU0NTN6LLVtPT
         IYUbhDrns9X/CLn6LJF2LZ1FfXt0wZqktfDUXR3/45gACvGBTqi59q6AGZBvcDqYVQ3Q
         MImleZJxdqvNb4uUtddbXdr95TqJQEqlDuNLQnWyX9bzOKlvHAQ3DX91Chs87J814GtT
         UCib54LNMpR16wVK3bgMt6a5ZwR0Sgtf1y49DXmGasfNbCL0HKdcvn1GaXe9EitMJgTW
         q04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741367601; x=1741972401;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1S49FbAWmDPAgJE/oAbV68GaShaPYtOqhE7rqbBh7qI=;
        b=U0eVp52pzQTk9W/4EhND0cus7RfuZ+EfauIX5/ztC4O1Z/DUOxwPZdMW7K8Nn0vbkW
         BGjN4oCg28J7YLnDNs39XhTI+0hyI645iDBZcJeCZ3Ju/RbhA1mp9F6oujJakth8oKPr
         1IRO6QYV5J+rWAnYmIfMDUhWXGvoxTd0GT8I4Y8dPUyggmpZdYh64eNELP0BysnhRWAY
         yzQW8trWnP7wejUz4oVD9UIP4q4YI8t1ON1P6h0cuLzXX3XnRj5EamExY1prJLHT4U5D
         uPP1tjFi0apCZRUo6XAgFFy4fEL0PyOo9NP+5Dm8jhWTbA834p92NLDYak9zDxy8x7mm
         RlMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnNsE6acIBn/aL7r5UzxQeMwBh3OUkOxKinNu5NnJFkYg43KqapUksSpb4pJHVIh2pRLl4G3kEDiCA6sumirZfRTABVAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmH7KKVe/B4v1g4zS0SuGyCtMnfyGAoUI2ZHZROPoj4vCvxZ8D
	PBpMxGd3ULTDd3Mri7R3mNi6XhRogFUZkSmNZsQ510jIURjEZZ3E1qIffS4o52JtUFkKI7PkVbY
	UdlmJP9805jibq+3XYvg0ASp0DRcuku9xvUwJeOMVysN1TT0=
X-Gm-Gg: ASbGncum6cedaL99GHr9pftfz0I7EycvrbCedzlrAm9b0VqfSMyl5CixJ++s1JeGBBJ
	kxDI7JCwSuaaGDarUpML/aEcC0jKrbuvh8JFCxAj3YkGyxA2J+w+Cc7zq3UCZhLHIoTcV/Vp2ZZ
	tjZWqHX/g3d+dCr9iZIxRAMO79rA==
X-Google-Smtp-Source: AGHT+IFZrcJv3DKH8N6mKzfALP9vldTvOQNZ8fUbwS7RCNKpJm8DuIWRxIESP30rLGZ3T+fRUPo8Z8hpS3iDl7k169o=
X-Received: by 2002:a05:6902:2805:b0:e60:9d12:c1e5 with SMTP id
 3f1490d57ef6-e635c1d8d02mr4575004276.36.1741367601049; Fri, 07 Mar 2025
 09:13:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304222304.214704-2-paul@paul-moore.com>
In-Reply-To: <20250304222304.214704-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 7 Mar 2025 12:13:08 -0500
X-Gm-Features: AQ5f1Jrh7gd2P5xNLqeBO5M-me2kPDDYAuqauHazRQMXvPgY8cCGhwVzpDIzO-A
Message-ID: <CAHC9VhRW4Be+uBbtgCRvSkUj1-CtYFZ9jbD9MZM70i7GhF624Q@mail.gmail.com>
Subject: Re: [RFC PATCH] MAINTAINERS: add an explicit credentials entry
To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 5:23=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> The lack of an explicit credential (kernel/cred.c) entry has caused
> confusion in the past among new, and not-so-new developers, about where
> to send credential patches for discussion and merging.  Those patches
> that are sent can often rot on the mailing lists for months as there
> is no clear maintainer tasked with reviewing and merging patches.
>
> I'm volunteering for the cred maintainer role to try and reduce the
> confusion and help cred patches find their way up to Linus' tree.  As
> there generally aren't a lot of cred patches I'll start with simply
> folding them into the LSM tree, but if this changes I'll setup a
> dedicated cred tree.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)

I haven't seen any objections, or any other volunteers, so I'm going
to go ahead and merge this to send up to Linus during the upcoming
merge window.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 896a307fa065..68e4656c15ea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6139,6 +6139,14 @@ L:       linux-input@vger.kernel.org
>  S:     Maintained
>  F:     drivers/hid/hid-creative-sb0540.c
>
> +CREDENTIALS
> +M:     Paul Moore <paul@paul-moore.com>
> +L:     linux-security-module@vger.kernel.org
> +S:     Supported
> +T:     git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.g=
it
> +F:     include/linux/cred.h
> +F:     kernel/cred.c
> +
>  INTEL CRPS COMMON REDUNDANT PSU DRIVER
>  M:     Ninad Palsule <ninad@linux.ibm.com>
>  L:     linux-hwmon@vger.kernel.org
> --
> 2.48.1

--=20
paul-moore.com
