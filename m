Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B367E56E
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115322; cv=none; b=aKg3VJD62HHe15sfyfL0hoA2aYiLiThzExAx2+iQMbbv7Rx0CkDBf4SULcpUnhYYOSOcOlid7YeVgvDNoXL10UfrjdPEj7juOfo7OfHCKnsDISr686ay1bcjOQin6nH49srBERA0ZGirovPS04dahXBAIDt3KtO5UuosCk7ANJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115322; c=relaxed/simple;
	bh=YImQJ7siYYOCy8HRvG07XXg2YFYJXgcsNfV6voSQuBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sL3Ia4RskgFZV/npCtVFwm/0/Myt7m160mykwwudZNPIKPvaibCUCUmFsoJ7z56uhSqKVwe4lr9OhhH1S/fDgMxUy8CiVGdCLqqfMxcVy8pYy7B9jEGaQfMHe+Z6TKaDsR9J2ZldkMLIhIQyYItkxGQocwhbvyEe58/fw3Nx6Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bQGuxd9P; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bQGuxd9P"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cf1fd1cc5bso10640211fa.3
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 08:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706115318; x=1706720118; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sPdCGKuEWKXJWP2sfaXpzZkS4P7GnOGZQJx21so96qE=;
        b=bQGuxd9Pd5Eu251gHRY/VYhrZRVfccrxjdaR9APocEm/kH+j2088ARnUJEed/jyFca
         JuLOBigSgn05DcSlLsGj+BS5/VWjKL6xsG+GBZz6PE56D15v9RPUYwz/6q7jRhUS+1Mo
         CzaoXyOR4ynFgPo1x/FbQkkXmywjuzh8hAYkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706115318; x=1706720118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPdCGKuEWKXJWP2sfaXpzZkS4P7GnOGZQJx21so96qE=;
        b=Y9DiS71sE3NfrxRGaxZwWjk5xOd7Mdh5Td/Zy6O3PtIboQXkyTC7i9VMR/3yuKSWDW
         4QpUUIxzNUV48+7MrtmKaPABrKf/mNCWBzA1d2Ck6ymGtcBkSp0dSor2JBzFTJHTlRYy
         iibBO1+Phi5z9u6bsvpRmP4Gc31vf5fO+9Rp2S5C7LfA+y3/75U6I36ZLvL1URNvanAi
         UR5TOTH1bEowCrwCXOU9eH0B+15cEr5VmaSSa9OA58v+CSBK4UaReMqEGHWxHwcBwfY0
         3m/2aU8j9ZIHua8ZiyaxgAztIYqYzM1pZhJVS79NPV6iGOWukY+w2ibEU5fsmXr41j+X
         KqXg==
X-Gm-Message-State: AOJu0YxhYhWiP/t9v7K5ePOOkeBD8Qid+9aTrtmG6j0mlNAdP/z61Ggb
	PBoAKlN+aRSDaO1r5ELg2qBDGkAZhBJW17oKbE8wAd02lIDdZOZGXGpaJa8kQALdCADY0PeuX8Z
	4nUEToQ==
X-Google-Smtp-Source: AGHT+IEgwwAnQoD+IpWFYgQdS+1oKuohKyJ/GaoTLAfKRKPfEiUnOssa5HPGcV3hAh0q5YdZZpw9FQ==
X-Received: by 2002:a2e:be1d:0:b0:2cd:9063:4136 with SMTP id z29-20020a2ebe1d000000b002cd90634136mr1296804ljq.47.1706115318656;
        Wed, 24 Jan 2024 08:55:18 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id k11-20020a2e888b000000b002cb28360049sm17241lji.96.2024.01.24.08.55.17
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 08:55:17 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ccec119587so73661561fa.0
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 08:55:17 -0800 (PST)
X-Received: by 2002:a05:651c:1043:b0:2cf:155e:2567 with SMTP id
 x3-20020a05651c104300b002cf155e2567mr1158083ljm.95.1706115317480; Wed, 24 Jan
 2024 08:55:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbE4qn9_h14OqADK@kevinlocke.name> <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
In-Reply-To: <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 08:54:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
Message-ID: <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from virt-aa-helper
To: Kees Cook <keescook@chromium.org>
Cc: Kevin Locke <kevin@kevinlocke.name>, John Johansen <john.johansen@canonical.com>, 
	Josh Triplett <josh@joshtriplett.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 08:46, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If the code ends up deciding "is this an exec" based on some state
> flag that hasn't been set, that would explain it.
>
> Something like "current->in_execve", perhaps?

Yeah, that looks like exactly what some of the security layer is testing.

Hmm. That whole thing is disgusting. I think it should have checked
FMODE_EXEC, and I have no idea why it doesn't.

                 Linus
