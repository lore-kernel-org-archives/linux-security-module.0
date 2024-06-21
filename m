Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D09E374DD
	for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2024 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719001900; cv=none; b=KdShghyTeIIAnM6UvEBZ3RE9YiySVMZbZM6YWPFekD3YNflze1XpeUSDhvHFFaN1LiuFD0O7bnFOt3R3zF8rA+dr7DBZrXiZL+VLU+yJRhEkDj11FghU1xx56AXMvFanZiWLW5VnysxRgB3dxgNyyo8NhkwLrBUE8vBVl8IrYyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719001900; c=relaxed/simple;
	bh=LTZZDiMALKyPN5p+8hRA+YseHImtAb+JtUOdlmoeOic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSjwXqWL2EYCEB7BySVQLTKGU8LV3BuXDEXlooBwiP7jZtHDAPyJ0bwaOsY1qzuvDaMkemHYXNi8nm/X03BMGf5NUeCbSqWbhZThlvF8P45ch9gIB7Q61I0var4SZEbGMa1gFEyme0Qkh1CT7DTeTf+U5BDBRZd9MXOKp88Z200=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DxiDfXCr; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DxiDfXCr"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-63bf3452359so24366017b3.2
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2024 13:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719001898; x=1719606698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9aMPfF58vRykJrjRvRAhedQZI2SIlSrwcX7UpNjhsc=;
        b=DxiDfXCrqA/tFmxO0p1Y2TxsSRJeYBfrsWTaHrtIwa99Y7mh+nFjvsSevtGrrVwM/p
         bsZ8HDYZfUh7Mnucj5g8pLr6ixk0rCzcZQzCV5KEnlUL+8QRI1xroqgBHxbKKSwLdF3C
         ohtZIKFG1xIKYzAcSiZ6rSgKK8pMUjHMO7yRUj7eqCcAlCjm1jr1G4MGUcWez4XwMjmT
         VVi/emKzch8LpEvUNPWJhVrs0hHgEqubp9XXuYQ2dUIPHipPRbBw6gNVn0W68iAYQ815
         8/1WoXzTKnqsZe32LpL28hA9hNl5bkyHWoSJP7DJXQjmRA1c+dd0KrD8LrKrhgdgNpVa
         mvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719001898; x=1719606698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9aMPfF58vRykJrjRvRAhedQZI2SIlSrwcX7UpNjhsc=;
        b=VEqxscyyNuGnxKQoi+QF02BdPcPCEK9j2FWtKC70BS42UWkVll+5Si2u+V77MAjUt1
         h+UO0FyAtljdRVil2Rl3XRTao2dLQJQGjP6MJ6jHREUsLRuRT8vqf3KegMN0cWAHwodi
         ODVChEQAACcoiXLBUOJfZ+8inXEeWhNp4ddL5XvVG9xXE6eS/ypYvJrp2exdRbXR08L7
         tlONoGZcJ8Pt9PtX46FUCbUepFe9H4lVBLY/RZbXDo9xpQXfwY4R4WzKYKCMMGz8aqQN
         RQQsvb5S2o0gSQYEQ6iZqbe9f9G09uRIC+mperMAxmxzhjXmd0rXjUQrdWLD4xXxbmhG
         2bgg==
X-Gm-Message-State: AOJu0YygtEvwYekF7zMk/ErbPqnFK4+rpH+suiAziSlZPUYPPXOMjLed
	qdSzCuhiKquM9GtRnkdnpko/lxel6bhpOeQgrG3B1L/8MV5jwIz4nSJoWZ3Akb1FNJVlGy2VGdh
	GoYbitDce+QdcmF78agVAMqQSPkKVdXfuZo60
X-Google-Smtp-Source: AGHT+IEjbiKBZ1jiOYgJ/iLL5pMFWzx2q/MMT+P4u529zBOknbbnzGDr+QZeruNnZmKG91iwCdca30Gpp5qvkGowQU4=
X-Received: by 2002:a0d:e810:0:b0:632:5b24:c0c with SMTP id
 00721157ae682-63a8dc08affmr92557717b3.5.1719001898037; Fri, 21 Jun 2024
 13:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215221636.105680-1-casey@schaufler-ca.com> <20231215221636.105680-3-casey@schaufler-ca.com>
In-Reply-To: <20231215221636.105680-3-casey@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Jun 2024 16:31:27 -0400
Message-ID: <CAHC9VhQnzrHPRWKvWPSuFLWHhcXkwqeAfXsFbEdBBOMcACZorg@mail.gmail.com>
Subject: Re: [PATCH v39 02/42] SM: Infrastructure management of the sock security
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 5:18=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> Move management of the sock->sk_security blob out
> of the individual security modules and into the security
> infrastructure. Instead of allocating the blobs from within
> the modules the modules tell the infrastructure how much
> space is required, and the space is allocated there.
>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h         |  1 +
>  security/apparmor/include/net.h   |  3 +-
>  security/apparmor/lsm.c           | 20 +-------
>  security/apparmor/net.c           |  2 +-
>  security/security.c               | 36 ++++++++++++++-
>  security/selinux/hooks.c          | 76 ++++++++++++++-----------------
>  security/selinux/include/objsec.h |  5 ++
>  security/selinux/netlabel.c       | 23 +++++-----
>  security/smack/smack.h            |  5 ++
>  security/smack/smack_lsm.c        | 70 ++++++++++++++--------------
>  security/smack/smack_netfilter.c  |  4 +-
>  11 files changed, 131 insertions(+), 114 deletions(-)

I had to do some minor merge fixups, but I just merged this into the
lsm/dev-staging branch to do some testing, assuming all goes well I'll
move this over to the lsm/dev branch; I'll send another note if/when
that happens.

One of the things that has bothered me about the LSM framework is the
inconsistency around allocation and management of the LSM security
blobs (the `void *security` fields present in many kernel objects).
In some cases the framework itself manages these fields, in other
cases it is left up to the individual LSMs; while there are reasons
for this (move to the framework on an as-needed basis), it is a little
odd and with any inconsistency I worry about the potential for bugs.
I think moving the allocation and management of all the LSM blobs into
the LSM framework, similar to what was done here with the sock's
sk_security field, would be a Very Good Thing and help bring some
additional consistency to the LSM interfaces.  Looking quickly at only
the SELinux code, I see six additional blobs that would need to be
converted; it's possible there are others in use by other LSMs, but I
haven't checked.

Casey, is this something you would be interested in pursuing or would
you rather I give it a shot?

--=20
paul-moore.com
