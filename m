Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0C61ADC97
	for <linux-security-module@vger.kernel.org>; Sun, 24 May 2026 00:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779583160; cv=none; b=ikzxiHtQfEsbZNEhS8iE6MPDwqr+1gjSt3RraWe6oskaD9+zzsVqD/f6CPJyLUZ/xrp/shzxjJEm8AgbNicxIa+aQCOC+zr0ncjUMn16Z+vPUd4l1/WdD1qL/quK3bWioYspeIN2CXAqmL55MmOAvOdhkqe75JlT7/14GuzFpTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779583160; c=relaxed/simple;
	bh=e54h4WgA0tRI9sa4Q4/H9CClP4ocySTFJquGCfhvkxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YS+4EZUTKc6Fk7FKHq81DmCBb3TKK5dcEGJJil0RcxK3DJi+cm7ugvz2nglt8OqjxHdwxI4COti/QseteGpgU3INZ6SN22bwOX0CBcfI6mNJhHKTI9tsfZgpcRKquJhaBX6SYOBnpwKkLkCyFKQXJJHTixEqIHbCV6TVG3zLM8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YekWJiIx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YekWJiIx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D225B1F000E9
	for <linux-security-module@vger.kernel.org>; Sun, 24 May 2026 00:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779583158;
	bh=OGDjsBEhb6EGRO60yGuSYT3l6Kqy5jJ1g7yfpVFShV8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YekWJiIx7A2tU6Qd/pCpe058bnGopSVPqnnKxi2VhBQqTum4PZg7tgx8JbIZbS5Pw
	 uv9Tjs1IfV/fnbXkHEKTn3Dw/g/Njn7mLxGYwv7VS5/ZgmgppTe63DBa5b5aerp/x5
	 bX1UqGESd04dBaZ3+YFwZ2/Wl0x9qXNRq0fPA1Z9X+DEB9xcrHI41+8Kl1AwACUFgz
	 6tqJVD0ZMIZACFqVRO3mzhgUdKv7FY02CjUj4ydLUbX7zWw5CiyzUiL+71znDzEUSX
	 J6xvjPm3hZzP974RtwuIJcjgO5N1YklZHdHNHNBSYLAreIQ6g0NboULxBF3/2LNKRz
	 6YrbWssZSEQ6Q==
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3045c195251so1428747eec.1
        for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 17:39:18 -0700 (PDT)
X-Gm-Message-State: AOJu0YzYn542TGVCmFlFcgodCBqshjyw6uYL1IoHMNgGytarBGpeQnOz
	WetjydtkiDx4X/7s+TQbYJvLsRyspKuXMwXBTlHCkWLKUaAAO5DXTKfETgyTv6F2tS05z2r6gH1
	WyAaN+hnJI4m8Z3jMEWTmCa+VlzZ0mmw=
X-Received: by 2002:a05:7022:1001:b0:134:def6:e751 with SMTP id
 a92af1059eb24-1365fb4dbacmr2839501c88.30.1779583158351; Sat, 23 May 2026
 17:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523200859.13527-2-paul@paul-moore.com>
In-Reply-To: <20260523200859.13527-2-paul@paul-moore.com>
From: Fan Wu <wufan@kernel.org>
Date: Sat, 23 May 2026 17:39:30 -0700
X-Gmail-Original-Message-ID: <CAKtyLkHz+7+X_=0d2si6yxMfBFRECJcNnN2QBp15Uvv21ZAyAA@mail.gmail.com>
X-Gm-Features: AVHnY4LNtZmsIZwH-MJwpHKdZ0WLWlQu5YsSH9q-1ckhFDRemKfzun64glvYb1c
Message-ID: <CAKtyLkHz+7+X_=0d2si6yxMfBFRECJcNnN2QBp15Uvv21ZAyAA@mail.gmail.com>
Subject: Re: [RFC PATCH] ipe: support multiple BPF integrity verification LSMs
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, wufan@kernel.org, 
	bboscaccy@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 1:09=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Currently IPE always records the last BPF integrity verification verdict,
> which is reasonable with only a single BPF verification LSM, but it
> becomes problematic when multiple mechanisms end up submitting BPF
> program integrity verdicts.
>
> This patch updates IPE to record all of the received BPF program
> integrity verdicts, along with their associated LSM IDs, ultimately using
> the "worst" verdict in the policy enforcement engine.  Policy support for
> selecting individual integrity verdicts was intentionally omitted from
> this patch to keep things simple both from a code and policy developer
> perspective, however future work to add selector support should be
> trivial.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---

I would say the current code is fine because there is only one provider.

The verdicts for different LSMs may have different semantics,
therefore I would suggest the second verdict provider should extend
the policy to provide a rule property like "LSM=3Dhornet" to
differentiate the integrity provider. However this will need a major
parser and policy validation refactoring with a proper documentation
of the policy semantics and use case examples.

-Fan
