Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8298BE7
	for <linux-security-module@vger.kernel.org>; Wed,  8 May 2024 02:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715135752; cv=none; b=qrB0u+A+tzNShL3/A/HLDHws2FtFDVm3xVnY5o/SY928Px0K3u3uKq1Pfw8k2w9MPA9keGox1Mcq/YwOFvcEBOkLG4Dgm+dWBtgsnbgiuoqGsCKFbzfEIL0C3K97B0yaV8wSVGjLcaHUtQ59B3QcHZ0bsanFL59UVVTWgiiReeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715135752; c=relaxed/simple;
	bh=osgX8tjFD5SfpMkUkJT1oW9YIAkBq/7BIgG/GoWsw7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssHFhZpJgTb2UVaKqbS3RIsJtwOrIBsPYnrWOPym7TidGXgFTGFOscrxLQDiakf5+800gmkYJkbVi/k6KrlMMLAPhzEZGcIsNyGN52T69Sj/V5+PC1EzzccW+2ZBCxuwBlFh2PoElqTIOGHyTE5ua7DTCXodufzCXg1SOnDDI3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XAscNMCa; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XAscNMCa"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f44bcbaae7so2932095b3a.2
        for <linux-security-module@vger.kernel.org>; Tue, 07 May 2024 19:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715135750; x=1715740550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W6UvHjV4WW7tio3LlaL+r5qi19qe6yV+hJDoyzpWlBY=;
        b=XAscNMCa8D2RFo0KwormPiyhC4pELQujv9y2IqbXN/mfcsIb+w+VXmcpLe5AP5PGr/
         1LDeRzEIpC/1dSbYhr6jkfPO9SN6NGd5oAzqnQ9KbtE0e/Tjf6rEv0n8TG+RspNSSa39
         n/U7nENnii/d2qcz0VMwVhS2kOJ0YZ0JF7MSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715135750; x=1715740550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6UvHjV4WW7tio3LlaL+r5qi19qe6yV+hJDoyzpWlBY=;
        b=rFLGeqOu2IQfsYIaxpDFUfodYVrZyEfgxbL7hs8Mxhge3oVCC0PPTwlfrWFPkwo2Lm
         DE72O9U0IQXv0AjiFQIOG6SCMu2WJhU8SkvoTMeXf5UJ+iCqQudf19bdq51zCpqVqBoF
         VySqmOQDL84Og3xgl/NqD74JX09Q6GbxC811S3a3NtnP2esAtD4vhNrQURyWlEKO+Lkj
         WZJlfsW8OLqJ8Zf2KCFpBwXBK+l5/ch22igAgtwUjo7usZmyKIY+vVYcaHA3btG6y29M
         M7x2f+fFG87YUMgztRZatbjMRVoRpFAJwWKzz4W/SSpgUaLlIY4Ev9+gsF+7KiJr0QBk
         kSgA==
X-Forwarded-Encrypted: i=1; AJvYcCWZHqaPbMhpESHKwMDKgBSLoV0HjZ8zKcWogqFL3CtvzSOhvUgf4ksuN0+5U8OQCmi/o5uHPEa5j6oeM+Wtv7hPMLNDP+Rae32LrNMXQJNBGsnqfqMR
X-Gm-Message-State: AOJu0Yyfxppz52fkauWaRWiyvOuRvBhySAo/dXMwqH0vY8Y5KmbxU+DJ
	2YmV0jkUj/uoTcZYiHkLp2zoqw0lu9ijt5ziACmokkvRfJ4uBSJ7Ap+KL5qPbg==
X-Google-Smtp-Source: AGHT+IGZ5rKp9Bo1YZOipsIloa2Y6dgP8s+sQDK3hSBjVHW9BNLfSWaoMbufoCqj3FPGcGeLAL+6Lw==
X-Received: by 2002:aa7:8516:0:b0:6f4:7297:7bd with SMTP id d2e1a72fcca58-6f49c2ade2dmr1384621b3a.28.1715135750244;
        Tue, 07 May 2024 19:35:50 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h11-20020a056a00230b00b006f2909ab504sm4792305pfh.53.2024.05.07.19.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 19:35:49 -0700 (PDT)
Date: Tue, 7 May 2024 19:35:49 -0700
From: Kees Cook <keescook@chromium.org>
To: Paul Moore <paul@paul-moore.com>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	jackmanb@google.com, renauld@google.com, casey@schaufler-ca.com,
	song@kernel.org, revest@chromium.org
Subject: Re: [PATCH bpf-next v10 5/5] bpf: Only enable BPF LSM hooks when an
 LSM program is attached
Message-ID: <202405071930.A3022BFDC7@keescook>
References: <20240507221045.551537-1-kpsingh@kernel.org>
 <20240507221045.551537-6-kpsingh@kernel.org>
 <202405071653.2C761D80@keescook>
 <CAHC9VhTWB+zL-cqNGFOfW_LsPHp3=ddoHkjUTq+NoSj7BdRvmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTWB+zL-cqNGFOfW_LsPHp3=ddoHkjUTq+NoSj7BdRvmw@mail.gmail.com>

On Tue, May 07, 2024 at 09:45:09PM -0400, Paul Moore wrote:
> I don't want individual LSMs manipulating the LSM hook state directly;
> they go through the LSM layer to register their hooks, they should go
> through the LSM layer to unregister or enable/disable their hooks.
> I'm going to be pretty inflexible on this point.

No other LSMs unregister or disable hooks. :) Let's drop patch 5; 1-4
stand alone.

> Honestly, I see this more as a problem in the BPF LSM design (although
> one might argue it's an implementation issue?), just as I saw the
> SELinux runtime disable as a problem.  If you're upset with the
> runtime hook disable, and you should be, fix the BPF LSM, don't force
> more bad architecture on the LSM layer.

We'll have to come back to this later. It's a separate (but closely
related) issue.

-- 
Kees Cook
