Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B3A3F164C
	for <linux-security-module@vger.kernel.org>; Tue, 30 Jun 2026 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817318; cv=pass; b=t7NCYJ/G5SjHQ2dsjXIdauzB4SL5p5zjBpeTxgfYsMB8XTfa2VHAssgoxnvf8hRVLqDyNebz8rloIdGLpiGDExyiQC6uVQ8Pq7w5Ds9J9CmBWBLDNvWkHh2Sl/yGe6uLj+6RiVvfG1CCaMsncc54Za9ck8x+Jv9444y4H6/Pkbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817318; c=relaxed/simple;
	bh=XVMnZazNe6ueinmZJ6D34+lB49c1hHJgeNSRfW04Low=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f79FBm3oVFEpabHBh4IGj/0vgaTvySr23xGvykc+5bxP2XpqThlPmuEiRn4EvyZaNx2RIEXgtja2VpfYIQEyjzVS7McOFTEZYsLkrPEkhQO41KmHc+nXkchCwf5AWUzpi8v3HhvtxHU3GC5sKiT4foWOd/yS88rLu2YYCV5whv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vh/cOEk4; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh/cOEk4"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69531108f25so8525341a12.2
        for <linux-security-module@vger.kernel.org>; Tue, 30 Jun 2026 04:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782817315; cv=none;
        d=google.com; s=arc-20260327;
        b=Zec6lovwzMLV6hzopqhd/K7UZK2dYAjCL+MgwwqoFJADLMTKSyqsZefjkzEdHWBXkR
         wD+bPoPiBlDsU7bOJG7cTKA7WG/AMummZ/VvTCmKM57ZKpB6Q9ftPDnaOSR3p+czDz1f
         y4voaL1jUwROiy5UMtdLV3BN8MJL2jA6mVJdu4+98Z/L3rhNlQed59qyrKCOV8/k01U9
         U1sD39JdUmAxaHD0Rq+Lm3wdJhqSsnr0DR4fUkK3UsjDKChxgIweHjcugD8Bxg6QplZ5
         fQbm9qiapyJR57rrsYH3wJqOiq1RYV/dkQf99eX1ConGS4lPrwlSpH1IulI2mCocUYuE
         6TZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XVMnZazNe6ueinmZJ6D34+lB49c1hHJgeNSRfW04Low=;
        fh=fmp8ulo72hLn5RBKgTMBOHdDY5r8eOCqeDRK2TuHS6U=;
        b=OA3f910iuZUT7lMU8eaCleOlZBCbyiOlMLyM6F7M6cYAY9w+FUWpKxDjWY4rUQeDQj
         OZI7wq9Hi8lX0B+CMRCpQahCnKtqPhWpym0he1rN+UW4ajpgFoGnHaEhzHe81s2eKNF4
         E8l2+m6znfiEZH1qpfgbaWIIwYa4RB+Unjk5/VWiiiq5DfXAmMIyM5DrAEbedi6Y0dWv
         l0NQrXvFcBcRtEB18xmyQEjzZKr73YBwB9xJOMaa2Md75MDCYxWwhA5ME7+3mdHhfSbm
         vqURNIALuBYD66hdK3BD3ynxf4KcLl6GGo/zX5P5tIVuc1phckS2r/HOqw1TZvuTSMP6
         wrCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782817315; x=1783422115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVMnZazNe6ueinmZJ6D34+lB49c1hHJgeNSRfW04Low=;
        b=Vh/cOEk41rYPNWUDRzL9fV6pGiGys+jgYv56yyVM5YLQG+CQ6HAz8bjg+2yhOi6Z0R
         HX5dq5MjKkDCK0F0V42AmSr9XYvoGMwSY8++X6KpGHvfsB59EyMe/afP90eBPd6RVRuU
         L7n25ctS5VPtXZFXOSehyvn8hizxq6TuElNJX8Iqm3lyuU2vWeZaWZSlzFn+po0im++h
         6dXOnUDzBwgqXpKdQxQeR6rYoXT3d9Jo00Fe2t0MpjfrJ99DhicDwTRG2/Uz1zEh9e4R
         eR7AWSSH51CU2MO3xvGY9EF+7aN4NbA4bV/dCilNCPOg4BUfkwmVFQbMOtZGFMCByYKP
         R3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782817315; x=1783422115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XVMnZazNe6ueinmZJ6D34+lB49c1hHJgeNSRfW04Low=;
        b=JSMd28vV+bXd2mplYlN+Fx6vdqqX4GicIt8+MWCv3MXyCJ6P1BYhVCSloI1zUPj2rD
         AqaMzIfAaVTB05RYGZLIQD9QlakNATzZ0twJSimT7PKfHqxMlrB9zYrzAXDMQ6HPqQ3c
         h1fuR/zXz2eIgm2smxJaIl7wmVE+PA/zLnn25uE1QwmOH9+0VMDk8xzcqu05XpU2d9xF
         h2mZUBqBRs/TOuhe5h4EauNxuoQOfWRCNJj/O9yxGS8nyb8aYW1E4ADgsD2Vlnl2tMTV
         Cy34NNkk9wsE+bCoPlrMdibbxDbUQfy2w+gk5Aly3uGc+PrsvxuNMtsdEFx9vt0sc7ML
         vqsw==
X-Forwarded-Encrypted: i=1; AHgh+RrYBwWg9Lm6jLozbzHwV5S+ZlIo/d7XCPT3XJhHqcGr2qorfg6AA8//xj7TKQGwEo4GhMrXmFB1xVnwV/YT2Z0qD+vWD7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvbn+wva84+lLVuL0k6yrG4SweFnlTlTvCRhqFoYzuCp5vzbkZ
	AVi3y0CB1J2QyWVZGsMBpf0gtgwP0KAcn2fw7Qu2XSWRrh8jEn6Mjb4kIikLp7S32om2IH15/4U
	yP3Y+I9VTHruWV8aIa/21as6XaSE1QT4=
X-Gm-Gg: AfdE7cnQcjEo97J48qZEwmNNxu6Ed6SimGufSDmE7GqDm1u+zPBa9QKfRRLp8Gb/juE
	wChgUGMw7htXrYLfiD/H+p8rHH584CddFxPNgeNLaTCnmE6YptTIZZGDRFUY/uv52x8PznJV+W7
	Qe3aYIWVeB/1gsalhxb9oAqJjqmRh3U5crOXt9QUXXerwjj8uQzWbpGe/1rLDF3g8nv90dOVQ6w
	Kgvei/TZWnQZ30pQEWhdWcuLurFQGfYv/voadPIVyNQHq1KS2oYSlRrEOYRhaY4xG8qaFJegswC
	z1xUPCoLoJF8PQGrOs9DP+hVXt7GzQw=
X-Received: by 2002:a05:6402:5248:b0:697:4307:991d with SMTP id
 4fb4d7f45d1cf-6988789244bmr120235a12.19.1782817314715; Tue, 30 Jun 2026
 04:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629070653.580879-1-caixinchen1@huawei.com>
 <CAOQ4uxjcD0-PHqqmrpEvkLRgtKJGe8-n+6DQyBngjN2TorwU+g@mail.gmail.com> <f4c8f5fe-30c3-4e7f-8512-7a2befdd1ed3@huawei.com>
In-Reply-To: <f4c8f5fe-30c3-4e7f-8512-7a2befdd1ed3@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 30 Jun 2026 13:01:43 +0200
X-Gm-Features: AVVi8CeRSS7JXqOJC8_jFJY-F8O-_1zMcUusRfzqJnniatTSJdpzkrHWbWs8ruQ
Message-ID: <CAOQ4uxh4-LYt8VUW5o+0mMrHpnZm3t8k4WD6x2kRqEj=_ZpLOA@mail.gmail.com>
Subject: Re: [PATCH stable/linux-5.10.y 0/7] Backport Fix incorrect overlayfs
 mmap() and mprotect() LSM access controls
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	miklos@szeredi.hu, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	gregkh@linuxfoundation.org, sashal@kernel.org, bboscaccy@linux.microsoft.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org, 
	lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 5:06=E2=80=AFAM Cai Xinchen <caixinchen1@huawei.com=
> wrote:
>
> Thank you for your reply. Regarding the two points of feedback:
>
> First, 6.1 is still in the process of being adapted.

So do not propose for 5.10 please.

>
> Second, this patch set is primarily intended to fix CVE-2026-46054, but
> it seems that for lower versions to implement SELinux checks for overlay
> mmap/mprotect checks, some dependencies are unavoidable. In such cases,
> should we add more tests to reduce the risk and integrate the changes,
> or should we simply not fix this issue? If more tests are needed, are
> there any recommended test suites?

I have concerns.
The burdn of proof is on you.

Thanks,
Amir.
