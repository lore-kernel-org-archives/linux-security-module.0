Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E316DC35
	for <linux-security-module@vger.kernel.org>; Mon,  5 Aug 2024 21:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722893325; cv=none; b=V9Y3y9a1sPKUQXS5YU5z4W/lz04QpLJnFyO6wKVyW+dp2m2MP4845CjocrjJJt/TikVrzd3ujRAj8Z/9lW7ITuhuHf/vRj5XhTLGxh5d4aUwvqB4uxWOH/wXByX5BUwWMuK8G6gKNSPncqebbTd5aVXmPjD/ILY9B6rIY0mmkyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722893325; c=relaxed/simple;
	bh=CTTjcSVZh00GG8bK8bn079xIUwIcu3ks1xC9HUn/WHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DD2t3tCsKDHxCRxHXNNtSUhonHdk0xf0v9KuispaYoz28HVtKqrJd+GtfxVFclWIoZzivLMZcs0BG8nGBN6OIdRiAsmOI7b4GOzt1i+pBbD1r+aFx7hO0EauWKPdPBH0eWnoBF4D2cDazT+xB4uKDDwphw/EHKXtdotrc/6IIvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PPje62WG; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PPje62WG"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ef2cce8be8so132963521fa.1
        for <linux-security-module@vger.kernel.org>; Mon, 05 Aug 2024 14:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722893322; x=1723498122; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4JmhoGoeqp0EkHzxnqjsByi1+fgV+qGizB/Udaf1KjI=;
        b=PPje62WGrts++kDkvapfmbGRkCHCXwVCPEndaKvM2Yji4MoLO+TZ5qZDLH5qPme/Kb
         mh5H0kTNjo0le8lSwaew+RU5vSEJwobkM111fW5gJkpJqXl5+UF55YTZJphAxcdj6Uuz
         eSK8/yOHbwPDM0xpsJIN9ENH0s4tWziMLtYHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722893322; x=1723498122;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JmhoGoeqp0EkHzxnqjsByi1+fgV+qGizB/Udaf1KjI=;
        b=vJOiwUovR5RYI27cWuBk1oeq9GS6c+wzkFVydnHF8oS8t6EXftfZ8e2RoaBrPG5Djq
         lOg0C7/hsc3RrzW2E1Ijs90OnMglHZ8MYckG9eEdNehXjx0ONqlirHyd5Jr/swPM8j8J
         NS9Rp8VmqdF1rIkgLrW95aY8h7RNOzazl8DwG5ZJaN8R/jvGxv93E6aWZY6yit2K01k/
         FvcLtEQ2RmN5UV9XaQ0IFHFcx3AM2hsDWT3MkBYdMAGPau0znKioq//hFqOl9yM/dZE+
         vN+04Nv1vVx7aH+VBt8dFiNrveg+jySX3PP/aKd69qDCkKWVslixkKCU/8TdypDKRh9v
         YKfA==
X-Forwarded-Encrypted: i=1; AJvYcCWQInfXkedFH99hvFQlbz4ScJqa0j8IOvbRucL8lHHnz29/wRYt9HOoTk0Mjzn8lON6JpgQ4Uhcr4aksuONfiUEhY8Rm4xCpH9Wo15aM5iW4hUeI0/r
X-Gm-Message-State: AOJu0YxMyERet0tPlv+z+vbw1Yfeh8PCItu3GTw/0yXyQzJDPuO+MvcG
	VQiEghIJFoPINgCQHsadrkUvDG5mthYan17lvusFSR0/AaUYskfjaF0UjPRtX6CBRAvc4ggt18y
	YTmVrJA==
X-Google-Smtp-Source: AGHT+IHC8quG057eIC05dqEbYe24c2pgHdVRoy5/bV1VfmTxwlA+aOvsF8r37s0a5xdnCYf5mGw9OQ==
X-Received: by 2002:a2e:8609:0:b0:2ef:2332:5e63 with SMTP id 38308e7fff4ca-2f15aac10f8mr104242591fa.23.1722893321608;
        Mon, 05 Aug 2024 14:28:41 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5babb4ec55csm2957846a12.47.2024.08.05.14.28.39
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 14:28:39 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5b01af9b0c9so10095236a12.3
        for <linux-security-module@vger.kernel.org>; Mon, 05 Aug 2024 14:28:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqv8muq0Q+6Q40geHvi5VXf0MryYGWTR410OxvtXt7UR2raAtysuMWw9++HgXvfC0TweY1vo0QOPHrzIQAdQTGgGqzfJb+0qAEUuDRNJEwEHwV0sGt
X-Received: by 2002:aa7:df97:0:b0:5af:758a:6934 with SMTP id
 4fb4d7f45d1cf-5b7f0fc7f1amr8956337a12.0.1722893319128; Mon, 05 Aug 2024
 14:28:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804075619.20804-1-laoar.shao@gmail.com>
In-Reply-To: <20240804075619.20804-1-laoar.shao@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 14:28:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com>
Message-ID: <CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Improve the copy of task comm
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Aug 2024 at 00:56, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> There is a BUILD_BUG_ON() inside get_task_comm(), so when you use
> get_task_comm(), it implies that the BUILD_BUG_ON() is necessary.

Let's just remove that silly BUILD_BUG_ON(). I don't think it adds any
value, and honestly, it really only makes this patch-series uglier
when reasonable uses suddenly pointlessly need that double-underscore
version..

So let's aim at

 (a) documenting that the last byte in 'tsk->comm{}' is always
guaranteed to be NUL, so that the thing can always just be treated as
a string. Yes, it may change under us, but as long as we know there is
always a stable NUL there *somewhere*, we really really don't care.

 (b) removing __get_task_comm() entirely, and replacing it with a
plain 'str*cpy*()' functions

The whole (a) thing is a requirement anyway, since the *bulk* of
tsk->comm really just seems to be various '%s' things in printk
strings etc.

And once we just admit that we can use the string functions, all the
get_task_comm() stuff is just unnecessary.

And yes, some people may want to use the strscpy_pad() function
because they want to fill the whole destination buffer. But that's
entirely about the *destination* use, not the tsk->comm[] source, so
it has nothing to do with any kind of "get_task_comm()" logic, and it
was always wrong to care about the buffer sizes magically matching.

Hmm?

                Linus
