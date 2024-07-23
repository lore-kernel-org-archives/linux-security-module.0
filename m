Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9E415821A
	for <linux-security-module@vger.kernel.org>; Tue, 23 Jul 2024 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759454; cv=none; b=n7kxnjpIJ8iFml+nHGVHuIqKe7Y4IB08rb6DTwmyLp9u4lxJTDnA2t4q+ONCOe0BPfSZcWHhrTHZIQ5ftrCFWIGyYz9gepvzBVOg+YKP3GdnEpFMHGNBhcIt2YTvVJTz9sMDTFPjIuUzzqWBPQV9wR4/XrVaT0sbXwvpjC15wKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759454; c=relaxed/simple;
	bh=Pp3VZCk6dq4+5Vpj+kfpnKF3kGHUtiSO1r77QnLX328=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSlhbGxFJk0uPwiiRYa5guESGc1qftGucV5suJ6exibRuInzZXvJGfCgkUwrI0WKoGQoF8xKIM2jYcZESKc+vPRmVO3vUGavdivfWTQtHKPP7bwJjxc2tjLi8EhQDmQlu3KIQq3EAsLS9r0KFii2uvBAJMZD8cKQigRcxhTlBzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JO71aRwx; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JO71aRwx"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so79413491fa.0
        for <linux-security-module@vger.kernel.org>; Tue, 23 Jul 2024 11:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721759451; x=1722364251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hbXsSOOY+gKi86u1NQNhucpEoLXztu3BNQ9K2X48C04=;
        b=JO71aRwxtFIHSsjJgZ+i/yUzBZqNRyNYYn/IOCyQGvboBq55v5B/KqX+SJwXodd1Tl
         6Y9sCw3vegck4Dw8p5tHodW1iHdNU59toxIICq9byt9I6C66mp9KwDZc8CAQox1rpDH8
         7A3Nxg/g6ZJ7AP6LTe+0ushslM1Y1K2t5gsiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721759451; x=1722364251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbXsSOOY+gKi86u1NQNhucpEoLXztu3BNQ9K2X48C04=;
        b=Zt6tvA9GjjMBEBqbknjP5Wa15/OPFe+NxiJnyDZewIb90igynBk6jntbYgHrxPSEqv
         LmQUXv3G04WPj+rD8omE2qsZ3gYIjOmKUquHeBdwNrGg2UvbezD24euJ972FER2uMQhp
         9lwZLlDdb/rwXBegBOT/iPGp6OcZV192wlDgTG7GpxOqoWeyn9qjQdo93n12GhMTmQmt
         j+extre9Tn5AR33Ehh4UuKxGUH4dM0ypUEmtDX7taNaEfV3UWWD+vzVQTYjMEayeL3wg
         gB/Q79J66KpMnAv1KbLJ/1y0V2sPil/xP/P+gNqFov4h8mEbsdEtACk6G1o6qod2SvYB
         uQag==
X-Forwarded-Encrypted: i=1; AJvYcCX7rx1yNxZ9t7NPzo5SQlhEqQF8oGQJ/tgZiwQnXJOwGfHLB07pnrPJcz/rJfT+PgCChXFTV38Jv7DBi+30SvzDMYlTygwfd9b5U/00GiVKKLpUhHVV
X-Gm-Message-State: AOJu0YwHzEmvmmiUC2/wRjJE6SC6slSmgDETj1bq6LceqoGurruaPuHr
	bokgbuv7Ucd4YsfrApthxEOUIgkjjmXAfaBvr863ZhSwF6CxFUUJrAV5P5wS4Rk0kEoD0uMA1uM
	EBq0=
X-Google-Smtp-Source: AGHT+IGxkwQiXW/F38eCHYteZdutPjcBePc8+qk4GmYs9mMaQSd/DRsv8v2BHaDFEMXt0Pl3uj2J5A==
X-Received: by 2002:a2e:908b:0:b0:2ec:56d1:f28 with SMTP id 38308e7fff4ca-2f02b7472c3mr4977951fa.26.1721759450886;
        Tue, 23 Jul 2024 11:30:50 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f0253eefd5sm2535291fa.46.2024.07.23.11.30.48
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 11:30:49 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52f025bc147so3855341e87.3
        for <linux-security-module@vger.kernel.org>; Tue, 23 Jul 2024 11:30:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXiahK5OgIH1k0fDDsIKRu98g4HJUZLC5tpGtzCGcBS2pyIVvxFLw97MzS51frRX+5fNEYMSm+z8+tr2JeoP0aE9xaio6fPpnmMXOakF6RRz2c5K1wJ
X-Received: by 2002:a05:6512:3d26:b0:516:d219:3779 with SMTP id
 2adb3069b0e04-52fcda6533cmr227963e87.58.1721759448531; Tue, 23 Jul 2024
 11:30:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723171753.739971-1-adrian.ratiu@collabora.com>
In-Reply-To: <20240723171753.739971-1-adrian.ratiu@collabora.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Jul 2024 11:30:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJL59WxvyHOuz2ChW+Vi1PTRKJ+w+9E8d1f4QZs9UFcg@mail.gmail.com>
Message-ID: <CAHk-=wiJL59WxvyHOuz2ChW+Vi1PTRKJ+w+9E8d1f4QZs9UFcg@mail.gmail.com>
Subject: Re: [PATCH] proc: add config & param to block forcing mem writes
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	kernel@collabora.com, gbiv@google.com, inglorion@google.com, 
	ajordanr@google.com, Doug Anderson <dianders@chromium.org>, Jeff Xu <jeffxu@google.com>, 
	Jann Horn <jannh@google.com>, Kees Cook <kees@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 10:18, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>
> This adds a Kconfig option and boot param to allow removing
> the FOLL_FORCE flag from /proc/pid/mem write calls because
> it can be abused.

Ack, this looks much simpler.

That said, I think this can be prettied up some more:

> +enum proc_mem_force_state {
> +       PROC_MEM_FORCE_ALWAYS,
> +       PROC_MEM_FORCE_PTRACE,
> +       PROC_MEM_FORCE_NEVER
> +};
> +
> +#if defined(CONFIG_PROC_MEM_ALWAYS_FORCE)
> +static enum proc_mem_force_state proc_mem_force_override __ro_after_init = PROC_MEM_FORCE_ALWAYS;
> +#elif defined(CONFIG_PROC_MEM_FORCE_PTRACE)
> +static enum proc_mem_force_state proc_mem_force_override __ro_after_init = PROC_MEM_FORCE_PTRACE;
> +#else
> +static enum proc_mem_force_state proc_mem_force_override __ro_after_init = PROC_MEM_FORCE_NEVER;
> +#endif

I think instead of that forest of #if defined(), we can just do

  enum proc_mem_force {
        PROC_MEM_FORCE_ALWAYS,
        PROC_MEM_FORCE_PTRACE,
        PROC_MEM_FORCE_NEVER
  };

  static enum proc_mem_force proc_mem_force_override __ro_after_init =
      IS_ENABLED(CONFIG_PROC_MEM_ALWAYS_FORCE) ? PROC_MEM_FORCE_ALWAYS :
      IS_ENABLED(CONFIG_PROC_MEM_FORCE_PTRACE) ? PROC_MEM_FORCE_PTRACE :
      PROC_MEM_FORCE_NEVER;

I also really thought we had some parser helper for this pattern:

> +static int __init early_proc_mem_force_override(char *buf)
> +{
> +       if (!buf)
> +               return -EINVAL;
> +
> +       if (strcmp(buf, "always") == 0) {
> +               proc_mem_force_override = PROC_MEM_FORCE_ALWAYS;
 ....

but it turns out we only really "officially" have it for filesystem
superblock parsing.

Oh well. We could do

  #include <linux/fs_parser.h>
 ...
  struct constant_table proc_mem_force_table[] {
        { "ptrace", PROC_MEM_FORCE_PTRACE },
        { "never", PROC_MEM_FORCE_NEVER },
        { }
  };
  ...
  proc_mem_force_override = lookup_constant(
        proc_mem_force_table, buf, PROC_MEM_FORCE_NEVER);

but while that looks a bit prettier, the whole "fs_parser.h" thing is
admittedly odd.

Anyway, I think the patch is ok, although I also happen to think it
could be a bit prettier.

            Linus
