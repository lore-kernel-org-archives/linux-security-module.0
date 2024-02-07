Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5477C6EF
	for <linux-security-module@vger.kernel.org>; Wed,  7 Feb 2024 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315936; cv=none; b=qi454Mg8I1RvsA/JEixMKTgCz42gWC09PksgUM7cqj3Tzsr1TPhbIT2+NjzE/cT7FgbvNkruciVr3CbzOS3SUyiJv1SdSRSKEaMmXxIhFLAGiyV04sw0WtZ5pzKFQj+/lMP/pdJE1f4pd+/H4R8Itb8AOen+VL8gJHEgnt9gHzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315936; c=relaxed/simple;
	bh=YOOfDCDKRyHiEDZVQRysOqlslMv9uBFs7/uEKQIlLR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZXVV0eIshDmGzfhUp7jws6sZdy9WtcyVeSqspG1j4CPsjIZ/S+RuPa23EzdaIWdFlnSUdpyYIaN+QXK6rXGS9muP/Qj5os960KNmQ7RTo73jgtLssZGbYi9Zebr5dsCGl1sqf4aXnNGvqxxb+VtiwP/zVQEIDG+XgMWsP2vDS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V1u3i4D4; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V1u3i4D4"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d95d67ff45so5652135ad.2
        for <linux-security-module@vger.kernel.org>; Wed, 07 Feb 2024 06:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707315935; x=1707920735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OYwgf7EQVS6kgUofsqdrhhqlkfda6mSImwNoXN3rr6o=;
        b=V1u3i4D4OEzTYXD0UQjP99wxwtkfzUyHvVVVWVoMntteoPlGQOUfq6DOgT8zx9P0yQ
         7VH2Zp3DAeeqeb18kGs1PlgfQ7JXOpIMo77dF0FAvnp8jFeaS58+hLWpNu7YA6tMjxi+
         4Bt6BefQpO5hA5cTJ9PCsfLViEGF/rIAP0XyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707315935; x=1707920735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYwgf7EQVS6kgUofsqdrhhqlkfda6mSImwNoXN3rr6o=;
        b=BwJ1z5DytwRun/m5jC4KX0vdrkl+CCT/8j1GwWr2lgnpuQZNF0GRVLpwxy5aLAn1a+
         xAF+zMEyXu0N9udqW1CnP8zl0XVX+rF8gh3HWAFt7dtX3lqLA4L5RemO9VwqKkYo/J6Y
         jatP5APE/QkwgRiNFTftGRHvh1QD7YLe7rtIgzq+00epDENAUoibKjVCLDDEXKr7GOvl
         hYXetcaqeG1SRUUALGOGdqiO/CronwiCt22F6jX92jnFV87+SySrpUgrVLwOthuxek+g
         zMqfacmS7U7YqKzlcMx/YEDJVdYkBvrsxQG09x/PVT1lbWxeFaabRLuVT01f1Abm0Slq
         HT4Q==
X-Gm-Message-State: AOJu0YxaR7ud1OL/KW84v4LGFXgPL/JGKYyprckVqA0RFCzGXaTPJF8d
	7GXWYgwwSIM4TdxTMvGtzFLSQ+kMSR1oOD3HoH/lUN/RU1ZD+NNLq26o2Sb9yg==
X-Google-Smtp-Source: AGHT+IHtarD8VIYNcqSebLjYXxu0VCGT1d/rJ3q8SLpLEvP4B5mIheZlHlscxHKlyoy1Vubw/2cnDA==
X-Received: by 2002:a17:903:2c9:b0:1d4:4df7:22ab with SMTP id s9-20020a17090302c900b001d44df722abmr5903706plk.55.1707315934840;
        Wed, 07 Feb 2024 06:25:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW/ODWqYd00OkA7mJwb1/z7CtnnyIbVHYpzeZA9GZfzzER+2IAvqyAyAHn48eLuwcYPv7EvsrVq/SJnPAApUIAj/EBfI1tcqbAXRjWumX3t2FxzCUTkPNf954DGqlvHYNgBwmI43Jd8eGHPZ4Q5chSXv3p9PiznWPMITF8/UE1S7jSstARn1ciWcxPOdMdAEFnUxbJuM4k82yr6lb5gGMmwExTVDDbjSdSr1pi1fNQFrHKyUh3ErjIKzdJxLbrw6h5kL1kHsq+zPHFNITfe3AHM0VFJ55lQC+YWQcfKiNY2uOBSlWshVJvyAuOWECfbxYcLC1eK1mcGPizBRTtgO3lSKTmQ7Tg9Qu7otMjb6LgnJ8ZKen59kc+gcyjUPH8Q
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b001d9aa663282sm1470017plg.266.2024.02.07.06.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:25:34 -0800 (PST)
Date: Wed, 7 Feb 2024 06:25:33 -0800
From: Kees Cook <keescook@chromium.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] tomoyo: replace current->in_execve flag with
 security_execve_abort() hook
Message-ID: <202402070625.57945D6995@keescook>
References: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
 <2a901d27-dba5-4ff4-9e47-373c54965253@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a901d27-dba5-4ff4-9e47-373c54965253@I-love.SAKURA.ne.jp>

On Sat, Feb 03, 2024 at 07:53:17PM +0900, Tetsuo Handa wrote:
> TOMOYO was using current->in_execve flag in order to restore previous state
> when previous execve() request failed. Since security_execve_abort() hook
> was added, switch to use it.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

With the kern-doc fixed, this looks good. (I can fix up the kern-doc if
this goes via my tree.)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
