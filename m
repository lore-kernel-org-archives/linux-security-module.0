Return-Path: <SRS0=GMo7=2U=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54613C2D0C3
	for <linux-security-module@archiver.kernel.org>; Mon, 30 Dec 2019 20:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B6B20658
	for <linux-security-module@archiver.kernel.org>; Mon, 30 Dec 2019 20:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577736919;
	bh=Y5Md63y9ed5vH4kWr2XOEflxc2mMGD8E2NiwLKoa4oM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uofwu0bbP8AWr2ieMH1ZGmEaxWYC7ky0y3yX6YkBMVeUtBDmTtSURkGlLo683gSox
	 3dEZfSxz6T2zPw5mnzct+LPK5jZqbboiRTznPLAyd3M/C7l6oXT5gJ2HDSHUfiRfMr
	 YYYsQ/fF0w690PZKQXmK70KvL7hed1xb3XMrCTYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfL3UPS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 30 Dec 2019 15:15:18 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47056 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbfL3UPS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 30 Dec 2019 15:15:18 -0500
Received: by mail-lf1-f68.google.com with SMTP id f15so25803670lfl.13
        for <linux-security-module@vger.kernel.org>; Mon, 30 Dec 2019 12:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0NUD8zZAQo+O9PgfrBGhsCZfnogIqpNz9ilU9EfzbLI=;
        b=Cw67PqYmY/9S3uWAD1VHsvkn1/R3WJ4iRuDhSyOtGeWMdXghCBxnq7YsOEtiUzJHim
         Vp31uJwyLJV62QuaFJjNEjhaAO7DeKrjBVuAaqC9Wz0tYLuOL+qVGWaET2U4f7Y70an7
         M+OOMzDlKChNyvPNj5GGoYW9JzpJ6hT5JzIHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0NUD8zZAQo+O9PgfrBGhsCZfnogIqpNz9ilU9EfzbLI=;
        b=nlxB+d5rW3KKd0DiNXWCQMLTgzau+pTgi5VA53RAOf7q+VYHOuTaubn84nX2hvdNc1
         KWFoaM4O8u0DqRedSxQtXVmpDDuDjJTVnAg4HPBr4o4qU7iF2KpU8WqS5pLvoTozE0St
         SM006q78FVsyhYh56vEkxPV5yuGL9FBafLGwcA1WDOEg6QgnHMEs9kyO5euFoirFShOO
         lrda1PefIGkDHerk30UQaxRu8uVR54sNIfvN7HySLT5pcI9gkMkkRnKWrNwh85AV4f9L
         hHs/WZFMWhHp/NuSI+DUROjxjd2SEVeL1JihdRA+cGioz3joacAjTSm9PlvLf/aVAyFp
         Atpw==
X-Gm-Message-State: APjAAAUUUiTmqQplWlhY0AvcmuRnRP8e5HL1O57ris+2ZvhZOaZ0EEZg
        H5kXn9AQwyI2WlYoI3URGrfVxwOtPIU=
X-Google-Smtp-Source: APXvYqwzTTtWCYdb/SMTY+hOaikIOWmYqfLiy9iYZyonGTl5w4PH8721FceT97/oLHX2tY+Vd0H0bA==
X-Received: by 2002:ac2:51de:: with SMTP id u30mr38533410lfm.69.1577736916035;
        Mon, 30 Dec 2019 12:15:16 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 195sm16627428ljj.55.2019.12.30.12.15.15
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 12:15:15 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id m30so25829461lfp.8
        for <linux-security-module@vger.kernel.org>; Mon, 30 Dec 2019 12:15:15 -0800 (PST)
X-Received: by 2002:ac2:50cc:: with SMTP id h12mr38668703lfm.29.1577736914815;
 Mon, 30 Dec 2019 12:15:14 -0800 (PST)
MIME-Version: 1.0
References: <8483f2c2-626d-382f-3994-ee29daebff75@i-love.sakura.ne.jp>
In-Reply-To: <8483f2c2-626d-382f-3994-ee29daebff75@i-love.sakura.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Dec 2019 12:14:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgNYqYSdD530KWQ9gtTeEvBd_Frn54Xc45B3D8PPL8ijA@mail.gmail.com>
Message-ID: <CAHk-=wgNYqYSdD530KWQ9gtTeEvBd_Frn54Xc45B3D8PPL8ijA@mail.gmail.com>
Subject: Re: [GIT PULL] tomoyo fixes for 5.5
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Dec 30, 2019 at 3:32 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> This is my first time for sending pull requests. It seems that most people
> create a tag signed with GPG key but a few people send pull requests on
> master branch without signing with GPG key. Did I follow necessary steps?

I do require the gpg signed tag for non-kernel.org pull requests like this.

I trust the security at kernel.org - it requires 2FA and a gpg key
just to even push to a git repo there at all - but even there I
_prefer_ tags. But outside of kernel.org I absolutely do want to see a
signed tag for a pull request, not just a master branch.

Side note: I don't actually require the pgp key to be something I have
a direct path to, and if you can't get big set of signatures on yours,
that's fine for initial pull requests. The key ends up still being a
kind of identity, and we can work on getting the proper web of trust
built up over time.

           Linus
