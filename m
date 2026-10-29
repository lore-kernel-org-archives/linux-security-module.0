Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306010;
	b=mYGSh+76w1LAAMZZb9BGIyy++q+iGmjnVOUQ3Wb6JTKm724uJrZ0tiCf+ylNmvG3V/H4
	 yp7jALUd6kr+Ena1l3Ps/U/JKqPxnuWpB0V8e2jo4bdwkZRO8toL8ejsXstO/j7rJs5TZ
	 muSpxdyldxPUrt8lRb4zVLqq3iG0SO+k9p040eCx1ptUZ1GR48PyKQPRL+bVZfSFPcYGL
	 MSXzxG8UmhvIqiSjovCpy1Wixzm655OUirQ2KUBtq0GH7/yJgkQWRKNs9teGBd45MrM88
	 /z2e4Zq6BJP2tOMRdtIJvE5Mce4Q37MIOm2x/kIega80AuJTNUQ9QJaH8dVw5gV8bsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=1FwGxH5RamrY2sgTjs3EG6aOjMo9Ydi6StxHkJqw4Uo=;
	b=hUtf1jFVcO7+IdMHp1E4xlpgrvkd5QvSaJYrYv4uKTtkHN1tsc64c2TjYPxdekKjZSSO
	 awiNzOCViwI3fBl260iLSezQd5nwXXbhbRpCxT28mB6Gh0j4cX6j5EGPKdkY9unK0RqFe
	 Lvt6S3zfhIKRYWTRWlEBkdwgo7O4IN6+y+h6bywFzMErqLL3g8C6SosZN2wCTTK8VNMLy
	 WNufa9+FKXSgBRlSAoWP3o9+dVewgjRmMrkSPfQgFbNYr9c3QOIikatx+G2RpAYknG5xu
	 k/Y/Xh/0R6bpV+IAOJEnDzEsPajRNRgrmeIzoW7ch0z1LYfWezl7reuunGgKawmevUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jzUC4j+m;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F21D606A336
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 20:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F21D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jzUC4j+m
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6de2f213b7aso1266227eaf.0
        for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1793306008; x=1793910808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1FwGxH5RamrY2sgTjs3EG6aOjMo9Ydi6StxHkJqw4Uo=;
        b=jzUC4j+m5k1GWzE4M+MP1+7CZ24I8OTXJlA+L47TEmbE8YmDlulAMxTxxOUwWkdRHH
         ZA7UWCWY4UP0IpGp1AHTAIZ3biCBCS3Tm/hc1d7JYAYzBEUgymxOLRamDSR52NWY6yTV
         Nj/CqyTphrQl74nCEr4jlN0A5maoCINl7zvMB7W8X8TZfTkAJvS2G8HM3Jp5HF69ixuK
         k8K6KaBp15/F8ksjNkcHk9DTAxy2LvSV5923Kd0H2P6TbZ8q5agmTrdcmkY94F1z8Riv
         XkPjRnV7/c156Gl2EZ27Xh6M+m8MNab0eP3uNFZbUkpddrNb2ItyVbJgXuN7mAV+JTBo
         PHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793306008; x=1793910808;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1FwGxH5RamrY2sgTjs3EG6aOjMo9Ydi6StxHkJqw4Uo=;
        b=qU+Xclg0umrepVzoTDgUgw8oNmlIhrzmZ8aIBz27oB9pNVAmVrfhHn/zGjBsFTcnhJ
         ItMY3Ibq8+jLhSZQoRD6DC7GXTcel70jiE9OrtYO0a56Kv8qGOUb2yZvxP8uE9LtArGg
         2pZg/FllaEoGS03lToBaiOlnTBH94oBEQMwm0wzF45spHsUnK3T6D9yuXkdMFNVXAFs7
         eDOy10/k1C3ZOs66SL95trnzMKokFs6DMo0uJvQfRd8Noz2t3yG0Y+2S0j36cqPsLDMz
         1yviTceEVDx+CSWBhvW/qsP0G+OrZxlm3jb2QGGuw8FEwyjzFrnrHHTbVhxhQLNVqVG1
         kEAA==
X-Forwarded-Encrypted: i=1; AKwUvBzookxFR0RjPUlibYIRj362RPk132JwqCy2dW4zNVJAbClNY6GlOrbihOEKS7heZxbRZHF3dvMVCJcIP50zd5BJRJ7ZjNA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbdRAx1SvPLag8uSM9gs4JMBJNNxbFkwOKFYNxiSot8K/aZ7gs
	oWE5HNT3Mz2DIWIlQIrOjHQgw+hkHZpv8+4JC7s5FFmxSNglcp00ROfVNvl/46rxHi78
X-Gm-Gg: AYBFou3QqRcT5Q4TmdkbaahEovakgL7JFxuhJCuui80Udax1YqAUzIYDlqmYAwac8JV
	ugBZTo/8b5LZujBtXUA2/nFUprpoZqscCW8vjF7o7tDIeI8f6hPtrKFTSbiWNptW5wDOdAkpWLl
	VT3+hqTDTM7shJtEN3YSC8Mi95HXSwF0grbZx/S+nj1vOJzk93U+4XH4fw3XlxRi4UreHXn2Ugz
	pQI/VUaKYnrQW4rD4DmDrj5e3Onoet+knDykCEP6N024WZll2fojd5KQBufYpwgkUwThMxqOYGb
	14akK0gDZqM30Vmsg36WuEHUQo/EJNTZxSC93+VAvGiVhykLg3ouFnxFkcfGmexJk3mRTRnErMx
	M7jo8PGAG0JtShHF9wQ0Mm0VTOoMc2uLCT+ys05DLh55V2exGwUI9MhpP/8Y+T8JTkDQkIGUuMg
	rJ5i6dQtJh0M8BH439rztI3cBgIcXzofRpKl3XQJ+HDm2lWfhDYkNuASEaDzp09BBRnqka8EGyP
	XR8wLnOG5T/q6ENR93HCSnfx9nuG120z1lvro4V185cuY/xLI/vZ9UXDlQiRZyywpsu9DyQbGj+
	RqYBMtBvGqnUrww4u4T0jGvj
X-Received: by 2002:a05:6820:240b:b0:6dd:25a3:94dd with SMTP id 006d021491bc7-714f29beb56mr224819eaf.41.1793306008134;
        Thu, 29 Oct 2026 13:33:28 -0700 (PDT)
Received: from toolbx ([2600:6c8e:af00:4c:73ea:df46:8ccd:ac9f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2ce7c9csm260964eaf.5.2026.10.29.13.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 13:33:27 -0700 (PDT)
Date: Thu, 29 Oct 2026 15:33:25 -0500
From: Andrew Halaney <andrew@amutable.com>
To: manuelh@nvidia.com
Cc: Fan Wu <wufan@kernel.org>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Luca Boccassi <luca.boccassi@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v2 1/3] ipe: add the .ipe policy keyring
Message-ID: <auOn9CzT_gku-5cH@toolbx>
References: <20261029-b4-ipe-keyring-rfc-v2-0-77727b205844@nvidia.com>
 <20261029-b4-ipe-keyring-rfc-v2-1-77727b205844@nvidia.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-b4-ipe-keyring-rfc-v2-1-77727b205844@nvidia.com>

On Thu, Oct 29, 2026 at 12:30:38AM +0000, Manuel Huber via B4 Relay wrote:
> From: Manuel Huber <manuelh@nvidia.com>
> 
> Add a dedicated .ipe keyring for IPE policy signature verification.
> With this, userspace can provision its own keys into the keyring,
> then restrict it and activate it for IPE policy signature verification.
> 
> Gate creation of the keyring behind a new by-default disabled
> CONFIG_SECURITY_IPE_KEYRING Kconfig option. When created, the keyring
> is empty and writable. The keyring is used as a fallback after the
> existing policy trust sources only when it is created, non-empty, and
> restricted with restrict_link_reject.
> 
> This enables scenarios in which a trusted userspace component generates
> an IPE policy, and creates an ephemeral policy-signing key pair,
> provisions its public certificate, and restricts the IPE keyring during
> the early lifetime of a system. The trusted component can then sign the
> IPE policy, destroy the private key, and load and activate the policy.
> During that phase, the system is considered in a trusted state whereas
> the system transitions into a possibly untrusted state afterwards,
> running arbitrary user-provided applications. In such a scenario, the
> trusted userspace component could reside on a dm-verity protected
> rootfs disk, and applications would reside on additional dm-verity
> protected disks. The latter disks would be dynamically attached and
> their dm-verity root hashes and/or signatures not known a priori to
> launching the system.

Not trying to muddy the water here, but I stared / thought about this
a while and wonder if I'm missing something below...

With this Kconfig approach, aren't we now saying "if you want to use IPE,
and you want to ever use this feature, you need to make sure you seal that
keyring or else someone can replace the IPE policy!"? That seems rather
easy to foobar, and means to me at most kernels (i.e. distros) won't have
this enabled which limits how easy this is to use. I know Fan wanted this
behind some Kconfig to make it controlled by build time, but does it make
sense to keep the command line option as well to really make this opt-in
for users who have it enabled at build time? Otherwise you really are gonna
have to craft a special kernel in my mind.

Likewise, but more nitpicky, I'm not sure the restrict_link_reject
requirement buys much over the chain restriction. restrict_link_reject
stops new keys being added, but pkcs7_validate_trust() walks certs
embedded in the signature, so whoever holds the private key of any cert
in .ipe can sign a new leaf, embed it, and have a policy accepted anyway
I believe. Under both restrictions that basically means "holders of an
enrolled private key and whoever they delegate to". If the concern is a
restriction like key_or_keyring:<id> pointing at a writable keyring,
that seems like a provisioner bug rather than a reason to rule out the
chain restriction. Am I missing another reason for the stricter check?
I do realize this is rather pedantic in argument and doesn't have a place
in the use case described, but I'm wondering if a future use case will
want such a thing.

Thanks,
Andrew

