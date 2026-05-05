Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3982132E6BB
	for <linux-security-module@vger.kernel.org>; Tue,  5 May 2026 22:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778021760; cv=pass; b=rjZ6x0oX74RICVRLSJydmsC0DkX6vPOXIlLNk7EBBHF66Ir10HgM+Q1OgNFnQzvbD7aytAmu/WK4cob5Ahk5CiV3A09yvGFPIKQ1CPlikZd8mb38YiHe6LuUIrHHgXYBs4M/02sI00QmlcBFdQ5f5wKz/4OznOh96wJyYc1rygQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778021760; c=relaxed/simple;
	bh=jp0ufABEKNNQZig+P4OStv7rq3Lf0B6nVuGfU3anl3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKpY6c/BwyI6HSNZomRZ8tGRCoNsc3WCPlirEjzn4bl1lZF8AEu03poht+gN06eBfvyl/MEfUOkYE7/ZC8+o0Q+VR/va8Zo8LFjVohVGcSg+ixnvItxGleDPH+hO0LWFTaPXoyfDRkxMQRnQGJ5IeDKoo8yQfM055yzHM0p5HDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CyGjf2g3; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CyGjf2g3"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-678a16429c6so572338a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 05 May 2026 15:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778021757; cv=none;
        d=google.com; s=arc-20240605;
        b=O3L1PIaL298olfIVg3AmhEOudoD1Us106c0ySyFrQmzBI9Hmccsszq7UEfRxfOQDnd
         TD/jmhVg0qX5G7qawbNuAI/tWQVjYH/vZSRaLHosM2qKzH4IAkcgUaNEbS15Hkxk4X0t
         sEWD+XaqoeCBDA09bUFgSjq2ydrqs5fkyDTYo70LEGrL/SPXIbaf6jmEJdNciMshT7Ao
         87h9wXB67oHiYvXrAtfShEssmN8IyxKLqX+KAQ0eZOtFKXZt7zheUwYfW8JdVcPR/m8m
         bxk8P25uoct3izQ3Lnd20LVTtg23CvF/fT4CiK7LTQci3Eh+L4yZ8nKFHkptYtTFvX3a
         SzHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=igXYnTt1y5W94mwyAvmuGSDvQ0T1atQGMaOaIv56W9Q=;
        fh=ZtsJJuoIuapAmO2UuBHmCWvTBLUw7dxWHWyau2Il708=;
        b=UPVgKdanCSNWOymyvyA59oKH5bDy5AlO2zyd7rqLD9p7i+ZaHzxP+AewZDAtx5RAD/
         zg7ySWnK8wcfYwoYX8wkY2B/OuZmqEbmvmeWxvs/bc8SNz2/ycnjdoADLzdWdk4fXLMo
         auiNqJdlhmjkOpgRYC3WUs8WxWs7edWuW7e8yKct6um+Yqfy6WY8GhPaREULon2tnNHM
         PBst97zNVjI1o6WaFAh0/WqO394qTQ28ZzPTccfbMh1v/5kZdYCgcOndTNuC0JLHW5QH
         qNduRmfK6+eybqFdXImvBsMHYP9/4Is4E0mdeZD5wCHzh012g5w68eFRIH8w/SuIpVb+
         YzsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778021757; x=1778626557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igXYnTt1y5W94mwyAvmuGSDvQ0T1atQGMaOaIv56W9Q=;
        b=CyGjf2g3a73QDzn/ZzguwA7lAkPSi/Ty+tjuFlBocjBu9Q2mYRsAtseTmeO6d9Cney
         U7B4bLQxhLskhSKplYoOX2/0WVJRzFOM+7p1UX9Kv3k7z4ESWBczK9MlN1sXwl2q+41h
         lP+4NDdccTrR1p81sP6hSQvDY1dD9sKEja4jzUMLaIT6toipqDbzmyFgrmL98RLBFwBE
         dZwL8LsiIZbxeAJ85BnnMr8eM6BnbgX5rIJ11kHNhqfcSz+y6/36hk3FA7rUr6vZUoUv
         8cFzvjgCf0cl2Ceyoy6d9YfZHtl4yzLIc2uGsP+YMT9ct7rwzY0PzwBfjVLBYhQICUvZ
         8wog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778021757; x=1778626557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=igXYnTt1y5W94mwyAvmuGSDvQ0T1atQGMaOaIv56W9Q=;
        b=QkytNPOYA6IJGQCEUDz2Od32YR3GOptNmyqkdAIWB6nOIddTQw69rkuTMUgMHPYs93
         8LHueVQRpsPxL9s6+iHOA/iImkomA9/5s21yW7cAhPX45E3FzpW5NKpnZ+5NHEXpXGYD
         FuphRo6q9tcPUehUUgGB/+twrNd5NLhuL+O+z7PjNb1J5vQbgHFjpS9ViYxNySmPA98A
         w5WI6nPeOYGZXeF49SHpO7Bxanck6IMv2CppabXxZGwL2mU6EcmBZtlyxqIJMWBEpBiX
         ay5QccvrmZh6BCxHtT2BcUx7PwEhRiTdV0Tq6fI/9ut8UTQ91OG6N7uMfZMhF6Ex3Yaw
         a6aQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dT1guBYCTYlw+jcu18El9LJ17kn7T2T0Jt8ipQpcuRfgXBY8lcslyB6L/N8BSWpCEg4BIgRU1qvREa4Wl4zfXAJ7Z91E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4aCH2II0gcsMSEevdvkpn0NG6k+2RWYqqSzd25Fxa3uAFj9ly
	3bC/NSY3o3mgWIo5+c/nZKnJB7YacPrmBAKCtZVmnHRovPoBNxv9MD5YgmO7rtmgV0z37fO5yhX
	U8s7WIDw3ZQSWEz8i2Tu32H8NalVrNJjBZzbRBzIs
X-Gm-Gg: AeBDiet4hWI+A1RuCL7rHbt5C1Ww5Wux1Y0LcHAAIAdQcLB8Oxrq4PUO/WNsrczALAP
	Etw5zSc+cUyCHzt8CJlyStDhDVNAWPhKV3xGHuxWNpHunb+k01oJ8pS97vDwIZAYwDvzMp4DdsU
	pxi8mz6IcnzaMBJ12ANOz7Wmr15Xo9Ja19Tnn06ejIdh8TsvVHdJfw2PSb+QyMLiJNhlU3pOzhr
	HKgDYpdH/nTblkMzNhZjkBv41e5WBEfgUmCYa+RQE7wwVCjKgCeb3cOsfBvW87/fMvfwRFeU3vW
	reJlsKIH3YIgFzrdi4cEG0yxa/VB
X-Received: by 2002:a50:8d89:0:b0:67c:a9cb:d85 with SMTP id
 4fb4d7f45d1cf-67cc392dbd1mr2021608a12.11.1778021756772; Tue, 05 May 2026
 15:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777036497.git.noodles@meta.com> <7734099f5e7fda5480bca016a9e6707983325fbd.camel@linux.ibm.com>
 <afMlgstqahnZg68h@e129823.arm.com> <9f188536f09a2db30877d6bfbb84aeaf2565cccf.camel@linux.ibm.com>
 <CAHC9VhRsnmPp2KmQAns5uq5qXX5EF2xQQzyfTgrPi4O9AXyPpg@mail.gmail.com>
 <ba4bf28314b679474a6a8da6298e548e54b3754c.camel@linux.ibm.com>
 <CAHC9VhRE2kRr1fdDf6xgQgpSrtvqtP8Vy9LVGJhDZFUbzLKGmQ@mail.gmail.com>
 <ff28c6dcb60c357c752724927addaa8c4fd3bf2c.camel@linux.ibm.com>
 <CAHC9VhQY2TMkTvQq9P8oZteQWQSr7qq2utOuH+pdVx+8jWLBCw@mail.gmail.com> <a9412fe10e70ce95dd70556ace19368bec5c188c.camel@linux.ibm.com>
In-Reply-To: <a9412fe10e70ce95dd70556ace19368bec5c188c.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 5 May 2026 18:55:43 -0400
X-Gm-Features: AVHnY4LjwHbGYu80nNIZo2bt6oowEdScIKVunh9rMqRrLydWrBO3U9oWRNn2sww
Message-ID: <CAHC9VhRUgNA=Sj=jhD=zOt8R80Q+FQj+H0nYSy-FAujTL3EKPA@mail.gmail.com>
Subject: Re: [PATCH] ima: debugging late_initcall_sync measurements
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan McDowell <noodles@earth.li>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, jmorris@namei.org, serge@hallyn.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jarkko@kernel.org, jgg@ziepe.ca, sudeep.holla@kernel.org, maz@kernel.org, 
	oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	noodles@meta.com, sebastianene@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 5:05=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
> On Mon, 2026-05-04 at 16:51 -0400, Paul Moore wrote:
> > On Mon, May 4, 2026 at 8:03=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com>=
 wrote:
> > > On Sun, 2026-05-03 at 12:46 -0400, Paul Moore wrote:
> > > > Regardless, assuming you always want IMA to leverage a TPMs when th=
ey
> > > > exist, your reply suggests that using an initcall based IMA init
> > > > scheme, even a late-sync initcall, may not be sufficient because
> > > > deferred TPM initialization could happen later, yes?
> > >
> > > Well yeah.  The TPM could be configured as a module, but that scenari=
o is not of
> > > interest.  That's way too late.  The case being addressed in this pat=
ch set is
> > > when the TPM driver tries to initialize at device_initcall, returns
> > > EPROBE_DEFER, and is retried at deferred_probe_initcall (late_initcal=
l).  Since
> > > ordering within an initcall is not supported, this patch attempts to =
initialize
> > > IMA at late_initcall and similarly retries, in this case, at late_ini=
tcall_sync.
> >
> > Okay, so from a TPM initialization perspective you are satisfied with
> > a late-sync IMA initialization, yes?
>
> No. On some architectures moving IMA initialization from the late_initcal=
l to
> late_initcall_sync does not miss any measurement records. However, as pre=
viously
> mentioned, Linux running in a PowerVM LPAR the move would drop ~30 measur=
ement
> records[1].  So no, only if the TPM is not initialized by late_initcall, =
should
> IMA retry at late_initcall_sync.

What do you do in the PowerVM LPAR when the TPM is not avaiable at
late initcall and you have to defer IMA initialization until
late-sync?

--=20
paul-moore.com
