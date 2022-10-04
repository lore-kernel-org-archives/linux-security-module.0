Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAAFC433F5
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Oct 2022 20:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiJDUzi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Oct 2022 16:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJDUzh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Oct 2022 16:55:37 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BBD2A264
        for <linux-security-module@vger.kernel.org>; Tue,  4 Oct 2022 13:55:36 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id h1-20020a4aa741000000b004756c611188so9591511oom.4
        for <linux-security-module@vger.kernel.org>; Tue, 04 Oct 2022 13:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=i/q6zCo6uZn5YFcofNOMTsjwW/LKGiHOxuAGM6UhUzs=;
        b=ND/gybQA4CKTUaptFFIy2tjNe9PchnhIMte9RFBXPLR2oiSuz4WOdkoAtngtt7/r9S
         N8UPUhVC9K43mGtqCUfZYIzJqKJTtFizqK/OuowWFJcQGs8bOaZG/El0odhHgBHT8EbV
         +jm3XnLCzNQgzPgxkCJ8PYznQ0PzbbrNbIhHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=i/q6zCo6uZn5YFcofNOMTsjwW/LKGiHOxuAGM6UhUzs=;
        b=5MutK+49Wodb6jGwsEQcmvxLLAWkgPcpwfp4agsUadOz3/cuopMwlkZerw9uk5m4MG
         J7uZ1l63A6RpzwkMcdVfIAz5lmH8U+/f8I4H1nMTy7VPuO7NAq1vZUdp+gvUAeqMo+L/
         0PyKBZqUAQkq6Dyg/wB/S8O9Su3RJD8UQb/u1lxK1H4bd5m83iEWlCiU0rEsDvcpMDJv
         8ycFOXm7VAv1hUOn+phvpXfiYych5x1tmAqdxRxgfoDokE9pmFSoFmVY5OYt8KxmJw0g
         d/ImigzaB5OdxSru2AaXNHyUtjvR8eTzvWzf9WZCbQRv+hRFVQFOcOoxInp4yDW1frcV
         5qzg==
X-Gm-Message-State: ACrzQf2Ioet5y0YqzSseo2PMeVUQS1j2klNLKnrL/4MywimlGJ0IRyWk
        xKesyf9KHFhpV4dPhg0wX89ivbtIVJKGbA==
X-Google-Smtp-Source: AMsMyM5+3ztxwV8M0xaUaJau15/hskForX1Rsqn/cWMbVs4vhBHVgatt5DOKj+mWb0+Dl8ZcR9bpBw==
X-Received: by 2002:a4a:4847:0:b0:443:347d:6617 with SMTP id p68-20020a4a4847000000b00443347d6617mr9921275ooa.94.1664916935022;
        Tue, 04 Oct 2022 13:55:35 -0700 (PDT)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com. [209.85.161.50])
        by smtp.gmail.com with ESMTPSA id i205-20020acaead6000000b00353ef11d6c9sm341691oih.19.2022.10.04.13.55.34
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 13:55:34 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id u19-20020a4a9e93000000b004757198549cso9577993ook.0
        for <linux-security-module@vger.kernel.org>; Tue, 04 Oct 2022 13:55:34 -0700 (PDT)
X-Received: by 2002:a05:6830:611:b0:65c:26ce:5dc with SMTP id
 w17-20020a056830061100b0065c26ce05dcmr10793439oti.176.1664916933857; Tue, 04
 Oct 2022 13:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhShpEVTuogj4h74PxbEeTUNn4odo8SE6GBvb6sGUM0LHw@mail.gmail.com>
 <87sfk3mim9.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87sfk3mim9.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Oct 2022 13:55:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiCqicQrnQPeHbDF7ECKHk_ceYzZK5dYq7y5nZTZhpB8g@mail.gmail.com>
Message-ID: <CAHk-=wiCqicQrnQPeHbDF7ECKHk_ceYzZK5dYq7y5nZTZhpB8g@mail.gmail.com>
Subject: Re: [GIT PULL] LSM patches for v6.1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 4, 2022 at 1:37 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Please don't pull the user namespace bits of this code.

Eric, already done.

And I think you are in denial about how many problems the
user-namespace stuff has caused.

Distros are literally turning it off entirely because the whole "let
users create their own namespace" has *NOT* been a great success.

I personally think it was a mistake. We're stuck with it, but we most
definitely need knobs to manage it that isn't just "enable/disable
USER_NS" in the kernel config.

So this whole "don't do this" approach you have is not acceptable.

99% of all code does NOT WANT the user namespace thing, and it's been
a big new attack surface for the kernel getting things subtly wrong.

I do not understand your "people need to be able to do this with no
controls", when the alternative is to literally turn it off ENTIRELY.

I'm not saying that an LSM is the only place to do it, but I don't
think there have been any better suggestions either.

Put another way: your "no limits are acceptable" is simply not
realistic, and you haven't given any sane alternatives that I am aware
of. No way to say "sure, let trusted system apps create their
namespaces, but not random things".

                Linus
