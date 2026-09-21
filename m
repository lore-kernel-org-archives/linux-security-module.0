Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EE5380FF0
	for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2026 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018464; cv=pass; b=CtnXcqln4/xbBrtBhcq8TUf3r1zxHYx/bC67mvSZtr1lFQVUSKYMoAf+w4jpoaU3owmOJER/fS4LNDrxrLFtdxb5DwCLhj+tGtmAYLfns8Od318qK7lzTPX/0789HbHbWLf/WYlMpALzuK90Hq0zx4CnwcVkECb/z69JZpQiLiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018464; c=relaxed/simple;
	bh=qlFdAR0F/wCuIts0PKz0zOO+oD2tVvhCexRQzujbsd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0x3SgVtT5rayH+1UdgYeAknwIswOFT98agwPml4WZjn8ZoR7BeHRSPKwwBui3UGW6EBHO3xQnBcRWmFDvjojn6exGvrFr8CreV2XXh/5U9oTdOeVOk68lrgWKTJCC23gKksEfaOlmgWFxbCO926h6tXr+ls4ivUdumFtG1AwN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Old1K8kL; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Old1K8kL"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2db33db4de9so475ad.0
        for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2026 12:21:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790018461; cv=none;
        d=google.com; s=arc-20260327;
        b=C+sNG02NRCMkC9GnP6u47NJt23/DkChZXfyP78QkpCwMdk4T+CrwwdaBFiiBkHsJQ2
         7ASVK/zb5TThiV2OY/mS5akwHNHAVtT4LSHEmbtCmtusfyNC6nbzBHrhLb/mplFGoG3s
         ovYRYr0WQZ7bfOKy0KyeKou+n4k4bzi4iTQeECsf5GGXNFqti253JytmGPLa+ZDo7zcN
         x9p4UdpyVnoRp7cImvb4a8L906zvOQexqZHk3mR1xk7oMO6WRnguNZxxSelGXfjPRdts
         ia1LHBvtzrKvLabaluZSFk2c45wRbmyzC+mKl/xYxTaqFfZEhb4gXBijIb9QMW/7bm9G
         o7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MEszMFKCmw9FeOOlcidO7gC0SHQCAcCefilt7YkTj2g=;
        fh=T6onHuOwvBRuP7o3nuNDGbnHkOdrAvT3s5A1vkl2qC4=;
        b=n8vqJGXeTUAzYqcbhpXXvH1ZAjkLSzHrqESkvBB7pTmrzgWpWAb5UYbC70V7wQBB86
         YEU6qGrzNTAdiYPQDjEaDXIxfu5e4mfFPgWVbxUBeimknl1ZiyaQ0gnp7iWzepBoL6DB
         /xJLhp9xQwiCWhuOJF5+pajy8Ic4JaPX3ZHo3gsKHb9y7XQghenIuD0JG6ngR4DAcNyF
         w0dLgagE4QFF8dVnf56VExrEIzKbyt5ge4KzTQhy/r9sQaX6G4+ojYAL1Fvbvi/CRf60
         EbwJ1mc2mxOJ35KYgYbIF6RrUUhLpe9CJs6kf+7cJDG27gllQoqMv9ECvEQvBdAfKCLl
         Grbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790018461; x=1790623261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MEszMFKCmw9FeOOlcidO7gC0SHQCAcCefilt7YkTj2g=;
        b=Old1K8kLo+/5sZfFxr1yO0b5CJop3DdWOVAx4746I2nslyAdNuiWbTaQeR0omwoiSG
         Zzdq78QuygBtKl2EqTnjPHSDMvlSUiaMYrFD1GTXi2776fM4gZN6IFwAPFqBhJTIKwwx
         LjgbgzLuv9Lmgv85zZhuniAd9okpEBN2dxyPuou+ftK3iTLp6OM768OM2/V+9aZSYW9X
         YzmUlCxYBFrpyfUmvxwcU7S7RyyIMuQBtL5cj8N6yypVhp8KTg0F9aPR2r9+hKVU8Iqp
         9lzRj0ogNKnAim1hY4KHi1x4JoAwPgXcYpV6QzshfWeyinGbLhTI7d9d4CNtfyd1+5EA
         JIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790018461; x=1790623261;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MEszMFKCmw9FeOOlcidO7gC0SHQCAcCefilt7YkTj2g=;
        b=L/PQX3vsisZZZipqUhNt0BgaBKQeBmv9z7OQVSLQ0bGrOUjvvon9qPoXpFd/wIBpDx
         P92r/KhyGuAbu58yU6Wrg75zixceC6r5spYLVzah1VYQiEEMxXfa9DOLhY0L+IBmPqlI
         XqWmCWYqAuXzTPHyKIGAfEzrAS4jla6y+UO5OMp6uKt+OePmwmic+B1R5a6lIVZ+cY/f
         SaPhur65tq3Ru12yUJv2u67Xg6lvFdjoq11KHUO8bJ1pRlIlAAr2MmLpmfymJOm+t/CI
         x6apaQlLSqmI0y6ycvKVuFVCl7LpAuWA7sbH51GHCuNSmJwq+Q0iTLvTBBLpD4jNefg+
         mi/w==
X-Forwarded-Encrypted: i=1; AKwUvBwSM+X9NkIKiJxcYNPVSoYETF1+mL5MD+U7LD+NHwHdGPAP+EPjIl7n7yCzp8p1d/l+5BNpCuwQZcTXbEnR7RdNiR+oozc=@vger.kernel.org
X-Gm-Message-State: AFuF++ly31xKDnN7LMAGYh5G7W+HukpZEymPiYnCYPBrO/4C+pSVbuKn
	VLOrzf4Xw6QcGoSWEbCuESHsAbuUsmU+3vOAKfJh/mcp2ShqTBj7fFD1iK5BpfdojcQRoBz9fx9
	KEWbqgJvlinUVvaVFw4Y8eOl2LYyz/ZpTLQVADL4Q
X-Gm-Gg: AYBFou1WGDma1yMEMrR4u7FvRwBT12snbOfxcgI6eESamHhhYDaznLwOa1Kb9MXTaIq
	vFDqIc8Txy/IP6R5/PmwY8JrS33DxSfdheWRjBXdEiNysriTR0wMzEcNGH+cGjfKB+d41yC3+9A
	mLVK3vGq6UY3QLVRnyOIbBhqnD0ZeBuUgosYVEOIiRMdR84dvlrCrrkI3zSc+ChQN3BP0MSqEJ6
	iDeU9VBxGSE9GRkUpko5nioy7+VY7zvGEaaObuuyG9skg7meK3ZNEDDGRBTgtLdNYUSyiWJ2YLz
	0dVQuZBNYnXkDaymX8ICBHUu3W/3MhM8yHFBiIgH2P7nzBZvxmXcripEkATEEmwRaRtISml+Enj
	vAP+CFcf4+12bkmF3RdEqWksviUaD6AzTKKrezB5cyhasTgwlkp4=
X-Received: by 2002:a17:903:4b4b:b0:2c9:bd54:cf with SMTP id
 d9443c01a7336-2df5a44e80emr2158055ad.4.1790018460814; Mon, 21 Sep 2026
 12:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-pidfd-get-paths-v2-0-c59ea6a21b72@black-desk.cn> <20260831-pidfd-get-paths-v2-1-c59ea6a21b72@black-desk.cn>
In-Reply-To: <20260831-pidfd-get-paths-v2-1-c59ea6a21b72@black-desk.cn>
From: Jann Horn <jannh@google.com>
Date: Mon, 21 Sep 2026 21:20:24 +0200
X-Gm-Features: AcwNN1U76ul6KsowgCeLOYWUNK5UYTHsLK5_fZAtm1s6K_0yYBp22XKyN_fzxbs
Message-ID: <CAG48ez3vJrbt+qYh5b-PYxmr2txcg3DAKDRwmBwVzNhRB+8Ueg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fs: Introduce task path helpers
To: me@black-desk.cn
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 4:59=E2=80=AFAM Chen Linxuan via B4 Relay
<devnull+me.black-desk.cn@kernel.org> wrote:
> Introduce helpers that acquire a referenced struct path for a task's
> executable, root, and working directory. Reuse them for procfs task
> links and AppArmor executable-path handling instead of duplicating file
> and path reference handling at each call site.
[...]
> +/**
> + * get_task_exe_path - acquire a reference to the task's executable path
> + * @task: The task.
> + * @exe_path: The task's executable path.
> + *
> + * Returns 0 if the task has an executable path, or -ENOENT if it does n=
ot.
> + * The caller must release the path through path_put() on success.
> + */
> +int get_task_exe_path(struct task_struct *task, struct path *exe_path)
> +{
> +       struct file *exe_file =3D get_task_exe_file(task);
> +
> +       if (!exe_file)
> +               return -ENOENT;
> +
> +       *exe_path =3D exe_file->f_path;
> +       path_get(exe_path);
> +       fput(exe_file);
> +       return 0;
> +}
[...]
>  static const char *get_current_exe_path(char *buffer, int buffer_size)
>  {
> -       struct file *exe_file;
> -       struct path p;
> +       struct path p __free(path_put) =3D {};
>         const char *path_str;
>
> -       exe_file =3D get_task_exe_file(current);
> -       if (!exe_file)
> +       if (get_task_exe_path(current, &p))
>                 return ERR_PTR(-ENOENT);

This assumes that when get_task_exe_path() fails, it doesn't set
members of the path argument to non-NULL values. That should be noted
in a comment above get_task_exe_path().
