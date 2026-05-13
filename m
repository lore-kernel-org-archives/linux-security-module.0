Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45633B19CA
	for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697382; cv=none; b=P8SmcV94aqQZh+H0VdfflCehKdWOhT9R/k5bJD74vfpJhMYlCN2OcWSPsTeiB0whGwUNM0Mav4l0CwiMAbrSyfXqPeI/l4kVUeDiTTUm7ZiC5J7evFPqO2IxGV8bpG4jdg9HMSNihwuk2sY+Vu87jWsoLmAARCLuEqIo02Z1XX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697382; c=relaxed/simple;
	bh=rM3smG6DhfmKq6u5uT72ezd1TJoaV7KpSoZfNmuAruM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=TwiELsdy2d1QE7NmPnpQiTIz3qGVD2wPBjyTwZuXZihprJjMNFA8rTzNx3jbE5deICF3ZjPJCHrG4lrYZD2+/CNQCLvY93SMLmFN4CXKI4R+qucXxrVJspr3vT9iv84raHaNzNxMmPt7xWjRNPobDI38hzNjw0z2ciYUy6BR4T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Gtmd5QBD; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Gtmd5QBD"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8b7105dfb35so69663326d6.3
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 11:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778697380; x=1779302180; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aPyCkn8cjAjReTjdDgF7aPv74Q5Bw6zKWh4tDPFGek=;
        b=Gtmd5QBDZ96LdBQrMonh4NM6wrCOPcJkTO6LltdyRy1HT3UTsgLbOfeUUMoTQID8Rl
         /53IUUbkBOqAWGInrqbaislt696O2m70WGctNrWTZocHMbm3MUmiUrwPKfIS1SmfHYnd
         g0UBHSUc4ZHEAFoo601hVezxM/n84ux5WH7wRhYf8fP4AYqietaUNEZxBbc3esBmbhG8
         cTACiCtJhXHHtgBQrHuS7G7WihSb3ltCFGy9i1Gc2KL36/scMcoNJ7hlUWgFybyUMtOk
         RnJgjdhKtxHW7sGxfVog2UjdjDwT2CjElxfBkprAlV+kc/UOgoEZg2JPfAKzp5ExwowF
         z7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697380; x=1779302180;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aPyCkn8cjAjReTjdDgF7aPv74Q5Bw6zKWh4tDPFGek=;
        b=pdZFmJLCrIJpd7Ayc+wdFs/PuX57pzIHV2St9IHkgASVLRiNI6OQVJkQn9MD9z7Nwz
         mmUwgXf2ajc/Qr0QT+dmzKdJF5UB54q5J+zlTivf4nokKGjIG+RXDbUOMVnmtoFJ4S5g
         jEuULPX7bPZi9SAfwBb7eSnBLpZoHOIJYKq0agKwZKya3a9C8db1Gqxpi8i7p3lNk40B
         RkwTBbO/OE63P5ZdAkTgbJxqNHpvQSr7k9ukLKiN3gzWseTXuTGP+y0SMwrqFR5UipzP
         XR6GTPgifFvCZnJHdpvAfj9IysAfdjryMh+Nzl5x0i0bz6b6BPG27wCKpTfhAghSAtGx
         RrlQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ShK3HnKvnIJfGGYy3B4sjoWAkYohhgKOxdryc+y9slxSA3oyfTj3C+HfsSO7MKfE5xMEvERzwV086PVA5PpUR8FVp/L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfcGzOQHGx6LhW25nnDLIee7OU25IqEhUWHTDGKfIa7sbUsBPL
	3aTls3aIy5RyGUYEP7Yv3hQZ6AuAoRcWekAPY0U3Y0Zzh2UWWpOuI1tKgrwcXRpbHw==
X-Gm-Gg: Acq92OEvYdK0BJAa6FPDc7zcHJGVZT9c9jxBx4d2r9m/2lYo9myKAj5/UuLK0+5ja2w
	QG4cxEp7EtksfJLGl+FB00EyfLcOs7AgvQCVVslDwSKp6ETQlp2ACnztqhjwjSlx7Xh/ocTm7lG
	zwFpEuN0BebinAn1G77CRnxMuFNypnffSKXhyhoxzONMLltn0y1vUpSxfn38QWmifz+QsLmrQ7Y
	VP2R+xgpdBIJRmi/3DK49mBEERbS6f/PWaps2txL6Eq5Obf3WXgho9Nr+Pj5Q4ucRc5kW6veNfj
	bZTgGda96ALigo3YCFassDqn+CLeITB94X2E8RLlZ9QjVP8OSoba/3+J7AXVdttfEhAgLp2OqX3
	nCYh1k6gesrIlGqXeeteWKapGAu13Q1CH0VN1wBzfxmvkQMMPG6oPF3p4/ZIXDJyQlYeRGKk6cX
	EV8ACLktMX4joS6FtwUAp8A3TzyMNTd4+rtnzRUucNDgWEG6mdlgm1DXOeFG4p0VKu+QdZ9ownb
	7FKxqA=
X-Received: by 2002:a05:6214:5781:b0:8ac:b237:9fb5 with SMTP id 6a1803df08f44-8c7bd2d3297mr68869026d6.49.1778697379782;
        Wed, 13 May 2026 11:36:19 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908562d3csm3280956d6.4.2026.05.13.11.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:36:16 -0700 (PDT)
Date: Wed, 13 May 2026 14:36:16 -0400
Message-ID: <5c1eb7f77bb48eae4ace38a5b35d207d@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260512_1604/pstg-lib:20260513_1343/pstg-pwork:20260512_1604
From: Paul Moore <paul@paul-moore.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>, "Jonathan Corbet" <corbet@lwn.net>, "" , "James Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, "Andrew Morton" <akpm@linux-foundation.org>, James.Bottomley@HansenPartnership.com, dhowells@redhat.com, "Fan Wu" <wufan@kernel.org>, "Ryan Foster" <foster.ryan.r@gmail.com>, "Randy Dunlap" <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, "Song Liu" <song@kernel.org>
Subject: Re: [PATCH v7 7/10] hornet: Introduce gen_sig
References: <20260507191416.2984054-8-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260507191416.2984054-8-bboscaccy@linux.microsoft.com>

On May  7, 2026 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> This introduces the gen_sig tool. It creates a pkcs#7 signature of a
> data payload. Additionally it appends a signed attribute containing a
> set of hashes.
> 
> Typical usage is to provide a payload containing the light skeleton
> ebpf syscall program binary and it's associated maps, which can be
> extracted from the auto-generated skeleton header.
> 
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  scripts/Makefile            |   1 +
>  scripts/hornet/Makefile     |   5 +
>  scripts/hornet/gen_sig.c    | 401 ++++++++++++++++++++++++++++++++++++
>  scripts/hornet/write-sig.sh |  27 +++
>  4 files changed, 434 insertions(+)
>  create mode 100644 scripts/hornet/Makefile
>  create mode 100644 scripts/hornet/gen_sig.c
>  create mode 100755 scripts/hornet/write-sig.sh

Merged into lsm/dev, but I did add a .gitignore for scripts/hornet/ and
I fixed up the SPDX tag (it wants C++ style comments).

--
paul-moore.com
