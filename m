Return-Path: <SRS0=cN3+=7Q=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E65BC433E0
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Jun 2020 00:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30843206E9
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Jun 2020 00:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591144817;
	bh=NlD2jPn6cNNUUUVK/+NlBV7fX7kuzjOImjXcrhUam6U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=T6KE/s4MC5cvFm62lJbOEwMFV+KvGEp4eLRyD4PziHFTf/iroAz6Njmu4BJx3PxuP
	 vbb614CTUlreC18zkHvrZSDx0hv+uj3CX+BpymygY68qZ1gwkojQAli+gWxsYdmxB2
	 d3mOx7hxOfA0ugGzUYrsP4uZBc6XDKAlvUMltO+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgFCAkQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Jun 2020 20:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbgFCAkQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Jun 2020 20:40:16 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B45C08C5C1
        for <linux-security-module@vger.kernel.org>; Tue,  2 Jun 2020 17:40:16 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c12so182576lfc.10
        for <linux-security-module@vger.kernel.org>; Tue, 02 Jun 2020 17:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9kGoCBA5DS7Gg4RTq4Y1cfvZFri+BwLVI8ih5oM9KhU=;
        b=FhGbMjiAPRBLkoRndyuewftQbr/2riV1V6xUqNHXLmfjq6YYYV18bLVRze+Zx84ghl
         D8ZtzBj8a2JIDjPYUE0PTf2ZQ1+G38IqMhyOu0NOsuLpvYUvHU9eERiOVjdyd0J/vfK5
         DDc0mrXlp/lSaPnLyCJHdubQL3qRfzCvvrMKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9kGoCBA5DS7Gg4RTq4Y1cfvZFri+BwLVI8ih5oM9KhU=;
        b=Qwa+Z/xN5yax1KMSDYfOH6vJqknyJQ4RypLRicgjWBP/3Fzyn+xyL5U7WQ0mcMIfge
         wVLNRtliCF7A5ueJvBhNq73pUOtUpy//yWw3BfImvJSbQSMQ1HDaYx4JCV+1i67zE6Qn
         1at9LJrd1IOq8R96KwBQtuCQKRRuZZpv+Uj2BVnms0ZN6gxzdSdUxGPMZaNZh8YQg63c
         bcIVFiqo+5p68rIlnfCdH/c6VJZ7VWZRNkNNKnj8ylqATPQAx4kS+vmupMc3k2bd/nkj
         xV2DWveFqCW6MElqnt5m+P+0USwxmzlWA3xf0ibrP3HKgp7gtbZcJ30in3YIcmtHG00c
         3u9A==
X-Gm-Message-State: AOAM532ac+ARY6Y3D3B2TqCsJMxB9Zu+lPGrS3nzABpQeuobn9dlnZar
        VAiyKi5S4bXJNYUWuZQSRLdgO8fclFQ=
X-Google-Smtp-Source: ABdhPJwiDRvt2mTICY0krbUay4auh7VEQMliSzzutRNXkypryDwGOD/FphN9jGzRNyaFSXkipyAeJg==
X-Received: by 2002:ac2:485a:: with SMTP id 26mr977699lfy.57.1591144814050;
        Tue, 02 Jun 2020 17:40:14 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id z133sm160615lfa.41.2020.06.02.17.40.12
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 17:40:13 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id z18so481369lji.12
        for <linux-security-module@vger.kernel.org>; Tue, 02 Jun 2020 17:40:12 -0700 (PDT)
X-Received: by 2002:a05:651c:2c6:: with SMTP id f6mr713504ljo.371.1591144812598;
 Tue, 02 Jun 2020 17:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.2006021212490.12446@namei.org>
In-Reply-To: <alpine.LRH.2.21.2006021212490.12446@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Jun 2020 17:39:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5hZ8BPKMAK4OhXCrRNvZ=43gE8j=LGX_urGUgbdcqqg@mail.gmail.com>
Message-ID: <CAHk-=wj5hZ8BPKMAK4OhXCrRNvZ=43gE8j=LGX_urGUgbdcqqg@mail.gmail.com>
Subject: Re: [GIT PULL][Security] lockdown: Allow unprivileged users to see
 lockdown status
To:     James Morris <jmorris@namei.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 1, 2020 at 7:15 PM James Morris <jmorris@namei.org> wrote:
>
> Just one update for the security subsystem: allows unprivileged users to
> see the status of the lockdown feature. From Jeremy Cline.

Hmm.

That branch seems to have sprouted another commit just today.

I ended up taking that too as trivial, but it shows how you seem to
basically send me a pointer to a live branch. Please don't do that.
When you make changes to that branch, I now get those changes that you
may not have meant to send me (and that I get upset for being
surprised by).

An easy solution to that is to send me a signed tag instead of a
pointer to a branch. Then you can continue to update the branch, while
the tag stays stable.

Plus we've been encouraging signed tags for pull requests anyway.

              Linus
