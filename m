Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB7E8831
	for <linux-security-module@vger.kernel.org>; Thu, 30 Jan 2025 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738257347; cv=none; b=ahd2t2Szs6RO5pBF1+WAYuIrpcvYCNxbj5K0SdNfOSAP8ZQVqdTUy6Svx7+uSpAQkPgAg8uDYobx9n0XIlIjAYX9FFhSCkWFNAKT51JK0aLSszllSRmp8gGidJwBa+8+Qy2HzehhAs2fSBFOEH1bAWFU/lF1SwBx0A4Dk0RnKtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738257347; c=relaxed/simple;
	bh=7bLqfCB0x0Su4sN4TfU2Dokj5aO1TTFadwDu9y3Nur0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTkbEuJjuueiMzCS4mN458xoeOsDJGYQnqqYXb1IGWqR1ZOOrSyvkI2RKE04LOG/K8NRvQ82g2Vh0OIypiLStRSGX4gV5XK7V/n0FWujpyE/Uq3ajd98gU+OThHfRiDUPeOQ+prWPF99wyzYc7sg1Q9fsaXqWJuQJm/TlMdqi9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dlRF4WRU; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dlRF4WRU"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e549b0f8d57so1696072276.3
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jan 2025 09:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738257344; x=1738862144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXwAKgPC0WWLrzCPMBSB6dxF1QIbwOHpmxztQ8zHp20=;
        b=dlRF4WRU/Ruf5toK5lr9KbnJabQGwJIh7+UId2WdkWjuH3P8EoV2ysczjYMHKzL07O
         CXBx9IZ0M4bOgurCIh/MHPH2EN9hDSql58/I3mg9HMaZ8enEcFzgkd2fT/H+72CLzPmG
         EhY0FpC9U3k0HVuYas39l+3LRuEnM8yGvoy+4AkHPbiwR2dHvTDWdkKQfg1DyqjKTfbK
         HWmCu7jXS06nkjUBkIIjYbYYnvhfPjChd4cgRcT72yw2rsI7c0fwPaFWa6lOPLM+2WWu
         AWryEPlJx0nhgIxkhQJFr4zjdsf96Mj1i4Alg2krLToduovTv/CLCKjXgLnXRlRsG+aj
         67DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738257344; x=1738862144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXwAKgPC0WWLrzCPMBSB6dxF1QIbwOHpmxztQ8zHp20=;
        b=hVTp/T7KVC3p7ODpy8AjqZvWbl9F3z2UpaKImWzuglBFOvFVlFXs1Lgz5WJJ76PEMk
         cvbgtXRalMyzwSAVpg4g/O1Rxjhakn9cNg+aKZQyf5By2ljxzyAFMzMp0pPfXaST1g19
         BMDN7fVUfH3I2ltK9y1DJCb5Ymny1PtpM+tvnAJFA1Gkrj+R8htp60Ux5x5VF04N4GO9
         L+P7WHjitv7oEfFeOw7AyPk97gpb8+WoVOulbya31nWTLv/LuRhLZ2Oc0T+ov8UI94M/
         rFkdXC62ptI+PbzbigKfwoRWrl3NIjhFpmMEw6Cz5B5ONgjic8xWHpBdbwXJki0ZsEIe
         Kf3w==
X-Forwarded-Encrypted: i=1; AJvYcCWea+CJXgQa+BDUmhkpmONcifNaGAsoGb+SQRhmWode6d+xGr1vcZzFYl/Cs9HkkUtAb35kPSyDvU4FMrPb2RLsMf72+NE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi/ASnuN01tJ+h/Mes+p/5789FWbeDrIlbgx6u8wsiQLwr68br
	vtG59+CvVi3Yhs/l1yfLD80DBF89U/KjjWQZ/K+o3yg95JGtiB2PsIWTYSByYKuN4ux6Y/zdl3a
	wR1FmFbN6mhcFORTVfl/VP9D4MoUoaHJWNken
X-Gm-Gg: ASbGncvdumXoVi3P1Zh7mIxLdQnS0UBSw+H6xP2xpp8ddgqMZ+PJd4/I/MPPgFxfHam
	vRLnpw6w7kdkzLNczettbb/zeKZ/MzGOraOHpW7vdrXlm+ZWOAxmMDvniig/AOM5YCkHkZXI=
X-Google-Smtp-Source: AGHT+IFQmR/dVOUcr5X4dKyehyTb3q/f+4emvxi0NWfXQJk4MY6xdD9R4017+V2TS3Imp2oGSKI5UhjtQ3E5tNQyzzg=
X-Received: by 2002:a05:690c:7445:b0:6ef:5cd2:49bb with SMTP id
 00721157ae682-6f7a8408102mr70814827b3.30.1738257344457; Thu, 30 Jan 2025
 09:15:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127155723.67711-1-hamzamahfooz@linux.microsoft.com>
 <20250127155723.67711-2-hamzamahfooz@linux.microsoft.com> <bd6c2bee-b9bb-4eba-9216-135df204a10e@schaufler-ca.com>
 <CAHC9VhRaXgLKo6NbEVBiZOA1NowbwdoYNkFEpZ65VJ6h0TSdFw@mail.gmail.com>
 <bb360079-f485-48c5-825d-89cbf4cf0c52@schaufler-ca.com> <CAHC9VhTAunsgA-k64-qmQzeyvmAHuQ-=Jp-yWDi9XDP9CHkhHA@mail.gmail.com>
 <84e580b3-0af9-457f-822c-f03271d20e21@schaufler-ca.com>
In-Reply-To: <84e580b3-0af9-457f-822c-f03271d20e21@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 30 Jan 2025 12:15:33 -0500
X-Gm-Features: AWEUYZkjt58Q6kGpA1-bf44RrRGs7lGzm9BmtjXrzlkCdaYgJFXIzQxNPQcrwuQ
Message-ID: <CAHC9VhSFH2aYoBqcCcamApHpU=YHbabkQEKriBDBLjP08gYV6A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] lsm,io_uring: add LSM hooks for io_uring_setup()
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, linux-kernel@vger.kernel.org, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-security-module@vger.kernel.org, 
	io-uring@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 7:02=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> I can't say I agree that it's an access control because although it is
> specific to a process it isn't specific to an object. You can still acces=
s
> the set of objects using other means. It is a mechanism control, preventi=
ng
> use of io_uring entirely.

I see your argument and raise you "capabilities".

Granted, we could have a fairly lively debate about the merits of
capabilities, which I'm not encouraging here, I'm only mentioning it
as a counterpoint and evidence that there is precedent for things like
this as "access control".

> I'm much more concerned about bugs in io_uring than in xyzzy. The io_urin=
g
> people have been pretty good about addressing LSM issues, so it's not
> a huge deal, but I never like seeing switches to turn off features becaus=
e
> security is active.
>
> If no one else shares my concern you can put my comments down to the
> ravings of the lunatic fringe and ignore them.

Fair enough.  FWIW, I appreciate the discussion, even if we didn't
quite reach consensus this time around.

--=20
paul-moore.com
