Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DD1374EB
	for <linux-security-module@vger.kernel.org>; Sun, 21 Jan 2024 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705865272; cv=none; b=h6o2z72kYPHRFRc/s+l73GgTZsvwh9fzwLMcSqWid4l6v7TIRSQ3UFj6GZv1CQYp117NAkdFGOSKvXXOTqupQnM2WrwVu3MsnpuZOrKz7YolGJ0V2cCX1H8YDJk96OiCE+o49AYWRIEJFt95ponHIohEXfa4amDaDwjFRmSZNYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705865272; c=relaxed/simple;
	bh=2FpoKLKzqH8UC9hSwhA9E7HCkyq8gOsBF8dHu25KccI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCJkKcmTmUK4/PDGRZgBfR5KCg/vd74aGsiZaVgTInWywSk11lfoDDDNPM6uKccGo0RzJjAFdmSjf387NoRTMs/nRS42ufpIBZcRxJXdh12J7maqHKSau80h5d7Y5w3HX6zvZ1aoFVFGW7FK4AH3z8lbLZSqCuu8hzX27aqnkPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F/hAcnGv; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F/hAcnGv"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e72e3d435so2157988e87.2
        for <linux-security-module@vger.kernel.org>; Sun, 21 Jan 2024 11:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705865268; x=1706470068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7ilsHoBAFLGrxDRmI028SujMWUyj+V2X5SyCrYhyT90=;
        b=F/hAcnGvmBQnAx1/D6OxmhcgXlAbilsW4q88/wMPdERBDF7V0wSHXqi52ZsKD24J+a
         sCZ0Px5W3PnPDjZvG0Iw0MFF9WKreKCMmdO615ffAzGtDItyA8LRT8rghXSPaPCLMbO6
         2+N81X2lBfDYk0gc847hkQ92ebxOZpYIKiouI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705865268; x=1706470068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ilsHoBAFLGrxDRmI028SujMWUyj+V2X5SyCrYhyT90=;
        b=bE6AH3k5wxFs36Yb3OQxO/aagMhkbpTmHSmaBwWYwdvA9TSoWppDruWpsvUcDfkQDH
         aKZVZPcNBYT5E3SOZ4hFs44rKs+rG3+ukKh7haFsWsKXCwyr1amO56r7XAFGRvJR8Fui
         pcvBAegquiX4pH5EKbHx4iq1O/UhYD3SJlzC1ZN414HX710laoiE/mC8+gi6apfbgYoJ
         ExE1rGkvRk5JEqVBWZUIUlsPpZ7qDj3onJ3gyHLL0J/qZEuUX2cqMjoSPJv7YDlgmIt3
         UOt/tYWs90dUoyX1zgGJPJ+ASKrFPuUtpjVe1gDOmNmjeXCcH3TDw7XAXA8Hol7pjdMz
         He9A==
X-Gm-Message-State: AOJu0Yz5W0q1rKKcvQ8cGqgmDPK/nznLOJ2D93Kzn7mjwxvOnoDz6tzW
	OxwAdUf/1Wg2eHF6XQFANBrYx7ZWlggde7N37+s4nKyfcgkVa6vhZ1lijwNMHoLDxneN7cJTJF3
	WOq2oTw==
X-Google-Smtp-Source: AGHT+IFq9MYejiwRkZk9bkvhrXYmfKTBqb/0fNyNfGSnwN4VfXLEjXRzQtqTh2kQF64y6fXtLqXzhw==
X-Received: by 2002:a05:6512:15a9:b0:50e:74c1:6e6f with SMTP id bp41-20020a05651215a900b0050e74c16e6fmr845923lfb.93.1705865268358;
        Sun, 21 Jan 2024 11:27:48 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id af1-20020a170906998100b00a2c6aa5e374sm12624200ejc.12.2024.01.21.11.27.47
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 11:27:47 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a684acf92so2390548a12.0
        for <linux-security-module@vger.kernel.org>; Sun, 21 Jan 2024 11:27:47 -0800 (PST)
X-Received: by 2002:a05:6402:26d3:b0:55c:29c1:4186 with SMTP id
 x19-20020a05640226d300b0055c29c14186mr493069edd.26.1705865267510; Sun, 21 Jan
 2024 11:27:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119050000.3362312-1-andrii@kernel.org>
In-Reply-To: <20240119050000.3362312-1-andrii@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Jan 2024 11:27:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg3BUNT1nmisracRWni9LzRYxeanj8sePCjya0HTEnCCQ@mail.gmail.com>
Message-ID: <CAHk-=wg3BUNT1nmisracRWni9LzRYxeanj8sePCjya0HTEnCCQ@mail.gmail.com>
Subject: Re: [GIT PULL] BPF token for v6.8
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jan 2024 at 21:00, Andrii Nakryiko <andrii@kernel.org> wrote:
>
> This time I'm sending them as a dedicated PR. Please let me know if you are OK
> pull them directly now, or whether I should target it for the next merge
> window. If the latter is decided, would it be OK to land these patches into
> bpf-next tree and then include them in a usual bpf-next PR batch?

So I was keeping this pending while I dealt with all the other pulls
(and dealt with the weather-related fallout here too, of course).

I've now looked through this again, and I'm ok with it, but notice
that it has been rebased in the last couple of days, which doesn't
make me all that happy doing a last-minute pull in this merge window.

End result: I think this might as well go through the bpf-next tree
and come next merge window through the usual channels.

I think Christian's concerns were sorted out too, but in case I'm
mistaken, just holler.

                  Linus
