Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE0182D91
	for <linux-security-module@vger.kernel.org>; Wed,  7 Feb 2024 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328668; cv=none; b=kfAA6oixejAJYO3qi8B89BapzCcjx132akhkaQUk/Exb6bP2yGVRInvxrpn/BqUMD+sbeWt85SweA0MyA2vNU/47PsDGh+ypGQSxtMFmio4MtgwUc79eesrJsL3OcLzV8qe7rSjBH2Co/sQbt0yRIh+/SIfMJxW0bwD8BoYmKro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328668; c=relaxed/simple;
	bh=cRRJoxkRzUXRvLL7R3KphPee6imOsA+kZBjZd4YXNoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOLf+Cgbepy+bFZA2T2McK7trPe+P7ITteVrLTOCpu+btZCpQl7fb0YsmsyMbFvDyiueB5agW6AQMctv+RUkeGyg8qxxJG01+gPwTqYsZa54fT/9kSzk7Nh49eb68O54VLKUMNwCi1nKkrYmd0EwQa4NCLC3PRmObzIP0uqRuAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FOeTtVQT; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FOeTtVQT"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-511234430a4so1821332e87.3
        for <linux-security-module@vger.kernel.org>; Wed, 07 Feb 2024 09:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707328664; x=1707933464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+D67kFPKINWDXTANYzDAtf4PxKO+gh9QVFhv0sOkzl8=;
        b=FOeTtVQTlT1j82Z6IqQ0nDXwNu3pb+VHp7soJPOC5qzkldGPYb5qNTHHrQXNoEQil6
         ULlvuJYJDjM0i7x1bf8lhJFhzSYPjH+xRzOQNz4K66Epxd/vy1pNO8mDkIg+2f5X/kxZ
         kl6iu88kXjxVKOffUDOZ1XTT7FAh6UXhr93nA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707328664; x=1707933464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+D67kFPKINWDXTANYzDAtf4PxKO+gh9QVFhv0sOkzl8=;
        b=fqv4bP/ab3RugWIKUFaNoL0kAuE9VE1+9mEvoSZdet+qWmM+YI883eT7ue5jjCPU3x
         7VDI+sdo2r+5hOpQkDjAUh2ZUidhoWbTruLc6yHFzYz/uHKAnSYVC53rrEktRh7QIrFc
         vtC4D6EVvHaS2W/FTHnw84Adg1sv2b+OmOslfbqwvGHXZqwjN5jjysXSNX8n8UV6/RUe
         7NroUt0KmGpZv5TiwOaxwmKc5dNq0sUwsDouESzybeYNdcaFj4HWkmbJyqceuSnf8qyX
         KFPzuk+le2WATSMdu/1kUbtbIxg4phLUmeAQrUUwTok8K1YAz5OaHPmlsKTF8Mu4X7kB
         v2NQ==
X-Gm-Message-State: AOJu0YzMPua30HAKw+i4Mvp2CkRFVM5YMocL2kdWTuHIbCJBsF/zpZ1a
	QsXpgAYoK6wMOrjW8lkOuSw/e+zXBSkD+5VBfsJDjAnRfgoPz5MNNhwBxAgkcI+wBsRsieNR4g5
	+
X-Google-Smtp-Source: AGHT+IFSSlH2xxyjqUIGZvsH+mQCc42MESx/TBO2X7mAuGC1beUbEAsOOgjNR4aa/rk6LwkNvc/VOQ==
X-Received: by 2002:a05:6512:230b:b0:511:670f:186b with SMTP id o11-20020a056512230b00b00511670f186bmr2245932lfu.64.1707328664177;
        Wed, 07 Feb 2024 09:57:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4NBQEfm2Lc/EeBsCOplDYJUqRPAk4GofH2z36vakAkYcHNmQQJqkMm5oJF5dvBE/tKI8yqa+waubIB9G1hKFF6T5ax7H3D1gj+/AITNOe309+8Kte
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id bi23-20020a0565120e9700b0051150a5dbb2sm258827lfb.264.2024.02.07.09.57.43
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 09:57:43 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5116bf4dcf4so19663e87.0
        for <linux-security-module@vger.kernel.org>; Wed, 07 Feb 2024 09:57:43 -0800 (PST)
X-Received: by 2002:a2e:a792:0:b0:2d0:be0f:96ff with SMTP id
 c18-20020a2ea792000000b002d0be0f96ffmr4990992ljf.17.1707328662807; Wed, 07
 Feb 2024 09:57:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
 <999a4733-c554-43ca-a6e9-998c939fbeb8@I-love.SAKURA.ne.jp>
 <202402070622.D2DCD9C4@keescook> <CAHC9VhTJ85d6jBFBMYUoA4CrYgb6i9yHDC_tFce9ACKi7UTa6Q@mail.gmail.com>
 <202402070740.CFE981A4@keescook> <CAHC9VhT+eORkacqafT_5KWSgkRS-QLz89a2LEVJHvi7z7ts0MQ@mail.gmail.com>
In-Reply-To: <CAHC9VhT+eORkacqafT_5KWSgkRS-QLz89a2LEVJHvi7z7ts0MQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Feb 2024 17:57:26 +0000
X-Gmail-Original-Message-ID: <CAHk-=whSMoFWCw=p1Nyu5DJ2hP2k=dYmPp-WjeY8xuc7O=ts7g@mail.gmail.com>
Message-ID: <CAHk-=whSMoFWCw=p1Nyu5DJ2hP2k=dYmPp-WjeY8xuc7O=ts7g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] LSM: add security_execve_abort() hook
To: Paul Moore <paul@paul-moore.com>
Cc: Kees Cook <keescook@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 16:45, Paul Moore <paul@paul-moore.com> wrote:
>
> Okay, let's get confirmation from Tetsuo on the current state of
> TOMOYO in Linus' tree.  If it is currently broken [..]

As far as I understand, the current state is working, just the horrid
random flag.

So I think the series is a cleanup and worth doing, but also not
hugely urgent. But it would probably be good to just get this whole
thing over and done with, rather than leave it lingering for another
release for no reason.

                Linus
