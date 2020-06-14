Return-Path: <SRS0=sigj=73=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26717C433DF
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Jun 2020 18:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA9A8207D3
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Jun 2020 18:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592159988;
	bh=6HjV6JeAa3cdwThnpmLRDert6SEydt4zZr5+vshpMfg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=u8TlWGyiyuRJMmFdoZW9+W8X2y/jnSF7dtW9fWOLGU1NisqdWz6LjZAfUbSuhUgsF
	 U5i3xSG2luxNlvGO9DrvL4gX8RVPlc2k1C62Hos+1TT9RDBY9wk61ILUCLZrJqlGhh
	 dIv0IoZFb4u+zWFIKQ8d9jB1mb7peMIDsVF1sNjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgFNSjX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 14 Jun 2020 14:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgFNSjW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 14 Jun 2020 14:39:22 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA71C08C5C3
        for <linux-security-module@vger.kernel.org>; Sun, 14 Jun 2020 11:39:21 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d7so8192701lfi.12
        for <linux-security-module@vger.kernel.org>; Sun, 14 Jun 2020 11:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oXvx2kQGekER/HMngBtl5oBpkARJ4k2YYk7QiCC78kk=;
        b=TT1TKZN+de9xCxXLIF7hxeLRHu0iO6joJ4x07Yliuoq91Wxbueu2SpqiSSNKLBBR8y
         spNwn6SAXhYJDUr66RMM33wySXFZK7IQUA3dms6jl5jkbC6ssfy8j/SqYqj0Yloxu1Jq
         8pYf9wOpMD8T4GaeFrOG+HM/WJnCM4BLT59sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oXvx2kQGekER/HMngBtl5oBpkARJ4k2YYk7QiCC78kk=;
        b=B1a8O6nM5yWQS94/MAPR1dVdaNo2AY6joS37/2F2ATTW1uyVZv9HMrCvR8pNVXzqqp
         aVD9TMsQswrwKyNjQzSbLQu/eeJ4vLsXAv9/PpaWlKML3HOW7pS9JgR9rQwgGZnAFcMl
         umwZVbM5enKNE18XL/1dU4mz2s7r7MBJAX3jRhO5ynzpJiymtw3AMsDU+8KUv5y9crrv
         0iJOPpZntrcb411Bxq92wCXsncq9RFbfF+yUK/GaBLWR+edRAN8yuGIvvcZRuUul1OhU
         e0EKqvDfTg60vhVGkPOXJ/qYuXydsaoyQd6AHWW9NIm0z7l2AJvp1kEySQMaSwHPCySu
         hGRA==
X-Gm-Message-State: AOAM531XcmNu6o+oXr/SBfNjcrRRddSwbP22RjJStLMDZxP1Quu/CWxJ
        2sRmF9wIXZJbkcDdnANZvk3Svv/GNZU=
X-Google-Smtp-Source: ABdhPJyQ0lROhrtsVtmwyMex1XYuI9elfXPyfH3pLnBqON7dVe2FoenGi/kDjlZgk+HlRldbNnAT4w==
X-Received: by 2002:a19:3855:: with SMTP id d21mr12073833lfj.156.1592159959690;
        Sun, 14 Jun 2020 11:39:19 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id l7sm3403413ljj.55.2020.06.14.11.39.18
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2020 11:39:18 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id d27so3639344lfq.5
        for <linux-security-module@vger.kernel.org>; Sun, 14 Jun 2020 11:39:18 -0700 (PDT)
X-Received: by 2002:a05:6512:7b:: with SMTP id i27mr11875869lfo.30.1592159958307;
 Sun, 14 Jun 2020 11:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccOy4qDpbfrP5=KH40LSOx1F4-ciY2=hFv_c+goUHLJ6PQ@mail.gmail.com>
 <CAHk-=wiLXXR1+o4VAuw5MM3V1D8h6C6te3y8VMvW8iAJw6noJg@mail.gmail.com> <CAJ-EccPGQ62yMK1Nmvie4qWzproSqb4POwAD4_0Nt62KLbGhqg@mail.gmail.com>
In-Reply-To: <CAJ-EccPGQ62yMK1Nmvie4qWzproSqb4POwAD4_0Nt62KLbGhqg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Jun 2020 11:39:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZz_E+Bu1L6YTxtDQu_piBjUBoULW7vkKxNux54kwFAA@mail.gmail.com>
Message-ID: <CAHk-=whZz_E+Bu1L6YTxtDQu_piBjUBoULW7vkKxNux54kwFAA@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for v5.8
To:     Micah Morton <mortonm@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Jun 14, 2020 at 11:04 AM Micah Morton <mortonm@chromium.org> wrote:
>
> I amended the author on the lone commit in this pull request. For some
> reason I was thinking using the "From:" line in the commit body was
> how I should make things show up as Thomas as the author and me as the
> committer, but looks like that=E2=80=99s not true.

That's how we do things in email, since you want a separate author for
the emailed patch than from the author of the email itself.

But git itself very much has that difference between "author" and
"committer" internally, and all the usual email application tools will
take the separate "From:" line from the email, and make that be the
author in git.

(And then the sign-off chain is where we describe the whole path,
because git only has the concept of those two end-points: the original
author, and the final committer, but no concept of the path in between
the two, nor does it have the concept of the copyright and license
agreement implications of the sign-offs).

> I also removed my own Signed-off-by line from the pull request body
> and included it in the commit instead of the Reviewed-by line.

Good. You will get credit for the pull request in the merge commit
itself as a "Pull xyz from Micah Morton", so that path of history gets
encoded that way.

But the sign-off chain is supposed to be there for each individual commit.

(I don't always notice those things, but afaik there is automation in
place in -next that should warn about commits with incomplete sign-off
chains. Did that not trigger for some reason in this case?).

                  Linus
