Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1E722B8BD
	for <linux-security-module@vger.kernel.org>; Thu, 22 Jan 2026 00:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769040891; cv=pass; b=TbaGdw1A0TpsEo3BHnT/k1L3H78X2EDKT1ErHRqHeZqH3y6QIpTrRrnLpIVq5hc3QOySY25lSfKl3rgVJlxJ73V7dR01zlNH7omxU0PGW2EovKVLXZnugYXsfLE++73ZnY6eZjHN8tSqKlKgfJ2vQQt+0GNdaQHvScd5Q0regrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769040891; c=relaxed/simple;
	bh=A5RWos469E7OdpHxOy7QWO7HMl+c1GqjTI4t+/0t7I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlCKKjG5KkYdDYnEQsenlniFB1zP16zO0zxC8aNlw9Rlzs4aeQG58euy1zYXkqWCjdsfJ9GJ5Fup1IFsi3Cxd7N2ZMPXwHhHt8mffYi8j0dry6z9iZW8lusg7AH2fgyDvqfx757Iw6aJDlF0YyxIRslzC9+WReuc/RFFTddJ/7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dU/GXHID; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dU/GXHID"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-352e2c59264so300989a91.0
        for <linux-security-module@vger.kernel.org>; Wed, 21 Jan 2026 16:14:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769040889; cv=none;
        d=google.com; s=arc-20240605;
        b=aQAchVEY84/V3ii3Nk2SSFnwiWMgRvOOniDtKwjQdaKLvNyNFpgmg8Qo2JI3m8AFFI
         mZ10Dm8G5uq9aIwpE5dd4ZP0efZdo01eXBZMAHz1tnlAitxn1go6PXK6zw6VUkBSdeBu
         1IzYW5kU2+qw032gABb1/L9tsTS6w+gtHZB5JGumE+KlwvB4+liuFHir4hjPZWgImi5h
         gi17tj3dnTgWPl+9jZE26mIYtb+lGRZK56zKzi2VPyfhGU9k3SVU+F9qVv6zOJsodeLf
         +p4i9VfzSA/PnUSa0nWiykjq6KXVStg4pEckycIfIwyzu+0tRx22hmPqZhAdHPcyAxPx
         QS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zXPAFU5JIVtw63vlsc/Q6CXxBcUl3qbYAmmc88ADSD0=;
        fh=tQhRDBW6S7FwxROxEraJ56fmcNGQcyOZO94M4RMoQrM=;
        b=TgTDmxN3jKbYpoN72nMmMdYI3tlOyTfGOGr1G7SsWAqmbCudy2ylyLQDw8bi80hJNE
         6ZFt5/P9E3iO3q9KvXSl6tGrBQV1uFiUVEQEJUVBwMzRikJC97ytZmuTHzGT6qAN1Esb
         NvadTa88/BWmJ/Om9Mb7N33I9zpgIVIO3xc/U0P25I7nmKbFlxcm0hcOZt7lsgET7g9s
         6u1FnJX919ClYNLyKzvCK8M7GiVSG7af88NHPH61r0gVmO9dBD9TUb7gMKdvLwtsVJG0
         hB7ZopzdDmau9crOzEYTPCgA0HZi/ddQ3JqOJjkHzWO1u/UcxiMfFPS4hOwiexk0w3y/
         4aIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769040889; x=1769645689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXPAFU5JIVtw63vlsc/Q6CXxBcUl3qbYAmmc88ADSD0=;
        b=dU/GXHIDEkNX12ZR4K9e0Su2HMD5q4K/1lbCMpzqcqWeYBBxT140w87zXDVx8oP1x8
         qZtqu81XZDb5HvBT+gChEsFOKdsAthJY1/aZkCO23VSX/wI3jCTkPgEdgWYFrSMwZ30Z
         Mu89dNh3Kr8X4v8gaHpNvQwU1bhu4+gS4DQpaJrre26gUSmxWc2rbWubDb04poJV+wro
         2rAgKytmH8rk/k4PxVrB/rZ2miT1Abc4jAiJVToiVx+iuCqadr4KFry2B5L7jEvn1HHp
         2FmqeHkTqVgxmMw/SnEB28gg0I4Cqbh5cMCG9hDLdBCmblR34DTCsikwNqdDpPva9QUb
         1QMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769040889; x=1769645689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zXPAFU5JIVtw63vlsc/Q6CXxBcUl3qbYAmmc88ADSD0=;
        b=e2wgMOQ1fag5HXrW6xmTl6bEOv4BrWcWGkrzIHfl4oj5bKmeZ8JWrbnj2lb00PjPIv
         YjIK0EXqdCM+kNUAdD+6P+feMat3xCkqXV3RF4iazqSSTzxFyGKQ4FnRnzaIjmR5afNq
         FG2llI0l2leCi0vAzYtaNkXUVOgTDNSEwtoH2eKYtNhDFh9aDecrpJeLY943y+DCs/jO
         1KpVFUBXzrAvTUADYZ4YuZdEGFY/RV8gtaZEYwKpGelJNTT9qjUY+oKHcT65gNG0dRmc
         6p0aPvzs31ZNQNaQ5VGlu/Hq96wKpuD1E5wyd9vyqjQEtWn5bI27FUgF01ULyif1R0CR
         RT9g==
X-Forwarded-Encrypted: i=1; AJvYcCUj2NTpTk0Qw7jY1EWw53Uk+q6geuBIzY5otegKJmk3S3vYwm3/AJpCABjlup2A4l4GT0PYmy/W8EjR1NcNrwC/VvhVVrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx14w+IzpPsBZgIai/j4cXz18kPF0TZ1fYy1SXAW8Beskc7rSKv
	7XgcjjMB82K2xK3bj+XegpvuSpO33f2Y7TmbceT2O4gt6ZVlFM2pb5eoWyBzMwF2m24lwExnsV8
	iFPnzGkT7ANweD5un6ha5X4fM+InhqM3OL3WeMjDu
X-Gm-Gg: AZuq6aKDIRs70MNvHMyOB2DNPcgHFJ8McY7J9FxPmllahDknvh5n5Vlb2ZL178M9CdP
	nWIyE3+uBYdza/xZ2bu9U1QpYeWMhRJfoMDak0K/IjdJb9PNlEoy5Y4a9HpH/c6oPmvGAWZchlN
	hojaqEuyb+WZVkXh0Y3m1kevPdCf9UKEAQew/O+X0D/SDuJMtm+aPXWZ6WxGc/OQE9kYDayqkBp
	7apjJE0t5Hezi1Jh9uCx1kobFfNQqAwm43JRIemdcA1731tid4lt0xuaSGaKni8IrsFTwc=
X-Received: by 2002:a17:90a:d00d:b0:33e:2d0f:479b with SMTP id
 98e67ed59e1d1-35272edb23bmr15763365a91.6.1769040888822; Wed, 21 Jan 2026
 16:14:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW4=heDwYEkmRzSnLHDdW=da71qDd1KqUj9sYUOT5uOx3w@mail.gmail.com>
In-Reply-To: <CAPhsuW4=heDwYEkmRzSnLHDdW=da71qDd1KqUj9sYUOT5uOx3w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Jan 2026 19:14:35 -0500
X-Gm-Features: AZwV_Qi4Pxfxx-5TehqNnHnBk2vVum5Naq85Aa55fS3OaaOQkTNm5PTJBxmaI_4
Message-ID: <CAHC9VhRU_vtN4oXHVuT4Tt=WFP=4FrKc=i8t=xDz+bamUG7r6g@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Refactor LSM hooks for VFS mount operations
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	lsf-pc@lists.linux-foundation.org, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 4:18=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Current LSM hooks do not have good coverage for VFS mount operations.
> Specifically, there are the following issues (and maybe more..):

I don't recall LSM folks normally being invited to LSFMMBPF so it
seems like this would be a poor forum to discuss LSM hooks.

> PS: I am not sure whether other folks are already working on it. I will p=
repare
> some RFC patches before the conference if I don't see other proposals.

FWIW, I'm not aware of anyone currently working on revising the mount
hooks, but it's possible.  Posting a patchset, even an early RFC
draft, is always a good way to find out who might be working in the
same space :)

Posting to the mailing list also has the advantage of reaching
everyone who might be interested, whereas discussing this at a
conference, especially one that is invite-only, is limiting.

--=20
paul-moore.com
