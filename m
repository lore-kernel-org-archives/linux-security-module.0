Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B013816E9
	for <linux-security-module@vger.kernel.org>; Mon,  2 Feb 2026 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770053961; cv=pass; b=chHL9d44DeuK1tfGsbgkRos/i4Dk+4KyIJXws0BI+ALeIwV3CPxIUiVzH24s/2t26yCOHBAXzGARP9uH7XeKCWCv/NJ9efo/9o6zC1aom/oTnqQTm/aTvk8Oja4PbUHGry3Fbn/gPqx76Vlcn0TMXzp9IuTWCDYDeT+NDAKJQZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770053961; c=relaxed/simple;
	bh=04Hq5Xa8xT5RLPLs9prS71IlZqDDMly+MEk+ucmReAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1yuZerxIi5QoaafSYwM2HACbPqNC1G6XVcPG+57HxIZ1A8OZux076sqaW7mM2WjJxxdIz4DGhME7EAka71AMomJa5zCiQbUM+zidoV4MhuYnYK5XtsBHaLw9cnwoXJn2YRlwyQ6y3dKvestje1CjVlHqpa6X0x1MaiocT8kQoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PQjLm341; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PQjLm341"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-352dda4a34eso1945103a91.1
        for <linux-security-module@vger.kernel.org>; Mon, 02 Feb 2026 09:39:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770053960; cv=none;
        d=google.com; s=arc-20240605;
        b=QbnnE3OGiB/ktxAgR9afN4RFiRmSL0Jjk68e3+7VkKWkrgl512laG3jWfgOE58nH/T
         Y85et+UcVcOIGDnOR764Od67odqutWtpLVb8+aml/UEPw0GvMeEMNoH7/848TJZw8Fav
         AeMxKtmGpDjY9Fa4blwFk7xCNzw0Xy8TrP4uaxz4K0ywK5AX5mEBiprBxm8xBhWCGEY0
         r3jbJeLAdfkwYKKUCTKTi7Fy3xkZpri+6MnxhUNiFUAXprh2nBnhISDO/Rr5RcI+0lDN
         dVOrcdB6+g/MvqownHl6Psvdw50sTD99aZVwFIh0R7fStSW/+b/Ejkp7JXIYimBupqOK
         I7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IRXzbgEycFnDgk09JzlrIl+9d+Uh4VqfyN7u/QWr/ao=;
        fh=qy0cEX7S2N9fKvjMQQEYiuIecD4i5sLIsAawqhotwAo=;
        b=YsR1nFkMCNaObWRDoTgtMiVy66OAQfUPS9Es3YthkPc4AnCmgDzctoZrcMUjvE5EAj
         avIVNC7uIldzgNRwPPRUEqLskOF/h79gpbVbpidoWWuVx2IIo2n7nRpHqVDzym/Sw/4g
         6V7LMaTdzslghZ59cK5e+OLrGa0iWw62Gr0Plktsom7RuTkG2q6p/zS5p+iAKzImnAwm
         44zdOLYTXLJzZUvd6/EMxJqQN1IHb73/4sitcZjo/i3LGA+5X5uPncwsu6B1LrDkb2KI
         154hxSUfWuwk5mstfRSgyY7uOZYqUA/Ho8o5gd/8f+2mMW32/bkWmylTIkpH47s1LSvB
         FQnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1770053960; x=1770658760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRXzbgEycFnDgk09JzlrIl+9d+Uh4VqfyN7u/QWr/ao=;
        b=PQjLm341ypB4b4VHYcyJLlYP3sUjAlaai6fWGtDR6ncHmODk6BImzc7OgukXS5a3qj
         +aQE6Z2EZ8aPa/bbjkU3ffP4dfms+GUnod7vxpWsVurYQsNUlpdgJkiYAQSnMpGQIfg9
         cWQoMg0a1cP7Y3cIYmgJUJWlcsDdsqUxob0ORaeNl43Cqje3EnZjVNIMXyLtZtDrfQZO
         FIHFUD0sWDm/+3ihwrDseblirGVKy5LrH5rbaFXtgRjclyFD/3TkdytWovhO6zYM/G1N
         Fkq3Fw8Zi47XG7mEGn3+HTvimNcbD2Erie9a/CLg9kXC2U1c2Lan1xUaj0C3C0gO0inn
         z+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770053960; x=1770658760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IRXzbgEycFnDgk09JzlrIl+9d+Uh4VqfyN7u/QWr/ao=;
        b=Aej/sx2aMaYilp5VPM3z++gSxxQkSekeIBdXMsUVfm4o28mE0BrwzASaChvAhVPr66
         5FZDKFPLtqBmQcuQXEB6rV9f/8j0dlGotCQ0Gmfyt333/amIoB5iyQb2bBIkL5ECRcZc
         demJjdDTlFA40JR6dxpJVM9EBZzDJHbRxw345ACieINicRhpxht3QxmN/241wcfv3e9r
         ho6ZOBmNj+W0zl/PQSC5X27vhRkqK77fIgWNOMy/J6xyMsPHUlPlD8Fo5aNVXAUz+1QY
         39TFcArLTsDMEGsoY6mmCm6PXFEU+7/AmkPTNoszFI/SGYh6Fn5EIo968nZqofxzhOO0
         VVJw==
X-Gm-Message-State: AOJu0Yzv8OWd+2r+91aldk79Hv80UmZXGykKfppTRXvNjt5CV/yuwRJy
	jByFLK0UyrJzOQ6Exve4JE6NYNyDVvadSHGqL9FXuB9UiRw6g6DJesiLitet3pQYizMmXw3mUuV
	jXL/bTDZzo8XR1JxNo7vk0M4VwzoHduHVjrBdK5lR
X-Gm-Gg: AZuq6aLCD8/Iv4HVcBZqBHvBKp857GeudQPatgZkdunuKj0jX5RPm8zvG9/5Z6xjWon
	5gfNQFldMO5i/EKrIg99CU48yy7ug4P4lz6bVFN4m5Nl0KsjNmWYYNv2Rtu2B2ZRHYvIKNjeUhQ
	8NbnL/8Sjf3JC2u4NWgwgWCfr9XG3aMYmyRm87XfhJIaq3pmLj02n4nsVK1rSyWg2UYY2mXfgn7
	8J1EaueheAdhIh+JlaE7cv1DlODmDzD+dRJl0mllPOr9/uec+C2xcmNgzekA/IjdjlUrcU=
X-Received: by 2002:a17:90b:3a48:b0:34c:aba2:dd95 with SMTP id
 98e67ed59e1d1-3543b3d1056mr12185565a91.26.1770053959750; Mon, 02 Feb 2026
 09:39:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1840fe300392f962e0bd444941c24969@paul-moore.com>
In-Reply-To: <1840fe300392f962e0bd444941c24969@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 2 Feb 2026 12:39:08 -0500
X-Gm-Features: AZwV_QiBQLAbglCMvo2tNwGlwgJGTW-pFRFhiaXYWcBtkktHOGbkuygW9A4h3fY
Message-ID: <CAHC9VhR80ZipmG8PGTdfvY-GpUsvX_UzND-XV6s844hbmO3BTw@mail.gmail.com>
Subject: Re: [GIT PULL] lsm/lsm-pr-20260202
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 12:37=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Hi Linus,
>
> A small LSM patch to address a regression found in the v6.19-rcX releases
> where the /proc/sys/vm/mmap_min_addr tunable disappeared when
> CONFIG_SECURITY was not selected.  Long term we plan to work with the MM
> folks to get the core parts of this moved over to the MM subsystem, but
> in the meantime we need to fix this regression prior to the v6.19
> release.

I forgot to add, you'll notice a forced push on that branch, but that
was simply to add some additional reviewed-by/tested-by tags this
morning that I thought were worthwhile given we are currently at -rc8.

> --
> The following changes since commit 63804fed149a6750ffd28610c5c1c98cce6bd3=
77:
>
>   Linux 6.19-rc7 (2026-01-25 14:11:24 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
>     tags/lsm-pr-20260202
>
> for you to fetch changes up to bdde21d3e77da55121885fd2ef42bc6a15ac2f0c:
>
>   lsm: preserve /proc/sys/vm/mmap_min_addr when !CONFIG_SECURITY
>     (2026-01-29 13:56:53 -0500)
>
> ----------------------------------------------------------------
> lsm/stable-6.19 PR 20260202
> ----------------------------------------------------------------
>
> Paul Moore (1):
>       lsm: preserve /proc/sys/vm/mmap_min_addr when !CONFIG_SECURITY
>
>  security/lsm.h      |    9 ---------
>  security/lsm_init.c |    7 +------
>  security/min_addr.c |    5 ++---
>  3 files changed, 3 insertions(+), 18 deletions(-)

--=20
paul-moore.com
