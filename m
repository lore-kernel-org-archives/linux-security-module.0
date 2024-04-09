Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D161157472
	for <linux-security-module@vger.kernel.org>; Tue,  9 Apr 2024 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712700093; cv=none; b=fG5bjZIKFo3h0D8GpwcF2CXd9DbVe//sS5i1ESHGnh45MZyaXF3Vvd7iGI48Q2WoAYiJX90Qk+i1pbSncihu8yGjEOqzRrYF7kBz9t7P6or28n2351w27UnJ2EZILsSyuhsicIY6sMjRDwI2orCQzu8FQJfT3EXKiabFkVm+aZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712700093; c=relaxed/simple;
	bh=/rmPaPci35cfsHpuQECvH6CLlq2vKyAGX6KkP6FcTG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nplaEWYjsNAKP5bj6KUiK2/jPVOTU3+CAcCt4Lv9OZ6SwUZUU6NhNEzKGVTWJmY/ffAk7o9XzGFNsVRehomjQfZ4e4J5FmbxjUnpMGwUo8bqOakPIhdp6SVxzDL1X54NHgmNkJRS04u5D8ilBHSvWpGdWEs7CcIkPisRO0kI804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eiuQk1gP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eiuQk1gP"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dff837d674so52059795ad.3
        for <linux-security-module@vger.kernel.org>; Tue, 09 Apr 2024 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712700090; x=1713304890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0yIUFjeUSHCNyXpPUlLoW5Si0Yh0hPYy5r+nCUIVpo=;
        b=eiuQk1gP80jLBCPKIoRgN7+8ONl6t/mLz4N38DTrO7bEJVA7X24audwZG/4x2LfSGB
         pCMmRjIIqMrJ6j5vEvInk9pK2tLckavVUws15+tXL7i/Ku2QDh3r5NVacmoaiLqFekV7
         rx1zaCVOIYsaFrxrqSy1g4yxSBOZ38YiTL+CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712700090; x=1713304890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0yIUFjeUSHCNyXpPUlLoW5Si0Yh0hPYy5r+nCUIVpo=;
        b=w4TXD3GR3vGY9Qj3d+xEShAp63/ENr8bpTyrncA+zKblpJwA6Vs8QR14u/VeZE6Ljr
         zBGjTbVmpGYqJXMHGoUhgwSKdKzyb8s7oWCyhiNrtGQRPNa934r3vlLH4DN5UPNIUUsu
         zbqh0/BIw0YtwrPrYyc3Fnqmt/ACgBekH1h2IbznXr4g4Sh67lpUadALq5l4iiE8GBnV
         /jBVJ+im8ScjWzq3+m55NG1jdPtDeAorcT9iC09YThsmIVUlYWBhogc/1nnq9iknTzvQ
         G60hPM9yoA1Errr+JAEK7WrMODmR9q9Wvy6oMDxV/pRfXvL1PKrjnI9s+53n/uRWs0Mq
         ezQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwPivl7I7YczQiRsjwZ3pHUbfiwpB4eUqFHoBlfCO94Eu94zbRRvqZoNt1009Xg3EwyWo/OH9S3RqkggqT4ZV7wQG1YdesqSef7QMlV9bAh+3ZHLSc
X-Gm-Message-State: AOJu0YxE5kACUa9EV9TE3HC3cwjTkT7fNSQFutERns1zW373YURtDnad
	lTOolS+fCAxyZaTTsTwHaqXM6AVb5H/MwufVXnePYHU++R0Ju6L+MO1GscqC5g==
X-Google-Smtp-Source: AGHT+IG++7Qrfy0n9fv+Qu2Wi/YTHX+eFWW4ETVqrqGdoTLuSJn+k8JaUwVMICcCNWI4pph4LGwFPQ==
X-Received: by 2002:a17:902:650a:b0:1e4:360:d926 with SMTP id b10-20020a170902650a00b001e40360d926mr1014402plk.5.1712700089858;
        Tue, 09 Apr 2024 15:01:29 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b001e41e968a61sm4848275plg.223.2024.04.09.15.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 15:01:29 -0700 (PDT)
Date: Tue, 9 Apr 2024 15:01:28 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Moore <paul@paul-moore.com>, KP Singh <kpsingh@kernel.org>,
	LSM List <linux-security-module@vger.kernel.org>
Subject: Re: Hardcoded security module suggestion - stop the stacking insanity
Message-ID: <202404091430.A00477BC9@keescook>
References: <CAHk-=wh+_xXpnHfUv=FwGWcce4XwqwKvtq7LcxK6WKmbf4eGGA@mail.gmail.com>
 <202404091041.63A1CFC1A@keescook>
 <CAHk-=whXwcBzFJd65gQ09EGt1yuH6RyuErhOgvJK8pjkAVw07w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whXwcBzFJd65gQ09EGt1yuH6RyuErhOgvJK8pjkAVw07w@mail.gmail.com>

On Tue, Apr 09, 2024 at 11:24:44AM -0700, Linus Torvalds wrote:
> On Tue, 9 Apr 2024 at 11:02, Kees Cook <keescook@chromium.org> wrote:
> >
> > I don't think it's sane to demand that LSM stacking be removed. That's
> > just not the world we live in -- we have specific and large scale needs
> > for the infrastructure that is in place.
> 
> I think we really need to push back on this all.

I'll wait for Paul to comment more, but I feel like there's a
misunderstanding about how LSM stacking works and we're talking past
each other.

> The whole stacking is new. There can't be too many users. And it damn
> well can be limited.

Stacking is old. A small handful of, IIRC, network hooks that only the
traditional "large MAC" LSMs uses weren't stackable. And it's been like
that for a long time.

> Right now that sttaic stacking code is written to allow 11 levels.

Just trying to be clear again: the LSMs compose, as they always have,
via hooks. There is nothing new here. The static calls patch needs a
fixed number for the array, which just comes from the LSM count.

> Why? Just because you people cannot agree.

"Agree"? On what? Each LSM has different purposes. Only a few are the
traditional "full MAC" systems. For example, on my Ubuntu 22.04 (now 2
years old), the default is:

CONFIG_LSM="landlock,lockdown,yama,integrity,apparmor"

And note that "capabilities" isn't listed here because it's not removable.
Each of these subsystems do different things. This isn't "nesting",
they're just literally the list of subsystems to use.

> > I don't think describing static calls as "random hacks" is very fair;
> 
> Static calls aren't random hacks.
> 
> But the "up to eleven levens of nesting" and "reorider arbitrarily" IS.

Maybe the better language is "compose", not "stack" or "nest".

> Seriously, what part of "this is now an attack vector" did people not get?

Come on; the attack vector is broken CPUs. There are plenty of indirect
calls in the kernel, it just happens that for this case it was easiest
to get at the LSM's. Next time it could be networking -- close()ing a
socket runs a protocol-specific indirect release handler. It would be
just as silly to hard-code our available network protocols.

Networking did try to reduce the retpoline overhead with a single if/else
for the common case, but it's still making an indirect call if it needs
to. In LSM, we've explicitly been working to turn the LSM hooks into 100%
static calls since before this latest CPU errata was even found. :|

-- 
Kees Cook
