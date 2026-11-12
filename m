Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.166.143.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794525917;
	b=m8OjzOV3dDptM51Qh1+Cg1CWdN52iU3Cavze/Vgw1GSmzTzpHMER1CD5heCKgaiH6N6N
	 J6JQ8IWiMNSg6rz1jKM0mqtIo3K8W2++XGPoCNhnq16R53lEnMEVn1M6/8QVnXw4dtUqi
	 JrFswcSEUXOi9DaNWe9kq4dZvgoxYBZvyvAQyNIyDiLNhg52xZjGqkyh61jbMlDr/2RH2
	 1u5CfX36lZ002OPYcmTD/QFjOqJUVsTB7POflillmcXR+uuMC+/EMDEoGlXMeyPbTDfwX
	 rp5s1P1A4wT9lrEnxywgffZV09MC0zQBrQ7JboXYFOH5VztGVL+IqhJUKpI+WeccPJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794525917;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Infomaniak-Routing;
	bh=flRGmW4d8UtNlDD87yf7rhJ0aJW0FN8fSmJOwF+K9Ro=;
	b=upb3W7pbJXn83yzrI9Twi7gzaJfR2oge6TO/uJ9UK8NFNKQbKCPJoQFMmazkFuzObtdo
	 RgdsSZWGByxplBFBQ1ZahzyJ7v3VfuSa8vnLJz/+SfkzlNCkuXCiU7jC+i8iDTvGevg6M
	 QgplRfFkd0PhBOJjeMErRDdVbwVSJum2Tp8ravTARtpgsM/WuKpMDdw5BgME2htabmkSb
	 panbcz+cuwtqDWHTJGix8yiW4ospoxK4MtPCaI17ifd4/WEMP+RS/83MQ2DlwTbk0mALY
	 w6Qsw1coHKqrmakYjw/Ziq+JokdABJ0S7gryiOiBHyM2JsRYbr4ni4Y9ceKR5nPNL9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=ZttEeMjp;
	arc=none smtp.remote-ip=83.166.143.175
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C0F606A321
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 23:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23C0F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=ZttEeMjp
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jQc1d4Kyyz12nk;
	Fri, 13 Nov 2026 00:25:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794525909;
	bh=flRGmW4d8UtNlDD87yf7rhJ0aJW0FN8fSmJOwF+K9Ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZttEeMjpoAZBEhWdJYwvM3Y/+MmD+wmyDPpWwtWKoGceHTobl4Dmvz9JywLGNJl/5
	 b380W89bLmw+MdwGGkdgQ2gYUGH9tqDfy8GoSeIm+Mm1N650OIi2I4VgBB1rU5BZB0
	 YURyErSosF6VWKlEKujdUuDaxTBZvseEpI6AXiQY=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jQc1b4mZ9zZvv;
	Fri, 13 Nov 2026 00:25:07 +0100 (CET)
Date: Fri, 13 Nov 2026 00:25:07 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Shuah Khan <shuah@kernel.org>, Dwi Siswanto <me@dw1.io>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] landlock: Fix layer composition of
 LANDLOCK_ACCESS_FS_REFER
Message-ID: <20261113.hij1gi7Ees1A@digikod.net>
References: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
 <20261108-b4-landlock-refer-nonfs-layer-v2-1-2b405fc1b3aa@gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261108-b4-landlock-refer-nonfs-layer-v2-1-2b405fc1b3aa@gmail.com>
X-Infomaniak-Routing: alpha

Good. Please add erratum 5 in this patch with abi-4.h .

On Sun, Nov 08, 2026 at 09:23:48PM +0100, Günther Noack wrote:
> In landlock_get_fs_access_mask(), only add the
> LANDLOCK_ACCESS_FS_REFER right if any filesystem access rights are
> handled at all.  This prevents us from accidentally treating
> non-filesystem layers as if they handled LANDLOCK_ACCESS_FS_REFER.
> 
> landlock_get_fs_access_mask() is used when initializing the layer
> masks for doing access right checks, so this bug meant that we
> unintentionally denied "refer" (e.g., link, rename) operations in
> layered cases, where the same operation would have been accepted if
> only either one of the two layers had been enforced.  If the rulesets
> individually allow an operation, the composition of these rulesets
> should also allow it.
> 
> The bug only manifests as soon as one other layer handles filesystem
> access rights.  Otherwise, Landlock filesystem path walk is guarded by
> an early exit for the case that no filesystem-enforcing layer exists.
> 
> Reported-by: Dwi Siswanto <me@dw1.io>
> Link: https://github.com/landlock-lsm/linux/issues/67
> Link: https://github.com/landlock-lsm/go-landlock/issues/66
> Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
> Cc: stable@vger.kernel.org
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  security/landlock/domain.h | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/security/landlock/domain.h b/security/landlock/domain.h
> index 935e18b12b3c..d9ebf4857fce 100644
> --- a/security/landlock/domain.h
> +++ b/security/landlock/domain.h
> @@ -262,9 +262,16 @@ static inline access_mask_t
>  landlock_get_fs_access_mask(const struct landlock_domain *const domain,
>  			    const u16 layer_level)
>  {
> -	/* Handles all initially denied by default access rights. */
> -	return domain->layers[layer_level].handled.fs |
> -	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
> +	access_mask_t handled = domain->layers[layer_level].handled.fs;
> +
> +	/*
> +	 * Handles all initially denied by default access rights, but only for
> +	 * layers handling filesystem accesses.
> +	 */
> +	if (handled)
> +		handled |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
> +
> +	return handled;
>  }
>  
>  static inline access_mask_t
> 
> -- 
> 2.56.0
> 
> 
