Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51981A7262
	for <linux-security-module@vger.kernel.org>; Thu,  3 Oct 2024 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989972; cv=none; b=c7YIfCzTU0jtmN3ZUI9xWbbKJ+m1HSwLiqt1L99H34iUmhWbiRfJ+la7QUIqWW0CqQapxkc/kzmgotUgYA1iMHiTl4tpyx2nmqfhKw4NEVkp25kM7j7hLNZnxcwsdYGqthTs1r0ML+8wRtKBTAR1iAYF6kozxqEliC9WUV6E8PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989972; c=relaxed/simple;
	bh=MUnqdNG7QpcXzMvkolh17Z8ZH9D0m5xr4sNB1SbJVY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mfCjszRxTpJBezkuiDqh823B9VbPRdixkyp9g9RathhAjcyxzOhp+BatkCt8AeAkNmMgT5EZk881qNlFx9OW3YzDm+Y6EKCq3K2lcgC/aGG24dcuXU/CsKXG9gFQSu/NrqC8eMqkSlhJ4CJL4Zu6iClbq8zvddkBAMdtEEMljX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=H8/O+SsG; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="H8/O+SsG"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6db836c6bd7so14091617b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 03 Oct 2024 14:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727989969; x=1728594769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPV6j9ETVMr9o1+u9Oa6oYdp17gnYRa8Vt9vWg1cpG4=;
        b=H8/O+SsGyM6fx9KceJL9kXWOYxfy1AxnXeE2jdGNVMMPzwyzfrrXKJnw1myMHQ72CL
         HT+slguUrQR8CczDUSBAMPZFNCuxnGqQjiZpzh7wVHwVDoNr9/SC4gSONfsftf/HnO/P
         0dxPmjyMKddm1eGLzWtFRCBHck/qOUxiftoeWyzvXprIAZTf3oQ6zfXfycFCW0KQ7BK0
         8gyF2686+PC1leSOnETnefPfqOl6qNbLH+2ZZBjJy1yvDi6m4uBCQaJIa9C31NmunsmK
         lHSPNpYhKsHMzn4furh0Paie4d17SZ7yaNBmUycbuiy2kXu5ZyyJtLmXQQ9wK0AHZBOw
         B/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989969; x=1728594769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPV6j9ETVMr9o1+u9Oa6oYdp17gnYRa8Vt9vWg1cpG4=;
        b=MIV+A3tAvwVkSABw+iA9gqfo9WvA/RozS+011ib8m3SGufiqbJsJ/hBQZqovff5GWm
         S9q0WbxPd3g8/FsWAZrZd6CYOFqDcw2XiX04CJkoL6Gj4arqrr2u18sKh/wKcydTE+yp
         pKTdwq4ZX++ulZruMxYPF9VcnGMXyAmLv+5p+Jk2LxkZB5CQdN6lk1lx0Dwq3PZzmh5C
         9XMdtzsCj72ZobMwIcPxCcV1/o0OkNtkbJsfz4T+zlIBLyiIf3Sy3bvV1MaQorA/MyO2
         vIslKHltF4F3xDAXGuHfAsizL4bXhpDTuX53UjRUqEwSZvmKT+66HaQVLTnum0AtOm1J
         /0zQ==
X-Gm-Message-State: AOJu0YwLm+7tSxh0zPqrqjJ3+5MvbSxM9jmfW7fm+b5ancUM0SAMC7KQ
	MDvrO5oZA0k/FtXGPtEsksqhO+kvKG5aMya3YEWeiNKWWVL0GkIatc0QM8E/WsTxh/TLr1Eg4HJ
	NQFcfqrfEX5hL0OzycVlskgCkBih+8yfBB3C12D977cwSg+sWXw==
X-Google-Smtp-Source: AGHT+IEGneMEspcd40UfNvg/vuiGHktD5LU90PLrW1YhfJZvE5h5OkdXdifuzzj/49OpG/jVD3Y8QU6QyazORgEhHeM=
X-Received: by 2002:a05:690c:12:b0:6db:4809:ed57 with SMTP id
 00721157ae682-6e2c7028825mr7503087b3.22.1727989969620; Thu, 03 Oct 2024
 14:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003210831.387261-2-paul@paul-moore.com>
In-Reply-To: <20241003210831.387261-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 3 Oct 2024 17:12:38 -0400
Message-ID: <CAHC9VhTpUsjbNr80MKW5mkg6c+bQXiFDQO3nkBqf_o=Xxb8iAA@mail.gmail.com>
Subject: Re: [PATCH] tomoyo: revert CONFIG_SECURITY_TOMOYO_LKM support
To: linux-security-module@vger.kernel.org, tomoyo-dev-en@lists.osdn.me
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 5:08=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> This patch reverts two TOMOYO patches that were merged into Linus' tree
> during the v6.12 merge window:
>
> 8b985bbfabbe ("tomoyo: allow building as a loadable LSM module")
> 268225a1de1a ("tomoyo: preparation step for building as a loadable LSM mo=
dule")
>
> Together these two patches introduced the CONFIG_SECURITY_TOMOYO_LKM
> Kconfig build option which enabled a TOMOYO specific dynamic LSM loading
> mechanism (see the original commits for more details).  Unfortunately,
> this approach was widely rejected by the LSM community as well as some
> members of the general kernel community.  Objections included concerns
> over setting a bad precedent regarding individual LSMs managing their
> LSM callback registrations as well as general kernel symbol exporting
> practices.  With little to no support for the CONFIG_SECURITY_TOMOYO_LKM
> approach outside of Tetsuo, and multiple objections, we need to revert
> these changes.
>
> Link: https://lore.kernel.org/all/0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-=
love.SAKURA.ne.jp
> Link: https://lore.kernel.org/all/CAHC9VhR=3DQjdoHG3wJgHFJkKYBg7vkQH2Mpff=
gVzQ0tAByo_wRg@mail.gmail.com
> Acked-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/tomoyo/Kconfig               |  15 --
>  security/tomoyo/Makefile              |   8 +-
>  security/tomoyo/common.c              |  14 +-
>  security/tomoyo/common.h              |  72 -----
>  security/tomoyo/gc.c                  |   3 -
>  security/tomoyo/init.c                | 366 --------------------------
>  security/tomoyo/load_policy.c         |  12 -
>  security/tomoyo/proxy.c               |  82 ------
>  security/tomoyo/securityfs_if.c       |  10 +-
>  security/tomoyo/{hooks.h =3D> tomoyo.c} | 110 +++++++-
>  security/tomoyo/util.c                |   3 +
>  11 files changed, 118 insertions(+), 577 deletions(-)
>  delete mode 100644 security/tomoyo/init.c
>  delete mode 100644 security/tomoyo/proxy.c
>  rename security/tomoyo/{hooks.h =3D> tomoyo.c} (79%)

As promised, I'm going to wait until Friday (US time) to send this off
to Linus in case there are any additional objections to this revert,
but based on the conversation thus far it appears that support for
reverting CONFIG_SECURITY_TOMOYO_LKM is high.

John, I added your ACK from the earlier thread, if you would like it
removed please let me know.

If anyone else wants to add their ACK, Reviewed-by, etc. please let me
know soon; I'd like to send this up to Linus in time for v6.12-rc2.

--=20
paul-moore.com
