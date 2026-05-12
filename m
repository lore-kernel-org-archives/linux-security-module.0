Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEC823D290
	for <linux-security-module@vger.kernel.org>; Tue, 12 May 2026 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592726; cv=pass; b=rKbGXrAUgBAYsypXFwU1s1GvIkHLb141cwoVJI3L8PLaVJgX6gBLhEODPwsuAqeQZNYRwhhQ5NJqbvJy/orrV9z6QnBdi/T1MTVz2mK4owQi/FtgsbXWi3ksuIZEQAbTso9be5XEx2uo3BlUf61ZNlduYe1U5hCuSO9zZjS3fLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592726; c=relaxed/simple;
	bh=49jW8ZapXANMFie0lrwx7RkYd4uYDwwdGjS4FnYv9zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3GZwNQHHJh+Vse8g+XvNlSTMoBBjGR3D36GejnOeqJ4pYDuG/LxN+N8wCHPqBRNbtIJiXJbI4PVN4OBMTC8rWjVzoB4mN9hon0tXg5sUbqDDLWqDYQJws4O92UXxUmV/x4IinFeJm82w8k0bS5DHH3wrIPLsB4deglHGcrY8is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q6nbj3ar; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q6nbj3ar"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ad9f316d68so25266225ad.2
        for <linux-security-module@vger.kernel.org>; Tue, 12 May 2026 06:32:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778592724; cv=none;
        d=google.com; s=arc-20240605;
        b=RcjU3hZu/B8gxoXHCmYAIkt/9vh1IKGvYtrgbeDlPsns97E7X/z4ze6el0qviDow0O
         2lqEujAdmFoZXStGdspRvyAn6e7bFPpvBPs2sASGKBVFt67zYZZk5TRSJAXT5XcvCR87
         UhiL2UjR0UCxFb5LLfyh6hzzUoUWjAddbHQ/oIuzmUDV2/baPmZG1QU85YdVs900oi88
         pKFrYuCGWXw8TY3G/ExUdmDzCH0rcD+mYZskGfNPdhjIGj1G4Lb5ynKE+RA1KB9SXkWm
         1g32+uyePz/6CI0flFCPP4GRpOlNneakbiHbqE5aw4RgmqP4tazB7wyxrOAhCgUw6B9T
         +fbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0/aQ9mwTMsHh/sgB4/Y2KBsn0VNAa/XO6yw99kEeKn0=;
        fh=0im+EHxwrObJ1dE163Ro/sil7b7+dbp0nve0Ekq6kQ8=;
        b=eovbBfraJnFG1tCVwiixYUUeybGaAbOhunv3yVFWyUFfzgw9PeYGzPt/W0jjhqgdoX
         7qkvpHwj8PF+EPgblN94l0CQHKU1i6o+CbnahopPzI9l1Sz+ffDgGnF+eG1BGWpckyHq
         T20QuT/5wDeSoUKYAAhhmdYqgBdeBiJuJfRsJu1wiN96YcSz89GlIuWwaHB0DczZaRHJ
         HY88M6U5epV1BF4sAMhvLLSrrHB7klSFDRIGE6UQmA4SkA5zCzDcn2zp/mctBZzWWODB
         kIQt+iIWiuzSs1pMoJ2h/cqGhh92I4WmHcbxjGanc2kQkoT5CHsb0+S4mspEm7g5IwN+
         56Ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778592724; x=1779197524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/aQ9mwTMsHh/sgB4/Y2KBsn0VNAa/XO6yw99kEeKn0=;
        b=Q6nbj3arsrs1ZogqprDPGpNBOPMkhELFsB3N5YCHDF263py0coD/cKJ4XAI81ReJlX
         hytSGWtxCzD5JSBLPFhUzBDXKv8AJYSj2XG64j5syFspKgTb1Ycoqvvv9Ihd/X6Ie959
         GYGKadZ7tViP+6Zl3jwlzsw5bxSvkyAqwyAbbUD7iy2EpowVW81E0hkB/d/0K0FlW415
         7ssdDaVxrIlhxx7qoQ4FCVI/ApRussIxmNJDYg1wIK2vNm33UxbmZh0DK/sd93Dk/Sot
         7vmX+VbX0aCoznwEVklpf0uVXJZylcZ7k23sysAzIBdDS4Nx0Xl2/JYNQmpVxXVnxoRD
         a3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778592724; x=1779197524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0/aQ9mwTMsHh/sgB4/Y2KBsn0VNAa/XO6yw99kEeKn0=;
        b=Y7D7rrWmoEq9ukTToauw7XFP90j7kxm7s0C+BHRalO2XQmxWXeo8e/JSeFyFtWVrhV
         korROMd8eD26s15JTR0E7NdBUORALq+BS1TZ80+aEo8b9ETPkv3iJVsACwueeXXhCd1s
         Rg2e/xljWfqB2+s48XbJObDBCmDNtls6zoMgk1I9ECMGnczJtPTg9jkBxKnijUdqAP/R
         yNpv8gywEMP9MR4osoqzrVe/Gy7ksXe+YBJKbe2SRAPOp/Bum4AIdr8WAI2XKahsfarI
         as1VUfWmu3IT4RwVMFKNjQYrpCqw+L/j8y0OrjOnzwpNbAd25PUL9gFVmyGwdD9rT/An
         /G2w==
X-Forwarded-Encrypted: i=1; AFNElJ8ZBeem7GUHt2CFW2SCFs7XWmlbXR/i05GCYFAsRfFltAueRKrYAHqKb522KfU8BDQppMTMFtdLWpv4YVKtCZ3+d43S2So=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyjlfo7pmSL24byxzo1Tf4novMS369ghE4IZZ7TA3rLaHVFBoA
	BgLWQewvNCGunH3BA7LCaPv+MLUBgYuqPl3ZwCkwl4DumVOKTHDXDmqQdztFRmtmUAJHzRhovng
	3juYXqoDkRxz1sDK1gxT1YYzn1eKLs6vdoFWFsRSz
X-Gm-Gg: Acq92OEyn0zh1kWjf9Crsn/k0TecpPj0WWK0C2FaQ59ogTUKG/4YpsVfuRWYb/cw05Z
	ZHgwPhaLOS1cMFOKLbulBnkuknDuN61VrBB5oCCXuYKuuzTXEVgIXrIdyhkTVDYMHx/CYHFyaf+
	PYZJSzNtJufQnHlrzq0Kwsxq4pUm3P0zs8VNJcMVDcxwFekihnZgqIqvZC1VCw//GyBZL74Ftg9
	7i165zbcsS1N3x9XFtt598XroL2D48dJmTvnD6kCmVlcaaCJW+y2wTK617yx2v2Iyxj9PabQbQV
	YeQ8D5fAb6A23lsUfA==
X-Received: by 2002:a17:902:f805:b0:2bc:dc0b:ab1a with SMTP id
 d9443c01a7336-2bcdc0bad76mr55621515ad.35.1778592724418; Tue, 12 May 2026
 06:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509015208.3853132-1-song@kernel.org> <20260509015208.3853132-7-song@kernel.org>
 <42a9075e-a4b4-4eb7-b96e-48e5c0cd2f3a@I-love.SAKURA.ne.jp>
In-Reply-To: <42a9075e-a4b4-4eb7-b96e-48e5c0cd2f3a@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 May 2026 09:31:52 -0400
X-Gm-Features: AVHnY4IPU0C4Y8X9_dcIUSlLPhJJAw5e4I09h5zch8q_eb3KJ5_1mBDuZ4l2gH4
Message-ID: <CAHC9VhT9vvaoYpRX4fPZ_H13+PaqG72CpRbS+d=9xgMBaKHo8w@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] tomoyo: Convert from sb_mount to granular mount hooks
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	john.johansen@canonical.com, stephen.smalley.work@gmail.com, 
	omosnace@redhat.com, mic@digikod.net, gnoack@google.com, 
	takedakn@nttdata.co.jp, herton@canonical.com, kernel-team@meta.com, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 7:03=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2026/05/09 10:52, Song Liu wrote:
> > Replace tomoyo_sb_mount() with granular mount hooks. Each hook
> > reconstructs the MS_* flags expected by tomoyo_mount_permission()
> > using the original flags parameter where available.
>
> Please fold below diff into this patch. Then,
>
> Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  security/tomoyo/tomoyo.c | 60 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 58 insertions(+), 2 deletions(-)

Thanks Tetsuo.

Song, assuming you have no objections to the comment blocks, please
fold in Tetsuo's additions in your next version and add his ACK to
this patch.

--=20
paul-moore.com
