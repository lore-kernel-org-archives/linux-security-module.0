Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CDD3A783A
	for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697366; cv=none; b=liJuSBG0zeSt2mtGkbUoplmqNOGEZ4NO3BssmHD/EaKl+WfIDVgNcBTOqvDHitrjKT8mvNlzjhQ/2aB+R++PlCP02kO10j7/YSA0e+ErC7BEF9AmAgrjgFnR6NUpOYJqwaZJlkFtOk/HrrfRV9K3gl/07dwOGYOAU3uHapjd980=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697366; c=relaxed/simple;
	bh=yqydc2BAvs/EEy/vMFDPydcYDh+gc6ICoo3g/wT4z8M=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=urleWDyvLfWbFrKntm0NzDRDJrnxW4wI9XRdEmXKd467pfXC+XdycF8OEPSiMNuDAk3us73Iuk71L59hXYDjCUpcszK3ci9E3jFQ3r5RiPDxiNIE4gSUWOxBE7BRa6c/gxVrss8121uRfj01ggDxcuO5j761suHOb1b97eBWaL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ef+MNUdg; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ef+MNUdg"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50fc496c8baso67227111cf.3
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 11:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778697363; x=1779302163; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQ2lrl+/gKDcPyuGztAL7xFoyeibd4FccB/Ub7cgd0c=;
        b=Ef+MNUdg2cj68iOeUx6W6u5nft19c9Bx8d31j7AN3WybWxNHZBb6dan2SqkNlVXciP
         Rbh3XdOv6EcXFPhbjOXlFJQg4RASegCNS6fiX35hq4YDmPc9DD1j0t8dcKFrbcPPlwNV
         kVy83zVUPu8M9skQHx3H0MKHLsULiQ88MjIerFZQile5SP/YeSExIhjHindyS+CNmTuP
         lhXjJo17EHoJ0/2lx7J90ZH2pHXasPeLJyzy2X3qK3FjSF3JJsfo8i2N9EHVbE9VIsDT
         Jx4cZGLBAcVUmRjrZ+iqVRWmq2sDmlZAvdXVDhKeP/5/u8qp2+OQOIOUYSjHuIQr8GCR
         qmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697363; x=1779302163;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQ2lrl+/gKDcPyuGztAL7xFoyeibd4FccB/Ub7cgd0c=;
        b=dBT91lV3IfoZhOHnuf1M3j8Ov+kAFilfekRWVg44hpeQJmneFxjWBlOq+LtkHMGzLs
         lxksMRqVBYUPsdkyYAd4oR+uXxHR0imyKagTxvmgH1BluJ1ssk/qRPY+pixsVziVn27N
         qbpxc/s6PjAjMV+XWLNFXVYAoFkEIZl+7C5pBmW3T2MUg5RWuds62CUlOk4wX3HPdygC
         AJnjQxHqMJAM7Ne8BMHnesP/pi6JMNMkG2fphjOBVRf81AKPxJ908p0HwqnKtN03aWDf
         X8LdT+mKe2f8dyOpd+oFdKz/hyqaSNd4YQZ2N1+MkkXv/Fvw0bEzxJRZiTfCe7dH7UxR
         vtuA==
X-Forwarded-Encrypted: i=1; AFNElJ/h8G15aUlq3D3IJF6ExGWVsnJef4o3g1lT1BziWx2pMnHjQkBjqje/WM8yIv0RlRN99b4n7/aqe1r/Q2dWGRXkgIQLg9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhCwZDWnGfMNbYxN31BX9bF3M1el7EamYRSizDbC//L6tENaMe
	HQUp8jazjvpD+4D3RK9sZyTi31DKJHMvJYCzZ876hu5OX4EydLY2AKKkDnNJFQZd7A==
X-Gm-Gg: Acq92OHOiidUbi4jLucc750sb7jEE9QOWHVPDhh0VNMaYqTe97VQmz1D6TRqtYDI42s
	dYytDgVjk2SfbtVtoSBopxuYFaaXz2ViVVR71dUWN4qBgndi3ZlxWv5b2vYmoan2PSj7zu1iDQD
	dUai2UITki+CULB0q2fQEAX2w3FDIYDREH6DRl9/oOo/6/vCpIgHv0tLEJXnNrwp722QF+vgAyw
	9ne2xwEUH+GoXGzj/EZnWnl45g7l08BPi8JrI+ZaTD9NXzvk/1l9zAgXlrGFrGOO4KzuPdTQ5eg
	oFn46uJWXZr/A4NGbfBbBa7LB0ED0jWkC13XTvDeKCK+bhBo6lZ0cDwd+vf0+/VJKXi+EjxG3UR
	aeHKhVswgvhrhafpmVPe6A2W/ijVr6We+jdwZWwNv5OooS6cMtvkaJjVl8lF6o/3xBQbE2hXj2y
	W8BwVPly05OjPgI+CKyUhHorlF6mpSlkTF90Dli3z6c7GhlAY7FMJMGSS7moKqcXaVqNbf
X-Received: by 2002:a05:622a:5:b0:509:965f:888f with SMTP id d75a77b69052e-5162f2a4b4dmr62133441cf.0.1778697362725;
        Wed, 13 May 2026 11:36:02 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e82579fsm151609761cf.24.2026.05.13.11.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:36:01 -0700 (PDT)
Date: Wed, 13 May 2026 14:36:01 -0400
Message-ID: <fed9fdbba52e91a15597b3eeb79c9d2c@paul-moore.com>
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
Subject: Re: [PATCH v7 1/10] crypto: pkcs7: add flag for validated trust on a  signed info block
References: <20260507191416.2984054-2-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260507191416.2984054-2-bboscaccy@linux.microsoft.com>

On May  7, 2026 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> Allow consumers of struct pkcs7_message to tell if any of the sinfo
> fields has passed a trust validation.  Note that this does not happen
> in parsing, pkcs7_validate_trust() must be explicitly called or called
> via validate_pkcs7_trust().  Since the way to get this trusted pkcs7
> object is via verify_pkcs7_message_sig, export that so modules can use
> it.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  certs/system_keyring.c                | 1 +
>  crypto/asymmetric_keys/pkcs7_parser.h | 1 +
>  crypto/asymmetric_keys/pkcs7_trust.c  | 1 +
>  3 files changed, 3 insertions(+)

Merged into lsm/dev, thanks.

--
paul-moore.com
