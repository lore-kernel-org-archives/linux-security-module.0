Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAB83DE420
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jun 2026 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782390572; cv=none; b=onKNUZk4aqOjNDoZBZytQT6GKFCWljyr58BYCw6SnfHgtjF3WrQ512Yrfh+L4R16ibzSO2oxYNHN7wuhV11S1DzWyMFeTzGB3sbd+Q2PKIM0soScft9De6UsaumzqJMUK/fBXbxXsPcSI1K8B016KgeaxgIZ3+GKoPPar2N07Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782390572; c=relaxed/simple;
	bh=3qWGQWCmb1NDpRT10cYiXu/2QBAKtTDY15am2sDbjvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIC726EYDJNBXup56UQBr8x+N/SBk1zdLpU0Yn1VxyGQAZH67oirbl/yRHcndIJ7CsZoxdRlfWYtsATwlHtrGV62CoMGYEI3mpAK4gpnVW+tdCkbMj7vcG2TFMnkMxhRucM8Z4W4s5NJWvIbdLYBXU8/cOZXSDEnDHDT9i8LQ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F4TlnSoE; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F4TlnSoE"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4626fdc829aso1734949f8f.3
        for <linux-security-module@vger.kernel.org>; Thu, 25 Jun 2026 05:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782390568; x=1782995368; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g2ppjyVbJYZltIdw6y8sH5RPhtFeQnjhQZPkfszvAoQ=;
        b=F4TlnSoEHiELmW4SFZQSUeQUmBjWOkPr1E3vMeeRTWSoBojq1cHUdWONJLNkV40hMe
         X7Zuc9taUrYvFEcSzePKYS6GyvZMPdlbYm5srrE5V3BqWO+WwPqlqc8ydo/YIHHFJwNU
         Ku1mBv8xEHsHlQo31bL37ekWRW3Rmi+vHcgKJIHO1YxeDzTGDD9N58eEKZ2fJpq2on6S
         OipI4xMXQiZ+dMKoK1l3F4HVeyDnPVEcgiudAz/LiECAe416i/PFjLtiYlgcD9+EMYni
         9M8oLeqT2ZcK6ngQ2Mk2CtWJ/X/p6VIsCgeLn0EGYZqWoWmhr1NtQX1TOp7loB2qKkLK
         YFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782390568; x=1782995368;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2ppjyVbJYZltIdw6y8sH5RPhtFeQnjhQZPkfszvAoQ=;
        b=d8SSGEvC8cYUs5LPckmQcJ20wB3bwBQX1SyEgKKaczbHtmFwW1chPR+bcxqcWp7qGW
         zjGcdnxr7vwDPxOZgEFSsmwwT8NoWONA9RN5S/lb+ta4czPeANwm3Rir0C17TeT+eHnr
         Cn+ik8m5svyMtvNiCX2yd1zyO/M2647A++EeGXVHj1CZ2DYveB4YyZsf2SYuYlhzdrK9
         6CxBRt/B2Zq9MSTW3BH0zvHG/eTercLJvdCWPA2TuJj8SEfW6s543sY26ECKc0T0if+X
         3of/UjgZK7/Q1VeKajpB3gOjqqb9vwbn3zEMvww7JXlD4KahuXWOq0Ermpokq0w3smgJ
         HMSw==
X-Forwarded-Encrypted: i=1; AHgh+RqywFjA1icQZDPNPVkgZM6NTqr2xnKVdcv8JkUFOu48WOUpcxObniY8iTQcmGlETWKqdNI2PO1/DlIg0g3cy8rgIapiTt4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9RQBGAHgXlqCVxY8S+ZCeIsUlG7Qo6sR+uHzGPwx60Cy6OE4m
	ooZb69QK4QoK71D5WkcPwb293kGT7yQJso8qxr8HE7I5CJ9GAG61Ba5qbKlNXI0GLA==
X-Gm-Gg: AfdE7cmGABVVw8DCvvyx41a2xGKAqIzsqgEgJNpk+73opi1TbAdP8TECdhHpkSA6Zz8
	UiTYhszr+EoW6hbCM+6DEqw5btri+WLIBxCv3cfc7cp16EWcZVU3iHekLwMAfbAp1C8Or0zhxcH
	HggZzeA/y4ilYgP67foNCj+xrHObeG++M67dZvlx6l+0oYhs3zGV4B3dSC4pMP4aTJEif3Pre0d
	k/7i68eEufqgcaW4OCCaLXiQyjXl3H64Qrn2pZfb2X0K6XvN39u7XfOdfwZGB8P/uxitU2Uw/vQ
	onIuEJSVPLJm1V0k+lgArAxfhZuOocB5IziwmwnnIiZ2r8ZSFDhE7RZL2BYA+nCLP5qUNlPFbbC
	VYhyi3nmCBQ0pLNvuV5Tl4yuHeeOuHq56dS6hUKrLQr/P58BYgA+1bp3laLOVQFPP9yo2o970ot
	haHB76eGbb46Uc023TgiZdhlfpaAzEEa56DcnA19vZ63Y=
X-Received: by 2002:a5d:5f88:0:b0:463:a7e3:9f71 with SMTP id ffacd0b85a97d-46dc0839c94mr3549517f8f.15.1782390567662;
        Thu, 25 Jun 2026 05:29:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:7a30:b9c4:b9c7:bc90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c2279b734sm15607575f8f.30.2026.06.25.05.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 05:29:27 -0700 (PDT)
Date: Thu, 25 Jun 2026 14:29:21 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
	Alejandro Colomar <alx.manpages@gmail.com>,
	Alejandro Colomar <alx@kernel.org>
Subject: Re: [PATCH] landlock: Documentation wording cleanups
Message-ID: <aj0fIbva9iaTX_Yb@google.com>
References: <20260516190112.4924-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260516190112.4924-1-gnoack3000@gmail.com>

On Sat, May 16, 2026 at 09:01:12PM +0200, Günther Noack wrote:
> Documentation cleanups suggested by Alejandro Colomar,
> which we have also applied in the man pages.
> 
> Link: https://lore.kernel.org/all/agW4yMK6CinJGqXt@devuan/
> Suggested-by: Alejandro Colomar <alx@kernel.org>
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  include/uapi/linux/landlock.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 10a346e55e95..48c12ddf1108 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -255,16 +255,16 @@ struct landlock_net_port_attr {
>   *   :manpage:`connect(2)` as well as calls to :manpage:`sendmsg(2)` with an
>   *   explicit recipient address.
>   *
> - *   This access right only applies to connections to UNIX server sockets which
> + *   This access right applies only to connections to UNIX server sockets which
>   *   were created outside of the newly created Landlock domain (e.g. from within
>   *   a parent domain or from an unrestricted process).  Newly created UNIX
>   *   servers within the same Landlock domain continue to be accessible.  In this
>   *   regard, %LANDLOCK_ACCESS_FS_RESOLVE_UNIX has the same semantics as the
>   *   ``LANDLOCK_SCOPE_*`` flags.
>   *
> - *   If a resolve attempt is denied, the operation returns an ``EACCES`` error,
> - *   in line with other filesystem access rights (but different to denials for
> - *   abstract UNIX domain sockets).
> + *   If a resolution attempt is denied, the operation returns an ``EACCES``
> + *   error, in line with other filesystem access rights (but different to
> + *   denials for abstract UNIX domain sockets).
>   *
>   *   This access right is available since the ninth version of the Landlock ABI.
>   *
> -- 
> 2.54.0
> 

Friendly ping, Mickaël!

This is only a minor change, but keeps the man pages and kernel docs wording in line.

—Günther
