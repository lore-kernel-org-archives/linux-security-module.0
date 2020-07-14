Return-Path: <SRS0=s2H2=AZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14429C433E8
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 21:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2E5F20656
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 21:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XR5InLU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgGNViY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgGNViY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Jul 2020 17:38:24 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A118C061755
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2020 14:38:24 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id s26so8186531pfm.4
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2020 14:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rhUtjNTW91qlPLBzYGxtd6FEYeoJpzq4EC2Nr6kXNew=;
        b=XR5InLU/ZuYgwGb0JtnB3ih96loG0AE59nbhZISKaA1qecqUWLJaYCd13NQJ3Or6sC
         +3LfdAmhLom67MejtQ6qgLpS0M6Dmkf1Wsb8or6ZSMX/ni3TgDMdp8V4HIp9Y6BLUVn0
         iB1MILb/MoIgDVtacC26ydy565jdZ3reUFdJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rhUtjNTW91qlPLBzYGxtd6FEYeoJpzq4EC2Nr6kXNew=;
        b=F04FTWXXVRnsrr597yDH3pM8EYLipw4GpBNDv9IsQi7MeWkrJLqd5OGcKEp0JOozMr
         /n8fjvZ7cW5Xf1XNIpGbXvOctp0GnA4xathGeY14sPV2KpR91jeogWLT1tGMysi4+wzf
         6b7nsjt5BydhzrcwDOKgxhaT5OvVEOUJUrrBY75Z+s3D8DEC4GOvneH8lJDCiPydCGG5
         BmVCId4rslG+3e5IFV9yvk8+L5obnicsiJxSOo0leL/Rd8ZRsh7QCJLokXnoW6+QXxjD
         j63Jqt1gl0GGGAMfqyuUT0+Kxcwrrvzcz0MW0DYrAfOgi7R5Sm5Wi9LfEq+jhq5lMNTg
         lB8Q==
X-Gm-Message-State: AOAM533b3w1Y4tf3vUVcRqDv9e2e1uU4mJtstegIH7j+BeRrGlP1+Tbt
        4lp5vfHt+670VJxOrBThJZ8Kzw==
X-Google-Smtp-Source: ABdhPJz6b6t7d1xxynzW3FbpvoGzvZ0dDIPSG7G6/UnTLzQBeOIoJTyLQKUygq9QebBJSIO7rhfuVQ==
X-Received: by 2002:a65:43c9:: with SMTP id n9mr4803979pgp.452.1594762703715;
        Tue, 14 Jul 2020 14:38:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g12sm109930pfb.190.2020.07.14.14.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:38:22 -0700 (PDT)
Date:   Tue, 14 Jul 2020 14:38:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/7] exec: Factor out alloc_bprm
Message-ID: <202007141438.C4E2A2A9@keescook>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87pn8y6x9a.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn8y6x9a.fsf@x220.int.ebiederm.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 14, 2020 at 08:29:05AM -0500, Eric W. Biederman wrote:
> 
> Currently it is necessary for the usermode helper code and the code
> that launches init to use set_fs so that pages coming from the kernel
> look like they are coming from userspace.
> 
> To allow that usage of set_fs to be removed cleanly the argument
> copying from userspace needs to happen earlier.  Move the allocation
> of the bprm into it's own function (alloc_bprm) and move the call of
> alloc_bprm before unshare_files so that bprm can ultimately be
> allocated, the arguments can be placed on the new stack, and then the
> bprm can be passed into the core of exec.
> 
> Neither the allocation of struct binprm nor the unsharing depend upon each
> other so swapping the order in which they are called is trivially safe.
> 
> To keep things consistent the order of cleanup at the end of
> do_execve_common swapped to match the order of initialization.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
