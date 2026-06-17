Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C012149550F
	for <linux-security-module@vger.kernel.org>; Wed, 17 Jun 2026 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781710306; cv=none; b=qwAexw7i4bIf2jYvWzfSQhuDfBct72zzovN2zwccCasC8Zz+Yv8kvdbcEi2HCvKbAyEP5ySeQNg+t2okhui57futB/PNgI71mlQOtpFGdD8PtvUPQHcchuNWB+/ooDvOBuCygQClUIiZP+c2yYRNEKtTGEcY1cS3tobKiNa/Fwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781710306; c=relaxed/simple;
	bh=TF8haHqenKUXIWHSQKRQ1srO2K3Otd+/f299io38fCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzKrus89bnDxDM1L4UwMgXKfBba6qp/1hO6efYux2wveAyH2Wh9AjvRgnq0iU7Q6bKUOVHueZtUi/sqilRQHcKWQuuZhB0wyW/W4aIjf7D7daghWPqFsA7UL/phdIy6m14/zvjyTWRCsnxi4JQ9YXyT7Nfhr6b/mj8Wu1HcOG5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DKMJg4wg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DKMJg4wg"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bed2b9bfa02so779175866b.1
        for <linux-security-module@vger.kernel.org>; Wed, 17 Jun 2026 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781710295; x=1782315095; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e/a3Ufu/P5FaF0fwJEuA4Rhhg7h705NuCKml4gOAODg=;
        b=DKMJg4wgOeGbX5JPf42ghg0Zz+JZY0Ot2X2aMy8boI+x7T2WX1BqMb6AW8YSGWeW/o
         XarLXnYRlM2hofjsMvEgHJT6DNzpfND/xTnWBX3gI3xBAkOH/R5YLS18luWwcJS+0Wa8
         ECqjY5YbsQo9qlSAZ8Kch07tFltpFxQdU84hAOErl1veAxYI3gCYHCXEStJZgBLperew
         98Ub+RfaQBRkxHzSD8P+5p4xX2LzbKhdwE9IHHOPV1u2Tqm/tAgBVap3pF60yETLEiLc
         PbGyh12eLRbtVi4Qzv8XSjya/TtMh9GfAbzHqGlW1qSYaRbmWW4sUuBDlSRlEFsLRCrD
         Zq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781710295; x=1782315095;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/a3Ufu/P5FaF0fwJEuA4Rhhg7h705NuCKml4gOAODg=;
        b=mBjP10FLu1KWsEHhLBI2uar036rdeytXuJftUmW9RPc+/6oekcD1EMV444pdFUU7Bw
         AmMJpfVy+LQI+rWfoq3Oxd+rfuN5BawsOjPjWOPf6U4NU8cPiCFWRWx+t4yU+5UChN53
         mQ3LC+n3jGC6nlcv8ar9jnsY1A9Sc9zUdJMUFvzzHU+OxCuViIPT0B+l1GK4EFtBlxOl
         FSH72EeKlXdTwWE5+caiV1eG88ro27wz94FmURsaDKkuM5JoJTgMFRNCGcOLqBFduNIQ
         TBoa7n1mQGGkjkW2msM0+vny+vDEs917aPi9XrUvY++rcPOauAEd9DKgY4U73XWwa3S7
         jF5g==
X-Forwarded-Encrypted: i=1; AFNElJ/RNSU6J9nSxf9Yi/MotZVPr+NZrClesL/hZzKYYjSTdMWEQ7aJcwW+XfmCbD6zt6OOPWMmwsioMoPHukcpeV1O5ATLEL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxemPDE3Xsm5P5uBH0Uc3jaZP6kvz/U9OeKKoi4YnXuu2sWV94B
	eRzisCmgOu418VoPHdwrax/cTSR6CmB4T+7o75VwWWKKwpqEikGsGWUvj43CDgoeNK6c9jSdZZS
	L/HLHjovx
X-Gm-Gg: Acq92OFZMtkjc0vCM3H9KNqj0/Sa+qE9Ply/8tLC+QEkL/8PNLPLby67lbPOQABVyIB
	4TxV9P15DzKFPh73wGQj6q8YFwSfYjGilETzmTTRok1ca3tPqY77gfIZjDxolUXh5EpDI5MSMHt
	fEt90pMl3QRmhL9YACU6SWC9BXPMzE/218NxovhXAYYA3Dth5kkTvDcPwriIjkYZkgSpe/0INj3
	zG94iYFrudyu8CK3JBUvHjZp3LOngoglazFm9jRGV3ioY5ElyvoPGYMZpjq7QOblno27wSRj8Vh
	4xoE55VVdUcDxMimUzVmU7mBBDKdcOcymazEu7SmJ94TBiEGvZih7iIQ3gl2h/1p0dakO9g2e0b
	FcmJeUNVAxf32lJxOgrtW7G1cE32EVb46oHG1O+qu7xC4nVY8R0ZuYNRUpGEMAlnTNVle/By3dC
	rdkJmZphf9xgWs4YzJaNoA0AnKQFX9WF/5d36Goy0Sa6YLCx48umCqcw==
X-Received: by 2002:a17:906:730f:b0:bfc:3a81:514 with SMTP id a640c23a62f3a-c05a1e4b56cmr317176266b.9.1781710291364;
        Wed, 17 Jun 2026 08:31:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:9fb7:e73d:434b:bf08])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb7b6e6c9sm828974966b.39.2026.06.17.08.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:31:30 -0700 (PDT)
Date: Wed, 17 Jun 2026 17:31:26 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Jens Axboe <axboe@kernel.dk>, Bryam Vargas <hexlabsecurity@proton.me>,
	Paul Moore <paul@paul-moore.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>
Subject: Re: Landlock: LANDLOCK_ACCESS_FS_IOCTL_DEV bypass via io_uring
 IORING_OP_URING_CMD
Message-ID: <ajK9zjmNHGw81alz@google.com>
References: <20260616201633.275067-1-hexlabsecurity@proton.me>
 <fcfa9bc9-4f7d-478c-90a2-ec4efd4c7d43@kernel.dk>
 <20260617022541.328550-1-hexlabsecurity@proton.me>
 <209b76b4-e028-4af7-bdcb-b5813fef32fc@kernel.dk>
 <20260617.aeNg7Aeseez4@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260617.aeNg7Aeseez4@digikod.net>

On Wed, Jun 17, 2026 at 04:16:38PM +0200, Mickaël Salaün wrote:
> As I explained in previous (private) reports, there is currently no
> io_uring hooks implemented for Landlock because there is no use for
> them.
> 
> io_uring "bypass" was already mentioned to us two times in March but
> io_uring personality credential is not a Landlock bypass.  The Landlock
> threat model is about enforcing restrictions when accessing new kernel
> resources, on a sandboxed subject.  The credential identifies a set of
> access rights, so in the case of io_uring, the subject is inherited by
> the io_uring personality (i.e. the file descriptor).  If a sandboxed
> task creates an io_uring personality, it will be sandboxed with the same
> restrictions, which is BTW an interesting property (e.g.  pass a
> restricted io_uring FD to processes)

Remark on the side: We have previously received bug reports due to
io_uring using different credentials, but this report is not about that.

Instead, it is about the block device "discard" operation, which is
accessible through both (a) the ioctl() interface and (b) an io_uring
interface.  The report is, in my reading, about the fact that the access
through (a) can be blocked with Landlock, while the access through (b)
can not be blocked through Landlock.  (See the other answer I sent.)

But either way, as you are also saying here, we should probably document
better what the threat model for Landlock is, so that security
researchers (and AI models) can refer to that.  It'll result in less
work for everyone.

I opened https://github.com/landlock-lsm/linux/issues/64 to track it and
collected some notes.

—Günther
