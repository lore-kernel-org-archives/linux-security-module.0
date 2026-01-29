Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BE92DB784
	for <linux-security-module@vger.kernel.org>; Thu, 29 Jan 2026 18:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711478; cv=pass; b=OEe1Ui6IOWddA2IaS4NgTfBRKh8bzml8BYIfL9r744H8bUS8yBqcPcJQgOAiaQy8LH8yyhyolj7Q12rx7MfpzA1D1+CFZR3b3wlJ2ut7s3p2uQciKRhpLfCdkBDQxLKwqCZYKPPLDvUYazn0dtUFDHUDbc61fnFpmiPMMbUaOsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711478; c=relaxed/simple;
	bh=Ncr8iPFpMGCLqXwGz8eGHHDAxANhA4AXkI9FgNfxy+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoeVMxGOxW7iiUOcXnEm/69C1LdS72Q3uTmKmC7eKhceSPaG6UUP/PJpsKjpeZ5eyj+bEn/+DSIF/22YAZk4RkzRS0njHOnelPltAhbY+q+8e+sMb+j7V+j+SVPVQ8L+cdSO/xEFD3oXLGNo2PZh8JclxgJ2t+/BlH6Nk/QJaVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=X1qGmbCk; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="X1qGmbCk"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a871daa98fso8430755ad.1
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jan 2026 10:31:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769711477; cv=none;
        d=google.com; s=arc-20240605;
        b=ZmHbX4AkxLT+ojK6IbMozQ1YNhgFS5QTL5LEy/MpYseZR/G4DoPHStHkw8feLqBw+M
         tRQWWzatud0zE6QB8zQMPrfkAcKd0+FC+Ypgv+e2nXHSe5AuWB00wPfyp6T6+jtTLsIz
         w1V405TYhE1JZKGTAlRZTXOFIAEknd+VroFloOMTmXp4prFL3nLRCkh5mUf3pLZIJY4z
         DxmuVaVqj7keYjrm4MD25bXXNdmNYHWLDG9j9zqyshnkqhan71ogfIYMLOH8uF+b8RP0
         56uklKiwfKn+e4Wh7dQBJHoYUivpSPFreEg74F+UPPJ1pZExLCwu/DM50qw5YCM3hzhT
         4DQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gaMEmesNW/2aeijf2CTvDdAzAco5YKTscfYAQiEGCu4=;
        fh=QQtayLJaS+jH13AS38ME7SuwKs07H7AAwIlkbEA1YRE=;
        b=PSR08JyW+quiQ3Wm8YdGovAy5ziIynIHYzzkoHdcvvAuAYQouiBL2QuqS0z68jF+ds
         tBeWsDwNr4hahJolMDxS5knzIKrbh1zTJgfmMoG9LBfGhZGg00qJMpsCY4sB5NEWQMlI
         /dld8MvRKx7YXHPyUlXgqKlb7/dy4c583GPZCpq2om99PEZoPs60k4Y0OtKl01I7h0E6
         LHf3sIq4/BZp7WCH5hT2Pgs3lmXkFdX+FB2FdMRTcuGM2rbamsw6zLbslx3LyqxzxAz/
         u+fOTom/MYLY0Tc77FHYJaLDctbhIfNQnu+Ix55zS1JaSz/xqvkMovqxeHtMTAIe6U5m
         xiUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769711477; x=1770316277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaMEmesNW/2aeijf2CTvDdAzAco5YKTscfYAQiEGCu4=;
        b=X1qGmbCk8McqlrmPvQOfTsgOcXqXyjcTTbQ2lfy/7HcHA+dRHM1Lx5fLQGK6MRE0LU
         /RKiY4+i/O6I6nmzCxzc21Ssln5oBRcFpKRXYe5ouOzoIs0fxP5uCaaF+/HAKs2M5knK
         LrUX77EFYutKMd8FZfXre9ZZMlnnJw+HmI4t019wcsfivnZN4mXok5iQN4h32cwnJkMI
         EZxvZdEuo+5alm8VHOr4RpQZCvBWwj2eEUrXUyplGY0QS/Yo39NBK/w/Ci9p9r/Bh29q
         d7UJ/yQNOF/BKEMYmxmm1k0/Z7UDxkcW2iLM1NmPguPt7wDGXPt6pSO7FlyDvWs0Vcct
         6ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769711477; x=1770316277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gaMEmesNW/2aeijf2CTvDdAzAco5YKTscfYAQiEGCu4=;
        b=fiC8on3yDZ3bHGKVUnQJvvnJBGlBerwWvJ8ZmvhILSJ2+X/lLggxldq5mgGOsvxSz9
         XkuwfGIhJLKs+U+SFLsOgK3I5mS6NExLER5rmB5BseTRDevrBQbBTMdLLFjR3ttZd4cZ
         F0Ae03sC8rtLjzQD6pgjROPYqj60j8IL5X2y5Vf5KP+Yv1PkHq1yDJlQXdeOMMD9Ahql
         exFNxv78IQjfGq8THLLI8Ilrdvy7vbXMQRTdsZgeEcm+1URWuQf2pJ1Pxn5mwaYPfkKQ
         uXwNHRkVTR4soEB40yBVYpXWxmtJnT+I13RCUcP6wTaSjVQtFpP50YxobRK6zfSWBfap
         PAUg==
X-Forwarded-Encrypted: i=1; AJvYcCWSu0hxQ/f9x+hKP8UByEX6V/ynL3TVRSZZDEVL43DSo/JT7COENxa6RpPg/UyAADUvVLb/9ROdS5gnJ02mxulBFJZZoAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw28N4la33UA3pe8LykubutmXj1TXS4lX1AaPyenJdBTgKpSmv
	DqaSb4VNG0uE5aazVVytZ/RMRo5Utql7nkdEt9ntSpGMtB1Gs3+PrcIrspd3V3CtxO1Gre2tR7R
	iTFsPKcaAK/DYfUOxaZgoT1cbod240uM/IhsC49Ip
X-Gm-Gg: AZuq6aJrCsEMlpP4ss6GbqM2u/mPC1kaIaxzKuXNv0qaEgPIyeTKJvhO3ISazBRqZsM
	sXVglw0hsG4U4gtOmtX4aa28YYGCOSWu393bZ5B0fodsnd1bf8qfd4v1hagAxeZvxwL7eyUcPeY
	otL39w15Zi2jby4tfmoagZS08PVV3jGjC5uddM0IV+noNn0wfrxPLjSaCxF90WM62Rw40g2YEC3
	9xCQVQFQcuEcOjWjGnUS/UQwQBHRhVSbsRNemmyXtRE4ff56etGsUYa30O+IEnPcC/3o7I=
X-Received: by 2002:a17:903:f8d:b0:2a3:1b33:ae11 with SMTP id
 d9443c01a7336-2a8d9949210mr973325ad.53.1769711476784; Thu, 29 Jan 2026
 10:31:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017202456.484010-36-paul@paul-moore.com> <20251017204815.505363-12-paul@paul-moore.com>
 <20251017204815.505363-21-paul@paul-moore.com> <0146e385-935b-4f66-9e6d-51bb47ae4bdc@lucifer.local>
 <14638978-b133-457a-ae9c-31ba54e3964c@lucifer.local> <74286aca-a565-489f-ad2c-886c650ea2bc@suse.cz>
 <01cb28cb-56b7-4862-bf27-07e4bf17115e@lucifer.local>
In-Reply-To: <01cb28cb-56b7-4862-bf27-07e4bf17115e@lucifer.local>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 29 Jan 2026 13:31:05 -0500
X-Gm-Features: AZwV_Qj91bihFusy7ufZpFTlJZmfomzjnqMHFZc12ATcxs7ntbmfJHUq6C4Bs2Q
Message-ID: <CAHC9VhS_y2gy2nAK7C-OpchME0pzS34-QN2bY9t5SRBXArz8Xw@mail.gmail.com>
Subject: Re: [PATCH v5 10/11] lsm: consolidate all of the LSM framework initcalls
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	john.johansen@canonical.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	wufan@kernel.org, mic@digikod.net, gnoack@google.com, kees@kernel.org, 
	mortonm@chromium.org, casey@schaufler-ca.com, 
	penguin-kernel@i-love.sakura.ne.jp, nicolas.bouchinet@oss.cyber.gouv.fr, 
	xiujianfeng@huawei.com, linux-mm <linux-mm@kvack.org>, 
	David Hildenbrand <david@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 12:11=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Jan 29, 2026 at 06:02:00PM +0100, Vlastimil Babka wrote:
> > Agreed, the mmap_min_addr should stay visible and applied unconditional=
ly.
> > AFAICS the only relation to SECURITY/LSM is whether CONFIG_LSM_MMAP_MIN=
_ADDR
> > is used as an additional lower limit to both CONFIG_DEFAULT_MMAP_MIN_AD=
DR
> > and the sysctl-written value?
>
> Thanks, yeah we should probably actually move the non-LSM-relevant stuff
> out to mm to be honest.

Yes, definitely.  Send the LSM and VM lists some patches after the
upcoming merge window closes and I'll make sure they are merged once
fully ACK'd.

> But that's future work, for an -rc8 hotfix ...

Expect a patch later today.

--=20
paul-moore.com
