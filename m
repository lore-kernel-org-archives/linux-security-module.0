Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D49450297
	for <linux-security-module@vger.kernel.org>; Sat, 18 May 2024 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716065238; cv=none; b=W3W8OfTvZy7PkLBou/86xMc5pKeGtM4ul/Tgn72zbslwwbQclaCtaehB4momiioEQZxgsSAsKUevyTgLMb2cxr3bEV/meYZT8BHURhv3NVcfVb/TMWvRhJ2Dvo/QIj9bdf9MEikomhurzp1Wi6cAS0ppETdPJ4bwIyvbjWxAj7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716065238; c=relaxed/simple;
	bh=rznDBSToB52+bJsEeKmwW3jC08WdGdMMMEqdHJrwhgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jxi5TkKcdwJELJzLqI2GdcyNVHBBmFFb7HKgbwEkuR+XtNgBS42oK9UibUHv1HjIpMtRJhpR+l2hzj2gsneP1CU/xFqRkj72OQC7BV7K9kvP+lm33v1wYKfHTbX3ITDgQJEazW0LBx/y2lGM2WNmZv4Axwtug1ZkUyn/iH4a5Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=STTZJUTP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="STTZJUTP"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ed96772f92so40863625ad.0
        for <linux-security-module@vger.kernel.org>; Sat, 18 May 2024 13:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716065237; x=1716670037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dovlYWU9/q7musU7eTyJn+RHgfUBDCCZTTuGpTV+/mk=;
        b=STTZJUTP6PCP7mAIICbVQXC303mAScYr8CA3W3+hlDviHwwlNZwB2m2GfVMb7pAC6Z
         trcNs6/KJsZNmDWGeKj0N23u+pXu98EXmJ8zEjBltLhRfh/2Jg6mksZGE29K1ckVTk04
         mdhHaSynW7bb37VzDegtGBsP1fcQHlMbOeqLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716065237; x=1716670037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dovlYWU9/q7musU7eTyJn+RHgfUBDCCZTTuGpTV+/mk=;
        b=PphekVB4+cSlQOZY3j6WfQzEWSQ0ch7YEByhO1sujF0H8GmAY/O+s7bcqEPVzeZVe6
         ciLdnPEW7dH/Ew6m3jQqSCBAHm0mIeMXLfPhK0MQhfqeC9y2c7dt0Nmps0IQzdlpgrl7
         bgVfhxjDGwkdppD5uPO5DcECxSlWWk23gFfi+82AUMZebtX1W3PuV+x8fZ+8IRp4dVB1
         XosCslo9AyETylt2ONI0wZB0ZCnCh6W4OnTCa3EJ2hUrdf5I4k8hupwCiN/sosrQeLxz
         nU8SSsbj54wqFICPIYo1FyShLTo2WABDWK5oSMQwFh9bZ0ceH035YihY+eU6GUMlx1gm
         IC0A==
X-Forwarded-Encrypted: i=1; AJvYcCXf85U3JpJG6pUkiwTaRQ/n723sN90ktzgRPPz1Z99tyPpOSwOZxN+jCLOLZkdR4GMID8394F1K6z9AYtbd8xap5P2yCa2ye7QAxf2UIW6Q5OiHcNWp
X-Gm-Message-State: AOJu0YzutyQ8XwfToCiUvkEDhDrIK4pD9HxORI4vEP2YzLZFHNVtXB6G
	WHI6jVtTcuCROC7ZmGE9dxXfK6OOdEvddGawA8cFXNoUUGYv9ov8qb0MDeqF6A==
X-Google-Smtp-Source: AGHT+IErrX7eTGQo+WffbLOh7zp6AXgmIidyVMZyBccWvtdbFOD4aNfW4ejCnUVAVRtcGXuXKO/5ng==
X-Received: by 2002:a05:6a00:1a8f:b0:6ed:caf6:6e4b with SMTP id d2e1a72fcca58-6f4e02d3473mr27469433b3a.18.1716065236358;
        Sat, 18 May 2024 13:47:16 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f6704888c1sm7725286b3a.157.2024.05.18.13.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 13:47:15 -0700 (PDT)
Date: Sat, 18 May 2024 13:47:14 -0700
From: Kees Cook <keescook@chromium.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, linux-security-module@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] loadpin: Prevent SECURITY_LOADPIN_ENFORCE=y without
 module decompression
Message-ID: <202405181346.901048F98@keescook>
References: <20240514224839.2526112-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514224839.2526112-1-swboyd@chromium.org>

On Tue, May 14, 2024 at 03:48:38PM -0700, Stephen Boyd wrote:
> If modules are built compressed, and LoadPin is enforcing by default, we
> must have in-kernel module decompression enabled (MODULE_DECOMPRESS).
> Modules will fail to load without decompression built into the kernel
> because they'll be blocked by LoadPin. Add a depends on clause to
> prevent this combination.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  security/loadpin/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
> index 6724eaba3d36..8c22171088a7 100644
> --- a/security/loadpin/Kconfig
> +++ b/security/loadpin/Kconfig
> @@ -14,6 +14,9 @@ config SECURITY_LOADPIN
>  config SECURITY_LOADPIN_ENFORCE
>  	bool "Enforce LoadPin at boot"
>  	depends on SECURITY_LOADPIN
> +	# Module compression breaks LoadPin unless modules are decompressed in
> +	# the kernel.
> +	depends on MODULE_COMPRESS_NONE || MODULE_DECOMPRESS
>  	help
>  	  If selected, LoadPin will enforce pinning at boot. If not
>  	  selected, it can be enabled at boot with the kernel parameter
> 

I've folded this change in, since loadpin also works in non-module
situations:

diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
index 8c22171088a7..848f8b4a6019 100644
--- a/security/loadpin/Kconfig
+++ b/security/loadpin/Kconfig
@@ -16,7 +16,7 @@ config SECURITY_LOADPIN_ENFORCE
 	depends on SECURITY_LOADPIN
 	# Module compression breaks LoadPin unless modules are decompressed in
 	# the kernel.
-	depends on MODULE_COMPRESS_NONE || MODULE_DECOMPRESS
+	depends on !MODULES || (MODULE_COMPRESS_NONE || MODULE_DECOMPRESS)
 	help
 	  If selected, LoadPin will enforce pinning at boot. If not
 	  selected, it can be enabled at boot with the kernel parameter

-- 
Kees Cook
