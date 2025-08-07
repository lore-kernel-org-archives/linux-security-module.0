Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BFD221704
	for <linux-security-module@vger.kernel.org>; Thu,  7 Aug 2025 01:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531362; cv=none; b=bBvtB9Czl049Ry+tfIfLEPGs3XvEigdLctBkUEhk8sEXnJW9Te3OM0RU7j9t2ja2Ex27DB0tKiW+31OGNNkY5dmTB+5UmFt58mNfwnezPIjN7Qn6+fecFETHmjJES9UvFf37bCABM0NbZ7TKzgsMHjIIdQQNf0I3PUNwgmuOf0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531362; c=relaxed/simple;
	bh=n+HnZ/PGAvjiuWfwDD7qwNeQN2hkMMOmZxNnX6ccbhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=r+FFsDXGAMHPUqS/UD22im03VtsWnu9E2bvox68s3Tb7CX/97P6uljFmH0mGfXROlaq3nXyDuUiHDxs0yPw1FOutwzUK7A6+4Fh+20/G/rBueuZkJCaY3q+Kv93TOZ3dkHbQNS3IUoUWwto9c0G55KDVkHBlXdosmKIZ6V4UIR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QoAoeV6o; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QoAoeV6o"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31ef50d8d57so407759a91.0
        for <linux-security-module@vger.kernel.org>; Wed, 06 Aug 2025 18:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754531359; x=1755136159; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64zwBizW4qZh/LpGt/Q6emWiQmUZsreGGck6l+mdXT4=;
        b=QoAoeV6oYFy3n8+Qu6p7GnTF+bD7HYejKmwtuWACRnwQCCSaG3EtCQwfWjgqYqo2c8
         GYTS1haBe3MZ7iy+3gdokMItEylymk27liFmnrses0tOnUrD0ZM7NYgfomYRRVPj7cUf
         fugVbuIk9P6/CFkHP8MbRWQRYhLe/b8dKR6o7BvRG8KpS+asgrTu5lMoqD/HDbZ9iVI0
         vzaBlLU2VjHCReJ2iY5FQxoJdvEBAHfHmNDl3Xx3Hwqcp8K1S5AkJUIj+upDyNc+d4G5
         809QXc/Z0MuBKUyExSWk0hX3qvRgBlaHwvi6CZ+1xBSYqYs4w9Zlt9Agi8lpw0mUzHcy
         LZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531359; x=1755136159;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64zwBizW4qZh/LpGt/Q6emWiQmUZsreGGck6l+mdXT4=;
        b=kMj2FQY7wKAtFqEPhXgDPRS6m7e9Ht/Ulooghp0LpGO2P34YHAwzfS9rNABor4SvMj
         b5o3XyJ2Ut7uzX9HnYR7OKMhGfsXt0HkTsjQwp20BLzO2LjshJnbk5q9KIUcaVZ/mWXn
         CDm8vbVfQER67HSFFhTL5mUUz8HG0143HAvFG3068VpQpa99o1oqBR2MGFXTB9EV1S44
         70PMxnTkpr3rnw9qtTIE9FEqJvFbkclOM2/8fyb9OJ6U6nI7P7+qMsVREk3TliIIiFh/
         NPPJGhRdG+i9qNIA7FqJPiNvZjNoS+xUpo2NnR4X+CgNNdMpL1rDqZUhRgKTH2sitkIN
         m9Nw==
X-Gm-Message-State: AOJu0YxkDxyCb2NjxZOOFwiO8kVp03ls3xnElEDqmcmccGXRXRyvGA4l
	RTt88T/4J98f7XAjD+Pc1BWX9hN1gr4myUnipI2InnKK+hzx/qU04ji1beUBchq1ANdy6lvnHdX
	PNUkdIiEUCycEJ+BTbsaIwmUuXcWp9DJFQN68eyRlhtEZ25FnwBk=
X-Gm-Gg: ASbGncsYGRi1AFUSbvxAK1/1FF5eOKReWlZUa7mtxO7SzzDB9LcxMQZa/jbNVDIOho5
	vCIL0F4gvFg94tjEoOM+CcbKx7VotOW8sITnBahDJ78fKWIygWB6/KrLrrRYKVs+90RIIcvbsg+
	fwoCg+BBCUX1xjlV8BnMeZMKQGFZ3rsZ6+5ApY3oGct7i2QRoiotjvjTxQIAKZg7fAxFDeGhpAZ
	TC8NRU=
X-Google-Smtp-Source: AGHT+IGkoeqzTWdnSCtxezhLC6L3BtM6xnwU/uXl/ISF6xTI/GOMwKaVqpkyLqyRkEjP1PjZcTkoF45MTtHgM6L/GeY=
X-Received: by 2002:a17:90b:5282:b0:321:6e1a:1b51 with SMTP id
 98e67ed59e1d1-3216e1a242fmr5489932a91.18.1754531359463; Wed, 06 Aug 2025
 18:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806212552.240730-2-paul@paul-moore.com>
In-Reply-To: <20250806212552.240730-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 6 Aug 2025 21:49:07 -0400
X-Gm-Features: Ac12FXwZuhDIJgQ26WyJlR8kvVBbpJpxlgxFqBkrNqrGMtRodLRpZ0Khj_iNrwM
Message-ID: <CAHC9VhR1rTnv0ARUhAPag2O+bEXzxoww6UJa6pkesHZTEa-BHQ@mail.gmail.com>
Subject: Re: [PATCH] lsm: use lsm_blob_alloc() in lsm_bdev_alloc()
To: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 5:26=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> Convert the lsm_bdev_alloc() function to use the lsm_blob_alloc() helper
> like all of the other LSM security blob allocators.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/security.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

Normally I might let this sit a bit longer on the mailing list, but
considering how trivial this is along with a Reviewed-by and an ACK
I'm going to go ahead and merge this into lsm/dev-staging for testing
and lsm/dev once the merge window closes.

--=20
paul-moore.com
