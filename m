Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B80A2820B6
	for <linux-security-module@vger.kernel.org>; Tue, 19 Aug 2025 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615403; cv=none; b=CAOLxpEoSMdN3N2TtLGwRNLf9GmC2gxYvwIf7G4P0PGc2DMtZp38D9NhoQ8lLDJv6/AJuqQkpgATX2jjMQ5RstMQWtNWUrBJwkG0UOVzpy64uJu6R8IW0TBwhTHyRUWjO8BFmBicki0MhJLOjYflKpfEQj6fnN1RNXF/xDYZ7es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615403; c=relaxed/simple;
	bh=ELRQ3hOZwpeTiP42YnBceOBTrxHGJHFkt+FI+54mVyU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DVN8RbWsmTtTgCokvUkVRBS7gFPi2cRxtJphXcinrepwTiBi+UcGjjKt8ZKl24vnlUoJF6mCtYCeq1zW4gjzwc3ZnqsaFQNd1o2VZXKyachr1f14cngNYWTGjGP9cjKM5niWpik/dyKWBtBfNGioRdKyB/pPIbfK6Ad2sWT/LpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QGmWCOAa; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QGmWCOAa"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-323267b98a4so4606226a91.1
        for <linux-security-module@vger.kernel.org>; Tue, 19 Aug 2025 07:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755615399; x=1756220199; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=om8+GylJanYijPqNxQuupiP0PYjgSVTngOJHk0kcsDs=;
        b=QGmWCOAaSnIEPzqU1vqtjpyKIOs8QOuD8qKrxO2rmU3JGj5kFz8CBDafeKG/KwE3IZ
         hK6S7FycWbZIp35iN2VnlKCKkLdL3ZRjq7BS6WGhtBUDuWDeu6UXYTOXejLetrDZjoeE
         fKiD+f0/Pbew9iE5U2mkEKyl7TZUyOZwVqAz07PNPxSy/F6F5I/Pp2s6A6399gNMp6R6
         tFjBxqefz8Jxc/FEW2hpFmau9jZvi560rBXvrDBd5ewvNyWoLbwbyID82Wk23Yvlw6B7
         Z55mgZPIeqGvR/ve2HIt9Qq1C4X9tQR+3KE9aYY+27Xwig2iSShjLe6857i58lWdv45o
         P0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615399; x=1756220199;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=om8+GylJanYijPqNxQuupiP0PYjgSVTngOJHk0kcsDs=;
        b=CPjdvVPkHwTu/gLPtajAwVgUIRpM1mm5V2nYnGKEPuAeogu26xUpEDI8GfvS4FKT1f
         hkXQ2UGjtx4j2Q/R1RYf7148Hs7Rl9Q0jD07hqjiI13jflyVAWFtwRPLhs4OPMtl30KD
         i+jZ7TjzfnEe0Rj0IPAoDJaJn3A1RGlx/TwTixTHGddzyk7L6v8Ws+sZTS8JZk3ysi3l
         hA3uxRm7K0VsDf31/0QRRmCsYfcXP6iPfimbRh/SUJvN//nDuHig3lIs/rHJlW16qZCt
         LPrTJfDTtiTX+izvJqL8H8lpfmanlaZlOjF3pOHaKzVtVhhVrdkWmoE64rwdEmmojSDV
         nB+Q==
X-Gm-Message-State: AOJu0Yx/WkmdXpDmxaZezcBVOKiMcPKd0L8UmDUoNmuesS4KqZaSXp/S
	oKKKBwJT0ZC4HC34vIfH7vnOhwoao5nXq332doSBqTC6leSeSmiWbcDWCpojseF4WCNFCERHUPR
	fw6NnTX9176fXCj/AotH4W/Jk2693sbFuIUg7EWcpJRsmqjEfeVnvXw==
X-Gm-Gg: ASbGnctNv50gAh+eRg5qHXWhIFZcLm9dIHKwYREYf6NY6xlgXiMZrgQ1QOIuqhgEcBO
	nDto6RbOIepOvcuBobD7a3DD3oTlyeHzUSVNpu4PAYGE8Q0w7Su9NeY0++iMW3RnqU22yx/VP2W
	/reCUxzoznGFMzeh4N15KVX5kLpBAwKrXgxrefaFozOQVrfqCdRZO5RjcGQma2G8mQL8B0EZKAB
	7OhI1M=
X-Google-Smtp-Source: AGHT+IE49+XPnBQc6B8Q5oFF3ZybE61TRrP8sGpydu+cRS/OemldinxpEQ2S7YE7y6mOMXaC6E4L57zujbzwokba3R4=
X-Received: by 2002:a17:90b:39cd:b0:321:b975:abe5 with SMTP id
 98e67ed59e1d1-324423497b4mr4040268a91.0.1755615399425; Tue, 19 Aug 2025
 07:56:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Aug 2025 10:56:27 -0400
X-Gm-Features: Ac12FXwMom27El91QycvjYzBe1ILor1PtOm_viaQq7KOGF6ZD2EdzLeM-qMaBDE
Message-ID: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
Subject: LSM namespacing API
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello all,

As most of you are likely aware, Stephen Smalley has been working on
adding namespace support to SELinux, and the work has now progressed
to the point where a serious discussion on the API is warranted.  For
those of you are unfamiliar with the details or Stephen's patchset, or
simply need a refresher, he has some excellent documentation in his
work-in-progress repo:

* https://github.com/stephensmalley/selinuxns

Stephen also gave a (pre-recorded) presentation at LSS-NA this year
about SELinux namespacing, you can watch the presentation here:

* https://www.youtube.com/watch?v=AwzGCOwxLoM

In the past you've heard me state, rather firmly at times, that I
believe namespacing at the LSM framework layer to be a mistake,
although if there is something that can be done to help facilitate the
namespacing of individual LSMs at the framework layer, I would be
supportive of that.  I think that a single LSM namespace API, similar
to our recently added LSM syscalls, may be such a thing, so I'd like
us to have a discussion to see if we all agree on that, and if so,
what such an API might look like.

At LSS-NA this year, John Johansen and I had a brief discussion where
he suggested a single LSM wide clone*(2) flag that individual LSM's
could opt into via callbacks.  John is directly CC'd on this mail, so
I'll let him expand on this idea.

While I agree with John that a fs based API is problematic (see all of
our discussions around the LSM syscalls), I'm concerned that a single
clone*(2) flag will significantly limit our flexibility around how
individual LSMs are namespaced, something I don't want to see happen.
This makes me wonder about the potential for expanding
lsm_set_self_attr(2) to support a new LSM attribute that would support
a namespace "unshare" operation, e.g. LSM_ATTR_UNSHARE.  This would
provide a single LSM framework API for an unshare operation while also
providing a mechanism to pass LSM specific via the lsm_ctx struct if
needed.  Just as we do with the other LSM_ATTR_* flags today,
individual LSMs can opt-in to the API fairly easily by providing a
setselfattr() LSM callback.

Thoughts?

-- 
paul-moore.com
