Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA584DA9B8
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474059; cv=none; b=FML3soiykCs/D9KSSZIWRgv0aUz/BKtauu2W+poTIochfp0WrYK74iosKsa9COO6SywR1TvwS6yZ9xBXJbBXk8CQuNxHtnWm1tk0bRR3t3Egy9CCNrAVsVA5sjZnsGRFtK+u/nPE9huvPZIVMl/YVzgt9Z7LU/dS/pZEHTbD6p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474059; c=relaxed/simple;
	bh=XcA+nLpj94/DJ/Rraklqza+8j4Qcoc86Vhgyq9rdRJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f5JeflnDdAgc91zzUNOUMfr51t4NzM2TBXTCPrSdgdJR6fdz94m23yCfSpix+UHlBE9c2SB6gaMbDQ4wwMemm5/ihS9Xuyyv3of05Fa7gXuSwnsrNUng/c1R+6uiEzsfFrqvdG+cWZzFc6iPXMdHi86PW12iNxjACZiLCPZuVPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=ZO275+t/; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="ZO275+t/"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a20367cf82so49827971fa.1
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791474055; x=1792078855; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qg3REX0qNPfLJEc1GEYkRVmVRk5EMast5JpkHxdhxbk=;
        b=ZO275+t/DUVWDWIWddvW08EnNAla5QG5HRaw/WrR2CPI/WlxsRzs1uvQxEr+eHKiX8
         FDYOAZcDR2GAklNBoF4mE5TJ/z/A63yoD66P6HYQd1N5jDO0Q98SYqsRS6L9dyftyNRi
         GwvyJgB9bxhujZ2cROIMYrHx35wWL8YL0A9shoeTr1WZ0ZftMIiqOBB23rjEGiJp4gqs
         LrFwVG6gMI/t1S0IfJdrrEw+e2bX51tk2pmPFtjof+UNsFidTWbZQSzxDtfcFX3hvKTX
         Y/NkkqgTW/s53r/Jd8tcZrP66P0zjYmU+xwR+TrGS52ogOddYFqEyO5FlEXVg/qIzYpi
         ia0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791474055; x=1792078855;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qg3REX0qNPfLJEc1GEYkRVmVRk5EMast5JpkHxdhxbk=;
        b=KCk9ZOM5/CdObeD/BzH4DpEgSgvwPObZsSuucW/LrNzJRRWfXLbnFkfD4pFddRGlRT
         0q55vaLun3ESRhCPWgdhxr37wFuCCcWe11tdrXuHrXHuZSQ0HcFNRaPm9QycsDpEO7d3
         1GuDa87CxtnX5YPrgLtp+AmYDSNN1sliodh05qJFW95MqqQkZtQyNqWCdyvTjZlcglVp
         P3V6DeEhc3XxBmVCaIqxlCuX3zDkfCix8DwZ43fx1oyw69/VDI4dKGJKeTwDVmHwMEiC
         NfbuWlUHHRY00FvMGtfBlPIrUagwgWVNIiD2cx1dVkUISCyj4RfZln7u4NAt1KlGibyG
         LW0Q==
X-Forwarded-Encrypted: i=1; AKwUvBwK4Ubeqtxsl7GZycYRotVk12SZgljNX2RWw3Ici9gJt5Zr078jZxRDgv32n7NP68YrolVddHOArx3C10D/Ig/4asOCOPg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAF8J8Zx3mAMVSay3SPd7oIfpmAtrtOiWpSQTybZ9YNssgPK2c
	qOZ+C3dkwz5AnWekOQGMosoZlSS9iXJ9S7eKVTL6PN9w50nE240unDzsFc92vYJuLhc=
X-Gm-Gg: AYBFou0tP8539Jimu74Cy/6zMYjAI+bDs3WJy0yJY7D1/d9bzl5XRGeguQuloL9o9wT
	kqdT0gIPAkQeVqSfKFvuRr7Kf+4isHNCCkh5GgrBMJp/6HGcCTMQrqvPi3gtkjv0Mqoz6742XPq
	/GKMV1gzeaWVA7rournSVYi3K9CtPfEO3GXQzoArvW7Fo6rtaHN28F1Xtruqc3Sa+UVtqb7ZcTp
	UnJJtqHR+XlV9UcBctQkA2HjuSNAcViArzIqTmY9Y+dwgrKMlr/7ZUJeX+kGSrw2g53MZnPhARK
	60NfVcuaLHyXjoW6uydNGLD25TpJMeF9vIAmScKKU53fMJ1INF/J7+8tDULzO9GwEkCz1vdw4zw
	KRdpJCRWBkeZRXZEVKZKz8PDdiiAr7BgA6Au7FaPIpWL4ghNhEOxHOcHFpXLnKgwMg58BllOVwg
	drGp/xgJBwLrRGtyMgxqzhBVq0G+mvNoMj5UzUDcVB4sW0rzPnc1BTwJLRFWtqfhH18AfKMBl3E
	XL9aeJYKzVQ6IA=
X-Received: by 2002:a05:6512:a83:b0:5b8:fa05:e49c with SMTP id 2adb3069b0e04-5bcd0702f0amr2360032e87.34.1791474054654;
        Thu, 08 Oct 2026 08:40:54 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcd309dab7sm1398142e87.75.2026.10.08.08.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:40:53 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Paul Moore <paul@paul-moore.com>, Christian Brauner <brauner@kernel.org>,
 James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>,
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] capabilities: close the ways around the CAP_SETFCAP
 rule for uid 0
Date: Thu, 08 Oct 2026 15:39:30 +0000
Message-ID: <179147397027.4.15064782992163283819@toxicpanda.com>
In-Reply-To: <asehZEWAwsJcbqvM@hallyn.com>
References: <20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com>
 <asehZEWAwsJcbqvM@hallyn.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Oct 08, 2026 at 08:57:56AM -0500, Serge E. Hallyn wrote:
> Would you mind describing what other solutions you considered?  I've been
> looking over this set since Tuesday, and finding it hard to reason about.
> (Part of that is certainly the nature of the problem, and it's possible
> that this is the best/simplest solution.)

Everything we looked at kept the state in the cred.  We model checked
the variants before writing the code, and these fell over:

- a bool per cred for "had CAP_SETFCAP over the parent when it entered".
  It breaks on two hops: setns() into a namespace that maps 0, unshare
  again, and the bool says yes for the second namespace.  Hence the
  level.
- checking only at uid_map write time.  That misses setxattr of
  security.capability in a namespace that already maps 0, hence patch 4.

We didn't look at keeping the state on the namespace.

> If we replaced the userns->parent_could_setfcap bool with a ref to the
> creator's cred, then at both setns and write we could check the actor's
> credentials, right?  There are probably issues with that specific idea,
> but that's why it would be good to see what else you've considered.

Checking at write time alone doesn't work: once a task is inside the
namespace its cred says nothing about what it could do outside, so a
joiner and the creator look the same.

It does work if setns() refuses to join a namespace that maps, or can
still map, the parent's uid 0 unless the joiner has CAP_SETFCAP over the
parent.  Then everybody in a namespace has the same reach, and it can be
a level stored on the namespace at create time instead of a cred ref,
which would pin keyrings and the rest for the life of the namespace.
The checks would be setns(), the map write (opener and writer are in the
parent, so a plain capable check), setxattr of security.capability, and
ptrace.

The difference in behaviour is that the -EPERM moves to setns(): a root
task without CAP_SETFCAP couldn't enter a root-owned container that maps
host uid 0 at all, where with this series it can enter and is refused
only for the map, fscaps and ptrace.  I can prototype it if you prefer
that.

> Of course UID 0 will always continue to carry privileges even with an
> empty cap_eff.  Here we're stopping it from writing filecaps to uid 0
> owned files, but if it can open a 0 owned file on the host, like
> /bin/sh or a systemd init file, or ptrace a process (in a child ns that
> maps parent uid 0) doing so, it can still cause damage.  My point being,
> we do need to keep in mind the tradeoff of keeping the code simple
> versus the realistic threat of the problem being addressed.

On the same kernels, the restricted root task can copy a binary and
chmod 4755 it (it owns it, no capability needed), and a uid 1000 user
runs it with a full CapEff.  With SECBIT_NOROOT that setuid copy gives
uid 1000 nothing, while the fscap file still gives it what's in the
xattr on an unpatched kernel.  So SECBIT_NOROOT is the case the series
adds anything for, the same case db2e718a4798 covers.

A smaller version is patches 1, 4 and 5, with cap_root_level() moved
from 2 into 4.  I built that and ran the same flows: every route that
ends in a file capability still gets -EPERM and uid 1000 gets nothing.
The uid 0 map writes refused by 2 and 3 go through again, but the fscap
write after them is refused.

Let me know which way you'd like to go and I'll rework it.

Thanks,
Josef
