Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0711A0711
	for <linux-security-module@vger.kernel.org>; Sat,  9 Nov 2024 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731189601; cv=none; b=OZcwQwuNDxQDF3PaPz30lTy5rwIURoMQYnfh73VR24Jng64swT8ekzrou8EvdpO6zFf+7pa+tD0EuFGyX2xLafaxhK1OFtP0dbP5cuNONLUhSANfCdGSkPVx+AQxRX4Q4kJCKWkkImcIRJon0XE6G/ShGm6yN3M/iQF+FdGhGw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731189601; c=relaxed/simple;
	bh=SorAhy9ty86LD00viwQJqvRfEu8dv8sSy3YjFa1woIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EknZ+9xj6kfwBEGcqB/WLEqFqleEbcCM2gnZRC3AMEgE+GZIRnAJRnze+hkzMRZ0yLdBEpNeVbb7tVBUylA48IQjg5BjLxo4sbE44+XujkKmKnNurWNKaVpyo4Bl9dU5lpJ8W/On4ZijnnCHE8g2tTLr/0bYfeb2oURSy2IcEuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GRs9eVeg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GRs9eVeg"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9ee097a478so212107466b.2
        for <linux-security-module@vger.kernel.org>; Sat, 09 Nov 2024 13:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731189598; x=1731794398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZMpIxu5tJ4g1sGmptF0V0nSmDcf4fOLJUmZLvsgvkM=;
        b=GRs9eVegPprtpaA4OM9g22GdOC8bv3VCWNIV+lZk7Y+B+ntNJqW0J6E/4GWZpFSSul
         6+Rv1GMHTLigLzYoz/POW4DBtZUoJ5XCkfh+2GCU/M7sY1a5tqu4JeqTuMvSWOowActn
         XmxbagP0zaQIOJk015R6E+qW2xV1pK+Mi0WCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731189598; x=1731794398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZMpIxu5tJ4g1sGmptF0V0nSmDcf4fOLJUmZLvsgvkM=;
        b=izXfADPHNjPdvAh+Q1U/6iDrd8bH7kb8hoTSz66/qtpG2GrUqVQcAwqCw+bnUKrf3b
         PoFvA62Pq3NOUd1Z+vKibnYc9Gjyn3cinK5AWgkOkzXN4L1oesS/MKKCvJpgzkZMJgwy
         wX281IOlnkArCUnz3IZrnXMW0qZTrbOpsNJuPz/hamojACrwIjmJlILycOQPUWifcFKF
         kE3H/UxjpGT+7QlEHFb/SAmsyJ6lDLFhjE09wTulONzQoU0BW5FrdumEB9KO4HLz8K2O
         UlloqChZQI5sQX8lMFWj2WgpXsEEeKRY3a0RedXsCMIhLOutFPaCM8chLL3xkwR3DD8y
         vrdA==
X-Forwarded-Encrypted: i=1; AJvYcCVaq4gsI7qq/rKPDFo3prdviORRF57Fg3/C7cY3tvNM+jF/iBuVYcfm0ZmU5iwKnN3EwIww8U3FHFTTm8FRdP5cl9Ta5yA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9cYcbxb9dA3do4Q4SNVQW1IJ4OEHdLbbi2SXqv6Idj967icOA
	l1gdcWK7u4yA0i8LRcdtY/UARcd9bMMRQWgCJBWqtfvJ2EgEjgkJK8g/N7aRddq5ugZIdPlKNka
	htS8=
X-Google-Smtp-Source: AGHT+IFuu8Gt3LGlqh3HVaRWvrYBm0GbwrsQNyhtaMJCC9qRE0H+L6V8JwxCKdO9ATcImqz6wzuJNw==
X-Received: by 2002:a05:6402:234c:b0:5cb:f1d7:56ac with SMTP id 4fb4d7f45d1cf-5cf0a2fe267mr9227090a12.2.1731189597633;
        Sat, 09 Nov 2024 13:59:57 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4f09csm3468039a12.54.2024.11.09.13.59.56
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 13:59:57 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cf0810f5f9so1862991a12.0
        for <linux-security-module@vger.kernel.org>; Sat, 09 Nov 2024 13:59:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX6gI3u4CFTiFdfzbNPFVK8ZtIuqJSRB28VFEHIALY+q+ApPg/WcoED/g/ytLhZixydy5yj2HZRklpqOBimoz2Gww66DmY=@vger.kernel.org
X-Received: by 2002:a05:6402:348f:b0:5ce:b733:2ac7 with SMTP id
 4fb4d7f45d1cf-5cf0a44667bmr7719738a12.29.1731189595811; Sat, 09 Nov 2024
 13:59:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109194158.422529-1-mic@digikod.net>
In-Reply-To: <20241109194158.422529-1-mic@digikod.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 9 Nov 2024 13:59:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiUy+ixmBnJuFzTMe4yvxH6fNqu5UG-K=EKZzCAXw8pVQ@mail.gmail.com>
Message-ID: <CAHk-=wiUy+ixmBnJuFzTMe4yvxH6fNqu5UG-K=EKZzCAXw8pVQ@mail.gmail.com>
Subject: Re: [GIT PULL] Landlock fix for v6.12-rc7
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Daniel Burgener <dburgener@linux.microsoft.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 9 Nov 2024 at 11:42, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wro=
te:
>
> This PR fixes issues in the Landlock's sandboxer [...]

There were neither diffstats nor a shortlog in the pull request, so
honestly, it's not a pull request at all as far as I'm concerned.

       Linus
