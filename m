Return-Path: <SRS0=s2H2=AZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A14CC433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 21:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469322064C
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 21:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NAZytOoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgGNViF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGNViF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Jul 2020 17:38:05 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BD6C08C5C1
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2020 14:38:05 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gc9so22459pjb.2
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2020 14:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7s2UJ6qLwDdlKEbAp3tWyPT6USXGH2ifsrFreEv7ly0=;
        b=NAZytOoWm9VM1GiubiKSe5di3Ui40jvz1ad82fuA7hPshCWsD0sAPqWNxkIB+tXufO
         8PDJesbqttfMwvM2r7RKiFJ9S+8rHPWoa6LAzcb3J++j0xsfn0w9xNRN8vff0eI2UJqT
         LqupB3U64BjXWhiq32HiGxHkrYkMi3pWzOPqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7s2UJ6qLwDdlKEbAp3tWyPT6USXGH2ifsrFreEv7ly0=;
        b=aG4t0t88d2l56owOLcij8kkU4P8dtLHwgRwEsgUH8JhlEMfEhA94pJJjRww2xbdZiI
         3yn1Hs5htrX7s2y1iGByD23Alz04zNy0nbCg1hF3ZNLAHaTWZdxs2JhwGs/jMK3BaLC6
         UmUFiR1eHLdC4Y6Wwj2ve3Xl0FU+NLKNfDnkvAWPqD0msL6IPUV06x+359vE5LaCBDrl
         00nf57hgF3jX+3ZKRj2CxuYckuN1HCsCJsBGnSNOfXHkuShvV4vzAHL4y8FHSqJ78oh8
         +dgFXYRxhq4rvtKKZpJ6qVYzOFMhCwPutaOQcoswJL8U/EKDFrbJ/f+nJeWJvZtFBnWM
         CVqQ==
X-Gm-Message-State: AOAM531VC0L2VRFgLwjYIxVL5g3f5PDW3UcxIEG1K8fNEyieotub4DWN
        lMQhRA1scY6BcOwW1zwd0o3arw==
X-Google-Smtp-Source: ABdhPJwm5N5VxmpvPXn/mRlZiisE39r8Uxn0Rr9gGkAApwpLxa53XG+7io8auKb4gwouc1z/xyDDeQ==
X-Received: by 2002:a17:902:7241:: with SMTP id c1mr5704992pll.79.1594762684784;
        Tue, 14 Jul 2020 14:38:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h15sm112092pfo.192.2020.07.14.14.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:38:04 -0700 (PDT)
Date:   Tue, 14 Jul 2020 14:38:03 -0700
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
Subject: Re: [PATCH 5/7] exec: Factor bprm_execve out of do_execve_common
Message-ID: <202007141438.9E5B93B@keescook>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <878sfm6x6x.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878sfm6x6x.fsf@x220.int.ebiederm.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 14, 2020 at 08:30:30AM -0500, Eric W. Biederman wrote:
> 
> Currently it is necessary for the usermode helper code and the code
> that launches init to use set_fs so that pages coming from the kernel
> look like they are coming from userspace.
> 
> To allow that usage of set_fs to be removed cleanly the argument
> copying from userspace needs to happen earlier.  Factor bprm_execve
> out of do_execve_common to separate out the copying of arguments
> to the newe stack, and the rest of exec.
> 
> In separating bprm_execve from do_execve_common the copying
> of the arguments onto the new stack happens earlier.
> 
> As the copying of the arguments does not depend any security hooks,
> files, the file table, current->in_execve, current->fs->in_exec,
> bprm->unsafe, or creds this is safe.
> 
> Likewise the security hook security_creds_for_exec does not depend upon
> preventing the argument copying from happening.
> 
> In addition to making it possible to implement kernel_execve that
> performs the copying differently, this separation of bprm_execve from
> do_execve_common makes for a nice separation of responsibilities making
> the exec code easier to navigate.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
