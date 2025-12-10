Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588883B7A8
	for <linux-security-module@vger.kernel.org>; Wed, 10 Dec 2025 00:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765325752; cv=none; b=NAX6mGpS2CdZNRoYIpZHrIktnAQ2H97Jy9sVCjjo80q3pVHKAgbJIQTfdAiNtU235bS0aX22PGB1LOLHWKSmdywonaC36cRfxobTFx1kjkFbkUetLiL6Sm9IMGS8JV8ISSsCTPGc4+QKxvleR2qF2y4issvAfi+iC3RKve+8TRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765325752; c=relaxed/simple;
	bh=n8e+9Lr7iQuygEvcfoj7A12RL+1Em/+C480lpH+SPFY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=j+ftdYJZkG4ffa3qNhfAf4A+f1x1+gNJAaN+FZCywm693xJqLp7KZfwOTnbzcnmlj3QGVe21vvXZIbJuTFbalEHxsBcfX62Qd8ZDkGGyjCJ2DBuuNrjo4izdek5qJUGib0g5keRaG+W6tDmc1a28y9OpSPEFpvoP+DRAuQ8LGZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecF12nLy; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecF12nLy"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78c5adeb964so15487087b3.1
        for <linux-security-module@vger.kernel.org>; Tue, 09 Dec 2025 16:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765325750; x=1765930550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n8e+9Lr7iQuygEvcfoj7A12RL+1Em/+C480lpH+SPFY=;
        b=ecF12nLy/GYt/qt24uHrxUuvPBsmniSh3KH5QCOMdbeEd5pK4XrSqEbf+rbAPXJST6
         ZBsT5QGXEHoEABTyJLgMSkZielAjA7dTgRNur7PxpL+1by+ppxDPLIo4lo/eRCZD/3l9
         6LvHrjS2bxZ+H1xCI2+4UEz5GFfzeRiHXyGprky49cno5RxSgqWFigzlwo+fSuj7BQ7O
         breAbDm8to0AUgOw9cMg72PTejhTRhbwMFJoFoo+9j149n8cz8S0lehOp6Zc8Aq6+ZNo
         JGuNPtBqZfMkIk0GDmG3YJNL20R3hJtBH0CbyHE4Owi4PGGX+K3K9mc4WiU+JEgTZhF8
         lRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765325750; x=1765930550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8e+9Lr7iQuygEvcfoj7A12RL+1Em/+C480lpH+SPFY=;
        b=BEU7TMDwiNt/P7fJi4V74Cneq5AbabJpBbTd6UKjBkOpH9Rjc8ZlcJ11qnz0N6CZj5
         HvQ6o/oqqYfqflxHc0v8cbPEcQded0JJeYHWhKUur7RKCbEw6HfL2G2A/PXJiuQg19H4
         rs7UfejoIQIEvqMklDKmj4Yaf8MByh/ENSRKJ2cfawuwI/h6t4iyd4rjcB88sc3ECTXB
         +zLnkD2BWHyxm20nzCC3JtAU9RjCuECuu49i2dXRbi4t6BZkz77t/pGa8Lb2fuyFbhjC
         l8pmEdX9EUsI1DqWm54FNkvE/htXs+vOHvGEp8pNceDedVPoeeMSavZFDPchvgevS6zs
         vlWA==
X-Gm-Message-State: AOJu0YxjvOIyTtFp0MxOZzRCXs4nou3DniszEbGw3OfOjWz2//LEqlb0
	+amuHvESxqJGPF5YDkhlC4v7eP25tuW6bWTfnlTRp1CgeuS7epKTHOrNf0MVQWkFx/i+LeI305/
	JQTRL87yMn31b5EDTgm38n1L7nrwYRT2TSAe5MHGbmt11
X-Gm-Gg: AY/fxX7d+qe7KzATj8Py+sQawXcDjLiyIYjM1WVWajqPIBYywpcBBCeDYfWKUb+EEWk
	MNGQa/c4FLw2qF8e/rJ+DGvLoihpBkwnLGeGjgI3k+w+8cKyqOVidKOsKMDmj9oWHYLpDCygtvZ
	pxlRltSv+SV14/SgYl+OAYG6DSIZFPsPNeihunrbWrVYoSJmKdwi4IxZDhvdEfo/0XztPHx8F1E
	uiycvDj0dGG5IKNYVyWZS8s/uUSXMRMwcHIs3uLKTWbcxLNdbFxtHHSXxBB0u5+57wGVzk5
X-Google-Smtp-Source: AGHT+IEhABOtEIjf81Q9rTt27uqjynGwDu2X3lBMvf7swKATu8xR4flyI3oOv44fOfEEIj/oSm+QxXB5USaLB96kqew=
X-Received: by 2002:a05:690c:498c:b0:786:4fd5:e5cb with SMTP id
 00721157ae682-78c9d7f9fb1mr4919507b3.35.1765325750268; Tue, 09 Dec 2025
 16:15:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Timur Chernykh <tim.cherry.co@gmail.com>
Date: Wed, 10 Dec 2025 03:15:39 +0300
X-Gm-Features: AQt7F2qMBJqF03UQ3fg1fTQ0zY1IkEr2dMK0MfZhb3SeP_Cr3FAjusb_3jvXUWs
Message-ID: <CABZOZnS4im-wNK4jtGKvp3YT9hPobA503rgiptutOF8rZEwt_w@mail.gmail.com>
Subject: An opinion about Linux security
To: torvalds@linux-foundation.org
Cc: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Linus,

I=E2=80=99m writing to ask for your opinion. What do you think about Linux=
=E2=80=99s
current readiness for security-focused commercial products? I=E2=80=99m
particularly interested in several areas.

First, in today=E2=80=99s 3rd-party (out-of-tree) EDR development =E2=80=94=
 EDR being
the most common commercial class of security products =E2=80=94 eBPF has
effectively become the main option. Yet eBPF is extremely restrictive.
It is not possible to write fully expressive real-time analysis code:
the verifier is overly strict, non-deterministic loops are not
allowed, and older kernels lack BTF support. These issues create real
limitations.

Second, the removal of the out-of-tree LSM API in the 4.x kernel
series caused significant problems for many AV/EDR vendors. I was
unable to find an explanation in the mailing lists that convincingly
justified that decision.

The next closest mechanism, fanotify, was a genuine improvement.
However, it does not allow an AV/EDR vendor to protect the integrity
of its own product. Is Linux truly expecting modern AV/EDR solutions
to rely on fanotify alone?

My main question is: what are the future plans? Linux provides very
few APIs for security and dynamic analysis. eBPF is still immature,
fanotify is insufficient, and driver workarounds that bypass kernel
restrictions are risky =E2=80=94 they introduce both stability and security
problems. At the same time, properly implemented in-tree LSMs are not
inherently dangerous and remain the safer, supported path for
extending security functionality. Without safe, supported interfaces,
however, commercial products struggle to be competitive. At the
moment, macOS with its Endpoint Security Framework is significantly
ahead.

Yes, the kernel includes multiple in-tree LSM modules, but in practice
SELinux does not simplify operations =E2=80=94 it often complicates them,
despite its long-standing presence. Many of the other LSMs are rarely
used in production. As an EDR developer, I seldom encounter them, and
when I do, they usually provide little practical value. Across
numerous real-world server intrusions, none of these LSM modules have
meaningfully prevented attacks, despite many years of kernel
development.

Perhaps it is time for Linux to focus on more than a theoretical model
of security.

P.S.
Everything above reflects only my personal opinion. I would greatly
appreciate your response and any criticism you may have.

Best regards,
Timur Chernykh
