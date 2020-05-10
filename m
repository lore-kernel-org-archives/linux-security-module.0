Return-Path: <SRS0=CsWO=6Y=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E021DC38A2A
	for <linux-security-module@archiver.kernel.org>; Sun, 10 May 2020 19:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDD25206A3
	for <linux-security-module@archiver.kernel.org>; Sun, 10 May 2020 19:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589139524;
	bh=zWd4cAEpL4YcnjKHepZKvaA1uFfEzxHy65/iMOgTYm8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=W4PIu9au6Ss4n+GhClV8qeFlhGAOVOxL8X/ryNU6zvPJOQOadwy8iAF6oCBp0Rh0m
	 wRGbiMDb7TbFccu6KEQYtNURfX8zkmWZt4evh86L4rb5yvK4XiPMpyuY4zWlgWKeqJ
	 cE2AylTgWrzJqX/+lNqys0OFMu5KrVr5OrsMd2Co=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgEJTio (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 10 May 2020 15:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729032AbgEJTin (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 10 May 2020 15:38:43 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E39C061A0C
        for <linux-security-module@vger.kernel.org>; Sun, 10 May 2020 12:38:42 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a21so7163327ljj.11
        for <linux-security-module@vger.kernel.org>; Sun, 10 May 2020 12:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GOt0HOaqZfjjxJE5mAqOm47sbC7ffDpQA2P+1UtM4RE=;
        b=MvdUhg89yXtJF0t/lWJcuLrr+bpGqVPlxoPK/Zhq2QqXYyp7vcGmiSrZl+n0GURWqw
         V64Z4RvbsMsrTzRFhphZJ44YD55cIcu0w/FHaiF/arWpo9zjG6+ztNZG5zl1l+5WIhmf
         vjboKU8xNCyk7pZgwioS1lDPWOU6mzJy+CNac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GOt0HOaqZfjjxJE5mAqOm47sbC7ffDpQA2P+1UtM4RE=;
        b=i/uev5bKqIovyBgEnDb19yt5DZ8yqq870yGOnNkltW8QXkgzxoi3IgDHJmAtPIhcsS
         BmeLig/bfuCKmgLNNfcRU2tIy/Cb5Pea1NBC2G68wfsPzDo9bhpo1zN/jVjiSXV/3CZ8
         WAI/ly/WX2oBI10NCwYV/UJTsy3gE+/hJUc524+5N2qRp/Eo+9ai/C19qunYy+1wYv1b
         TYwjvQvB+QiO2tBfa7dhwAYY8SALvtBigqi3cwzTQskCsibd0V88v9sFXYqXA35FkB5I
         xgub7PKKUB7LaV2BGWXdzVracrPEowBnj2wm1YXHbjHoKmdhywLXolEOpGmuJjH27tTU
         8fQA==
X-Gm-Message-State: AOAM532w3RcLSVd/fEFwLGw7E4TzB4iV6cKkpjjf1CMyIsd8KRJB2FSJ
        MykIjk9ciFr5/2Z9w9C6JVDNPWUTyUs=
X-Google-Smtp-Source: ABdhPJx6mODISDy+ZUtlvz+y8mPr5uy3ha+UpHmBD8f4xFF4KsAspswx7Q0djQZvisFlTi14Mdtf4A==
X-Received: by 2002:a2e:82c7:: with SMTP id n7mr8247856ljh.47.1589139518306;
        Sun, 10 May 2020 12:38:38 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id f24sm8848383lfk.36.2020.05.10.12.38.36
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2020 12:38:37 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id w20so7195560ljj.0
        for <linux-security-module@vger.kernel.org>; Sun, 10 May 2020 12:38:36 -0700 (PDT)
X-Received: by 2002:a2e:87d9:: with SMTP id v25mr7886930ljj.241.1589139516386;
 Sun, 10 May 2020 12:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <87eerszyim.fsf_-_@x220.int.ebiederm.org>
 <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
In-Reply-To: <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 May 2020 12:38:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
Message-ID: <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] exec: Remove recursion from search_binary_handler
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, May 9, 2020 at 9:30 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Wouldn't this change cause
>
>         if (fd_binary > 0)
>                 ksys_close(fd_binary);
>         bprm->interp_flags = 0;
>         bprm->interp_data = 0;
>
> not to be called when "Search for the interpreter" failed?

Good catch. We seem to have some subtle magic wrt the fd_binary file
descriptor, which depends on the recursive behavior.

I'm not seeing how to fix it cleanly with the "turn it into a loop".
Basically, that binfmt_misc use-case isn't really a tail-call.

Eric, ideas?

                 Linus
