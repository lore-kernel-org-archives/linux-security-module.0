Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A30195
	for <linux-security-module@vger.kernel.org>; Fri, 23 Aug 2024 00:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724371566; cv=none; b=Wne6DQyMMCQAhaQyh1WX3DYcO9s8jW1UCgS8GN4l0W19ST1TC82bfyfmQdPa5bAcMQtDjyXy0mZKpvBT7CDf+GMhCZQcFVJF3ADqaqyUs4nY8yrNPqVdt0Urb3BNN1qpSt30vCblTfeXsIlwNrEYSV4KTwOe0L29dsrRFAeYadA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724371566; c=relaxed/simple;
	bh=4iv64pRtCw7dW8hTYbxzB/BoF83GDOhTtw/b5ukR+O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6p+g7qtwxxIKhZg2k0NQjtXewiwPh29K95iF4oI2nuY9OK9oEDZSlwJ6eaCJZywzgIHTrfllepIRBJMC30JH6sSFl9U8X8RsR+aTd/ES/2D9V0HxQ18Z8ggo+7gakmTcQDAknkrlsCOhcRA6LcXHafApDhuXs0iw4KpkA6+uIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gMxmBpXG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gMxmBpXG"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a868b739cd9so178888966b.2
        for <linux-security-module@vger.kernel.org>; Thu, 22 Aug 2024 17:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724371561; x=1724976361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G2PT7YMor9FcgwOjC3cZXMnMxjtj8zbdFSuetCOJ+xA=;
        b=gMxmBpXGsZMhwERbfNd37JAcsZCeOUu1mxqS7VWbQjHvugFXYZJccq9uq033IU379u
         dk7f+SeDbzTy5nTv9sok7ewsT6RXv6iEOcRam2BZrvLao/iki5TSN6ajcII+leqn4/5z
         zGzAie9XQUsbAsKjVQ1ajb1dgLwrQ98vm/DvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724371561; x=1724976361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2PT7YMor9FcgwOjC3cZXMnMxjtj8zbdFSuetCOJ+xA=;
        b=F9t8KuY+vJFrB6zH4Kit6BCoxbiLi3urYvUuDhxt6vLTvoWr0n/FUfIsM0lSC05+Iq
         Mi7gWk4vOyaCBpppKEJ6p1vbQHx26ns5kNiVR9NAK0R5MZN0HbI+gt4HpCQu1VEO4qlT
         4WLPshJdLzqWTUnZ9joZKX62SBwxuAduIF73R0WIupbNTQB8vfxW1TdLe/hdRN9Ilb4v
         YTBZuTxHue9Xs0883mopnYDJrM9R7pXZI8xOwFO65rJwCT/c6W0XeQbdCzG2fd3vIgMk
         MnCQcZR30M236Zu6uyrBwJ2KypBcFW2QqkcCFy8ePl6Y4wGw4+G7nCBG6aWJQZ3YEBWA
         6llQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6n08S4dn4lO8ZPvgqtAsFEklbR+GiA2rhorWb74KKnwGcN0l3IG8kMpqZIisxppd3Hzot+TIrT5rIBwXttos5xbpf2/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRhOrLqlPb4yyTYVgZJO8sgChrS8Ln7FPVCruTUrUoa3w/9OfD
	O+P+i90EL7uV3vcZPpuU5PMYIulrkIjaNC8qgvAp9/HgCsKjeA58ptwaRQamVnUS21/BfO3sRc6
	iWa7gGQ==
X-Google-Smtp-Source: AGHT+IGwNQ6u+0FJCE1uT4oVDxDJ9VaeuIdgsCBMv1X3cd0hgA3VF5BN14fW2oqMmDvmX1PvX5WbMQ==
X-Received: by 2002:a17:907:7ea5:b0:a7a:a7b8:adae with SMTP id a640c23a62f3a-a86a5189e00mr34255166b.4.1724371560792;
        Thu, 22 Aug 2024 17:06:00 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f222b23sm183357766b.19.2024.08.22.17.06.00
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 17:06:00 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bed83487aeso1643095a12.2
        for <linux-security-module@vger.kernel.org>; Thu, 22 Aug 2024 17:06:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUpTaOZSYFCSZItsW5MKXJd1kEb3C2D9Y2+0uArbq8Wy+nwF/qWr80WxYmvHgDnPJlzui3I90OeZPGPVneDQk8mcm3/2JU=@vger.kernel.org
X-Received: by 2002:aa7:c68e:0:b0:5bf:17f:4b7b with SMTP id
 4fb4d7f45d1cf-5c0891b21aemr159924a12.32.1724371559743; Thu, 22 Aug 2024
 17:05:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822131542.785546-1-mjguzik@gmail.com>
In-Reply-To: <20240822131542.785546-1-mjguzik@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Aug 2024 08:05:43 +0800
X-Gmail-Original-Message-ID: <CAHk-=wj-UanKTT-NZKLVjK3mgQsC0Ptv8mK8AM7LfZhj2dVCUA@mail.gmail.com>
Message-ID: <CAHk-=wj-UanKTT-NZKLVjK3mgQsC0Ptv8mK8AM7LfZhj2dVCUA@mail.gmail.com>
Subject: Re: [RESEND PATCH] cred: separate the refcount from frequently read fields
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 21:15, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> The refcount shares the cacheline with uid, gid and other frequently
> read fields.

So moving the refcount around looks sensible, but I don't see why you
moved 'non_rcu' away from the rcu head union.

Isn't 'non_rcu' accessed exactly when the refcount is accessed too? So
putting it in the same cacheline with ->usage would seem to make
sense, and you literally moved the RCU head there.

Why not move it as a union, and keep the non-rcu bit with the RCU head?

Yes, it is rarely actually written to and as such can be "mostly
read-only", but since it is both read and written next to refcounts,
why do that?

Did I miss some common use?

               Linus
