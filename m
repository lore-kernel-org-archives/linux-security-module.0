Return-Path: <SRS0=JRQQ=Z3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2DEC43603
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Dec 2019 20:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023B924671
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Dec 2019 20:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575577638;
	bh=HBx+Fd/NT+SDbzqqeb4YRELFUwI5g02zAAe+CpFWWPE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sSAoXZCWzDFIZ4clIbRU1zaVgBLVFTCoGXIpuK6owJW2dYM+pye2HqIpG2lBRyREe
	 ys1ztjpp5GGa/37nKTXylPl2PNc36U9/snjGh/g3HlNI5HsIMK7/3NPGR+Bs077zB0
	 f56afOCMFi90oUlL/NGNflkS/YYVx/c1zFFcrC7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbfLEU1O (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 5 Dec 2019 15:27:14 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39840 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbfLEU1O (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Dec 2019 15:27:14 -0500
Received: by mail-lf1-f68.google.com with SMTP id c9so2982775lfi.6
        for <linux-security-module@vger.kernel.org>; Thu, 05 Dec 2019 12:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2nboj5xrRkV1yqHjA0Aj2mbWgmjh4x0SrJcMaszVtA=;
        b=TY6MoxQFBEklRwMxXtPk7pq3Wq5Rwa2J/YtugYsq/w1lH9+ERuu6f1+z8+8JuKIiKx
         YDkuPczmV+9Qf+ENZhlePKKmJs1rLUEQ7rx1SKksdo9OxMTgxyWfNyX7ZM9ZSUbccBnx
         JYw40/VtEd257BEbFslSJIyKBygobO7WiYq+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2nboj5xrRkV1yqHjA0Aj2mbWgmjh4x0SrJcMaszVtA=;
        b=asTp+7swsgACcyQ6qyW4NzFdjakOOmAilnbisvsbRan9u5fxQTTf0MUXxbHbNwH2dZ
         3YzwmOGzfhHOXqtsfk8KOdHJhA/v8BJRLtPI71ze3KLvreE1b8lwY3mm611BW3yjZtbB
         3lnlHoAWi0yMEiGXO1SZrdJSZD+XJhX+Mnl56QOqaLfnNqKwig98OqpcN573SM04BqY2
         eGsxryqx9EdpFGoB7/vUxV+GBn1Twpp63cuDkpW2h/fhPtbEjwFwEbP96LjjSgZEfZv8
         tkdNRkYouRiCoAGOBZIw3v9aVvOtBV9OJEuTJPzvuAaUxSeWP7l7/9zvSvaUpGoyZUYV
         tJ/A==
X-Gm-Message-State: APjAAAW1RS6TTp3PbwHRKPknsZkrYbxcZ0sdmaT4VgASKCJf2qKWGEUN
        ZyrNNw293Wvx6rZxk9j9Bjtv4BaFYOQ=
X-Google-Smtp-Source: APXvYqxo9KVVQuTkC9WNui7Ighs0i6keuMNB7KVhqJsZghF8ket3SJztZyN7V623RIr9pxtXA9J4bg==
X-Received: by 2002:ac2:4909:: with SMTP id n9mr2430lfi.21.1575577630896;
        Thu, 05 Dec 2019 12:27:10 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id d11sm5383788lfj.3.2019.12.05.12.27.09
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 12:27:09 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id k8so5100181ljh.5
        for <linux-security-module@vger.kernel.org>; Thu, 05 Dec 2019 12:27:09 -0800 (PST)
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr4294750ljn.48.1575577628995;
 Thu, 05 Dec 2019 12:27:08 -0800 (PST)
MIME-Version: 1.0
References: <31555.1574810303@warthog.procyon.org.uk>
In-Reply-To: <31555.1574810303@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Dec 2019 12:26:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj+_n63ps_-Rvwgo4S7rd2eLAVcJwbZee7iHZaO+1hvYQ@mail.gmail.com>
Message-ID: <CAHk-=wj+_n63ps_-Rvwgo4S7rd2eLAVcJwbZee7iHZaO+1hvYQ@mail.gmail.com>
Subject: Re: [GIT PULL] pipe: General notification queue
To:     David Howells <dhowells@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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

On Tue, Nov 26, 2019 at 3:18 PM David Howells <dhowells@redhat.com> wrote:
>
> Can you consider pulling my general notification queue patchset after
> you've pulled the preparatory pipework patchset?  Or should it be deferred
> to the next window?

So it's perhaps obvious by now, but I had delayed this pull request
because I was waiting to see if there were any reports of issues with
the core pipe changes.

And considering that there clearly _is_ something going on with the
pipe changes, I'm not going to pull this for this merge window.

I'm obviously hoping that we'll figure out what the btrfs-test issue
is asap, but even if we do, it's too late to pull stuff on top of our
current situation right now.

I suspect this is what you expected anyway (considering your own query
about the next merge window), but I thought I'd reply to it explicitly
since I had kept this pull request in my "maybe" queue, but with the
pipe thread from this morning it's dropped from that.

            Linus
