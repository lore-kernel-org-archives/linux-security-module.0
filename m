Return-Path: <SRS0=hX+A=QS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0CFC169C4
	for <linux-security-module@archiver.kernel.org>; Mon, 11 Feb 2019 19:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399BE2186A
	for <linux-security-module@archiver.kernel.org>; Mon, 11 Feb 2019 19:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hWinqYJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388158AbfBKT3N (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:29:13 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34351 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731532AbfBKT3N (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 Feb 2019 14:29:13 -0500
Received: by mail-vs1-f65.google.com with SMTP id e10so60098vsp.1
        for <linux-security-module@vger.kernel.org>; Mon, 11 Feb 2019 11:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pg6m4puueGSKgxFi2uNwC9kugYg5UTfpjB90FPweV/Y=;
        b=hWinqYJ/c2te/mMDwRkz4RGJ6q9hQd0b9oB5Su5BNgJ1rB5H/5fLVvhH/JNk9EGi3I
         cUYGO6xtpyJQIVlRvwmMIOzI1g9QV1tBJeYO6s//zxjUBEsxfOSKnTrRGWLK7rc0mqqv
         gnhBDMILghoWVTItSD6WU3WZfQx2F7FgO0T7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pg6m4puueGSKgxFi2uNwC9kugYg5UTfpjB90FPweV/Y=;
        b=bTfvUR+BDUAvYpC+8i6NiVJp7MjZAgF+4CEws+YdEuawhIc0+PiEgPRRJvWYoAK3FG
         H7p3bqhkeR+dEVTLisTpGoIGvVBzT+LOmOL2J20BHgpJmaww5/VPVQ4ZiGQTpQA05UE4
         pyN1PUxCuQ8sB2kc+oU2XKIJscdgSwHEhnTJ0wZudBc69K3q49Q0og9XepbYhm+4zyDC
         iR58AI4i/6R2htLfGgAEhHTigR4Ctuf0GSRKO5RHFRo56c943f+R6Uq9HjOl5MfuKyx9
         8X2AQNijNRvi09DnL/6xvcvCxtb8fvlv1n5iMBA7hBdbdmEQ4jukSFYM9KtPXm7M0LOn
         lLRg==
X-Gm-Message-State: AHQUAuYzTVH4jCvGMeH4BsicxqWaBwBWH0dTGsMWJeqYY4xbEeVMu9dJ
        QM/k1W3hstiIayBs5XeH0ukDDzELC2k=
X-Google-Smtp-Source: AHgI3IbZ19kqX4M1g0fqonW9w5JfMDtQ+fMCju/ujskYqbM1Q90XhqH26Yu4VsBZ8cK+f8eaD1F8jA==
X-Received: by 2002:a67:7893:: with SMTP id t141mr9888333vsc.57.1549913351207;
        Mon, 11 Feb 2019 11:29:11 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id b21sm898813vsp.2.2019.02.11.11.29.09
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:29:10 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id t127so11970vke.8
        for <linux-security-module@vger.kernel.org>; Mon, 11 Feb 2019 11:29:09 -0800 (PST)
X-Received: by 2002:a1f:e7c5:: with SMTP id e188mr15096131vkh.92.1549913349277;
 Mon, 11 Feb 2019 11:29:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549540487.git.efremov@ispras.ru>
In-Reply-To: <cover.1549540487.git.efremov@ispras.ru>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 11 Feb 2019 11:28:57 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJ8DaoXk4Vt-K_Tgvpe4=wgHZ3Z1Y=D8JzRHU9n=bvgtA@mail.gmail.com>
Message-ID: <CAGXu5jJ8DaoXk4Vt-K_Tgvpe4=wgHZ3Z1Y=D8JzRHU9n=bvgtA@mail.gmail.com>
Subject: Re: [PATCH 00/10] LSM documentation update
To:     Denis Efremov <efremov@ispras.ru>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Paris <eparis@parisplace.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Feb 7, 2019 at 4:45 AM Denis Efremov <efremov@ispras.ru> wrote:
>
> Recent "New LSM Hooks" discussion has led me to the
> thought that it might be a good idea to slightly
> update the current documentation. The patchset adds
> nothing new to the documentation, only fixes the old
> description of hooks to reflect their current state.

Do these fixes silence any warnings during the documentation build?
(i.e. how did you verify the results beyond eyeballing the changes)

-Kees

>
> Denis Efremov (10):
>   security: fix documentation for the sb_copy_data hook
>   security: fix documentation for the syslog hook
>   security: fix documentation for the socket_post_create hook
>   security: fix documentation for the task_setscheduler hook
>   security: fix documentation for the socket_getpeersec_dgram hook
>   security: fix documentation for the path_chmod hook
>   security: fix documentation for the audit_* hooks
>   security: fix documentation for the msg_queue_* hooks
>   security: fix documentation for the sem_* hooks
>   security: fix documentation for the shm_* hooks
>
>  include/linux/lsm_hooks.h | 127 ++++++++++++++++++--------------------
>  1 file changed, 61 insertions(+), 66 deletions(-)
>
> --
> 2.17.2
>


-- 
Kees Cook
