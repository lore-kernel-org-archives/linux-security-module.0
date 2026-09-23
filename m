Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C483CB57C
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 21:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197642; cv=pass; b=PAivNqPUiE/J6SERiFV0T6uSB6owJeTcsMPPyexQy/ULEI6mIySnazZn4tV428mNTSsZTgBneEmytd58Ez5kLZK3ngDVpr/FKdGKwgD4vckCg9WjalOG1HUU+OKadLYrPh4vCGVx/DsYIMiguMGQoDPfABD5BLIb+sJe0v+2oRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197642; c=relaxed/simple;
	bh=Dem5nK4pGkIGesk25ZB1fjJQVbSK5tclia2Nf7cl28o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+/HuV/8zljA301GeXBygRaXZlMgRG2c7uoGW4Qfrju2GdKNwmp8P11oIkAYgqpsD51Z3IGqK3drjl2h+sM20gL6PiR6WgctSASsRU61Egarg/KPlawemuSj2JtWKwijMUuFJ0Yl7eC5R4Ocuf667veKqB53wsXxQoVG2/e9TrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bCAAER4d; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bCAAER4d"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a60591ae54so2405095a12.3
        for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 14:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790197634; cv=none;
        d=google.com; s=arc-20260327;
        b=MZevehc2UMRnRKjtw3Hlr/nwpSs8ZFb8Lm7ovnkj86fHBfpoTdjFFRQ+AP60ossujO
         B9hP5DX2rLBp32OROIrDY+0uYOndH6FvOJStIPGHbk8fLzb6j27YnvFY3WA9KiZBBLBz
         mWW0HZrXT4FNGJpNIx5GAYEe9jGd5q2N+bRYXysxZIV/O9hn7tJL51YFd5D+ttfhkIdM
         Cgr6Ww6o++qUjdha7p6t72Gp9SsyYyF+xR8M/WqOpj8GMWny8fbp5Xn92VNv2/lHGIrt
         hBBEKlNFoiBQNQQwB0ClBi6g+nwDbrkxoerdWpjlotV/AqyIhTM8DQZAScWfbKEZ0tja
         Y5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qY60ZsRG5qhxIjnmQPWdSglWYuMq5BNKrqrKyqL2BrY=;
        fh=oHGl+VifiBAEaapckvTheRinIZPwoCWzS+cwNvrPjT4=;
        b=Mn7Oc5tVSSxKs3mNq1YWoTkpYfQsoRqhNCJVk7Uhh9Bbpq4QM4o2/DQinNVDLxzSsj
         yd+ScR6HvkesTXRHmnn2AUWl+38QyrFx2+rYlRPwYmynEjsJiFzpqFwI2vKwaQTBqye3
         1lux6ryfeQol+vf7ZeMJaXE6fojvvCUoujwOafZ41FFiwx9t0Ax2wghkWqZ73DGlW5Yx
         wiTR1pD2DirJMJAPKOIMioRCR0tc7rVUhx62aY8PeJCMA/euNYkfIM42p3Alj1C5KmEO
         jOAQyNlN1hHJGoL4AogiWYrxUX6g1TyCBxpxt/cDI8EHzHR/Anht9p8YJ8g8Q0qKUmE7
         OtBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790197634; x=1790802434; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qY60ZsRG5qhxIjnmQPWdSglWYuMq5BNKrqrKyqL2BrY=;
        b=bCAAER4dg/jSHIRYOR7qihHD5nLu4t8dN4m1ecxYAHyO7f4hoSN3Rwa0u2JpsmBed6
         Nfl7OD7nzJ6fUxPdpjhSarOIk2r28j+ePUwNO+SxZmTF5Xb9C4kCeUFVSvcOC1Pr+644
         eQC/gHgBT9+/rf7xPKrLpkSG/FH+Uchaeyzq/V/EYc7KkdYqXCNLlTVV+GmAmLdS+8/I
         VArVHIzRXVKUXJYNhVjCVpvJt7zP6wIecXWzJOLMEpJOBmWEjJ8d8qbRicf4Pm2O8yPH
         I0kFWN+OE+/H0e0Ux8ctPPVQKxpw6i6z0TTFTKiBT+CGlNlRuMrtzhmdYi4nVGJ+4DEy
         4P5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790197634; x=1790802434;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qY60ZsRG5qhxIjnmQPWdSglWYuMq5BNKrqrKyqL2BrY=;
        b=vwlTV+IMe/Xzocp0PJAx83SwPlBJQ5Z0dVnYCQroKcOZQZ7t3gcNImNb/FwX2s+wxJ
         htQdEhtbluQJVKXcCXhaEJmkwePWfLY4I5q8S97QnaothFX+HTzimmhoHJ2MjlE1Qzd4
         kwyUIpHCbF+qO/+kVsGv8xIvx/D2Kl5x6HhZ10D+/ZDtsjR/n69JJLXFCFNQhtSVOe4D
         EZ0V/EUyeuYGvTyw5nG/3rKdMEsWkDBNhWiFHmZfp2nEkLppoYoj0F7k1vFlI3Ku5EOj
         YnshN/gKFu5kjUIm56ms06W0sb5Njxbv3lyoZj5X23VQd+4ZTovaV5DJcMeE2epSpG7u
         u/Cg==
X-Forwarded-Encrypted: i=1; AKwUvBxqGuurFObSFlhpW2H/46wmgk0muPwMmM06ohIBSDoq/QuYqvatxBdHyNvgk5Ry1wQod75HVpfrrUhDXZK7I83EJKAd9K8=@vger.kernel.org
X-Gm-Message-State: AFuF++kCVCqPS18bgwy7CSjxnkSiVM28+Pg/Rgq81ktknBY1F5tEgUvO
	OvIcVkEraVLqs64vCEjKk16CVkGRAuAZP7UFOcBY5E6xyREvHuDCCzkSs6Sc/3SHktOyu58ZpIU
	XKUqgdHEUg/EVYSyU3IOmI/luRf23FMIAr/39CE7o
X-Gm-Gg: AYBFou20hqN9udpn7K/Y6FNw/0rofbaA9Ps1CLJvdHtZa9veHiMPqxge27Bi5Y5rYk2
	ztVTbky8DS8adRU5QpEtvJzew/JxLj0sb2J1TdeTKq+aaWyGRObtn2nJcsBnsLzddg/ZpLOZEQM
	ZLybCi2p+eYh83gDF0aID3qt/TwSFpYZz7MGpSHM8T4PmqZCWgn72rmiRTQQkMY1JFmVJjZBBLX
	ksXyUzyUAyHroLMkn/bWODrOmYw0emyWSmH15sL/NGWPYey72EngEoxqh1yhyaf3naUCdIms04W
	oZsOAPFhTx6JY2WPQmprBdSYnyEr8tEUTWjQf0eMY/EO/TPrPPAJIkmguZcaPfbN96/TvCIicY1
	JuzJgo0RsXnY=
X-Received: by 2002:a05:6402:388f:b0:6a3:ff14:ebc9 with SMTP id
 4fb4d7f45d1cf-6aac8f10129mr413713a12.11.1790197634286; Wed, 23 Sep 2026
 14:07:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915150739.284189-1-daniel@iogearbox.net> <20260915150739.284189-5-daniel@iogearbox.net>
 <CAHC9VhR2Zp9LzDRwDOZoesOC7o8hretfgRH-PRqQRXA0EES2vA@mail.gmail.com> <CAEXv5_g1XQAwsydnbu9SUvxNBdYQf+xXjPaZMeC8hxgfThP+pw@mail.gmail.com>
In-Reply-To: <CAEXv5_g1XQAwsydnbu9SUvxNBdYQf+xXjPaZMeC8hxgfThP+pw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 23 Sep 2026 17:07:00 -0400
X-Gm-Features: AclHuK979p08Ta0TyW85fwx2_KJpKtB3aJaWYoJNW4H4ynPYtF25vr6stPl_yEU
Message-ID: <CAHC9VhQzW_tCCLyMwkuFhoJhiyC2XSsUyQF19+Ag8X1=J75qUQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/8] bpf, lsm: Let BPF LSM provide xattrs at
 inode creation
To: David Windsor <dwindsor@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, alexei.starovoitov@gmail.com, brauner@kernel.org, 
	john.fastabend@gmail.com, memxor@gmail.com, kpsingh@kernel.org, 
	matt@bobrowski.net, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 3:14=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
>
> This implementation was chosen due to its immediate mergeability (it
> only touches security/bpf) ...

Ooops, I hit send on my reply to you too soon.

It's worth mentioning that sometimes maintainer objections/NACKs can
cross subsystem boundaries.  You may not have followed it, but a while
ago a LSM was proposed that implemented BPF program load access
controls and it was successfully NACK'd by the BPF devs, despite it
not touching any BPF code.  An argument was made that the proposed LSM
manipulated internal BPF state (there were arguments on both sides of
that topic), similar to what the proposed BPF kfunc is doing with the
LSM framework.

Hopefully we won't have a repeat situation here, but it is worth
knowing that code location alone doesn't necessarily equate to
"immediate mergeability" based on recent history.

--=20
paul-moore.com
