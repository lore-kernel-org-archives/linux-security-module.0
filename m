Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEDF13C8F2
	for <linux-security-module@vger.kernel.org>; Mon,  3 Jun 2024 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717453451; cv=none; b=WS9mNopUuD/Bcnu8B/PC2GUfRXIBSv+YATnevzD20+6R5q2DgZfCCdcl5yqDcK79X6Nxnzcz0kI6AzawzBbzV0ykcYrIao3hjhdRGbvmUCqJ56PYFl3AkVkXE8g8Cd6rH2dDuUmrdFsYO/GZIdvIjtCDEgezn2ayf9lDKgG61kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717453451; c=relaxed/simple;
	bh=AFfU/PEC+zuhNdQ2tMeUL2Lz6Nhx2hQNDlZEumLFtHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0m9T/FwNcqy0R/uPVYl9INutx4xOAafrS2NDEGjcPaD9YPK+QO1tfpVayRHFNnOoeMTniPjs1njJnT5P7OMq4KVgzb3kq9a5nKGa4D/H6SpnARQhdQwcbUoV+sNBsmq5bPECuAilgyWAKmdf+w9iDHV/gk7NsL7oC0R09fpfag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NvlNM94t; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NvlNM94t"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a626919d19dso877475166b.0
        for <linux-security-module@vger.kernel.org>; Mon, 03 Jun 2024 15:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717453447; x=1718058247; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vUfCTj7RhneZiyZGwU4My8ep0xDaKOVngko5RyaH/ts=;
        b=NvlNM94t6sll7sF2XotPG849RkvwqA2mzJ7yLghmdoWCe/+h99vmOGCGjvSseh3s6r
         S/GfB/Qh0OaiI3bRW58c5ghzkxxojQrnJFc064N7uvD/XG7B0PItbqmuoTwHykQXxJCr
         +nEcQxl8fJ8V30NsnGDoJNRo9gdlJTmDzbEkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717453447; x=1718058247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUfCTj7RhneZiyZGwU4My8ep0xDaKOVngko5RyaH/ts=;
        b=U9F5xuDPGG2/Lj/Ebhm5ria+e4xpFr1yUvefqBjN7kJh7uB157J+yrJKZgeL9A7w19
         fnokoQB6udZ4ZmJ67tb3PB7Jti4IEK8aVaBIS2/b4+mQkEZ3a2+u1uOqYhxYHxCZ+08C
         aHDf2ZXn7m3/hL2QQceUb53wHblR1Qb2+qXQxjtsbM0pgCOElK6uPC/ERFVvfCpigDGu
         4hypY1TKpgpBEuO2/jFCAU8pCvGxuXMHqoQhzjqYTGfMICsuaQLjnEBFcCy85qaKkG80
         D6A4g1+lrHA895/4iRE0Ta+XhtDT7DyQoU1s9J7LX6vF7JdQMOus+FCEPRiG+me2Z/0O
         UUrw==
X-Forwarded-Encrypted: i=1; AJvYcCVmhXUwKBYOTyvx2JcyHFX6mGYjuXMlbGYLJz3gPGha/eaY/eV++CBQWHTAMZdHc2l969ZPSDpxlp3Stn+9XD+ryMhTf/IbOIETo0O+6jxQIu0O9eDG
X-Gm-Message-State: AOJu0YyRm5pnmNRtMZm0qBcttkq08xA2E4O6+Mt6ao8dhC+G6bO3TfM9
	MMfDc/novJIolW7qu+9Ri0Qhqki80n/d4LNHiMo5ssK5sJeV8MmA580wkGwuQWKuulUlly6wlfB
	+OQUj9Q==
X-Google-Smtp-Source: AGHT+IEysby9aiBGMqojzvAdj5eNGFeqITdtND+iEmNU3/BCk0Z2K0Was1BFwN/3CuCdiSow9vU2qQ==
X-Received: by 2002:a17:906:e293:b0:a68:b073:14a5 with SMTP id a640c23a62f3a-a695425e2e8mr73980566b.9.1717453447121;
        Mon, 03 Jun 2024 15:24:07 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b991b1sm6039221a12.5.2024.06.03.15.24.05
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 15:24:05 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a68ca4d6545so380648566b.0
        for <linux-security-module@vger.kernel.org>; Mon, 03 Jun 2024 15:24:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5z9GNwGf2TpEZmMH6mzosg/mQAgm0Bf13NwugoJD6J+FCJC+oJBERyd4r79F08pLMAHCJaRkXdHoO0dHz2/e3j21usH7kf6Z16xadzOlYCiwQu+6e
X-Received: by 2002:a17:906:d217:b0:a62:49ae:cd7b with SMTP id
 a640c23a62f3a-a69543e118emr67505166b.24.1717453445163; Mon, 03 Jun 2024
 15:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-3-laoar.shao@gmail.com>
 <20240603172008.19ba98ff@gandalf.local.home> <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
 <20240603181943.09a539aa@gandalf.local.home>
In-Reply-To: <20240603181943.09a539aa@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Jun 2024 15:23:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgDWUpz2LG5KEztbg-S87N9GjPf5Tv2CVFbxKJJ0uwfSQ@mail.gmail.com>
Message-ID: <CAHk-=wgDWUpz2LG5KEztbg-S87N9GjPf5Tv2CVFbxKJJ0uwfSQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] tracing: Replace memcpy() with __get_task_comm()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 15:18, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The logic behind __string() and __assign_str() will always add a NUL
> character.

Ok. But then you still end up with the issue that now the profiles are
different, and you have a 8-byte pointer to dynamically allocated
memory instead of just the simpler comm[TASK_COMM_LEN].

Is that actually a good idea for tracing?

We're trying to fix the core code to be cleaner for places that may
actually *care* (like 'ps').

Would we really want to touch this part of tracing?

            Linus
