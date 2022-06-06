Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F66C433EF
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Jun 2022 18:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiFFS2r (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Jun 2022 14:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiFFS2p (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Jun 2022 14:28:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF5A6BFF3
        for <linux-security-module@vger.kernel.org>; Mon,  6 Jun 2022 11:28:43 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id m20so30539335ejj.10
        for <linux-security-module@vger.kernel.org>; Mon, 06 Jun 2022 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qXYqp07Gt1ZtS5TmqPmPcYjNyQa7EHn+PPqLupxduxE=;
        b=e5deP955cqquSyg6oIIx3CAf8kgiTaqIY9bcnFfEj7ZLflDPPAW86Emcn95M8HZaCC
         42qc7J70nZug2SNdJKjJgyCMPhAPg0LD/D4YMTCvWKzcs83etYmdBaLlq/Isztw3LXqz
         giP1rEm6h5Y0md23q+Lg6Uqv0VYv58smLzap0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qXYqp07Gt1ZtS5TmqPmPcYjNyQa7EHn+PPqLupxduxE=;
        b=y6m3K00YnUjBqgkK736Xs1XTbrwAhsqcK9pzLOP4W5Gs1pROz0dAxBCrnLZt+yqunf
         mvSS6uqNW6ejwdE3V4gC0CAwCZIN06gL6yYoaS1pFGzkFqieZqy2lNxjcLQk6+S0FkNs
         05V9VDIOyQgRV3TtyztxAk4FrVJSQPM96RybV8zk6Df7sW7IV5TXhr89aLarJtyzM9YW
         UBPfKzzFitEcG35nHIZ88MulLcmFVmI36/lmlzEZ/6ojwMx5bAuHjwUfEoI9CV9dqJH+
         EMAINbHpJNVzvujaYUdYMKXh7bfQv5vM8jBXS7MAKpeOjLv8wmdtWdQ/3ODiUPbegzaK
         xFIw==
X-Gm-Message-State: AOAM532Jj8R1eGHvMuDZg/ViP/FQXE68hrrh3LaYh6HbuZfk3QAqWGxe
        2LOvcnd4gQh0bVWV3+z3cfx/tSUV7U6gdrshX64=
X-Google-Smtp-Source: ABdhPJzt70Up5dkhu5o6nNVhVeiuB4Y+vtsLT4Cs/swoHvH4LgPqnK+Za1CY5tDEOG15rY2hnkil2w==
X-Received: by 2002:a17:907:2d29:b0:70e:8b1c:c3f0 with SMTP id gs41-20020a1709072d2900b0070e8b1cc3f0mr16481197ejc.37.1654540122110;
        Mon, 06 Jun 2022 11:28:42 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id h4-20020a17090791c400b007109b15c109sm3430891ejz.66.2022.06.06.11.28.40
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 11:28:41 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id a15so12444483wrh.2
        for <linux-security-module@vger.kernel.org>; Mon, 06 Jun 2022 11:28:40 -0700 (PDT)
X-Received: by 2002:a05:6000:1b0f:b0:210:313a:ef2a with SMTP id
 f15-20020a0560001b0f00b00210313aef2amr22896573wrz.281.1654540120455; Mon, 06
 Jun 2022 11:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whmtHMzjaVUF9bS+7vE_rrRctcCTvsAeB8fuLYcyYLN-g@mail.gmail.com>
 <226cee6a-6ca1-b603-db08-8500cd8f77b7@gnuweeb.org> <CAHk-=whayT+o58FrPCXVVJ3Bn-3SeoDkMA77TOd9jg4yMGNExw@mail.gmail.com>
 <87r1414y5v.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87r1414y5v.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Jun 2022 11:28:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijAnOcC2qQEAvFtRD_xpPbG+aSUXkfM-nFTHuMmPbZGA@mail.gmail.com>
Message-ID: <CAHk-=wijAnOcC2qQEAvFtRD_xpPbG+aSUXkfM-nFTHuMmPbZGA@mail.gmail.com>
Subject: Re: Linux 5.18-rc4
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, gwml@vger.gnuweeb.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 6, 2022 at 8:19 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Has anyone looked into this lock ordering issues?

The deadlock is

> >> [78140.503821]        CPU0                    CPU1
> >> [78140.503823]        ----                    ----
> >> [78140.503824]   lock(&newf->file_lock);
> >> [78140.503826]                                lock(&p->alloc_lock);
> >> [78140.503828]                                lock(&newf->file_lock);
> >> [78140.503830]   lock(&ctx->lock);

and the alloc_lock -> file_lock on CPU1 is trivial - it's seq_show()
in fs/proc/fd.c:

        task_lock(task);
        files = task->files;
        if (files) {
                unsigned int fd = proc_fd(m->private);

                spin_lock(&files->file_lock);

and that looks all normal.

But the other chains look painful.

I do see the IPC code doing ugly things, in particular I detest this code:

        task_lock(current);
        list_add(&shp->shm_clist, &current->sysvshm.shm_clist);
        task_unlock(current);

where it is using the task lock to protect the shm_clist list. Nasty.

And it's doing that inside the shm_ids.rwsem lock _and_ inside the
shp->shm_perm.lock.

So the IPC code has newseg() doing

   shmget ->
    ipcget():
     down_write(ids->rwsem) ->
       newseg():
         ipc_addid gets perm->lock
         task_lock(current)

so you have

  ids->rwsem -> perm->lock -> alloc_lock

there.

So now we have that

   ids->rwsem -> ipcperm->lock -> alloc_lock -> file_lock

when you put those sequences together.

But I didn't figure out what the security subsystem angle is and how
that then apparently mixes things up with execve.

Yes, newseg() is doing that

        error = security_shm_alloc(&shp->shm_perm);

while holding rwsem, but I can't see how that matters. From the
lockdep output, rwsem doesn't actually seem to be part of the whole
sequence.

It *looks* like we have

   apparmour ctx->lock -->
      radix_tree_preloads.lock -->
         ipcperm->lock

and apparently that's called under the file_lock somewhere, completing
the circle.

I guess the execve component is that

  begin_new_exec ->
    security_bprm_committing_creds ->
      apparmor_bprm_committing_creds ->
        aa_inherit_files ->
          iterate_fd ->   *takes file_lock*
            match_file ->
              aa_file_perm ->
                update_file_ctx *takes ctx->lock*

so that's how you get file_lock -> ctx->lock.

So you have:

 SHMGET:
    ipcperm->lock -> alloc_lock
 /proc:
    alloc_lock -> file_lock
 apparmor_bprm_committing_creds:
    file_lock -> ctx->lock

and then all you need is ctx->lock -> ipcperm->lock but I didn't find that part.

I suspect that part is that both Apparmor and IPC use the idr local lock.

               Linus
