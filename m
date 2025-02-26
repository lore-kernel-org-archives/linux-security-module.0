Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E6C2512CF
	for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601469; cv=none; b=q4wc8ZpsEzUQdADJazhGoSTqdKwjkIVzZ9OJbSUyH74E3Rzp+VLTaTzS49YrhKpY8/DQtCDm9LtpQ1nuDSn4I7s0pq5TCQbbumr6EYFFjoUfrt1an//mNWlH63CgB/GITEHVU7uQgH0TpTEHS7rKq2ZwxsMRSxjNtQy2nqQwyY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601469; c=relaxed/simple;
	bh=iFWhRPyJmvvsiybpf94Dpp37+uigPtTulNHGuHIzrH4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RuYNKQ22UgIAeZo8qtFdXCWalfN3M02h1gDq8680AZJA+kdaXTrvU6CjcdY3eBGTNF2AkqcKJKdWYnLzr95ac9WfcQa88OXpPgly0mxNip+NJz1U1jqWuMZaiqN/0DvKV71jtOldDR28CzFN2s1qcrOXSP6Oxaijh3FqBIOv484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0QgPtlq+; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0QgPtlq+"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5e4987b2107so190131a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 12:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740601466; x=1741206266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5HjEmf6zI3uVsACPtj0IDjnQzDbyRsoOFTng7ArnK4=;
        b=0QgPtlq+1UdG1JnAIh9hqFwBlpM2kCzoX+08VRt1+6CNUxV/F/wWJOj3b2Ufh5mQAz
         L5vTiFlOuMVvRRs8iF3hRRITPemKT/AB1reBKFezUIAL8jM3NzwmP3i6LhRSLO1+MKbB
         64nervXaaYp6eJL+JYncsi65VMzU7bNzhDem1gOolkKaQD9SzoDvrOgO+9Xuu3FSRILY
         c+NbWIjUBe2K9WCGB8P4aUpODHq1l0VIHCHdz0+wxzydjdSieezEAYp6v51HClyTXoTs
         2NrHi8+a8/FSChtNFCuiVBUdeIQtCIXGI2+vpik1+CnG93wZol07rAUt2CSmhoaHYzDG
         ASJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740601466; x=1741206266;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j5HjEmf6zI3uVsACPtj0IDjnQzDbyRsoOFTng7ArnK4=;
        b=K94iiCRY3aoTkKG86Jb/9u/PhBsEe3U3ovUSDtuFLokg+SZiu8r5YiL2PTAaf1dvIS
         PrMe7qJEAaaMrAfVk6kzgLM91NaqZMUQuulxKIfC9O0QThLalHoHCy/c9FgQFM9j2upj
         LiyYdtzCt3pEEa46knz6x/FLJ0YZ4Am+oz4l4WN/kOP8h2UzEcT2bvumvR9PtHhCy6O3
         NivdaPZrzZAhRPdaC2syZ+wlcIeB6aelKEemTCpc79yHmxGeL+uT202gxlzdBKblYNHB
         LsXVPL0UihiBHwrla2zA+F5uVfgyQj4his2yANjxmI9JN6tMqqNIdRFg7mWGntLJXSed
         KwBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGJL3nDJU9ekRMXmUWSlHT+AOaWKiv6g98mWdNs25yMr8vS0GhHzR9UwjJfQHrFOAHoxayK4vWSU2bHHxvKHyvxDxB0B8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLpeNPU0u0gg/sy1YEuKW1aJoR0lV9CuSdiR6qtQ1rgFQaDz8D
	0VORDUa1HHu4Sa9/l6CS0GJwZ5aW9T8M9Ge5FVox4wZY9CMux1QT71o36nz0RzaPGj91aPbDc+Z
	ymQ==
X-Google-Smtp-Source: AGHT+IFrxoll1MD7UHqls7EiRvzGp8NMB0IfiuwW4ozw145cHL5lQA37kDHTx8jx1EQOGS0Jj44sXGKknIY=
X-Received: from edben26.prod.google.com ([2002:a05:6402:529a:b0:5e0:40e5:1607])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:40ce:b0:5de:dc08:9cc5
 with SMTP id 4fb4d7f45d1cf-5e4a0d46bccmr6357700a12.7.1740601465988; Wed, 26
 Feb 2025 12:24:25 -0800 (PST)
Date: Wed, 26 Feb 2025 20:24:22 +0000
In-Reply-To: <7vl6uylhzgkokl42bz36d5g3krcusqf7mdy4bd7tblcjckatrw@ullu2kblovji>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250124154445.162841-1-gnoack@google.com> <20250211.Ree5bu6Eph2p@digikod.net>
 <22olfm76rcgjfs4vrr3adtbznsnz47kaehlr3ljn6e5jkc6waq@ue7azstxlwfv>
 <20250211.ieSoo7Phe5oh@digikod.net> <3unkhxarmiddobfjvojx4sdpgitjld26udcagka2ocgrb6c2jc@dcg4w5yk5mut>
 <20250211.oavooPhap9OX@digikod.net> <7vl6uylhzgkokl42bz36d5g3krcusqf7mdy4bd7tblcjckatrw@ullu2kblovji>
Message-ID: <Z794dm_xmViQ_lFF@google.com>
Subject: Re: [PATCH 1/2] landlock: Minor typo and grammar fixes in IPC scoping documentation
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, linux-security-module@vger.kernel.org, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tanya Agarwal <tanyaagarwal25699@gmail.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, tools@kernel.org, linux-doc@vger.kernel.org, 
	linux-man@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello!

On Wed, Feb 12, 2025 at 04:06:06PM +0100, Alejandro Colomar wrote:
> So you could really use man9 for internal Landlock stuff.  Even if I
> think generated documentation isn't ideal, it's better than nothing.
> Being able to use man(1) for reading kernel documentation would still be
> a nice feature.
>=20
> And while I can't run all the linters that I run on hand-written docs on
> generated pages (because generated source necessarily triggers many
> false positives), I could still run some, which would trigger some
> accidents in the docs, and would also detect bugs in the software
> translating the docs from one language to another.
>=20
> So, I'd still recommend you considering man9.

This is different to the BPF helpers; Landlock's existing man pages documen=
t
user space APIs, and the largest part of the kernel-side .rst documentation=
 for
Landlock also covers only user space. Only a small part of the .rst
documentation is about kernel internals.

If I understood that correctly, section 9 is supposed to be document things=
 that
are relevant to kernel developers, right?  So it doesn't sound like the rig=
ht
place for the documentation that we have?

=E2=80=94G=C3=BCnther
