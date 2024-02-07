Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2838E7E768
	for <linux-security-module@vger.kernel.org>; Wed,  7 Feb 2024 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316498; cv=none; b=mI+yQCGGCs8WrymJqiTE0kpyu8w2wNq1rl6VMJAyPFYvo7R9OldThdtD1mrP86WIqRk30YxbTPh4SYHHSN6r+Qe/rj/qHGPBh3wK9OZmY35Ahh1479v7YVA651UChrCwrKL9722aRpbMBcnmw5Cs28AmXZ5RIcb1cGUF122OjM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316498; c=relaxed/simple;
	bh=tdwh1IwErse1HmUo9Au6zB1zOVIh+JAIkT2kw/cysnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZsMeqhW94BeLKFWu4CYw9W4LJcSMra/SFcp2y/bCLfyNPi4xiGtVamM1pSs1S/nX3U0j/nQLq12CcMfkf+D4Vjk44fBBHtOOEmcwZbxI75wzI/OwChGWwY8kfMBSvBQU/SQOs8th3+lPdKSsHZcC+8X3yJTc3/1CcEsVYmvoQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZAD87+K4; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZAD87+K4"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6da202aa138so473871b3a.2
        for <linux-security-module@vger.kernel.org>; Wed, 07 Feb 2024 06:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707316496; x=1707921296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3R8hD3LqyYlOdsZNUPeAOakP2zt0WKnTjsDWlY67czw=;
        b=ZAD87+K4uFXA+xaSYcGaTnJzmvepfTfA1i6aah1bq44QOJ7IrFwQi5+fbLCa2vNHIK
         0eduOlP4mI3fAnzlEUIWu/cl5lSYkR/XG7ih74B1/wRev6MAAzw2zUgTMxhwnDgbQOTX
         lVHLBmrwCvSkRhYUwT1dYOQHCL0P96aYx6ems=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316496; x=1707921296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3R8hD3LqyYlOdsZNUPeAOakP2zt0WKnTjsDWlY67czw=;
        b=gL36xAFJqO02B+g3yr70DIwkW2P5ijJk/V/HiRXFlWV0uin3FOY450UKtIeieXSiSy
         3NhdDschFcc64JDiiECvsrfkCXiD3NTKqSlpb/R2EyPTjwTJg3AWTbryNEkfdU00r4Zg
         9GeMELFvRUbcKtZS96UNMlnDPh56IQOl8alEJRFM6xTguXrtqc6w3rVF77sHofDkeedT
         X9aaOnvG81ADE3ALv6CTw67lq0iFSlocULm4SPMtF18rCK694tIcWZYBs/m2SwJXSSXN
         5SnB5fVlAlaeOKEyMBIXI+xosV1qkD5umKovp/xZs2uC048uC71rEXLMSGVm6AN+xOYK
         OLVw==
X-Forwarded-Encrypted: i=1; AJvYcCWPdANG2DUkNvALIZIvwS5EWk2HR80eP0yA7pfRxdnbsvvoT8T6J65i8BWlRMugBOJDUpVcQyVCxIj6RGMHDO8u24okAjBaXfCy0Z47LIN/+gymqhb9
X-Gm-Message-State: AOJu0YwD/NvR/funDmYtwk0FpD0jFHBrD8Sdg9HnOWox+44o4d9vE4sU
	Dj5M63cXskoIuEqFjJMX5EbzqeFr54yLFdENUyweXGZUVG4e4xS4wD2wXv14MQ==
X-Google-Smtp-Source: AGHT+IFLN0XTJrm1FUZSe42FPH8mZKyju5Oldd8AwEeWM2Hi2DzwW/SrXJe1h8jh2+iZLp+GVLYz8Q==
X-Received: by 2002:a62:ce44:0:b0:6e0:54bc:3591 with SMTP id y65-20020a62ce44000000b006e054bc3591mr2664142pfg.10.1707316496274;
        Wed, 07 Feb 2024 06:34:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1MSnZssNcOFyWSASvEJmCtF//dSlLKb/4xNtF+kn2PJ7FhkKbjeic0Jg1UAIPkweoy/XZNzKNzPWznQymiFuWJJkJ9A6+aQrm8ueV0Cakc/frHENuPXvmu6psyj6jmFmlnAADEkvYBnX6zQvwCETO1EgW+1ZH3Oe5QoxjheyVhD88ZhDDeXurfq8qZ1iwc60qT8w=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z1-20020aa79901000000b006e063fe6b1dsm1620884pff.100.2024.02.07.06.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:34:55 -0800 (PST)
Date: Wed, 7 Feb 2024 06:34:55 -0800
From: Kees Cook <keescook@chromium.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Paul Moore <paul@paul-moore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] LSM: add security_execve_abort() hook
Message-ID: <202402070631.7B39C4E8@keescook>
References: <894cc57c-d298-4b60-a67d-42c1a92d0b92@I-love.SAKURA.ne.jp>
 <ab82c3ffce9195b4ebc1a2de874fdfc1@paul-moore.com>
 <1138640a-162b-4ba0-ac40-69e039884034@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138640a-162b-4ba0-ac40-69e039884034@I-love.SAKURA.ne.jp>

On Wed, Feb 07, 2024 at 08:10:55PM +0900, Tetsuo Handa wrote:
> On 2024/02/07 9:00, Paul Moore wrote:
> >> @@ -1223,6 +1223,17 @@ void security_bprm_committed_creds(const struct linux_binprm *bprm)
> >>  	call_void_hook(bprm_committed_creds, bprm);
> >>  }
> >>  
> >> +/**
> >> + * security_execve_abort() - Notify that exec() has failed
> >> + *
> >> + * This hook is for undoing changes which cannot be discarded by
> >> + * abort_creds().
> >> + */
> >> +void security_execve_abort(void)
> >> +{
> >> +	call_void_hook(execve_abort);
> >> +}
> > 
> > I don't have a problem with reinstating something like
> > security_bprm_free(), but I don't like the name security_execve_abort(),
> > especially given that it is being called from alloc_bprm() as well as
> > all of the execve code.  At the risk of bikeshedding this, I'd be much
> > happier if this hook were renamed to security_bprm_free() and the
> > hook's description explained that this hook is called when a linux_bprm
> > instance is being destroyed, after the bprm creds have been released,
> > and is intended to cleanup any internal LSM state associated with the
> > linux_bprm instance.
> > 
> > Are you okay with that?
> 
> Hmm, that will bring us back to v1 of this series.
> 
> v3 was based on Eric W. Biederman's suggestion
> 
>   If you aren't going to change your design your new hook should be:
>           security_execve_revert(current);
>   Or maybe:
>           security_execve_abort(current);
> 
>   At least then it is based upon the reality that you plan to revert
>   changes to current->security.  Saying anything about creds or bprm when
>   you don't touch them, makes no sense at all.  Causing people to
>   completely misunderstand what is going on, and making it more likely
>   they will change the code in ways that will break TOMOYO.
> 
> at https://lkml.kernel.org/r/8734ug9fbt.fsf@email.froward.int.ebiederm.org .

Yeah, I'd agree with Eric on this: it's not about bprm freeing, it's
catching the execve failure. I think the name is accurate -- it mirrors
the abort_creds() call.

-Kees

-- 
Kees Cook
