Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0263093CF
	for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779552381; cv=pass; b=ecXuzOBgA2SQlsc5Rw/V6m6SafGh0sFNpJmmusglbh22nVL7z27dO8uhyg99730btvXo7U/LXseALNxzFthb0UbeJmjgbHlvjDnPl7Xx/AfcSRUH9hqnW1BohTmu0ZOtmsIOuoUwvH5EqJrqfDRQ18frzhLILYMzK6ohMNj6oUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779552381; c=relaxed/simple;
	bh=5RT6gx3WNSCcANgMySSyAw/pGeqa7pvPn+JlBzeRtfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=H7tfggQw2Uwx1HUPSQdCD/crRaqU+alfXx83aJfTal4Udn3fdbXSKbIVzJCzn0Zfq384BOJfUVEK/aC2riP2aqrZbrdJYvFN06Pefeax+5LGx5lzCVFSox+h8GzEsI5BD2l3kOXXQ5hVGMHqaeJvtYBP99dmUW38SdxE2eYl4G0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fWDD8NbD; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fWDD8NbD"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c802803ac17so3570871a12.1
        for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 09:06:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779552378; cv=none;
        d=google.com; s=arc-20240605;
        b=jEICqr8amD1AQMm38Kk7CZh5Xx/JR3p5/CnjAHexGfl4cilnC2640c771sDVuKZVW3
         EJFvBAH6D8uOsC8p+cpjdKJNmoWPBkh2ByZOec6MnbUeFRIX6t9g6cpLBaXi0jotp3CO
         lGDPe5djTgJxUWWDKfCoDr1IFs64lzLhi7z6xgrtqorGhtsSxQrAy05ItcojBKFX3Ogm
         6RYabyHFt2CZhdW0SuFyW8uvRgibmfh5Q6f52TGPbwiJbZuutO0yDB7Fw21S7Tr7toYd
         M0kHcH81PG+ibbp1AmqbDr7qKpVDoZuZnB27wH0qurWqiBjGmmJyCeOL/ZA0ZSnFkoya
         Aarg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YzuxNquxS4blmJZDdgOjr52REsd/YHhwoXobXMMFVCg=;
        fh=Ooq/vPMeOvoqvU3zfDVeXIN/eVHMPHkw6e6FCwilgxg=;
        b=ERZkKXTwf1zK6XfajERjl0HW9e2pce8bPotkA6Xv8HbwRLKKMHo5hXkNU9YjjvB6eR
         xT+DU7gdWNRIWQEErRse16ImjIOB7vzLlY+z84P9o9Yi/Sj41WLE1NEd79txUvem3KpN
         SDB7fGabfnGvMEF5qWb6qYHWVMNQcbZttdoS1IKfCyzfGuG+DTZa5MlGtvmwDUeSFkum
         fxRIdxpHAo+UPgBk0zVpFJs7tJO4ujjg13RVMBCv3PA/hqAlvQOGupfHkvUQt7PJN+fX
         gVxFtt+gLf8H5lL4KFMUM90p5r9gv6I88oA9QWRaRv8DXKXIYPHtSz6i5diPJZmzbPWJ
         Oe3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779552378; x=1780157178; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzuxNquxS4blmJZDdgOjr52REsd/YHhwoXobXMMFVCg=;
        b=fWDD8NbDhVvdl8zej7KFyXn8LmxJy513BUWU2lNZU9rKPQxqho6+WyVpxmUjW+ra5X
         E+01/mpHsI5F6N1BZ4OkPtQZXpZ6pNsRc9rLZ0L64H0CoLeBN0eSKU43n6KGPmrTYODD
         yKJPkv5NFeHyXpgcN/KIyxB66XaecptJF60k7y75l9zOQ/7/hxAd2Wanohcr/DIZlhe5
         OFa4rz8hbIKjvtHeOhp6DSRVEzWBymuxfzcbqtG1TTmraubl/GIFNbfO6pO8NKySJkl3
         A8Jpay9L1cntQIPzH0f6Y9Iw6ya8QRTPw284wuCRtiOT3psWKpnm7rDSGpFtl8zugACd
         r4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779552378; x=1780157178;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YzuxNquxS4blmJZDdgOjr52REsd/YHhwoXobXMMFVCg=;
        b=p11mzg+qVtH8kAd5MtwSjQGq3IixtH6g0LRQPX/6MCIyOgTEkyLWRozw9yyob76gdD
         uvwKAWQ8nnaXCRbEshtZDWB2ITl6GrfyCgvTV4l4l8r1HS1npEV8/Q1tPJUWvzA4ugcb
         dmuGmkoRrsvvJZOVmxbd+U2az78EFDbqFxXDVe06MjA3aosD75haxpUrR+iuR9yZvxky
         SDvpqBlxglNX2l8RuxMxH1gSXUBJnzDJNmUUDHPHE5Oi4OWPa5dTVYEveH4FqAoYyekQ
         U/9Za5Ban4F8iXTeITKjK/jlAfI9rPq9cgSXdciqncJ7PVmVWR+QyzompZ2A1tpUU8mf
         48Gw==
X-Forwarded-Encrypted: i=1; AFNElJ/IIiWbTLY9WJRgyCGtxXfVr9J2z96r8WuBd5J3KlgsrVzx+KiwKtT9G6KxucHQaVRHVBPL6ffZNAZ2Hn5Q8fFeOrJ95/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx2ce80ZagaM69V+U6jx2GWbOyL5P3tqbc0yRKyOqvUrRaVDmv
	shGPrA+kVrxOcC1W7koNq6djGfMvT68mzwcuGoOwc/09GASni2sfoF/iG0IU3kLxnl0zrNi4KjV
	bf3XGOGmJJ7IEiPT/5CRmNgogeEEIT3mrediNPXOE
X-Gm-Gg: Acq92OFmgetBTFgmYjC8SKLWj9IhWWRaxRTjL+5I1V6PslNM8qbPnstJgBX6oGoLBwN
	3yh6M0rvF0eaX+GxFPeTJD569Osv1CcfvKgwAQ3YGF0PEJnd7yFbCQZgSWmfDdpfzpkitIN/eAN
	eGr7fNYDHTjxWmQel4rtMZt9nXbNDQVvhVyRH7YUxqhTkv3h4KFINxyNFZlqC4KhSR/S0ET8LPe
	ERlK7wyKp4967yFe18wglG7XFUJFe+TaTPBynxKF1KUyeS9c8wrcjzJUQllVK73ogRcSa1R43oO
	BLed
X-Received: by 2002:a05:6a20:a11b:b0:398:7c6b:8615 with SMTP id
 adf61e73a8af0-3b328c704aemr8691849637.6.1779552377963; Sat, 23 May 2026
 09:06:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523160025.16363-2-paul@paul-moore.com>
In-Reply-To: <20260523160025.16363-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 23 May 2026 12:06:06 -0400
X-Gm-Features: AVHnY4Ksrg5MgyuLuXO5H_htBNxpD8uLxSvwcm-hjCJO3jA1M6Rnf7obQMcr7Vo
Message-ID: <CAHC9VhR6RSq1TUgAyvHmaF01h87Cazy=BNJhk654BP8yfeSwng@mail.gmail.com>
Subject: Re: [PATCH] lsm,bpf: fix security_bpf_prog_load() error handling
To: bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 12:00=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> If security_bpf_prog_load() fails there is no need to call into
> security_bpf_prog_free() as the LSM will handle the cleanup of any partia=
l
> LSM state before returning to the caller with an error.  Thankfully this
> isn't an issue with any of the existing code as the LSMs which currently
> provide BPF hook callback implementations don't allocate any internal
> state, but this is something we want to fix for potential future users.
>
> Cc: bpf@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  kernel/bpf/syscall.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Alexei, I'm assuming you would prefer to take this via the BPF tree?

--=20
paul-moore.com
