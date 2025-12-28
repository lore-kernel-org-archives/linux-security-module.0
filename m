Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C4224B28
	for <linux-security-module@vger.kernel.org>; Sun, 28 Dec 2025 03:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766891810; cv=none; b=RhCmySNLpnngpRTfgIesXMETki9HioQhI8g6hcypc+r8Q8XKsLJA27VP0XiVy7M6TUwcmAO31f4MHUcCm9BcBqdHxpFVceriicEEsbVx5nH3Vv6qTge+0Y/+qfFvgVvZ2MoALDh5YuV7wj83hyeNXsNSj5msLpoZMRA4EKz9vDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766891810; c=relaxed/simple;
	bh=D1B/8qGaIULiyrWZIU7ksue6i2ruRWEPGXnLBNYaHYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pe9NuN5j/qdSS8nr2AxwyvPzZUubgUlymbWnr38Ay/D2uFD8w4DPK0jksOzAzW8OnLWqs0ukIcVbs2pZ6UjA2q/BZWMpt2jFHxVuqm4NvfP4GWz9zJpd8uD8rCB1vwHJKVfoo+glQ+6UTGbWUkPgMIfVTaV/pdcmHyrNn/3WCxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=csensrfK; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="csensrfK"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78ab039ddb4so77710937b3.3
        for <linux-security-module@vger.kernel.org>; Sat, 27 Dec 2025 19:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1766891808; x=1767496608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dcfnVkad9dNalZK5dHkAImODCCJ6qAXWtwQcj5QBYRw=;
        b=csensrfKIjE+PjRi4xUdwBQsVW32ewX8MGM3S2PyiaKc/li8w5/QEvXP8mcLJGcm5Q
         kmJoe3glggjFQbFE57oRyArHuSsp3u9MEIuYBLJefVGfmoWfkhlC76/a8JY3YGYTam17
         2akpp8b1l6smLC8n3LrtMrH7ssPatv4wAn4ccJ33oagPAIMj38O7Z6d3kmv0WnBAhNGn
         hOB1i4NQsUftPdBICWTntAe6J4AKUqRMtjUoXy2WE0U8OLKH2t+8Hgh743vUNeSYnBar
         KlVZTiysmVvD5K2I6Xrbyicl5ehp5L8k+1E3B07i5hLKxlZg9Ze8yRuZVz9c8yEgRi05
         ZUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766891808; x=1767496608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcfnVkad9dNalZK5dHkAImODCCJ6qAXWtwQcj5QBYRw=;
        b=b3+8izVu8GYSfRkonnwVtCOwwv9toLlv+/RBM0fqpWDOgAtOCMXANoPiHDBy6uowSn
         NRlREZlvselAYMm8ARnCZJwy9w/Qzo5XS8TFjxoLy32etL6a+kc5WyCFyFx9AVP1WUM1
         Wmw6Z2NX6pb6mMvTmCjucYzfdsMJaqGhEc92WVrbM2Vnp4aoN5OOsgnYQQhR/poQN1GU
         EoimSq2AoK7OutF+hvRXX6bEwonHG1Z/C5L6SvykFlNrsUTLIneDn3ereApMyc6cm0Hq
         uNiIzPV00hiCx5h/KeHdHlU2XSEKDYoypIUcqzDvMFKkjYV1vTeNWPRJaGsfOXJHEB3Q
         ppDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjmFH14Hl5cVANRgmiRR+QhfjCrBkDKWHnDqaEQMI303nrhd5DeS3RxUe4zfdttdFdVzWbN4dCm15OE0y1nVpn/nIulhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJP0USU054FEcK/W223KJexV9RunDmArFK1UQo2Gs5b0GQ0407
	J8/S4wTtW6SayC4Bsx+tHHowI9F3bJrBCswJaiWU5BZAk2hWnEkQ5ujL/XyQpv6ISXY=
X-Gm-Gg: AY/fxX71PLJytLlmmQZy20fPHO+/eHVjI5Gm0ibXVfAgA9SzBvVS3X+MMwVifmAwwx3
	nNt7LLPZqac/Ti1hIPToKYGrDNqNcGv37fPdpAjjIzw+Hf8yDIyR/W3AnHSZkiMz1ML60FpGg8y
	TfTv9Ee49RvxFkH0A4pNip1vqCO9o0VxkYqD4KKZVHmxHI/yCmgOYjTtc8/KtVnFKZ7abTDGhr2
	R3+oqhQjnbHXa4C/1rJ+GT8VnlEU8lb8zXdSou1hHUJ/qVO6++fmNkA6MwbmD2sVAxoSYHPgon1
	o0HGxhOMfRz0i0BK0+DNZgPAU166jiBUvu0Xg26n3D5t6dJi/upwS7uqDGtSsPu/LppJHHanJOT
	gWyNEmSCOnC6toxju2X/teJwmAHoYOzcTC1dSniVSdpbaig20Sh7+gHMlz2xlvFrij1wB
X-Google-Smtp-Source: AGHT+IH69knnQP2R2Roi5tRt4UtkALVf5KehNg9TwvQPoK1c5m2Uq1ktnZ6i74jJJapPSNUswT/RaA==
X-Received: by 2002:a05:690c:48c8:b0:788:20ec:aeda with SMTP id 00721157ae682-78fb40b0a83mr229397877b3.68.1766891807785;
        Sat, 27 Dec 2025 19:16:47 -0800 (PST)
Received: from 861G6M3 ([2a09:bac1:76a0:780::5e:1f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb416b32csm102409507b3.0.2025.12.27.19.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 19:16:46 -0800 (PST)
Date: Sat, 27 Dec 2025 21:16:43 -0600
From: Chris Arges <carges@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: roberto.sassu@huawei.com, kernel-team@cloudflare.com,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Kees Cook <kees@kernel.org>, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ima: Fix stack-out-of-bounds in
 is_bprm_creds_for_exec()
Message-ID: <aVChG8bjcAqOBEJi@861G6M3>
References: <20251219195456.912190-1-carges@cloudflare.com>
 <20251221180128.1026760-1-carges@cloudflare.com>
 <3aeed1ff9388f09555bf5c6ade03cbe9ce93ff14.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aeed1ff9388f09555bf5c6ade03cbe9ce93ff14.camel@linux.ibm.com>

On 2025-12-23 16:58:26, Mimi Zohar wrote:
> Hi Chris,
> 
> On Sun, 2025-12-21 at 12:01 -0600, Chris J Arges wrote:
> > KASAN reported a stack-out-of-bounds access in ima_appraise_measurement
> > from is_bprm_creds_for_exec:
> > 
> > BUG: KASAN: stack-out-of-bounds in ima_appraise_measurement+0x12dc/0x16a0
> >  Read of size 1 at addr ffffc9000160f940 by task sudo/550
> > The buggy address belongs to stack of task sudo/550
> > and is located at offset 24 in frame:
> >   ima_appraise_measurement+0x0/0x16a0
> > This frame has 2 objects:
> >   [48, 56) 'file'
> >   [80, 148) 'hash'
> > 
> > This is caused by using container_of on the *file pointer. This offset
> > calculation is what triggers the stack-out-of-bounds error.
> > 
> > In order to fix this, pass in a bprm_is_check boolean which can be set
> > depending on how process_measurement is called. If the caller has a
> > linux_binprm pointer and the function is BPRM_CHECK we can determine
> > is_check and set it then. Otherwise set it to false.
> > 
> > Fixes: 95b3cdafd7cb7 ("ima: instantiate the bprm_creds_for_exec() hook")
> > 
> > Signed-off-by: Chris J Arges <carges@cloudflare.com>
> 
> Thank you!  I'd appreciate your limiting the line lengths to 80 chars (e.g.
> scripts/checkpatch.pl --max-line-length=80).
> 
> -- 
> thanks,
> 
> Mimi

Sure thing, I'll make that adjustment and send v3.
--chris
