Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795862288;
	b=VsPjwVY6Ic7SUoVSgHfqVeYLN79kgYHoG04k/1DZQDl1DyS1NIVc/ru4sJktx9+j28gN
	 VEKK5QxBmj+nSCyKKtPRw4OoIw57xdHjbQWo5KANaE+xji7RWIArZ5AiEONdTEXU1cbVP
	 rBNf2Dbp+a3JRzRIGMM1rYQMSXUD9yvW6TEXo/tY7ewqsrUUV5dl/M9qdSB43OzskE5p5
	 nEyad0swQY0tWKheAPbFiXMy2AFplmA6tFMRThx3t9fxbeSypuptulkFgC2gqzrJNVP62
	 IYwzyAHK6Gi6otK3xQmFMI28VitQVMu/IUXuzHOFmUr/TmYCUkFTuEKy8+CZ1IoCB8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795862288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lwyHdZrIt37fPawafrGp2eMQQXYbv+RrBkeaiIqXtM8=;
	b=iDRyptAPuk5N4P1O19A8soCBuFJuqbQ4Qom3vYiD4HXqPMXncO+Pbvt/x20iQ72qfR2A
	 C/dBX0ZcefVgLcG677IeIvgDsic05IjupacWncPSP/zYwMED7QZljkisEX51rdTeuIHb+
	 /J59pNWXv+GHKOoM/XWBW1JrMn1Q0mA3JO3XqBSpN0BbfZT3gKSolXYpc3yJKZkwlofrl
	 YlTTiZhNtaQ8loLHsuaJZhlg2jIBdLhZU9X3aG8hePHkj/78bT8NgaaN2WdwP+EsndxPK
	 csQSxHHh9Qc1jDAET1jwVcHQW65RtY2c688w3/zmCuqq5Bsear/hE7xfpmSxqtzTVRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vDwvR9BB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A8F606A31C
	for <linux-security-module@vger.kernel.org>; Sat, 28 Nov 2026 10:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1A8F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vDwvR9BB
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b5981c4834so10289657b3.2
        for <linux-security-module@vger.kernel.org>; Sat, 28 Nov 2026 02:38:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795862287; cv=none;
        d=google.com; s=arc-20260327;
        b=dUpaYmKAgbbFCTu/ZWX5UGNryzGVPi2sJ20WRaBW2Zys/Qr/5nvrZdEdfAwdnIEHM2
         YNtGVvX+x742TSa1BawZu9sIokWM1b5GL6wSnhiDuJVT0BKGtItguTGlCWUYGDrmap4b
         2pg3IsnV/L+sOqbJK56yp/WPr5lTa2XxpVCOwr3bUdG/RcwqxNa1aXEJxe+jvbw4likU
         LbfAepRhybpLEt3MvDdduLyh9Mw9X7vY/ZjKmKGBot740Il4bdrIY8aGo9aWF2Z+Z+lg
         JLqz0OX2TQ+5OllVKWfwcO5r6X4hPwldLg2eMsCiWa0ECebQICRfbNtyxEGktPWtcQ9O
         NwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lwyHdZrIt37fPawafrGp2eMQQXYbv+RrBkeaiIqXtM8=;
        fh=ZuTqqjkBARFisiZ/LWtzwTDLX2iYY/Wb2FS7GGoXy9Y=;
        b=Hndy/D49vHELrV2xU9d7+2UH9wyj7c167EurFNugd56bSGRCZ+TcBCfi5GBUDyfkKV
         xdS9Ntixb4uyAzXbCS+JwLrigDvjTS5k4BTdXL4Jn9xbeaoQ1aXxxuVXrHuv4uvYWmH8
         lP0GYBV+diFbLlagq6fIhYs4ANSoq66wS+AgmwH95wiam7Mpruu34prOW5af1ezuvIoo
         5tCpitNrdTPd3KyeWhoLOgimFVi80wHrpMbVo4VFS454aaSfTga1y5T2T9deTsSDqnCS
         XsYRp17m4qZRjT9S1qVLQFb5vlxmp199mEbrlhTNRweMsLWlAtjAAAWqOg5VMLV59bOV
         dQeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795862287; x=1796467087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lwyHdZrIt37fPawafrGp2eMQQXYbv+RrBkeaiIqXtM8=;
        b=vDwvR9BBdpjQ3G8joaGDJRaUV5jS124HvjZGLj7uHk8NKri2VFFDC2exXnj6FYJlXC
         goC8qD9we1ivYYYQjQ7BoUbbJnOWTkoEsSFiEI4kxV2O8GjTTkV2IOr5PADmXWcIFKAz
         zbn8LsXtyYafRkO07aOMoORp3uxZU8xyDtOFRR07M6RVWLWasiJSah2QVcE0YMNkZJAS
         nDgAaqySwgTVCmjf6oGYMBdlMlJTFl7dYR+cv4LXk4Zqz97/7qRnb/dGKYK06bxJdmj8
         mFLAlw+EVv3mhauzIJb35S35NLzOmfjRcj9igT8N7+ujAqdntfnf6xIOOkCfcOUBFN9q
         U//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795862287; x=1796467087;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lwyHdZrIt37fPawafrGp2eMQQXYbv+RrBkeaiIqXtM8=;
        b=n6Vm5PXyssqTWzHo0vl2iyRE6YQgDPSGXeidtbORLz+1t+eDPvK5h5C119u0um25Dz
         jrq+4BzB1p0xBorJaUM/0kVgwJpEeAXuYeVVrbyVympDGtLk1OfYSl9msgqfeTI+OCDL
         Rv+gchWVUrpC7bMUKBXVB7d9O9Cv/rpCf4LlyDZDZ6mA7S7vRA03bNeoG/jUyMUcMo0x
         as1I7a3Hrir0zRtGM1tSvEYMij5ZXmclZX/huFov9vWt8q/AjJDoVKL1Ittd1M+llmPj
         cV6pFDmxv5So5TJZryQNaNB6p6TozTayFqsSeV9Xwto4mPK9QTcsO2JOjAwV12RUsJNC
         XLUg==
X-Forwarded-Encrypted: i=1; AL+hErG69MfTAkDg/VPkhWMwEMtQ2Yncs8kJJkrtmNVKoqUIPxZYV87fATP/A80rK0Kkor+jUG8WH73aMlZ1ld0NMBxvjGX6jK8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fKGSUmpsIogN+KbuNuUNVm8o3he+QZa+TMlPPVBkF9zD1BMTD
	7E7FqZLg1WHw3ED2FiCfYGMCendflmPdByI+EVXkOXHtitzoWfgUPOkpmBi56UBodB0B71J4zqI
	Sc1WyU9wrM9OpwXko1EdfJ+BB0VOyccOBfZ2D
X-Gm-Gg: AZFdTZfvyiIE4AWhraHZfkGSfPyZE8c01GWBy90U3EMxPQZuVkKcze4oesvZo8aJZ2a
	buY1pvY4NofSjYMHHuQk8hZ6UW6X5f/qc1E22hKbBdojCWl30SxnPuaLs3ikhVpOMe23qIFcor1
	1mTB5X0QAMFEVI4clpNlf22PP1iJJLjYvcr1+3ydvytdqSTsQCxZ/P8dyscOycbIW3lUJmRV5+S
	jDBljTRIyKVhKwGu7RialbSIfkqC18qlHbjfmmOmFMjOr03tnGoXZsZFYFNcnPfLiH7tcOkTrJv
	AXsOJLRPRBd7fzQ5UnmnX4lFrJGVDAS6SfNospLeoTbI6mTKCbcE1AQNqk1h/hK6/+95VpgDcOd
	aL2zryXDkhmEWy9UTwfztnS7jS8q/KRFPjoUfD88=
X-Received: by 2002:a05:690c:7348:b0:8b4:cba5:fd6c with SMTP id
 00721157ae682-8b52044065amr126739297b3.22.1795862286628; Sat, 28 Nov 2026
 02:38:06 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261127080132.266236-1-congnt264@gmail.com> <20261128030319.3205806-1-maguicai@kylinos.cn>
In-Reply-To: <20261128030319.3205806-1-maguicai@kylinos.cn>
From: =?UTF-8?B?Tmd1eeG7hW4gQ8O0bmc=?= <congnt264@gmail.com>
Date: Sat, 28 Nov 2026 17:37:55 +0700
X-Gm-Features: Aa3M54oYapQM524laP5MxH1c1g8R2EyRuvG3jfItLB1ggZgI1yiJdWq_mT0z3GU
Message-ID: <CAJpJ=Gs5hzFGeR_qmrtfL94LCWWo5HCUhkHewMG285gR98ZyHg@mail.gmail.com>
Subject: Re: [PATCH] apparmor: return 0 from unpack_tag_headers() on success
To: Guicai Ma <maguicai@kylinos.cn>
Cc: John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 28, 2026 at 10:03=E2=80=AFAM Guicai Ma <maguicai@kylinos.cn> wr=
ote:
>
> On Fri, Nov 27, 2026 at 03:01:32PM +0700, Cong Nguyen wrote:
> > unpack_tag_headers() returns int, where 0 means success and a negative
> > errno means failure, like unpack_strs_table() and unpack_tagsets() whic=
h
> > unpack_tags() calls next to it. On success it returns true, which is 1.
> >
> > unpack_tags() tests the result with "if (error)", so a successfully
> > unpacked "hdrs" array is treated as a failure: unpack_tags() destroys t=
he
> > tags, rewinds e->pos and returns 1. Its caller, unpack_pdb(), only chec=
ks
> > for "< 0", so it continues without the tags.
> >
> > Return 0 on success.
> >
> > Fixes: 3d28e2397af7 ("apparmor: add support loading per permission tagg=
ing")
> > Signed-off-by: Cong Nguyen <congnt264@gmail.com>
>
> Looks good. Because unpack_tags() rewinds e->pos to the start of "tags"
> before returning 1, unpack_pdb() leaves that section unconsumed and the
> profile fails to unpack (-EPROTO) rather than continuing without tags.
> Since tagged profiles cannot be loaded at all since 3d28e2397af7, this
> probably wants Cc: stable@vger.kernel.org.
Hi Guicai,

Thanks for the review and the test. Agreed, the profile fails to load
with -EPROTO,
and this wants stable@vger.kernel.org. Adding stable to Cc.

Thanks, Cong
>
> Tested on mainline (f4585067150b) on arm64/KVM with KASAN and
> CONFIG_SECURITY_APPARMOR_KUNIT_TEST=3Dy: the existing 30
> apparmor_policy_unpack tests pass, and a local KUnit test passing a
> minimal profile with a "tags" section to aa_unpack() fails with -EPROTO
> ("failed to unpack end of profile") before this patch and passes after.
>
> Reviewed-by: Guicai Ma <maguicai@kylinos.cn>
> Tested-by: Guicai Ma <maguicai@kylinos.cn>
