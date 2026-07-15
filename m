Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23AE42BC31
	for <linux-security-module@vger.kernel.org>; Wed, 15 Jul 2026 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104780; cv=none; b=OtEeJtGUKv1aiEU7gO3+/k5hn1VsManCl2IvNDk8BLBfAVOWKSKTJbGyz+6X+kcOAKM4nXWK/gqvNP1bYu7sMrVeu7E2f98lLGmx30LAv6ggeVZM32A/MJBvz69/FBVdFRwPk56ocjQTvlVF+Vp9wM9yucLbaZp8VDu0kxM+sGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104780; c=relaxed/simple;
	bh=cEm/qTnAzZOqSTvTREY+WKNkOF2thKgKBFQSaQ9uI4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhgFLIJF9Z7vrWR4E2ibh0bK0+PKK8f5yjdFvnWPVuza3QxRl/2BKtRW7Y+E3VSfOnPGbTnmXfh7B83BtFFaMUfr6h/4pdvteGQcWJ7Dj6oL/RqJ1n/Dmj1QccxpgFq2YOmQKtOxHv4x4b6dpWs59HOoA43Ny8qbDMAsizwGBEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jl/u16MI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jl/u16MI"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso44376765e9.3
        for <linux-security-module@vger.kernel.org>; Wed, 15 Jul 2026 01:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784104777; x=1784709577; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WLOCq+q4901QS8UaLFpDknPRI2/Dvm2Tx9StZNFHsJw=;
        b=Jl/u16MIA1cRxyenjXQq+4X/jD58eImUwian7eSfQdiizmiRljDAHNpwfalscnCAiM
         6YgzN0mnp1serutviXLhOpdLnySBk3NLAGpZGUHm+WCpfZEYqFPvXqFMPw4ErZk5E3AY
         sxHSlLfsd2k7vDD+PytbeKJcTAUTUsWCTyX0o4na0sJxtkHlbrRBLSyla4lkgdvX6uqq
         mVqfyYBRJTeZCza93pmCFJadiy0N6AvY6VoqBYk7tEupfMDph3gsg/FTQQhLo7MrQoYY
         3lA806aERwG6sBymkGMSSPK0kjqnKuiOt6buZBjaxwPezXxO//jBrxMFdgHgWGHPB77A
         aRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784104777; x=1784709577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WLOCq+q4901QS8UaLFpDknPRI2/Dvm2Tx9StZNFHsJw=;
        b=n/nPUG2GdnuljcRfX0mc+aTUcURVk6UHj4tKvKaK+cPrKD6v0QsWmdOVPXEWxxD/hT
         //WCNCQN1gcL42f9R+WxJMr5h3i0INZig4fOGTQ/9riBkxpfbV+yjDemILVaVf1Ji3Jq
         DFpbvL99p3p/9VQqqo9c0bwQkVMzhv+kLKWHIi9Nl+/VUpJ44zfoglf3ZV7aoczKD7dx
         h5Q7mPt/nqWEke1ynmP1gNoNUBph7I6iw48zrcOade566bmmzvc4k+EW22arBvaYVlF7
         siGvvVJE8HvGSR2KlKZ7kXn/0bq5DRtz5pg7A+0QDpFM186dfu+lo9SPMnvXOTTDQ+xk
         CB+A==
X-Gm-Message-State: AOJu0YzjHslbZYMIaVivYccGUf+pnfMpoe+4XbMR4EzSo/wVBOhyIV+3
	M5/GrXe++ajsptM4QoeYWDQZA1/usTFH4z9YNcPaIuIAm3/ZZk2yRPtUX9KjnoKWATMJt7TseLx
	+z+n15rhD
X-Gm-Gg: AfdE7cmig381scbq39v2QGghOvQO0rKYwgER2+Nr8c8Oo+MiTewN3JdvShKuxevQfYK
	d9ph2go3EmRrLo++ecf3b6a4sMaDbxZXuuKmcEKzSTmYRxSGo/TeLvQkBDhMM6ojLjTNv2h9hzb
	AQ2xnxJZHSmEyXXeSIQTDuu4aTrCXmo+TXJM3d34ljuXRDFD4r8z5n491+UhUWsEJPXHgGzXxhN
	z48JBOZkl/OlNTBCyuGHEKjXlbE5vHf5scVlxwxD0d2ZBOAqG6JUhxVcIkl7hARFQaFscO8ghoN
	XTlhFjEVoHEy5etf1WkZIQC/kV08nJlsZenMh6+5niEvc0zVOD+hqfkwSpyq4bFPSx+hh4j0wWe
	+oZCXKKt6iScl7bd1cFpCaCo1PGUQrQNA/6XbU4H5yL5JPp2okzsNsjo1hKJMbuTGFCYevtJWAC
	lua6a7REP6L2ryGApN6pgbIEKnXLWe8hm6m348Q96E7EU=
X-Received: by 2002:a05:600c:699a:b0:493:b783:ad59 with SMTP id 5b1f17b1804b1-495389dc078mr58391605e9.14.1784104776541;
        Wed, 15 Jul 2026 01:39:36 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:53b8:23d6:e5b4:dc54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a32b9f3sm154561155e9.13.2026.07.15.01.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:39:35 -0700 (PDT)
Date: Wed, 15 Jul 2026 10:39:29 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Ken Grimes <ken@kengrimes.com>
Cc: "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	landlock@lists.linux.dev
Subject: Re: [BUG] Landlock denies LANDLOCK_ACCESS_FS_EXECUTE despite a
 correctly-anchored PathBeneath rule (contradicts selftest layout1.execute)
Message-ID: <aldGXyfBQz8GsAMn@google.com>
References: <P8RYlSi7C7oum2lk1F3PumYSvaUyd0Sn_VwUYAcWwjbQxSt_Rau30Aa1oLIEnLZ2iafcsFmEG5C4LTeBWCyd9vCx94FYeTX_OJdHoERcWSI=@kengrimes.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <P8RYlSi7C7oum2lk1F3PumYSvaUyd0Sn_VwUYAcWwjbQxSt_Rau30Aa1oLIEnLZ2iafcsFmEG5C4LTeBWCyd9vCx94FYeTX_OJdHoERcWSI=@kengrimes.com>

Hello Ken!

(Also adding landlock@lists.linux.dev to CC)

On Tue, Jul 14, 2026 at 09:07:56PM +0000, Ken Grimes wrote:
> Hey all, this is my first bug report for linux. The issue was discovered 
> alongside llm-assisted coding on a downstream project. The 
> investigation/testing of the bug was a mostly manual process so I could 
> be sure this was something real. Please let me know if I can provide any
> further details or assistance. Hope this is helpful, thank you for all of your
> hard work!

Welcome and thanks for reporting your first issue!

I believe the issue you are observing is that the /bin/true program you are
starting is a dynamically linked executable.  As such, executing it requires
both the LANDLOCK_ACCESS_FS_EXECUTE right on the binary itself and on
the system's dynamic loader binary, which usually lives in /lib/ld-linux.so.*
(but there are symlinks and 32/64-bit differences at play as well, which
influence the actual final location).

You can try this out with the following experiments:

(1) Compile a "true" program statically and try using that:

    $ echo 'int main() { return 0; }' > true.c
    $ CFLAGS=-static make true

    This can be started with the test you have,
    unlike the dynamically linked version.

(2) Alternatively, add execute permissions for the dynamic loader:

    Add an additional "path beneath" rule that allow-lists the execution
    access right on /lib/ld-linux.so.2, /lib64/ld-linux-x86-64.so.2 or
    wherever else your dynamic loader is.  (You can discover the actual
    location using "ldd /bin/true".)

With either one of these two changes, your standalone reproducer program
starts working again.  Or at least it does on my machine.  If it still doesn't
work on your end that way, please let us know. :)

I admit that we should probably point this out in the Landlock documentation
for the LANDLOCK_ACCESS_FS_EXECUTE right, as dynamic linking is common and it
is a potential issue that many people might run into.

For background on the dynamic loading mechanism, see the man page ld.so(8) [1]
and the LWN article "How programs get run: ELF binaries" [2] (specifically the
section "Dynamically linked programs").

—Günther


[1] https://man7.org/linux/man-pages/man8/ld.so.8.html
[2] https://lwn.net/Articles/631631/

