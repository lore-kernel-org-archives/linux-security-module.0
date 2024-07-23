Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA235158879
	for <linux-security-module@vger.kernel.org>; Tue, 23 Jul 2024 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759635; cv=none; b=GNRDI6Y/wlF+jBgEBMRtwZElXVJ5SeNgNOVCBoefg01UJFXl6juaNgBh0iQYAkROjiYvttkqu0/sOkT9K9SftYyoFGWdrCjIy37c/GL9a26Pyd2mdnzGBpKKx+27SbMUnVy0Ch//SQXO5IqZiJHHGyUCRXkrrMmUlc90rJagDxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759635; c=relaxed/simple;
	bh=NFq/ekDOEm1BCUiEQxAbPVsS7vv5PxDQqveu1WlBUdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uc/kUYyguLALdUn21xR+kYVEkOzhq5xG0It0ljQUIxHM9O3BiM/WZwt0mw4mvy8qW2TqUBS3X5RLCwlHJ66aEpC/hgVk9+bkC8267tfI2CPQQD3YYVI+F0ALuLfwHFafFauFzWVnchMnYmmrv4E2quyDCWCyG9niC3LgFXT9ElU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BWoVOlkh; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BWoVOlkh"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52fc14d6689so2246661e87.1
        for <linux-security-module@vger.kernel.org>; Tue, 23 Jul 2024 11:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721759632; x=1722364432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jVlnyN0btPbYCcHbH0TkKobCqtHm6zMls3/CNbNfk/I=;
        b=BWoVOlkhhWtTHUF4nKcFnVEDmWEvMIIXT6uWr6WvJC2qcVhoYqcbkuTxV17PNZMuss
         EeBEyGYv+kp7YDQB9vqG2Zsi/lOz3tbPFvhTt5cC9ZkMiuljwqHJ+T8HncDwcgNkMV9o
         0GzdAoD1N2Z69DtYI0erbcGA1WelF6MmHcrUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721759632; x=1722364432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVlnyN0btPbYCcHbH0TkKobCqtHm6zMls3/CNbNfk/I=;
        b=hrVjUhDBdKsu7iXcmmoxxtkCgQVrmw1WnIW73UcWigs9Nxu4eZnsa4sUDGycfuAUIk
         LleLfM0hnBD5KnJ7xsuonx2sGdq+zatCGT76zJlq9D8+wW2PS+W+4aQ76iNQ8FiOvhvK
         5hMu0Xb/FJCqxx1IRTDQw5wga+LAK5gKZlT3ndn//1rFUWUYxVSDaT3Ipi6na9GmuV9t
         jCcFmb1cKkCoxyrYG5N4KtoPl/9ckUwJ82tMLpZ1/O5tgFVfQuMjiLdK1oL1EnAM/NEp
         pIExwVeLA1dXFOsKpNpPqL3B6zc5xOrlbTpXm5AS/+Oo2jl/MQLEDnqsyu00+0Tc8SmJ
         e+kg==
X-Forwarded-Encrypted: i=1; AJvYcCV+o4PDJAk4/RmkGR8AmiJsJaoCoKsWsbWWEs+eVmh7iQXfmQjZN97WZhk1LPwNBXcaseWlUTPAsXfZSy1xlVx9DHdfdHj406OEcyr6jF4ft/RTmmEz
X-Gm-Message-State: AOJu0YzadT/Hynq0tJD+4Apgvqa1YrAp9nKL99nceKWPFbOB3fXYCINI
	IUlUnohu5AJjH82iP05K5T8LHXxup8zmcdua9GvneukORTb9b1DTbISOskeJEz/n3kJScZWPtwp
	fGjvWmg==
X-Google-Smtp-Source: AGHT+IEUOfHVEd4ypPSU+EVENrJEtKfU41gHJ+518kYL05vWDanb+x72O2j4foGdX+f77Qke7Jnifg==
X-Received: by 2002:a05:6512:12d4:b0:52c:e170:9d38 with SMTP id 2adb3069b0e04-52efb771787mr7042333e87.31.1721759631775;
        Tue, 23 Jul 2024 11:33:51 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30a4d6c17sm7905275a12.5.2024.07.23.11.33.51
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 11:33:51 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so5269679a12.2
        for <linux-security-module@vger.kernel.org>; Tue, 23 Jul 2024 11:33:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVS3QtU5L9INtP5ucj9nL8IqloJ8vVux/N5EuI1YcUuspyOkALHkZ4NcjwhKtaNYypNtqbWcNsGxnqMoLJ05193lWw8zvDym66nq6FkYjWMQevEg/SD
X-Received: by 2002:a05:6402:26c2:b0:5a3:f5c6:7cd9 with SMTP id
 4fb4d7f45d1cf-5a47a61f330mr9178333a12.26.1721759630852; Tue, 23 Jul 2024
 11:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723171753.739971-1-adrian.ratiu@collabora.com> <CAHk-=wiJL59WxvyHOuz2ChW+Vi1PTRKJ+w+9E8d1f4QZs9UFcg@mail.gmail.com>
In-Reply-To: <CAHk-=wiJL59WxvyHOuz2ChW+Vi1PTRKJ+w+9E8d1f4QZs9UFcg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Jul 2024 11:33:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiU8igSGkycZ1e8+6-NF9obbbt1aZXYwd0ONzXnHsBgHA@mail.gmail.com>
Message-ID: <CAHk-=wiU8igSGkycZ1e8+6-NF9obbbt1aZXYwd0ONzXnHsBgHA@mail.gmail.com>
Subject: Re: [PATCH] proc: add config & param to block forcing mem writes
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	kernel@collabora.com, gbiv@google.com, inglorion@google.com, 
	ajordanr@google.com, Doug Anderson <dianders@chromium.org>, Jeff Xu <jeffxu@google.com>, 
	Jann Horn <jannh@google.com>, Kees Cook <kees@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 11:30, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> but while that looks a bit prettier, the whole "fs_parser.h" thing is
> admittedly odd.

.. don't get me wrong - /proc obviously *is* a filesystem, but in this
context it's a boot command line parameter, not a mount option.

The "constant_table" thing obviously does work outside of mount
options too, it's just that it's documented and used in the context of
the mount API.

                  Linus
