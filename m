Return-Path: <SRS0=JRQQ=Z3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3C6C2BD09
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Dec 2019 17:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98C52464E
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Dec 2019 17:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575567205;
	bh=r67g/9hiA927KJVVx+cBd7MCpOd+2xqMrxYTzGwUZns=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=SzvlnQMMk5wlYr6x75c8ElnP4Lusl2CiaD5nXnk8W4b0xd9wteWQ/hTj88PCFHSKs
	 N3xM4lypZlDJJ9DOVlc5k9POyx5wS5sHA0ImA+McEMQosWN+XVRHTHzGN9OXZwLA2b
	 Er4bLF6sOvyBHMW5kw/Ey9PXPKGzLEzxsf7w92ds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbfLERdZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:33:25 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39052 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbfLERdZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Dec 2019 12:33:25 -0500
Received: by mail-lj1-f195.google.com with SMTP id e10so4526739ljj.6
        for <linux-security-module@vger.kernel.org>; Thu, 05 Dec 2019 09:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/eKd/FDqrplPYUuvbR0AiU2l8M+m4LPxDGweCaRKq6w=;
        b=M56np70zVr1VfiJPsuEXyT4OG9+Mgq+nZRonIdlMO0qNjSITB1EVwHnE+jM9THnBNz
         3vX00ZNLigUAoH1Qop/bcwkoEis8chlXpTrSREoavAISt/m/5l5mLyPd23rMwP17l/QA
         7M9TY3swoS1z9u0iCZT3it6ySOEzIm2iiZPAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/eKd/FDqrplPYUuvbR0AiU2l8M+m4LPxDGweCaRKq6w=;
        b=UMc88ug8HDX7hc/m9jZyPyGy3QBjmHoczAgWROraRYTzG91NrTeqIG1ZzQ51DmD0J/
         PYWxP4xgRbIpYhWdm9vHBMr8DacrVtEgrveLjFLbqa30LbC1/gkTr6snADIm2lQnOr0E
         FSxxBHHLtEKhN79FiEyuIUdjTl0mej2NhwYwZ6CJ+GIuqWuPCG1SMqEMZ8bpVCRH3d9y
         hBQe7TqAWErWs6sAjAsRKtWZXMcxZxw7cdta1oxF8kjISn/wn9XxqVb5Uz/EcA80+1Ho
         niE4cU2/dI4G9BATEJ4YS6TrKEjeR0JUpg6x6L8sXRdHm8ITG9IxmAXZahzVbfDsebvv
         tXDA==
X-Gm-Message-State: APjAAAWBTL0vYKuLijTkyF+ed0ksTbq4Z8wFeItzz4Av2AIOvGlMcSNF
        v+TY+PBvW+CE0LIdf26NrsgSBunb9gc=
X-Google-Smtp-Source: APXvYqwCxkjmMavRKYWPxVZGRpYr8+Lj0NA/KKdr2+bXabd2o9lwwy7Xx+4+IhMx2Ht+aMbpDfpWKA==
X-Received: by 2002:a2e:8797:: with SMTP id n23mr6014300lji.176.1575567202008;
        Thu, 05 Dec 2019 09:33:22 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id w2sm5294536ljo.61.2019.12.05.09.33.20
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 09:33:21 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id n12so3129916lfe.3
        for <linux-security-module@vger.kernel.org>; Thu, 05 Dec 2019 09:33:20 -0800 (PST)
X-Received: by 2002:ac2:430e:: with SMTP id l14mr2520386lfh.79.1575567200366;
 Thu, 05 Dec 2019 09:33:20 -0800 (PST)
MIME-Version: 1.0
References: <20191205125826.GK2734@twin.jikos.cz> <31452.1574721589@warthog.procyon.org.uk>
 <1593.1575554217@warthog.procyon.org.uk> <20191205172127.GW2734@suse.cz>
In-Reply-To: <20191205172127.GW2734@suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Dec 2019 09:33:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=whw+R5GVQdpV6J_5afQ=76vtBPzBPRj6-zG1tnhT32Pag@mail.gmail.com>
Message-ID: <CAHk-=whw+R5GVQdpV6J_5afQ=76vtBPzBPRj6-zG1tnhT32Pag@mail.gmail.com>
Subject: Re: [GIT PULL] pipe: Notification queue preparation
To:     David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Dec 5, 2019 at 9:22 AM David Sterba <dsterba@suse.cz> wrote:
>
> I rerun the test again (with a different address where it's stuck), there's
> nothing better I can get from the debug info, it always points to pipe_wait,
> disassembly points to.

Hah. I see another bug.

"pipe_wait()" depends on the fact that all events that wake it up
happen with the pipe lock held.

But we do some of the "do_wakeup()" handling outside the pipe lock now
on the reader side

        __pipe_unlock(pipe);

        /* Signal writers asynchronously that there is more room. */
        if (do_wakeup) {
                wake_up_interruptible_poll(&pipe->wait, EPOLLOUT | EPOLLWRNORM);
                kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
        }

However, that isn't new to this series _either_, so I don't think
that's it. It does wake up things inside the lock _too_ if it ended up
emptying a whole buffer.

So it could be triggered by timing and behavior changes, but I doubt
this pipe_wait() thing is it either. The fact that it bisects to the
thing that changes things to use head/tail pointers makes me think
there's some other incorrect update or comparison somewhere.

That said, "pipe_wait()" is an abomination. It should use a proper
wait condition and use wait_event(), but the code predates all of
that. I suspect pipe_wait() goes back to the dark ages with the BKL
and no actual races between kernel code.

               Linus
