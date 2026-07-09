Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237233D75BC
	for <linux-security-module@vger.kernel.org>; Thu,  9 Jul 2026 20:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629230; cv=pass; b=iZjoM2IsLuhI39bhbuxvg1xt/ilkbCDlA45n4SVB/LpqZbPF0FXEKaP60xQwkutBrXuXxrkxdKRIHS1Pz2eaiJB30pRVv2WoCHxsN9MTcnXuC0I92e7sB+gN5pGrprca7BacpbRDrZvQL22t7bGBZ0xGlJnBHJk3NSAbXoXMF7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629230; c=relaxed/simple;
	bh=jMtcbdMjpbPZxFzIQEO/tWpTrxEOHPXtdEvc/wBne44=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=epfBrwIoS0zhMZ0lAggTJ2ZDx0uBF+X3hnsWHL10zbG3nSQ2OJ3/a2Yh6PGAIL81hyLN2I09oO+BoXf4Ug0F6mpWgvz3pPm/mRyPa99uKDL0RxyWzuXUGSBZGfWAP7wTyhHzs6WiGowhyPxRp9rFthOls/Zx+63AbEHbDkm4wOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=bLY2Kmvw; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="bLY2Kmvw"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-667a0f55a59so328052d50.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 Jul 2026 13:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783629224; cv=none;
        d=google.com; s=arc-20260327;
        b=fyXkp37tQ0Lg2SG/NtgNYzw3kN0PEHtOiO223tNWAc0LM6Y6S865nw5JeNv3o3ZwcS
         WuaMDneF5I5LYLEBR0tFg6PFpqIL/vEm/7baJSkh3EupzdJ7H26yA7x23kBZQFLb3pQh
         K4K0SsYaNVl94jVUBj8CI0wC+4H3n7qJ3RNUZDtJGJ5dtrZ69Ndepl5bn/ml4i7IedTG
         cF30xAV7034VG11ZEeU87HOrG4j+XnnBToj4FOn1RyAZAxZjBkLWko4FbXL4doLJj1kM
         eTd5gw2wcGqdsaV0+QX1TggWM3ofmoB9gVNHmgzg9SXBT+ohmx+VcA1EfCMvTLANa9Lh
         LsLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=jMtcbdMjpbPZxFzIQEO/tWpTrxEOHPXtdEvc/wBne44=;
        fh=HsCAyaxWwnHJE2Jp1MyP+19oBbwNduD2RLqQ0RblmMM=;
        b=YgsLKtMTPWI8sITUwjMBjKFd+BI+JQl7qercEvEYFusU+sAKsmxb9yOE+/rQ5oq5ZV
         q2in/jGcE9lM5tISZ5CAZdJANZJ9zmHUz5+E7qsyjzbzThwyfLyvo4HltBYDRGbvn6yv
         aWm2RicfyWjahDEp7xy8pPAYyQlI+sK1Notko2ZJ8zO5XJfqlSfrctKe9VmAnmHMibWt
         Fuq+L3QXmw/on4XQ2qszt2PEYe1jHckSv+DqwAcNyMJAO/9Sf0ywwOE0HWCAsY4FL10i
         qaVLZKPltU8fZgTH31CMQDCMgR4gRe+h9SoMBusAXxT3Tqu37MsphMRU6o+SU8EP3KZQ
         mavw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1783629224; x=1784234024; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jMtcbdMjpbPZxFzIQEO/tWpTrxEOHPXtdEvc/wBne44=;
        b=bLY2Kmvw4ctkM0rU8W2rvdL2jujHbmqnZQ1rvtn4RSsR9i02XV+Tzvoon0xxS4ewRI
         j2nB1jkcEYhYT+T+Ghs4AsXLbrLVydEQyokZWsN+LrBDv31q1tmYu9PJ4OKdYBIsfF5b
         wfxhq0GdvAtlSD+cmhcQPLgGo63mz3847o/wdpoCqOV7rtEs8siecgdOrf4B9dlYh6BR
         lQ+676imjyT1+6qJScW3UKGYnoyOQzi10xrb/3NnBPDNLuU5g/hcjWjITOclyhpnbJaT
         SrGOaYM6W9+HlNmY8Bm7Mqtz5g8l8M3fMD8ufNNH9ni5ZDirp0apHAqkapHbRF5HT8LL
         8bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783629224; x=1784234024;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jMtcbdMjpbPZxFzIQEO/tWpTrxEOHPXtdEvc/wBne44=;
        b=i/eJqMpvDMQp9QzsXnltMcIp4QhDtXMqRBS/rwGgjvuP48HuvtHeoyGwA4HPIIpl2H
         YGv+/1pxUjM3XNZDUbBOoqssgkWpFm17N9P/pe84xZyL/KWcrHd8LKJemVQ/qgEzSouq
         GAssc+zFjGZgf7XU1HAlUsPOoafyyCa8kLMnUVIxc+phZMabyS7/NhgIesWAMYFcHFPu
         Avhy50K3sRbsOIdclnoM7s4pCbhWJ9g5Wz29QXHUY3mkG/hJdlCG0jlNuxc5mgZCuvjS
         mW1D2VLenSNTD5Zi1fQR0JsWrWRe8Y7LWRWV7jesAqRtDwCJfTa/BczDsrvf/us7oJGw
         gyDA==
X-Forwarded-Encrypted: i=1; AHgh+Rp4RdHKxiXzPX2POph/25Y4aYESZTxRvjAkbWTBn6vG/lLPmOMGxBSZScC7XeVVTeBCGwshlysfWwgDIqDhk2OKAduitiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpNWXKJv6JS6QfepVxkqqNYpcSCjtVJBxThSbLV5h2J4NXNuOH
	6TvZsHQQCO7wwD1ekNZSnNmFVRHm7loyWYvXPZCR3L3xQp1Hs5Xpd7p9BHW9n2P9thTjqrH9OaW
	oI3U3o5H3fxULbADa6LG0yUAjnpcZFwtZ42d3JT6/
X-Gm-Gg: AfdE7clrlrJnCxujTYLZLMIqjY+Cu9UM3T3M2LsvbXfmgpqOIqBiVifD+Pc3np40uwy
	d4reDlT2WYdfUZMR//Qn68UpglvsR98NhtBf2+yBeI8PT2edrU1/8MDvqNDjvZO8ajmnACs5H3n
	aTc6HyD2zDwXLRJ2dUyx17B0MSGetQUvViDn+L7+bUqYZKbXpxHR4zygkk4yCVGCFVwHBKl0s1z
	dM7uUPWQL2edEoGsGPZBdZqOmrk91XTfvFFC14mrmO13G0TSZKJUFexj2v9J0+/toH6PhS4WU9v
	pzy3jng8ik8ARuqUTedkVW1twR0=
X-Received: by 2002:a05:690e:150b:b0:664:ae6d:ad28 with SMTP id
 956f58d0204a3-6679f15451cmr5789029d50.66.1783629219309; Thu, 09 Jul 2026
 13:33:39 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 9 Jul 2026 16:33:38 -0400
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 9 Jul 2026 16:33:38 -0400
In-Reply-To: <CABtds-0AUr1jD2Sri6ViiFiqyBbjc3-6xeAOr12YLJA9ux-2BA@mail.gmail.com>
References: <CABtds-0AUr1jD2Sri6ViiFiqyBbjc3-6xeAOr12YLJA9ux-2BA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sean Rhodes <sean@starlabs.systems>
Date: Thu, 9 Jul 2026 16:33:38 -0400
X-Gm-Features: AUfX_myqQ-bWDD15nf3rkjgivCsr_EhsGHyEecNL3wwNc7IvLT4cfvzbzaUymKw
Message-ID: <CABtds-1d8uYi5YbxgbL5MwZOXTUgBmeLQWiggVhBKtqct5VC-g@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Allow hibernation opt-in when locked down
To: rafael@kernel.org
Cc: lenb@kernel.org, pavel@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com, 
	keescook@chromium.org, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Please ignore this patch; the approach was wrong.

I'll follow up with a v2.

On Thu, 9 Jul 2026 12:23:11 -0700, Sean Rhodes <sean@starlabs.systems> wrote:
> Kernel lockdown disables hibernation because the resume image cannot be
> verified before it is restored. On systems where external platform or
> storage policy protects the hibernation image from offline modification,
> users may still need hibernation while lockdown is active.
>
> Add a hibernate=allow_locked_down command line option to make that opt-in
> explicit. This only bypasses the LOCKDOWN_HIBERNATION gate; nohibernate,
> secretmem and CXL memory restrictions still apply.
>
> The kernel does not validate the external policy or authenticate the image
> with this option.
>
> Build-tested with Fedora config:
> make O=../linux-lockdown-hibernate-build kernel/power/hibernate.o
>
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> ---
> Documentation/admin-guide/kernel-parameters.txt | 5 +++++
> kernel/power/hibernate.c | 6 +++++-
> 2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b5493a7f8f22..0d20ad9c7d78 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1967,6 +1967,11 @@ Kernel parameters
> protect_image Turn on image protection during restoration
> (that will set all pages holding image data
> during restoration read-only).
> + allow_locked_down
> + Allow hibernation even when kernel lockdown would
> + otherwise disable it. The kernel does not verify
> + the hibernation image; only use this when external
> + policy protects the image from offline modification.
>
> hibernate.compressor= [HIBERNATION] Compression algorithm to be
> used with hibernation.
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index d2479c69d71a..71232eece9a3 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -41,6 +41,7 @@
> static int nocompress;
> static int noresume;
> static int nohibernate;
> +static bool allow_locked_down_hibernation;
> static int resume_wait;
> static unsigned int resume_delay;
> static char resume_file[256] = CONFIG_PM_STD_PARTITION;
> @@ -109,7 +110,8 @@ bool hibernation_in_progress(void)
> bool hibernation_available(void)
> {
> return nohibernate == 0 &&
> - !security_locked_down(LOCKDOWN_HIBERNATION) &&
> + (allow_locked_down_hibernation ||
> + !security_locked_down(LOCKDOWN_HIBERNATION)) &&
> !secretmem_active() && !cxl_mem_active();
> }
>
> @@ -1433,6 +1435,8 @@ static int __init hibernate_setup(char *str)
> } else if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)
> && !strncmp(str, "protect_image", 13)) {
> enable_restore_image_protection();
> + } else if (!strncmp(str, "allow_locked_down", 17)) {
> + allow_locked_down_hibernation = true;
> }
> return 1;
> }
> --
> 2.53.0
