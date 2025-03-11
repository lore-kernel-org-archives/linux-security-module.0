Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E37825DD00
	for <linux-security-module@vger.kernel.org>; Tue, 11 Mar 2025 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706063; cv=none; b=CFWyWWFMCtepDMg3HnDoEMG41b/FHisfAg3CHGAAP+sPWDxfG62eOGYzM9N7T9Np8u6GnLPVb1wPdp9QIjO5KZXzdCAP7TgoMeMzDVnAbTmEs7UTPdBirtZSZbfdnpi7R9Myht9zl/TQw3FHmatGfq5NFsFbTFCeeKbNe+r+4R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706063; c=relaxed/simple;
	bh=iBv0SBI0u0mqJ2hLDa+I/+nk5rpoHMCvlmD4u1xS/9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAvE7gwPQFDBqozTB/MFAwDNytoCwVKkPpbxSzMqJ8Z+8kBZpAozeAq6uZ9EwPAoWCXukkhHDenaIjaqKKnWJ7fKJpytXgDftz822Qo0Rq5/UNSc//ffRvb94vjdNVfDA+k1/tASuL/GBxb/WmzLKxf5ShiCPa1yvNKu2cdbF2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PpvvgpV/; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PpvvgpV/"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c55b53a459so160924885a.3
        for <linux-security-module@vger.kernel.org>; Tue, 11 Mar 2025 08:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741706060; x=1742310860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Evy3i/UzIkhyI0KxEccbdCNHkQedTc8R4M/ZChk2KNY=;
        b=PpvvgpV/NLuHfdiYMspZ6IHKTAu+rOTZU1Nh0B0YZZQXC95ea57I2qaodMMNZA2t+b
         B47Mm8OukEQe+CM/hMinDhRl8iJ4n6/DOroAR5tnxl5Pg574dWV+uaGrhUXC4Jtt7zS4
         S3xyjcgTBqT5UonvENBQPoQIj4mbmi86rwEvvUBuwQHCjT8SLtIotGtu8gHTgnuZi8Bm
         cwEV0MXxUQmTNZEizpc1Q2/sdMhizV4PQNVvIOqcGu+ONEEOZPuzHFcBLXqdo4Rq2C02
         gyPcGxCKEv3tSt5G8sgLdWDABZE2FQC6HBnBnhP3TO8a8otKmlOCNTcRFGV174I4JJ36
         CsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741706060; x=1742310860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Evy3i/UzIkhyI0KxEccbdCNHkQedTc8R4M/ZChk2KNY=;
        b=Uji+JAIpOCh2ztmGImvpSI/9Rrn6RGPsAAZKQwdK9GVmdagKlH6PFwWy+iqXHfUmsX
         2tSMZAHMW5stRFTAoCu4soTvvtPy5El8M7u9xUbEcgmxH5n/5cOYc2ZoL84CmZlYCrOf
         N3F4pjBw4aL9NqWlsFZUROTtv705bf3P0GJrZN4T4Eur4Rcu3ijJkFjRhCB/wsLlZsZB
         /tcIr0Fy97kBnrf0oHCTTM81luPypXA01Yt8n5/vCBFSvI5y/CI+t4plPzJneXrGrC/i
         6RiE44JD/SEW1RNO89QvHI/1oUaojn4V+K3FQXRVdLPbqV1zMqinFYR3TzFXfwP5MfIt
         cY4w==
X-Forwarded-Encrypted: i=1; AJvYcCUZ9izxwdccouIR4MnMiusVAi+PxYBXU6qeV2k4+z0ew15x7vZ3S79nBm1AlwBM+XO6r1GKrnGD4Vf3qA+gY/Q/fEn2YK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV/+mtiyyENylIk+/uuKcNqJQ4aAIj3r6TynVpMgVA3uRLr7dR
	Mwrc8BCtkjygRmKbxO1r4Cgm50DsssoSohN6TGY/GILawEnK+Tevc/5icnCsloo5p8RmZfu0qkc
	ncXb9vBF6hqB3eiUfFX5IYoek7+/cjRWRaxZ0
X-Gm-Gg: ASbGncuxVe4y+f3Slj3OCjRNIjsrctugsOaZ2qOm6l9MnJAFrO3uF03HypO17EHNk+D
	yJLrP0neUzOZvOmfUwq5TYDBhkZAx+684IIybU7axk7wlB1SaN6+K6hI4u6CQNn23bFMgaholDX
	mDVgDZv3qF5CXtJsRfBNWxDnm00A==
X-Google-Smtp-Source: AGHT+IFSa2EhAAeUGu4Iit9E0/qpbd2+7yC/0N9EYTysdPGCdpU8ni/m9o25fyB0KM5SpgmA8E6N/2aHbDADMxT2F18=
X-Received: by 2002:a05:620a:618e:b0:7c5:4c49:76a5 with SMTP id
 af79cd13be357-7c54c4981admr1323514285a.12.1741706060070; Tue, 11 Mar 2025
 08:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801171747.3155893-1-kpsingh@kernel.org> <20250311133731.GB17395@linux-l9pv.suse>
In-Reply-To: <20250311133731.GB17395@linux-l9pv.suse>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 11 Mar 2025 11:14:08 -0400
X-Gm-Features: AQ5f1Jqr4_hVE1x1R6hZKxzTP8FN-7YzAhoE2LEe81DYBasZfYzjWj8gWtHnCQg
Message-ID: <CAHC9VhQxhe6Gqjzri+SXi_OdW_7tSM06A7M9_O=FPef1AsuTkA@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: joeyli <jlee@suse.com>
Cc: KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org, nathan@kernel.org, Jiri Kosina <JKosina@suse.cz>, 
	Michal Suchanek <msuchanek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 9:37=E2=80=AFAM joeyli <jlee@suse.com> wrote:
>
> Hi KP,
>
> On Thu, Aug 01, 2024 at 07:17:47PM +0200, KP Singh wrote:
> > With LSMs using static calls, early_lsm_init needs to wait for setup_ar=
ch
> > for architecture specific functionality which includes jump tables and
> > static calls to be initialized.
> >
> > This only affects "early LSMs" i.e. only lockdown when
> > CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is set.
> >
> > Fixes: 2732ad5ecd5b ("lsm: replace indirect LSM hook calls with static =
calls")
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
>
> I have tested acpi table override function by
> CONFIG_ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD option. As this patch
> description, the early LSM can NOT lockdown acpi table override in early
> boot stage now.

It's been years since I've had to an ACPI DSDT override, but just so
I'm clear, this replacement table needs to be bundled in the initrd,
yes?  Assuming that's the case, I think that's likely okay as anyone
who cares enough about kernel integrity to run Lockdown should also be
protecting the kernel/initrd with a firmware and bootloader chain that
ensures only authorized images are booted.  If the user doesn't put
any protections in place to ensure only authorized kernels/initrds are
booted, Lockdown is a bit silly anyway.

> Do you have any plan to fix the early lockdown LSM? Or I missed any fix
> patch in kernel mailing list?

--=20
paul-moore.com
