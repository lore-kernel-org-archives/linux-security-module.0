Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815B02620D6
	for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 23:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740613310; cv=none; b=NSQjKzOcTg2cftP/nequPESireGOMrlYncKTAOXqjoFUhSyfZeJFI1mZKdEjt8ei/LNfncmA62ZiHD53HMydtmZUroQ+We704KdKaEtKR8TcOkFEe44CTb53Mt7XlZ0RZpMmQ79H/XndUbu61lDaC79fJnpmwm3Z+UvYGYfLGF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740613310; c=relaxed/simple;
	bh=JQDAukDOA1SXdHWfiWnXuv4Qp+qpUTG+aOURb/RFTMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laJViOtxmUks7B82zw3/+KaNJHCHcngkrRss3E27up1JIRJmjGF47rLC3/J827B3KCG7+4JwaCDi8/uuPG87+nbSnStvBagwP6aHMT/eKR6P+8n/ezxgAT7QLAxkyxd7JeM5yoVhLzGD98Ere5TVdaeDzwWMgANXFpKzT9Fge4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f74K/K/a; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f74K/K/a"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6efe4e3d698so3851717b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 15:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740613307; x=1741218107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQDAukDOA1SXdHWfiWnXuv4Qp+qpUTG+aOURb/RFTMg=;
        b=f74K/K/afzWjWvWsdHxzN/jH61xJHHyuPbfUP001y7a/mX6nUiQ6DZSUR4rQzkAFCx
         uOFAYRBDM75LJJ3tEtVTkKT7Pfyamp4QYiJxQoBN7PAuBLpEFKsB4bsCIFSC+EyqITA4
         MSFowOZhYMXT6smdUYfJrBJNAGtzWPePtqkaV+TeW+JQV8A86bZ4NvxrgQQwmhygBwVc
         4AyCxHkuezll/ele/Euj7pr1pPIBuQgLCodPj+v2Il0IkiTCMNdfBwh8YYMXpiUuZsUg
         jNsMH1mqRG2FYKB9txR+/jBVrF4PiuwCG7NFcaxSBTrxjJCbTAetHKMw2dcEExoHNhUR
         hHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740613307; x=1741218107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQDAukDOA1SXdHWfiWnXuv4Qp+qpUTG+aOURb/RFTMg=;
        b=YROVAWIKfxEGfuFFpr9rVbQQfaXUwX+E3lJhDEzQipHefyK62ZHUkT6odg1i5Etvm6
         5Zb6dXuTYQO6I/jLUOMZ2RKQBdDTNs8uPZWGo/un29cCWskyhNfx4PAnj4Eiz3Cu0LGW
         zhbLqBj3x+y8aWgP0JPhXvK96ubYbM4T7HkKRdPLr+gX1TtlrHoEqJhRFEgRZ3xNQ1hx
         EWug2qMZu11g8lRsszD6bh50A1hRYsAMUephv+xYJ8dF3kWNLeeIYlFD2ySOGa84SwHF
         EgK+0AHaKqnco56Vh4Zjbus9gQvWA3C9FZYL5XZCX5OPzU9cAoam6z4FZefZDEUCi7AE
         AQzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUvM8TYdo6Mzedofk4G49yfIiceSAOOJ6WUNWXfWtr1rUv8EPy/ur7E1URSXgc0G6er4+pKRw7+6fmucgjhfVy8g3+Thg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZMkHpii17QMP6O932Zrp1SPN786q29FQAd/z7mDFu4ua60dqR
	u4akZw2NPjxN7Dc0b694RkQ2M4XyPO+TwI0mXF4PsZ/bmqvfz1jtFsBSBq5eW6RXgqZEwzUzwi4
	VOWKCPPmyb0YCP6D6DxtPjpv3M2cqy2f5/rJT
X-Gm-Gg: ASbGnctzU+FpsC2obNndqT9OLiopZCEemAGoLBlkafkHG91rSU7GkyUPTrTAJYCQ6XD
	wI+COKTqqf5LweN3GbgNh1Lm+twc5lp2FLU9JtO38LZDpV2EuPc3gO6F1kE/bb9PnCmaQUXVwC6
	dk/qhLJFo=
X-Google-Smtp-Source: AGHT+IGemVdA8vFM5APA46NT9uZdRK4EJWAEgmp2/eNiVxXqJ81TXGGCyav4i+lfYJLRLeB/U2Bp2pN4yp0P8tAT1hU=
X-Received: by 2002:a05:690c:38d:b0:6f6:b646:4f34 with SMTP id
 00721157ae682-6fd22074377mr57621747b3.30.1740613307514; Wed, 26 Feb 2025
 15:41:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131163059.1139617-11-mic@digikod.net> <7ed44e7b0e371302d29be95789cd1a57@paul-moore.com>
 <20250218.aePeer3oole2@digikod.net>
In-Reply-To: <20250218.aePeer3oole2@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Feb 2025 18:41:36 -0500
X-Gm-Features: AQ5f1JqWYmxLqpt22zS6kb-r4-IiD-XvgZ__5B9665k_Ga0PZ4Qv98lgbWnYyX4
Message-ID: <CAHC9VhSo7L8jw2pR9x6KmVCiqucGaRqkuj+RyQXOC6jnQBcQjA@mail.gmail.com>
Subject: Re: [PATCH v5 10/24] landlock: Add AUDIT_LANDLOCK_DOMAIN and log
 domain status
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Eric Paris <eparis@redhat.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 2:21=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> Are there guidance about __GFP_NOWARN for audit or other subsystems?

Unfortunately I'm not aware of anything, and I too would be very
interested in learning if there was some solid guidance around the GFP
flags as the comment block in gfp_types.h is rather short.

--=20
paul-moore.com
