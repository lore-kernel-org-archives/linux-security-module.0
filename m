Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2BF39FF7
	for <linux-security-module@vger.kernel.org>; Sat, 20 Apr 2024 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713636372; cv=none; b=fELA0NFkZdFBKBDsOh0uWC+DEUQIvWKjmGbBBzconwfhlZSL3zY7ZS9VhnWVo/bePOX2d6EUXQEuuX0se+bB1ocywqZeI2u9A05TrC+Cy+GsCahemNd7vp8nmobZiUWqLFejxLJATF/fjWx6BiMiNJbGqr3fd+Y9zwpdk6bqjnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713636372; c=relaxed/simple;
	bh=BlUmaU5cCzdfHYaIDu1dOY26l+Y9HZW2UwF8EAjxQ3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjI2vgZrHbOi8iBAm6gdOGfC9hG3BdffBNj74zwB4UdKIIVm13gez5kS2yHv5D/FAIGoBnc6h2dOv65SR0picS4vgsgvtKJO4htbAY2VdoB8+PWwM0+nec4lBrDkJDkVEUoG6R6IFLyD7Ihs1Sw3p0MIoLWm6w84Okb190WUCYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hjgGdUu3; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hjgGdUu3"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so4037096e87.2
        for <linux-security-module@vger.kernel.org>; Sat, 20 Apr 2024 11:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713636369; x=1714241169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9q4d+5HJT9JoCSnjfVAkQZ3NFNLdknjcESdIWM7gPdU=;
        b=hjgGdUu3beaYsUZ9BCmAGD3/1ekEG/+7InKyG8F/b0NHMBCwcuqKW2hXFWn7onKJDI
         J4FNg91RcZIABf9HN8WEuMyMn/1BM5jnOKUVNKY/TmMBktOHX2uezqlqENsOHoAiDdPe
         8mzsNd/0ckAuS4E1eG3QuVRKvnFQZgCEtM4Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713636369; x=1714241169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9q4d+5HJT9JoCSnjfVAkQZ3NFNLdknjcESdIWM7gPdU=;
        b=GYnp171tFAPdv0t5UwQ5vCv7qyJRBnG8hlTc13jrWgGBNEntC5jEQUdqMc5ZKgl4rM
         8Y0gXhLOqU/7vL5olJg56ssM6ZDT6NrlzDS1Zs+JUZNlsSimltTZKohzDwpE70u+1S6i
         p13PekAAM+WBUjFjpWxOoo7DnQA1DUPWBuf7nvfuJBzXekh+5+XrXpNTkUeCJLKqlets
         eHcDUTTLa+9RJy6T+jOFGSttHexlixbe2jMwbf7UJHBGOflPc6MhmA/OXPfrpOArNIk1
         PVb8XPn/7dhPp8RhbWrBZbqU64u6EWs7BTuZFshhHB7T0oUNf/b+VHzsjnrj9fPu+kQ2
         Ei2g==
X-Forwarded-Encrypted: i=1; AJvYcCVEJLLM7afqlMZmWVvXDcCEnqwOkqPZMNgZTtnCdfPcnZ/eA5poV2p6S7e/TcsbU5moSrwYmyBT7HawUyuR+DzjvVaqCHG7Ad5sD53gc6U9RKa38mnj
X-Gm-Message-State: AOJu0YxFfJnUVMBcbcvpaxlCpjhj5afUxlH7NbjxGqoujV5RKx2y07vx
	SFlJENPxieSNJihzZArAWqUT26EkM4CLrDVLnTGDrvrx/1nFvcsMvGi/tyoDkcT//t3tXWqe4Iu
	FBkps4Q==
X-Google-Smtp-Source: AGHT+IF03rpO/XtcCj9Gm0KUUKSoPL9BPXH1m0CpopMpi4ELQ0MpVBzR7sK2YdeYOctsk8pfQ0v3/Q==
X-Received: by 2002:ac2:5990:0:b0:519:1503:9566 with SMTP id w16-20020ac25990000000b0051915039566mr3235856lfn.56.1713636368728;
        Sat, 20 Apr 2024 11:06:08 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id i7-20020a0565123e0700b0051b00322bc0sm52821lfv.151.2024.04.20.11.05.52
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 11:06:08 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51ae315bb20so870284e87.1
        for <linux-security-module@vger.kernel.org>; Sat, 20 Apr 2024 11:05:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXe/eS5U0W8WVvbIH1D2HaJeIW0FjkWfFEttBOzr+uV43iYATW1t1dEinc4cJoC2WDxK8d3qxzBQcH/hWcIpXO63NUFWjs9FRMvczLAAgFfVag6TgVq
X-Received: by 2002:a05:6512:78e:b0:51a:bebb:690c with SMTP id
 x14-20020a056512078e00b0051abebb690cmr2860885lfr.12.1713636351915; Sat, 20
 Apr 2024 11:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e696e720-0cd3-4505-8469-a94815b39467@I-love.SAKURA.ne.jp>
 <CAHk-=wjEZvnn51dhhLqBKUd=cuFhbYA47_OyfUOPB-0zKToL7Q@mail.gmail.com> <CAHk-=wjzqaqcicTtWfBtXyytJs1nqjJNved2JFsLVsVLYgVkuQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjzqaqcicTtWfBtXyytJs1nqjJNved2JFsLVsVLYgVkuQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 20 Apr 2024 11:05:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjW3PdOZ7PJ+RHUKRc8SqQhcWXCACOvmwBkKUKABHKqwg@mail.gmail.com>
Message-ID: <CAHk-=wjW3PdOZ7PJ+RHUKRc8SqQhcWXCACOvmwBkKUKABHKqwg@mail.gmail.com>
Subject: Re: [PATCH v2] tty: n_gsm: restrict tty devices to attach
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Starke, Daniel" <daniel.starke@siemens.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Apr 2024 at 11:02, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Most other normal tty devices just expect ->write() to be called in
> normal process context, so if we do a line discipline flag, it would
                                        ^^^^^^^^^^^^^^^^^^^^
> have to be something like "I'm ok with being called with interrupts
> disabled", and then the n_gsm ->open function would just check that.

Not line discipline - it would be a 'struct tty_operations' flag
saying 'my ->write() function is ok with atomic context".

             Linus
