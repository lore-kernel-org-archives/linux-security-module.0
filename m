Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7415717C7BD
	for <linux-security-module@vger.kernel.org>; Tue, 13 Aug 2024 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723588301; cv=none; b=aFrOZpuYEJtn2LvSbqpKLH2LqngoCjbcbg/F1vxIl5zbVRxfqDIahPiMwb00uRZXlA7FW3Te2I0ec+OUpM7+MCxNBu2jZuJqKdehL8sPMfXaR7hQJhnQ6W27amymOKGMGnyOWxnO5DUZVOeSYFBtJWuPhzy9jUEXlAEfkHBzFvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723588301; c=relaxed/simple;
	bh=PjDal07NYOKBjkEkz7/rPrI2L3lDW5tzH1NRX7vsX+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLNwgaR6zyAHOYr2gkieInoOn7RHpiNXM+bbHk6tWzVoLc2HusXyt/KfE1GW/eOFsxp6Ncy1VeNI2jcEZ5cc4bdwJW9vNDP4sGRUcymUjSObqCVeDZbbhczY9ObmRYEU5B7V4kaTx0mGIkk8lbltpy1Lo/Ht2MdtiFz/CU1Bo+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D+j9ex3p; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D+j9ex3p"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4929f9a28c7so2073799137.1
        for <linux-security-module@vger.kernel.org>; Tue, 13 Aug 2024 15:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723588298; x=1724193098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjDal07NYOKBjkEkz7/rPrI2L3lDW5tzH1NRX7vsX+E=;
        b=D+j9ex3pJWeRWjq0NBYRAHJ12rIjeopGts0r0GTgjexMWWliauckLTij+u2/DtqaWn
         IPQXwFUz1MUSigu0oPStUaFqzldIUc6ZItrjzNZ/XMk8CJsMoIBgaw6AdgZAnuJ74Mif
         HxjrmmUY7YEzRN4Age1V1a/oYDZTMq+Ml6HWBArv3qWfb6CB9PbAegBWfG+qzwhxG1RQ
         8SxkWeeBd79wsXNDRQvBmgxkybLm6z0e9rqqFzohuML5RHyHVhs4s4sDyHpNo2DNY+wi
         +Uz/c6UKDHSB47b66QDOI2Pe1KXWo0XtrMjFe0TmfKB0ldc351LTEsWBPcRG8r1WJ/Bt
         079Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723588298; x=1724193098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjDal07NYOKBjkEkz7/rPrI2L3lDW5tzH1NRX7vsX+E=;
        b=vCZP0C+fTHMID7h8OOVkYTLEm/smu+Gf4GoJJMpwDaZgnqb5Ec+5ytZY+J2zBBktQH
         c84gSwbyjP38PQymg//Z+v6k1FRW2+kAHcDGOCKUmh9Lkrokxv6sRRF/mHpCguhF7TC/
         QDMFq1ptE/Qs1JpA5ZsHZgP2Aomk63s8fFqL7eGfyFT7S5qzL4omkUELWM64Cabrcm7E
         w3aeHNWknuQVFmcGuGApHZuQgEqcqpaf79kRuMxikK1cLmPiXHqHX7CfMkruvbX4mAeM
         DtCG+H7DID9hTwdJp0A2ihVJFk2LxOxgXvlNX86sWhasJ7sZvjtEJ5+IiojFVHbEtImI
         x6AA==
X-Forwarded-Encrypted: i=1; AJvYcCX4BwrCGmuXBZ+dANZPlX13NwkQcD+Ngf4yvHX87BWPUzVa8YDgJ502LCOYue/KgnY+J0t+sz7DZE9NNZYN65h3bYsaSJ0RVvUjPXk7+OYTlbDIxuIK
X-Gm-Message-State: AOJu0YxM8F4BVYD9bck1dkx1au/1l4bl7TnecedwFKuyauL6E5l+AehL
	lLoLQhtuzIhJjsUkPpjgzaWtrtPt/nY+d7Fo7VV7u/6RAUqC3vAsf6guFbelprVvI4rbLQrKnYM
	N3by3OldyJOmcOl1nvTQLfV7HSgJeK/kaIhox
X-Google-Smtp-Source: AGHT+IH/QraxU2fjWjOPkx0WDZKuaY29L3Zen/pzf+3bC1KTX13QSkaN1GEjq4vqJeNmusG+MLJVL3jxUBZoAMXwy+8=
X-Received: by 2002:a05:6102:c04:b0:493:b4b5:4850 with SMTP id
 ada2fe7eead31-497599e9a02mr915097137.31.1723588298200; Tue, 13 Aug 2024
 15:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812022933.69850-1-laoar.shao@gmail.com> <20240812022933.69850-8-laoar.shao@gmail.com>
 <hbjxkyhugi27mbrj5zo2thfdg2gotz6syz6qoeows6l6qwbzkt@c3yb26z4pn62>
In-Reply-To: <hbjxkyhugi27mbrj5zo2thfdg2gotz6syz6qoeows6l6qwbzkt@c3yb26z4pn62>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 13 Aug 2024 15:31:26 -0700
Message-ID: <CAFhGd8oBmBVooQha7EB+_wenO8TfOjqJsZAzgHLuDUSYmwxy=w@mail.gmail.com>
Subject: Re: [PATCH v6 7/9] tracing: Replace strncpy() with strscpy()
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	ebiederm@xmission.com, alexei.starovoitov@gmail.com, rostedt@goodmis.org, 
	catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 3:19=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> Hi,
>
> On Mon, Aug 12, 2024 at 10:29:31AM GMT, Yafang Shao wrote:
> > Using strscpy() to read the task comm ensures that the name is
> > always NUL-terminated, regardless of the source string. This approach a=
lso
> > facilitates future extensions to the task comm.
>
> Thanks for sending patches replacing str{n}cpy's!
>
> I believe there's at least two more instances of strncpy in trace.c as
> well as in trace_events_hist.c (for a grand total of 6 instances in the
> files you've touched in this specific patch).
>
> It'd be great if you could replace those instances in this patch as well =
:>)
>
> This would help greatly with [1].
>

I just saw that Jinjie Ruan sent replacements for these strncpy's too
and tracked down and replaced an instance of strscpy() that was
present in trace.c but was moved to trace_sched_switch.c during a
refactor.

They even used the new 2-argument strscpy which is pretty neat.

See their patch here:
https://lore.kernel.org/all/20240731075058.617588-1-ruanjinjie@huawei.com/

> Link: https://github.com/KSPP/linux/issues/90 [1]
> Link: https://lore.kernel.org/all/CAHk-=3DwhWtUC-AjmGJveAETKOMeMFSTwKwu99=
v7+b6AyHMmaDFA@mail.gmail.com/ [2]
>
> Thanks
> Justin
