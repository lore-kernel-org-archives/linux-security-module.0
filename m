Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B9521A459
	for <linux-security-module@vger.kernel.org>; Fri, 26 Jun 2026 01:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782437915; cv=pass; b=PtPNME2YP7fEGOL0KwJNzmvwbE2cpc7II6YikDu9nai5t5/6PapMdPzPQ2dIvV3eyE2jqTnZXtNudXpVISjzeREj5QHPRIlEMMxaljAgKsg6N5tNJaE4yYnNv0t0R73ZwN6Bwj8liv7PY47l0bo1ujQP+RWatEueEN3zIHKb9uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782437915; c=relaxed/simple;
	bh=9l7Zyd74R2894i2sVz8bx7i81K0qtgAvXYMerMMV0Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2zVQ8PVEdf5QGnZ4B+ewhUBbKdf6h5ojTliia7yYWy47h+FCNdd1G5tqMCT9SyuFDSWu5YGKZc4jqsSUy1gmQ5e/Zm98inRrD/yLGSqPimXcRwARdMCXDUzILDUbm3Gnq4FVyUAR9wyDLmlE0yKsl5ang/D2zgdNS6oUtVA/44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=D2eQwc8+; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="D2eQwc8+"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c80879c36eso1936335ad.1
        for <linux-security-module@vger.kernel.org>; Thu, 25 Jun 2026 18:38:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782437913; cv=none;
        d=google.com; s=arc-20260327;
        b=ieXVOx64aBL0dXL9Gh0mk/yqPXYYJkVzZSdY5evs2iq+NMoKDgc7OHvbPEEBAwzMAb
         bORHPSERkbjHVEUwGPQAJGkmT46/l/wfxwAXa714QreuSlsolMXSylxq6jEx9n9mmeRd
         nK5OSLLtM6wOVY/EZLOEXnXzLJasAbIgU+DPnyijMiNAr3bA1OK6iH6s4ZRo3S/Ra/4a
         ZxFYadzu2H8sgb47S2yVBy7Pnxl6lkDeu5pV9VmHAAKY/t9Qn3gduHofyl2ZVKXZp74e
         I/KbsvvahJiXAq0xktHRGuitMGcL/s2Lr8MqII0qBvT/rOASo6+gwnL4GDXR076YtP/R
         MU1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YhhogthNj9XjiqAxxo/P6pHEwVbLooE1/KogGrO0nVc=;
        fh=OAAWs/xb99Y3Xp+lVhQK+sFv5W65VhDvNOo41DX8Kfc=;
        b=Hmt6JFwyian/9BRDvXJCOFeTOcZAcOQYvLeOH14jxibypJyB4iGRSLWwCnun6A6OSo
         9FDvGwGxRY5ghAmZEOE6n9ksyXFNcfS4gZIJjrrgKEA0eLyfRFaEmslndAxv5PqQrycM
         Ig/boMLEZ8dt9ntdaybdlWninJnzJPdDYSkxILYpQR76J/D8OqnQRcIkxxXXFgh4Lw9H
         BjzU03FZbikTNuJm4Tlmq6asRsC83U2lsLYi8cShKR28IyKsevz9ACE/S3k02HLbwj0O
         NKVPlq9JtcOXBXDCF7oYwbVd4AsJf9hFA73WSct9c81P+TOGkf8ZFj2ntvPcu/a8Rc8i
         Kf+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782437913; x=1783042713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhhogthNj9XjiqAxxo/P6pHEwVbLooE1/KogGrO0nVc=;
        b=D2eQwc8+xKL4aeTydJj8JtLLTxX4EnKxds553e1ugRPjALEs81Edq7BVh9pXWMYzI0
         reme1YbDZEEyCX/C8h3MmX/22bkBI+TCEhnhKKMEFiNc7+9N+HOcHOaN33jmWbN3KYQj
         GLOKjZaKpJBMU9Va+Cb6j5HS0tqntUAHIy+2bLyE7Ut/WqMJZsCfmSMAdmIfJZpSSPJs
         LIegsTee+ZNm35hBqjkAcCCMny4Ei/3JgBk9Slfc03eKK9GKZy2JmMDPkcLlBJsyanA5
         +mUr0Wzh0yeB3mJLi+CtJqsov9HtubgYhNheVRD0TxLZo+C0gfQCz0I5OJ0tQyKZsqLJ
         1vsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782437913; x=1783042713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YhhogthNj9XjiqAxxo/P6pHEwVbLooE1/KogGrO0nVc=;
        b=mt6Ps0Y4PL40gzoHmBXt2XIbcT/MKIXbc+bBHKyem9L9//m5cUrkRb4oBhT+NFYMcx
         ClIPPbXR5dxqBNrXVkpgecmUTsJN3WR5zZpFH41BEKXzbnMbEsuA+c9XhQKf9nxTKI0S
         S3V4HLHHJ4jF+2phUoJqi5Qk1b5wqGSpDvwfffPxpco6SVPfdu8z0+wTCqYwiosIG78R
         34a8rJhRK4k4U29PmyrDLwuJobbArMrJE6//yPtXXOBTmGBhlc4S+ow93my628cEN8/K
         Nvnni8n09SIQDzieDTXTZkP1+3F2YDgyB4FTGo/IUyq1KoLX3asxbGUCTPw1pNhlxQRV
         aE7Q==
X-Forwarded-Encrypted: i=1; AHgh+RqGaRtBj/nJ1gxKbiM/v8OR+nHE6aShj1Ae6DiTK8Ijq+xR5y8LrQlfeeXxfLelpeNI0JbLHBT5KwdPY9LpWOR1WdYPNYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ht9gJGHRrjKUdLGHeCBXkEdqmR/nASggOkoBxUMO5QH5bc/1
	Ep0Q31V5Jgw9wAxQHFJJRHykLbB7NNhO3flYHRAffWbLTcvAVojpyw5kZImHukAIM7unCIdNXux
	y1vSo/VlRm2r9itlpM052WIBSkD6VJlaRCBuEm1HE
X-Gm-Gg: AfdE7ckOx3aszoYWtLMbrrxrbYqnUhf5XKuTeto+xXkpcKMjSALysf6NJnB2hWw4Tar
	SaP+pqy8kSsYMmHg4uIfLAXQDTFbevguwnK2zxzFtHPzICUKXFZXgedSisqBFllvURxgkTbTc8b
	mEnQ+geDXJ8YtyCMWgNAktj/LKW5Feh9WAggxDzAehBdCL2LXE+R/C+HZS7zoK6438UVC76MHa/
	zFUXwt65BmYaBNeyoHQtFkQo7bMbLUdyZLiU2vNpXCO9R3xbgPuZ0itbNOXe/skt+Y6Jlx529mr
	aNcWcjw=
X-Received: by 2002:a17:903:37ce:b0:2b0:badc:c9cf with SMTP id
 d9443c01a7336-2c7c3e6b287mr117609735ad.13.1782437913330; Thu, 25 Jun 2026
 18:38:33 -0700 (PDT)
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
 <DJIL18C2F40B.39U9WHD43SDBR@gmail.com>
In-Reply-To: <DJIL18C2F40B.39U9WHD43SDBR@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 25 Jun 2026 21:38:20 -0400
X-Gm-Features: AVVi8Cc9HRHCKG4lPYnMRDI4DdlvNLRJbJ2MdxSHsz2LRRiHOW7j0FHnRgMqMnM
Message-ID: <CAHC9VhQsjW0OJhKYUNEdkt_31oo56aMusDTANDOAQFNQwCpo4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Verify signed loader metadata at
 load time
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org, kpsingh@kernel.org, 
	James.Bottomley@hansenpartnership.com, bboscaccy@linux.microsoft.com, 
	memxor@gmail.com, torvalds@linux-foundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 9:16=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Thu Jun 25, 2026 at 5:59 PM PDT, Paul Moore wrote:
> >
> > For all the reasons I gave previously, I can't support moving the
> > existing security_bpf_prog_load() hook at this point in time.
>
> Paul,
> it's not up to you to approve or deny where security_bpf_prog_load()
> is called within bpf subsystem as long as it doesn't affect behavior.
> Daniel's patch doesn't change observable state from LSMs pov.
> It merely moves the call from syscall.c to verifier.c.

Alexei,
It is my responsibility to speak up and voice my opinion about LSM
hook placement; arguably that is one of the LSM maintainer's larger
responsibilities.  Non-trivial work, including several allocations
(which can be quite large in some cases), occurs between the current
placement of security_bpf_prog_load() and Daniel's proposed location.
We must preserve the existing security_bpf_prog_load() call site.

> So we're going to proceed.

Oh goodie, will the fun ever stop?

--=20
paul-moore.com
