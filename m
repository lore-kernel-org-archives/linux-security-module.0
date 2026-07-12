Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9A6313E34
	for <linux-security-module@vger.kernel.org>; Sun, 12 Jul 2026 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783873340; cv=pass; b=OSCNPi0427yNk9hCBVURycUe9RbgvgcPUjQcBt5vZM0/by56tu7KRsBZE4HMVJTSUvLCVH7EYAx/6a/AbhxqK1vU7KPV7Bx7MgFoby+V3RSehuEOTB3rMD2PZtOJWjYqOGtm1QtbQOY+Gzl0IKF03mwkK3lPbKLLC81/k5r5LAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783873340; c=relaxed/simple;
	bh=J+iZNQQvMSCXr2hbBHz7Wo3mc0Gi3r0duqYAG2oZu7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CiXx8u6Zyk3+zkMSgGDQb0df0zkbEzf/W1oijRsDxposZCE/IT8q//4IfdCVW1f+2fpW6SJskNY+zNTTCkbePPVh4OdYx17DMKxJETf9tpW2cxKgViuWDUjJatj63AQClcYIyqto0TmRPzUIdciXasDxnVnVUZXWN5ci0K7w+Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RacuGe8L; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RacuGe8L"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc6dd436c6so28166215ad.2
        for <linux-security-module@vger.kernel.org>; Sun, 12 Jul 2026 09:22:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783873337; cv=none;
        d=google.com; s=arc-20260327;
        b=grmhvTY8g/GdOMrwehttSQG8ENTb+C5E5/d70EyN80qrMxjSZoVoTi3iEMzVfd+Yau
         xxMpWcKWfcUJi4Swq75iJY4mo99jXxqr1PS5k/pVZX4CV5GzfapXyQMFghZV7W2st9nM
         fSMB9pygcQnxhrfSa2leb/EFvNfZGXsJj+oykqxOHXtHag8deh6Z8uXzjEW3Wcm1MMbt
         tpu9u5nfVzI+pTRvADOyYH3eFH1CO2UjRx+go/5XEb0kcG9QN7aOqsE6tr6/Npp4iVfE
         U3QwCr+YCFRnFS3f+kmT/AadDKna2GWII8Ia70132Y3s3yZSGvdL9rVFwH61kVscGyby
         joNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wNQFSIoiUS5yps8KC+SWZ1gAvHIjXV4NMadqHQrQOw8=;
        fh=qc36XxNNtpAGZBddpnOoakvTb9a1lrjF4oK/bbvoup8=;
        b=Kwfgbld9+w5C/37nllsl9FP/uEmuSEdmrPisp4HSTYABmsFU3OZHKsgMXX5spmx4sq
         LMVVpjOzDcJtlRSXDSRIOA+KeuYtWlgT0xKWakqshsyAXWPhFFryT96QpsGk99WYVdFL
         ZIesV4q9IvjnnX/q2jVhvwAYGR96G48scZOQKUTWNCu5onxTVnbctLM0S3Rt06r5T5vA
         Xgs+ewVmtDBkeQFPHovw2j6SiCNPhqwcn1BpQmHM5M0tfw62sXm7Sx6ucw/tUxPnHBvC
         60tP3eSDqaZoE1+KVUcvsuv1brLhwL8aLzz0FwrZUgZ4dWNt/EnsR6u5MH2ejZW4k00y
         OvRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783873337; x=1784478137; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wNQFSIoiUS5yps8KC+SWZ1gAvHIjXV4NMadqHQrQOw8=;
        b=RacuGe8LN4plnA3Xo9TIQCTzwQDNnp6xMSC0wc9wW1zydSoq46Rz/4tcx4cc/paW1M
         foJEUEpl8KDGifywcNLPBrHUaBXperRJBeavl2NA9e1Qmi2SOnvWTCF+gEP0gtw44fuq
         U9wR9IcP4dVNglv3a55eluPRqyojM0A18tmXSQOEqi+mdK5WKvw4LVpPK7h8vMV+h2NH
         ePzOZHWyBcRSfjk2z956w5cD4wn7ROrQjtfSZ14R2486Tp3roKrerqHvaNOPq0gO+IAm
         dVuQI/oQEsFmrXJa4+3aCGSo4vDJXf76rkR0jDTDonTylX+vsatHMYIkC7SoBlzFkLS0
         Hd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783873337; x=1784478137;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wNQFSIoiUS5yps8KC+SWZ1gAvHIjXV4NMadqHQrQOw8=;
        b=db7JLdgfbW7B+dYee3J/Ozp0ivjP0Bv5t0yTol29dOL4BB4tW9oTLSPuabYu72g4O5
         dP3agypGhjOOmSSmpm70CWdfObrxmXOljjV7lSD9FZbv+1npN+Lr7HvqxlRdFEXGcRt9
         H8okfLoajbpDVigzyZCXWKUz1aqMe73l0YuAmp+EdSH3c/++/IGa169S7+QNk2X0qLRm
         JYmvFMAkIXIVCgilq0XZ2z/Zs7CPsWQk/7hT4KYD5p8kUp76HVuQOUz3T1cli+Kw2xe/
         msqNBx+U1EfUaqrO725U9IFXRS44ZfYpyWGPcGp3k/4WmzxG5TWnUiwPbxmXiN1Z3WTJ
         7O1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rou+IvB4axcQ8vhGr4GE0TCFC/3l1IsBkOKBnC9rtx3ZnaoU4oxd6C4j8acv16MLhTSEIU0ytdeCS1kq6EhK335v1EK6YU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2tITqgeSZs8WOtMReIiOcLf5n5I5PLInlwpI7CEPMwQ6lcpWA
	y63DrdPv/vB0R5mNxI5g6Y3QrlKv7MGtb3fm0JrUiBfw2E6r3qWdLyvI2tphZa5El0/jyg4OSKO
	u10EyGhbhh0o3CAI7t2G9La4YmNyUxCA3JyLiPF8t
X-Gm-Gg: AfdE7cn/6ZEc659lNnaafnpUn6S1nO6CZxZiKx1NJkb5cs5QBrCFLWL1mRz74HmlF9V
	kqYpxTifyzb1raaQgPfCNpiy7D39eyc+q1AcgAUkuOAR6Sr6yl3deNS2cX6C4GObPuigrAhaR1t
	AKDg/WzMY1kgqAXG1JM+OQy52Zv18FYKN5FhiOGyvtYvRjG9yWtc2HjI9o+x6isbg8creswcnqD
	mcLVD0xSOyM9jan+tU0vE7pN0vtg1/5axw1ZrEy7Bz1ZSJIgLDtBKS0zDi5GsnhrWsg7867m41v
	0z/jokA=
X-Received: by 2002:a17:902:f706:b0:2c9:97a8:afef with SMTP id
 d9443c01a7336-2ce9f3c2c44mr56463405ad.40.1783873337523; Sun, 12 Jul 2026
 09:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712013941.4570-1-fmancera@suse.de> <20260712013941.4570-12-fmancera@suse.de>
In-Reply-To: <20260712013941.4570-12-fmancera@suse.de>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 12 Jul 2026 12:22:04 -0400
X-Gm-Features: AVVi8CeR6p9IFdHxiLZpYHAlyp8c47JdAudStQqM7LnXYkS82gL2ns4MbJCsLNc
Message-ID: <CAHC9VhTA8Y+BLOcLcv6X9u3nRU=X7NQz-u4kZuVNL-Yz1mWKxw@mail.gmail.com>
Subject: Re: [PATCH 11/13 RFC net-next] net: cipso: guard IPv4 packet
 manipulation functions
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	idosch@nvidia.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 11, 2026 at 9:41=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> To enable compiling the network stack without IPv4, the CIPSO functions
> that manipulate IPv4 options and generate ICMP errors must be bypassed.
>
> Ideally, CIPSO should not be compiled when IPv4 is disabled but
> currently it is too integrated within netlabel, so let's just bypassed
> the relevant functions.
>
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>  net/ipv4/cipso_ipv4.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

I think I would prefer to make CONFIG_NETLABEL dependent on
CONFIG_IPV4 at this point in time.  This will keep the code cleaner
and allow time to do the proper work of wrapping the CIPSO code with
CONFIG_CIPSO (or similar) and making that dependent on CONFIG_IPV4.

--=20
paul-moore.com
