Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4EF291892
	for <linux-security-module@vger.kernel.org>; Tue, 10 Jun 2025 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558413; cv=none; b=C+pyA/eUpZLQq4dxKmHQ3UsqxK5EhBoP425WA7szdcpqj6S6/TYNmsTom5ZRB5jp2Cct0t9horOPhC3Fm+MVD2LiLVrVd1a2puvZsuVVmXNToUVWGag7ZYnP29oHjFP3BilusxNwc6JRQgyKN1IatjXZW5o4SRcV5BAMNsuQFsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558413; c=relaxed/simple;
	bh=JCy8CKcVn4/R8yM8udj+pd97xBlK9sRGA7kQ5k5UhAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWZ+qnpN0guXeyaarsJ5RaAPrX6SR2hHO7YNXBcA9zaIIockiS3P466uZrLYgIswF0mfS/PaKNVeFECqRkci7H5FTghbZfTRUHWTEXLIxywUlmB9S6ZorMmS78x5T+pF4Nv5lopcImuorSZhJ0AvwdV7UbMODSp9AXK7m45zKf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6eGpyk+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6eGpyk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DCFC4CEF7
	for <linux-security-module@vger.kernel.org>; Tue, 10 Jun 2025 12:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749558413;
	bh=JCy8CKcVn4/R8yM8udj+pd97xBlK9sRGA7kQ5k5UhAo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a6eGpyk+06R9+yFk3qUqqFo47enQT12L35D14E7YEBcyBYFu7qKeQgr6TQ3cz73vP
	 KYpA1ORlrw7MxgZnM2TLxbE0VAPgcGJX6VgoD2r2ENJiJ4+Bl8FO6CBX2oh8Kz1Obe
	 2EeX3FmgPtUHCgP48i5UoZP9LVaIV9NMd6/YQHTz1kZQIQrN5PjZGEMDS/hKU4kbrn
	 KnW0+fFcKyL0n4socl8IhkF+6+e5Qz3ldnCyVNy9ni+tNZNyEQj6juJOaCK1KMfC+Q
	 n1f1fRXgIE0YfPftL9HzT/xrr19iHXWdKL6S/LPDwuuihjjNU7xCcuBTTqs8K1Wdps
	 TceFvpy3cQ+JA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-607b59b447bso5286483a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 10 Jun 2025 05:26:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcvPPWktBCp0H1M2nuEzp9EshgMzy2mltKR6qCT90FBdGHw0ayucPs4uxUP/GQ4GOzKdVB6XPFKaT/I5cBhgEhPvNH6DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPayXvSlsuRKev5Z5HYqLI17wP4LO8NF1En2i3JVNHqEdBaD4g
	CQKMlXY0f4ADn9A9D3TE67xHwEBJF/Yg5FYHmXYiypaoYnIqT5t5DShZsQCTrY7jPjboDho+YSf
	UkovPHGl9jUvg9rvC1ZUvu8jrDYCCTuxlMFu7nwpH
X-Google-Smtp-Source: AGHT+IG0Dgn8ULR27TC/537VfmISOF/iFFnRICf9RrkY7C4TfCEcDwQyM1o1UqRsRVoyyW8NGrk8UTfiA4bPlNo3CzE=
X-Received: by 2002:a05:6402:280d:b0:606:c388:636d with SMTP id
 4fb4d7f45d1cf-60774a83cf8mr17012106a12.27.1749558411584; Tue, 10 Jun 2025
 05:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <87h60ppbqj.fsf@toke.dk>
 <CACYkzJ6_VXiWauPBMWOzX+QHedj4noYxfmt_usUzXCiifuEuLA@mail.gmail.com>
 <87cybcdj5k.fsf@toke.dk> <CACYkzJ6SLvJNfGiQ7DegBGv2vryxtdHq8isme29ByrAeKwhwDA@mail.gmail.com>
 <877c1jerkq.fsf@toke.dk>
In-Reply-To: <877c1jerkq.fsf@toke.dk>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 10 Jun 2025 14:26:40 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7mOk2CbFpKi_eg16a81AEeTZU1O6r6zOgwAjwSReYedA@mail.gmail.com>
X-Gm-Features: AX0GCFtI5MFAeoWj6llQhRBZhvqYzZ9OL6FpBGO-f4y44UJH0k8ErkOpUkD5Ep0
Message-ID: <CACYkzJ7mOk2CbFpKi_eg16a81AEeTZU1O6r6zOgwAjwSReYedA@mail.gmail.com>
Subject: Re: [PATCH 00/12] Signed BPF programs
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Right, but this patch series has no mechanism for establishing a
> userspace loader binary as trusted (right?). The paragraph I quoted
> makes it sound like these are related, and I was trying to figure out
> what the relation was. But it sounds like the answer is that they are
> not?
>

The relation here is that no matter what we do, the kernel cannot be
the only trusted blob on the system and this was aimed at answering
questions people had earlier when I proposed the design. This patch
does add signing support and this allows us to add the following
policy, it does not directly add any user space support.

bprm_committed_creds (check signature of program, if verifies with a
separate key) add a blob that allows:

 * unsigned bpf programs
 * signed with a derived key

security_bpf:

 * Check for the right attributes for signing.
 * restrict which program types can be loaded.

(additional key hooks for restricting which keys are allowed to verify
programs).
