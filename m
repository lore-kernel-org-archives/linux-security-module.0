Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AC43AEB49
	for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697379; cv=none; b=jrat84qIa1A7Vr5+OYQApdB+nAMipYScyovkcG2SQBHNCfgiJ8fbkODRDmFmpgeejeXDBBFU+wZi4C0p5S+OaQ12tMOgifcUh38ie8bFGPLE+wuLJa4z2usSI7JK+AfSalQj9inPbW9wt+kvImHVCL06WBB13YM+ezo9Hyy9RhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697379; c=relaxed/simple;
	bh=EGzWceiAVeeSBnRWldnrtoBTzG8f5fZR6iZziGoTu4A=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=WpcF6CC6ETF2O9cdv2DyNOtefGf41TCL/gw74M2AksfdNmibMb9SOuJTl2dJ6z9bMAPJ8GnoLJqsD5vD/BAOp6VoKBFG5JcKOiDeZbWAGerNs4V3se6tgG9wfCGYjiDwR5EWsny21FkJ7WQ0vXt/bkFoJCn6MxHHpuVtewm44f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ynx7Z4Lj; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ynx7Z4Lj"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso93077246d6.0
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 11:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778697376; x=1779302176; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Lovk2GB7TQrI5ucvuQmmBzaE8ASoKYdV2IJHUjIv4o=;
        b=Ynx7Z4Ljie1JEomghn7GlULS7IhGgd2OagVENW1wPLCvZRScYzUpNdeVLtI24noRpc
         WNIj+KqksgMw40fBxE6gveV8VEplGokq04TM1GTe9/7whTW+hB7R/M1FEcy46QJ1nIUh
         7ac2mnOYCxaG1x6/okZLQ8zAoySoCBIkRnRw0efKl3ZevCt6uU1U0impaQkdQ9nXO/3c
         Oxm+hWns60n8b95RQrnkijukTwnCiTdfkrJSboyzP6VrCr8kmb6L1sFwrQSAD1GsN6PI
         xkZ4g11sk2AwYC8Nrbi+mp7aTaC2WnA7KeFNhXVKaU/I13NZj0gK5IIKTSPCTfvNlOKh
         rxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697376; x=1779302176;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Lovk2GB7TQrI5ucvuQmmBzaE8ASoKYdV2IJHUjIv4o=;
        b=RX8ZsF6fkjhROhGj3kb1DAwmjI1yvCwVjOBMqK/g7osgB+JDJtXEV+4Pdw1KDwVEVa
         QHga6LTnwRU/wNEnqXoz4JY9BJdqx367DD9e2y9t3AREoeaP0L2vfTagrBleYNxc1ond
         gUo2ZeW1Pa2AcieqOkW8izNAM5fbkUk3QRwBtZ84P0xNli7Y4jjAZvELwxQ/aWVpwqjH
         uvZsR+88DUwdJ1aXN8RhHdSMfa5UFFjWXJtOpLN/N/dzkv2ht4Qo73o6Lm5RcAMWa/Rg
         G4RgdJBbPrJowMZ9rQknqs1ygGy6rc6S/avpc67geBcXTQYPXIf2y9X61TFV7EyaoR34
         hDnA==
X-Forwarded-Encrypted: i=1; AFNElJ/gftnoVQgGiaxIhbUz0JVfY434n+QaASNRplpVDbVviyUenhxK8jbSAiNHMbNPP7Lw93iilayld3/FAJN6e216qkcevko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLvRbqDrMkzvjYRgfqPH+luQk6tV5wpc5Zt1gtPQYfLXTBUJOH
	0bV2MjT36kX9rJnGiO8jc6tSysV3fx5pOOVD/I1oIL8o/dOZ2HmVdUNEnZcpRyowGA==
X-Gm-Gg: Acq92OHbnd9DV2sjWCwo0hf/6HfMLPplNjH3iyV8asvbfV1KN+3WHekMKiLCwRbw3EW
	iPwpg/7b4zjjE7l76bewKX+MKvFFPYoKEmWsBlaQeiS019V+jWvpAZ/JKQCCC44w0/UdQnjQyvR
	3IQkK7Hv00qRAqrZPy6mtT5fhe4qnMv7PaWxhO5OTEqkNaI7JPJtqRXwcNtWcxjf340/NVjKGw0
	a1a9gLi3ApSU0lSlOc6OywW73ult5WwSCzsheAExisoVWpea3qi/CUMHMpYgIH91Ike61glKNia
	KGe5DqrDmCV5mufRHVOnq5S3rRRFzDDY/fxn5uU6fl2LCPiDOU0rFJTuohT6y8uwUYi8JLT2CWG
	OagpaFD0tIgsqHCRVzui75N7g3MvDGMIGCEXZFtjS406MDbQYOeg+5y74QYGEvOpfNW8f4RlFih
	TANy63RPzVg50gpTSVOQz39oJlk7Qf5iiNEB0jiifZQmBwL6kQs5tNVbJjbf762CaKdvns
X-Received: by 2002:a05:6214:469d:b0:89c:cacd:244a with SMTP id 6a1803df08f44-8c7b9e6573bmr74418346d6.5.1778697376105;
        Wed, 13 May 2026 11:36:16 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90bb8241dsm2941076d6.34.2026.05.13.11.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:36:14 -0700 (PDT)
Date: Wed, 13 May 2026 14:36:13 -0400
Message-ID: <426bd02f7870a8af23035d506a50de78@paul-moore.com>
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
Subject: Re: [PATCH v7 6/10] security: Hornet LSM
References: <20260507191416.2984054-7-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260507191416.2984054-7-bboscaccy@linux.microsoft.com>

On May  7, 2026 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> This adds the Hornet Linux Security Module which provides enhanced
> signature verification and data validation for eBPF programs. This
> allows users to continue to maintain an invariant that all code
> running inside of the kernel has actually been signed and verified, by
> the kernel.
> 
> This effort builds upon the currently excepted upstream solution. It
> further hardens it by providing deterministic, in-kernel checking of
> map hashes to solidify auditing along with preventing TOCTOU attacks
> against lskel map hashes.
> 
> Target map hashes are passed in via PKCS#7 signed attributes. Hornet
> determines the extent which the eBFP program is signed and defers to
> other LSMs for policy decisions.
> 
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> Nacked-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> ---
>  Documentation/admin-guide/LSM/Hornet.rst | 323 +++++++++++++++++++++
>  Documentation/admin-guide/LSM/index.rst  |   1 +
>  MAINTAINERS                              |   9 +
>  include/linux/oid_registry.h             |   3 +
>  include/uapi/linux/lsm.h                 |   1 +
>  security/Kconfig                         |   3 +-
>  security/Makefile                        |   1 +
>  security/hornet/Kconfig                  |  13 +
>  security/hornet/Makefile                 |   7 +
>  security/hornet/hornet.asn1              |  12 +
>  security/hornet/hornet_lsm.c             | 352 +++++++++++++++++++++++
>  11 files changed, 724 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/admin-guide/LSM/Hornet.rst
>  create mode 100644 security/hornet/Kconfig
>  create mode 100644 security/hornet/Makefile
>  create mode 100644 security/hornet/hornet.asn1
>  create mode 100644 security/hornet/hornet_lsm.c

Merged into lsm/dev, thanks.

--
paul-moore.com
