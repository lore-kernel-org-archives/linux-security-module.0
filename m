Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8305D4D9FB
	for <linux-security-module@vger.kernel.org>; Wed,  4 Dec 2024 05:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733289923; cv=none; b=Ojuft5bfffWcT0tdiHTO13fSL4XS/ruNev2PcsP4YOeYwqea0GOF2pl2WkLjY8Ww1XTNNUGSfHGM3e3dGXs27tywJ+VkCna6YQKNtSurQxVqcBQ7VpQpkU05def9Y9OZ9+kHI/QmkDXUgHAzk/x9EzXfFJ7F+nI/k9cdQb42u/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733289923; c=relaxed/simple;
	bh=/dvvirKhO2gPPNSdX6vqHzMjHQN6aZB8f5z4IOP4fsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUUUK7XMHmcmfjCP/9xchWTaEqNUqyaqskCAkGAm/wmJW+L04V1Bp6gYh3QQhBHAmNdtGfU4I8DqNuwZC+fGH8Ol3IYLxWaU6LL3rVIqz+HNwFp7eIipZabXxJy2d0Ntbjmq7eIPWt6n/yBNFZT0N3Zmfv0nHJtYzR3nAqQ/X4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kcnY/mq+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kcnY/mq+"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a8b94fb5so2673385e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 03 Dec 2024 21:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733289920; x=1733894720; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i5h1tihuQhYWDe85LTj2y/HqnD9DTgtBeMrhCQ93/6Y=;
        b=kcnY/mq+HK3P/gMDZDRyowqMfuxVcV4/P9bPutqgth+GM0W/DTMsqI6KeLhegNaaiy
         GOiBgRtRetboOV1vwFqpOkpZhJ5UZUvb+CX4ZsoiJMmYfMaD0dWW3HJ9v2IIlrINC9Tq
         ZK5e6iIgsWRPIfqSCtsTvUXl8iTW9lvwNuueelXfnQ67j3rnri+djMpjt+Sx1bJ48K5r
         wLuGQytf4hbVP9kEooy/cBkCK6mRD/X8MsI1YS0/dmh8WrwWBvU6bWNMQIyS5DKofAjh
         Pp/AS7k/9fXNvavAU0qS5IWpjFSGi1+VITSPecCAIAWGCk2UoJXGKj08+E3dn+Gc3imy
         dYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733289920; x=1733894720;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5h1tihuQhYWDe85LTj2y/HqnD9DTgtBeMrhCQ93/6Y=;
        b=cHfr/eOeeJvQql9YplMqxaOSO2fGZyyvFSZynZhR5/svWd7EamOEUQQKk/hpxg7F4i
         NFmy1R6WOUDYVEn6oSQ9YFmYXa7VhwNO06qgVSc2RZJNLMM9r7k7saLpsiMiWTT/qsh8
         qXlvq7Ld8m8PMQvxCseFjWmzc/6d0HQNdzVawVzymDN3r+8daSkLHnbJs0eATOeh+GpB
         p8tuUytgc69uxU+mmHwm9GqHfIXsRaJieIQ5S/Es3+5YWwOdxHXm1CghkstrXnVJ7AKm
         neRZz4NAzqhoa2AEeGTfM/st7fSZmXyoBQZDiJOph3nE28vfGxR1RYDiah/nYUSPEQO4
         j0YA==
X-Forwarded-Encrypted: i=1; AJvYcCW8tGyHeNQyeCaa9P4wP8v4wuZygvKre0hmKKWA7BvWf8UhDN5r7BJ8sTKr7AAy4xBD2w8QjDIUQ19tiBpn5gZYyDnVfJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA2EzXOC9kQbUOEJAsKhhqlVC6fLeAqHRdEzoNuTJT8Wf4rnK7
	04A5mbwQs0s/ql46n96mTGo2a5coNnKeIVZ9iGapHqKoLAvJeHhf7+915cGFGFc=
X-Gm-Gg: ASbGncsAUY/j+JXgdawFWslQSMm6jz7xytpLwPaIgnYD5afmzLVLUs+UYPBoGjUtqY+
	wZHZ5U0/1+Zc6Dypyq252Dzk4odIThDzk4fRtsoXn4a94QTPqhpkKieiLb16pwjr/kMqoiU4BgH
	IQvXC8G46/MJGLQDV/T+/nfxj/dev7nsAe9HRmr3NI86I3HUidoY63RbKDgt73nX+oFRiBXUXd/
	lu9o34tvNA8QodJxhz949WaYMPALtcPQvPwatVIcP3y1UpWoJbejSg=
X-Google-Smtp-Source: AGHT+IG2NnsCiD2948m5umN0aVUZUxCxIX2v+BEOj7dTiesZDB20MuULl9aG0UBQcTzYTL+o0PAEzw==
X-Received: by 2002:a7b:cbd0:0:b0:434:a4d3:31f0 with SMTP id 5b1f17b1804b1-434d0d1be0amr41592185e9.3.1733289919310;
        Tue, 03 Dec 2024 21:25:19 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d05b4909sm27378955e9.2.2024.12.03.21.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:25:18 -0800 (PST)
Date: Wed, 4 Dec 2024 08:25:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
	LSM List <linux-security-module@vger.kernel.org>
Subject: Re: LSM: Replace secctx/len pairs with lsm_context
Message-ID: <3a3c35f2-1228-47f2-b0ad-5d861917ce11@stanley.mountain>
References: <f16f8d81-3894-404d-baeb-febf2fba16f7.ref@schaufler-ca.com>
 <f16f8d81-3894-404d-baeb-febf2fba16f7@schaufler-ca.com>
 <CAHC9VhTfKfAeKKbe3P-ZxP-0Y01r0GF6pPvt=2FxvQzAeTGjag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTfKfAeKKbe3P-ZxP-0Y01r0GF6pPvt=2FxvQzAeTGjag@mail.gmail.com>

On Tue, Dec 03, 2024 at 04:59:12PM -0500, Paul Moore wrote:
> On Tue, Dec 3, 2024 at 2:29 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > Paul, do you want a revised patch set for the lsm_context change,
> > or do you want to stick with what's in dev-staging?
> 
> I figured I would just move dev-staging over (I've already ported them
> to v6.13-rc1 in my tree), but if you want to send out another patchset
> I guess that's fine too.  Although looking at the related patches in
> dev-staging right now, excluding the rust update from Alice, there is
> only a kdoc fix (me), a signedness fix (Dan Carpenter), and then the
> two fixes from you.  If you like, I can just squash your fixes into
> the relevant patches since there is no authorship issue, and to be
> frank I'm fine with squashing my kdoc fix too, which leaves us with
> just Dan's fix ... which I think is okay~ish to leave standalone, but
> if Dan's okay with squashing that I can do that too as it would be
> preferable.  Dan?
> 

Squash it.

regards,
dan carpenter


