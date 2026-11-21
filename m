Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795282062;
	b=O+45Gn1tB2hymUcit1InZalIM9ZI3bq6jPX5CkRZWndqB3FksrS5SFOkCHkDSK8dgl6c
	 ovf25mJtzyYW5hF1uSSuVrRan520V1ZPWaJCx756QTB3Ttu8jR8CAkEq7ujuky6v1308J
	 TJQ+fiLSv4OSP8lUdOrl8P04niDWJ0M4KrDmjZ6NHvbk09SGcZFHUhZM4tApe5XHz5KTj
	 JhHKhIk5oLyEpWu1j2HkQ5E/bOpdffUODrZp1oUnBLZ6BB1v+8mvWI0Gda448t2qExWSE
	 1embKpAlPQacnBehTXqFuQXHft3Xz2ozIxGT7rseyhFqlADg4/BtmQhfC+lp6Izbu2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795282062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ktBKIek4EMk6enUgNGM8Irq1UakO1dTw/0fxPeN+ZzU=;
	b=Op5/SjyL3EMz0ieHO8nENVL2FBBtHrF+vLkeUrb+LVlS08CTjiAoavTjbZMJpLvU2v5n
	 6BOT+lPxJmcRXZs/aJQCLGpKMuc2lRntDfix1Ha8GW678v+jb/t0AGo4pW5OOLqyHeppV
	 l3aYYWdlK8Xa6xm0YZ8naDg6zx0VF0X9UOx22HVJUXsP9syrRRk0xnCckNtc9m9ZLqgSw
	 Fre8Um3kZqQ4uI070Qx+eeIcoo5d3IyfGSiEzCAAIwVY9QiphAH+WgH4PyZloVjLAtm51
	 yzQRAvhYyvYjxM685owYmgGGFhrSBasVbAqfCEUFtltlpeiT6aJQOnsa7iWBbaJVjpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=northecho.dev;
	spf=none smtp.mailfrom=northecho.dev;
	dkim=pass header.d=northecho-dev.20260707.gappssmtp.com header.i=@northecho-dev.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hVkSObN0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD83E606A320
	for <linux-security-module@vger.kernel.org>; Sat, 21 Nov 2026 17:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD83E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20260707.gappssmtp.com header.i=@northecho-dev.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hVkSObN0
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-86156081432so492484a34.0
        for <linux-security-module@vger.kernel.org>; Sat, 21 Nov 2026 09:27:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795282060; cv=none;
        d=google.com; s=arc-20260327;
        b=SwDAt3DDBeJKSni5ZxX+siXdKaZVa/wdwLd+sQr7z50tztnafYImsckp8AFDXvyY+w
         o07UlrZpK7QMJiF+qb+L2f3TzWniNe4GjL5JMpgtfV4fV1SkBeJGxv0k2ZK+FosyW4Q0
         BEUcX+IxXQolPsUi22iTh93YCUWgDVqhGfRqm7ABibCuk1HmCb7nYozLIHUUun5tnCa/
         sANDyJq91vOkWK3XYpAgdNl3Ts+up774WkxfdHGmDG0ZX4yEonENPdqj7WAmeF9Vm/4Y
         OESfNWigFf9OMkg76+64y62tVVu1UU/24tQZDLPKDHxiHr6hspAlGRtZsZG4B9a8LExE
         dZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ktBKIek4EMk6enUgNGM8Irq1UakO1dTw/0fxPeN+ZzU=;
        fh=3FA5T25OR9RVDCui7jgWpECLR0VI/eupm3axXAradvA=;
        b=bKPfT5Ekw+XpvX2j+Yo3Jz0/6qFRei17Wu59KBZcEdew+Vs/1n4tEFpIczcUPeCEFv
         d4AuezSX5qxVqv5X263jgmf4ozpyHIh9Vr0I3Wl8H//NBpYGMNAV6Yq8hiS/rhYLGDwz
         MSGgKsRdbpFc3067PZ6t7IAVFnSxsaDQGo4X++tdcDqGWezYWztFdybecNATTTQo8QH9
         x3OygIJPd43ioq/ZqIsDzmUQSGuDdyPgtY+bZcqvvAOca/xJua8kJHRCCdOtCzJyfHrW
         cvY8CUSn0OqAn+hFOBpPUkDwmAmwpN6KANNS5UrkcrE5jQYC84bZ9UXH/tGv/9CNtxoh
         Rsrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20260707.gappssmtp.com; s=20260707; t=1795282060; x=1795886860; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ktBKIek4EMk6enUgNGM8Irq1UakO1dTw/0fxPeN+ZzU=;
        b=hVkSObN0rdMle4xWlrloNKlZ+tPLJhlyNiJ750y4bBrNo2nvb0wfhDdW7IVPCM4C2Q
         NptodQkOkNTHcNfbS2iZHysFUP/bVIT6vuRS9JfEkVduHlDKT0dIM8uBzHDYnHiTe1Y6
         oAMUKBaWV2BrWvzQQ5gqPKRzWuMn+oAQMgz/Zf23OnyhxtwqG3XiJ1vVWXB7f/f3nR5J
         bVHn+cHuJDH+s+6UsHU7+mSGMBvtpBm/ASA14c9asxyKXKK2BpmTGZwj64sCCKU4jCjy
         c/RI86xCw+18lYMXHLmqZShhzCrQVw6InOqCyCZs6yY7H4U+rSoMUbWi2oR/9VD1MJBX
         9Fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795282060; x=1795886860;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ktBKIek4EMk6enUgNGM8Irq1UakO1dTw/0fxPeN+ZzU=;
        b=SXBhRa6PDZeg66drYfIG0Y5NVWSmdcGSxEXL6EDih6e71BHytpoEyT16351f6jGJYL
         Nepumir+V/lNGwBzLE2bt7K3XJ8YQol2ThothmkFlvdsb8Qw70DdBMOiui1FHWB6iaxA
         jfKyvfeJEyIJ0Mzf1R/y8V9iu1z+GjRgkmVU9w7WuiAdFxd3/L/RWC9UKeIbxxxFDIXN
         fB55nXybQlMEktd01bbDd7i76YnQhW1ATkgsSdRPgK99Mz5+CHgjuPB32vAJN7gG3eRj
         gwfTFN70DwKeXU6AhU4vDsckd/u2srpNa83SaIPSKP84emX3lWH33ur/CXu+mDBPVsNS
         FGLQ==
X-Forwarded-Encrypted: i=1; AL+hErFk969GYnUzR1dcRiCiMxxtnubIiBr0G1TBtkj0kfuaRAdZRnr4GOmiokodL/gRoJs5WM2Ck6M36XBiGxWBLH1TdeCQd1k=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BEsRWmpVGDHPUA06LkVGIfFZKgZT6e4V2ux2ELIJ2gfXWl5/q
	QvMHdgTZQMbnZdwkLEkLUyzoPolCmfyCfIeNE3vRSbPTvDWZu9jzxO3LZrdrTv0w2k1rwvT7OQ1
	kNFwjdqxBpCSioQ69+xPTAjLvPDSYlLibiCrS0kXZfxk=
X-Gm-Gg: AZFdTZcQWTsZ13x5tiSvNiE6WfMeDlVFoZkUaby2tBYirDopKihJlm4lUQnJihy4Ucm
	vR/x6iy2U3vAaeiLceqGriM1G10m3sfIwExRQAmGHRe7ww5+/5gpajkSWnqhsal0qqheJ9dKsRW
	BL/zofusSiUIJEiSR2KXMpIE5AGb7r0jAaojhGRiXZWgyaui1lblWju9FYUdUQjWQ4qKOoExAkH
	pSLViiaPjc5dCguv7iNTNGB6ycak2yPmN/SutSWRwv2AdXbzgjSbDmM0I8DBAPKqI2sNdcB8c0P
	cR53MRel4ve7GtOB1crW2vr/IvjVqgSbghiOyt2IS7v2hUkXB3/IVai6KrPIMxfY91K3wmNYmkb
	jSrzP+OCs5D/2SsU2kMygAkafS/tI2jY+db+08iYmhwWVDeA3A6lwJq5TMRE4qQHlHjM=
X-Received: by 2002:a05:6820:8599:10b0:70d:73e2:ff02 with SMTP id
 006d021491bc7-71b3932ca28mr6441341eaf.1.1795282060643; Sat, 21 Nov 2026
 09:27:40 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260923163321.79770-1-clusk@northecho.dev>
In-Reply-To: <20260923163321.79770-1-clusk@northecho.dev>
From: Christopher Lusk <clusk@northecho.dev>
Date: Sat, 21 Nov 2026 12:27:29 -0500
X-Gm-Features: Aa3M54orh1M5O9_qcAUCF6E4VUevGUSAveunaEstDX0bKk1tWEnBw-GosaSS4K4
Message-ID: <CALgo1C_xLcfb_SoEFoJzyE0ff_XHywUDcWrLKZfLE1_fYZ1MYw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] landlock: clarify TTY signal scoping
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Micka=C3=ABl,

Just a courtesy ping on this series. G=C3=BCnther reviewed 1/2 on Nov 7; 2/=
2 (the
selftest) hasn't had review yet. If it's easier, 1/2 could go in on its
own while 2/2 waits. I can rework either one if needed.

Thanks,
Christopher
