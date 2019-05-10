Return-Path: <SRS0=PrzU=TK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34567C04A6B
	for <linux-security-module@archiver.kernel.org>; Fri, 10 May 2019 16:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C842070D
	for <linux-security-module@archiver.kernel.org>; Fri, 10 May 2019 16:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557507283;
	bh=v0k+j0EGTqKfLCN/sWjZmDwFvLdo5sw2+VPrvgvNA+w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t/XOwKetQ3mw+5p77ohzeUxiexY8XHRKnUA2im1qR7H7svs9gZbcPv7HtfPufPVnO
	 10zyO7UF31uGOgfet/c9n6SZJrCyyUucagjGSF9ZOgf7lCGz3Kakm97fYBYLQMgGGH
	 tLY8DbRY+Bub5VeXR85SwpZBgLaAZ0KR/LAqU5IA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfEJQym (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 May 2019 12:54:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36055 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbfEJQym (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 May 2019 12:54:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id y10so4646585lfl.3
        for <linux-security-module@vger.kernel.org>; Fri, 10 May 2019 09:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=teyAXz9aykZ29Ynkf0/pUzS9u8QM+umNpzpW+ZToHRw=;
        b=XIh8EA8MUYC9ZfQwd4nS42dAFIXehXTQ9ExQgOBW9Yj8aHIlhEEu/yMn8NTgvGKXZ0
         fU644LXBUDs5/0+b+VttXiFOMpxLSZuHtF4ogmRVB5AQgpjd4hZjmkRMD9L0UzXldHT+
         EOGtlg03/sgjANIzj9BsTcPE/HDdhtMc6frng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=teyAXz9aykZ29Ynkf0/pUzS9u8QM+umNpzpW+ZToHRw=;
        b=REgTsQD58IAyOBIMcbQdoclceUhZelDatrB4nGnC4sX1YJcd3hLUGh/2K+0UqM1aCs
         p24BeuFUVfTGeEPiixt+cYgFNP0XtHNcVCt7/7mVZdA6ygbA6rAFzDu6fzDhQrQ0PNJK
         qtGO34FOa0K8sotvI7zs+s9Ce4ODnpsAQc9C5fetktj1mGrVxsYVpD7/vFGX6TNn5GUs
         WeCBGgbji/bK0A2fF5h0GrSKW4SBhJJc1/HYAW/uCiUL4RJ5m0tnqoKrp2KHP2hVhAUw
         Knayi8AviB2FuVwrnALVCOqUYjxQqFZtQkCXjMrW4kZCyTQi/Y54siYyHMmfFQG9fyaR
         D4zQ==
X-Gm-Message-State: APjAAAXFiSeN6+3m6MZMgUZCWqrLzxADeN921VIu5E3mrsxNDP/koXiE
        jCJ7DPIfE6OS3I+8OmUkmwb2vUVCBmA=
X-Google-Smtp-Source: APXvYqyU+i3RQk2nQY1KEqvL2BQ4nmezdpo/zfXvsO90j5Lf1w0kABnbmxUD+bgADTPdvU1uk6WU7Q==
X-Received: by 2002:a19:a8c8:: with SMTP id r191mr6649333lfe.85.1557507280017;
        Fri, 10 May 2019 09:54:40 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id v20sm1619959lfe.11.2019.05.10.09.54.38
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 09:54:39 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id d15so5671609ljc.7
        for <linux-security-module@vger.kernel.org>; Fri, 10 May 2019 09:54:38 -0700 (PDT)
X-Received: by 2002:a2e:9044:: with SMTP id n4mr6483923ljg.94.1557507278383;
 Fri, 10 May 2019 09:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1905100325330.25349@namei.org>
 <CAHk-=wjjfZSxaivGyE0A3S2ZHCi=BVGdwG4++QVS80OTshBR1Q@mail.gmail.com> <f7420347-a926-e923-9914-714ead9298ec@I-love.SAKURA.ne.jp>
In-Reply-To: <f7420347-a926-e923-9914-714ead9298ec@I-love.SAKURA.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 May 2019 09:54:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_oN0zQnwYu91CbXoEfRhxCiy6QD3FVfp+pfC-4P1-Kg@mail.gmail.com>
Message-ID: <CAHk-=wi_oN0zQnwYu91CbXoEfRhxCiy6QD3FVfp+pfC-4P1-Kg@mail.gmail.com>
Subject: Re: [GIT PULL] Security subsystem: Smack updates for v5.2
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 10, 2019 at 3:50 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> but I don't maintain a git tree for sending pull requests.

Any chance you would do so?

Anyway, I am not suggesting we change anything this merge window,
that's just too painful and would be too chaotic. But I'd love for
this to be sorted out by the next one, perhaps?

                 Linus
