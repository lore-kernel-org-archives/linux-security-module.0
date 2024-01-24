Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A92133402
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125912; cv=none; b=tgBuJfUenuoxPjWaluB52JjZ6S9zNsZgyel68fRiCH++KKfEHk2DFfKr+9Od1vQQaRjf2ztNpODlnXkbkIOkJMTA6XmiIPjk/4U86GPoq2nkqlRly05yLj8vQ/RMnSS3nklNmWk/F7OXAVrxKnH7R9WbPP8eMX0177mXetmgn7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125912; c=relaxed/simple;
	bh=+IYqSxEQ9oBa5c9r8B0bfIvQXLqXBMpi4Ryc4G+HXuE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TK1FPxvKu3E8+ZHFOrR5WPQFH2NP7sTB8NJyUs/OMjDYibFgn5l11uLXAWdZXWvnkND3paulq2YFDcxA/wzNLBNrDCHD4LzdPiJjiWulQQDU2kDf7x9Pgnd+le8KWul3X4QRg4wkECvB9LgRgsaQc3kujvjEH7PgSIgJm+MKYz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J4Diar6n; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J4Diar6n"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d71e184695so24656885ad.3
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 11:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706125911; x=1706730711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kA0mFxG1k0QSiOKDeUD/WDcdNFn8yF9DrGJFsA48PEc=;
        b=J4Diar6nU/37c0/UwBQQFu7zCFodAGZNbMK8zK5T4ksD60wf29XsDjczDxsZMoOkG8
         VWNui00mTtdF2GLDTKMEYsm80XO6z1961TZkKiOaKfAmeJPEEG9nw+44TX83kwwOMNbj
         w/zguEDg41/bg68FDXI9OEyyVi7Lkay37ry3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706125911; x=1706730711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kA0mFxG1k0QSiOKDeUD/WDcdNFn8yF9DrGJFsA48PEc=;
        b=vnfMzfP/IzJKKSDJVRg/xZoMT+fZfcdZWZ7gLd5s7sNr0iVy8v5YBz8eSzsKO5dps8
         RHfb2CCWkaTch5u/Kwl9YnoPopvBY0Czhpabq1hlxWlnnvTflySLoZIW0zmpURuHSF58
         Uvq9JLODA6Cym/+lXWl+5mNqwVQPiKtVXe9WKe/7h5KdDsHBbJGRRZGJHILabz7wNufm
         bl9UP5nO0B9EFOq6tQFVeXWV/iGOkftIcncG6GaW6gy5cFiQqeuKqiMZ2bl0vV3ANmi8
         7dO55cZQId1uJVZdX4FeK3XdJ2yyKdCTsAV6RkIsab1tE7jzLaNa92s83zE7hn98CVW0
         HqxA==
X-Gm-Message-State: AOJu0YybmMc66OL7jZILmM2qsp9XP4LxtBRVcUHMFCkhhQPDUiVtTQoZ
	YsGPq/cSfbHrM9CEwMwATHYwl46wVIoyKYnIiW3FX8jUzjfCSPuo9um48gZ8rA==
X-Google-Smtp-Source: AGHT+IHOo2S4XZPrJkJAVWNIUu5O2sihiMmNygdfJCCs51/i38ljraqICbhZ/brbhlRxs5RoeWJoDA==
X-Received: by 2002:a17:902:8685:b0:1d7:70d7:c05a with SMTP id g5-20020a170902868500b001d770d7c05amr1210754plo.98.1706125910737;
        Wed, 24 Jan 2024 11:51:50 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902c18900b001d707163122sm10456896pld.7.2024.01.24.11.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 11:51:50 -0800 (PST)
Date: Wed, 24 Jan 2024 11:51:49 -0800
From: Kees Cook <keescook@chromium.org>
To: Kevin Locke <kevin@kevinlocke.name>,
	Josh Triplett <josh@joshtriplett.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] exec: Check __FMODE_EXEC instead of in_execve for LSMs
Message-ID: <202401241151.25D468FE@keescook>
References: <20240124192228.work.788-kees@kernel.org>
 <ZbFneq3URF5lLAT7@kevinlocke.name>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbFneq3URF5lLAT7@kevinlocke.name>

On Wed, Jan 24, 2024 at 12:39:38PM -0700, Kevin Locke wrote:
> On Wed, 2024-01-24 at 11:22 -0800, Kees Cook wrote:
> > After commit 978ffcbf00d8 ("execve: open the executable file before
> > doing anything else"), current->in_execve was no longer in sync with the
> > open(). This broke AppArmor and TOMOYO which depend on this flag to
> > distinguish "open" operations from being "exec" operations.
> > 
> > Instead of moving around in_execve, switch to using __FMODE_EXEC, which
> > is where the "is this an exec?" intent is stored. Note that TOMOYO still
> > uses in_execve around cred handling.
> 
> It solves the AppArmor issue I was experiencing and I don't notice any
> other issues.
> 
> Tested-by: Kevin Locke <kevin@kevinlocke.name>

Thanks!

Sounds like Linus has taken the patch directly, and I'll send a follow-up
PR with other clean-ups.

-Kees

-- 
Kees Cook
