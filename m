Return-Path: <SRS0=sigj=73=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB2FC433DF
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Jun 2020 19:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED9A520739
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Jun 2020 19:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lsz5EOC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgFNTMz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 14 Jun 2020 15:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgFNTMy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 14 Jun 2020 15:12:54 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6BFC08C5C3
        for <linux-security-module@vger.kernel.org>; Sun, 14 Jun 2020 12:12:53 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id mb16so15123303ejb.4
        for <linux-security-module@vger.kernel.org>; Sun, 14 Jun 2020 12:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MrLddIkcot8tNQvLVw0AtZLgQi2l5giGkwxDkf5jFnc=;
        b=Lsz5EOC7hGOW3kxIqpRHQK9XYomqtcYtwkxyKDnKHLrGTno3HnIozqjt8oQ0rd90aa
         m3vQZ0CA2ghaSZPkK1dHC/xQnqR1ZxnqoFuTQr4c7fmX5nH0oymvG1jyRUNw+stxbpqO
         2WmWDCtVGHJxYPR8xfXEcuAaBH6CsokuEgAEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MrLddIkcot8tNQvLVw0AtZLgQi2l5giGkwxDkf5jFnc=;
        b=LFcUAB+QOYqFJZ3GlpKxU7SZstp7IHWGCs/DiPE3ugcgL1y11kQrTxyEZXXiuhBAVY
         k8qWpsfTzhfhxozyT5nv2cz4lA8/Xos8VAC8Xz8tXHHfcrHpn93QD3nxkKk+cBKUK5FW
         o9MDNBhejGIcBFrU6RpfIoeAytnfEM7JzkPVu5NNvXIAhsX7G4u+kxBYkstfybJ3AbHs
         Un6BruOGh3UUYrKW6LFxhTuCML5Rn1PWTjEdeHGodGDFHGmDO3C5ZeEo32eP1zRR+l01
         VODOPS54VIZaCHKSK25xcPwPopdFD5j4ymlFCx0B6pGIveCf1lnhJNVyiHleNlXuFyDE
         7QJQ==
X-Gm-Message-State: AOAM533UmbSQd3c5mqFDxj4Y+rS6rjey80edz91HyIUhf2taGdjurWOt
        eEMtLvduZhjZEM/F5np8quGi49eyrxcbC+N4PynKsPAV
X-Google-Smtp-Source: ABdhPJxpSt8E/kV4o2MEhoil4h5Nijfxto783DKTZtexB+8uLOfIJGg0jA34qWrwtLfgvxi0lPizqI23J/L6G2zHstw=
X-Received: by 2002:a17:906:7e50:: with SMTP id z16mr23294118ejr.277.1592161971719;
 Sun, 14 Jun 2020 12:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccOy4qDpbfrP5=KH40LSOx1F4-ciY2=hFv_c+goUHLJ6PQ@mail.gmail.com>
 <CAHk-=wiLXXR1+o4VAuw5MM3V1D8h6C6te3y8VMvW8iAJw6noJg@mail.gmail.com>
 <CAJ-EccPGQ62yMK1Nmvie4qWzproSqb4POwAD4_0Nt62KLbGhqg@mail.gmail.com> <CAHk-=whZz_E+Bu1L6YTxtDQu_piBjUBoULW7vkKxNux54kwFAA@mail.gmail.com>
In-Reply-To: <CAHk-=whZz_E+Bu1L6YTxtDQu_piBjUBoULW7vkKxNux54kwFAA@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Sun, 14 Jun 2020 12:12:40 -0700
Message-ID: <CAJ-EccP-MW3MZ3n=u-CoPD1nL73paLUSP3v5dQu+iiQLAtaZfQ@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for v5.8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Jun 14, 2020 at 11:39 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Jun 14, 2020 at 11:04 AM Micah Morton <mortonm@chromium.org> wrot=
e:
> >
> > I amended the author on the lone commit in this pull request. For some
> > reason I was thinking using the "From:" line in the commit body was
> > how I should make things show up as Thomas as the author and me as the
> > committer, but looks like that=E2=80=99s not true.
>
> That's how we do things in email, since you want a separate author for
> the emailed patch than from the author of the email itself.
>
> But git itself very much has that difference between "author" and
> "committer" internally, and all the usual email application tools will
> take the separate "From:" line from the email, and make that be the
> author in git.

Ah makes sense, thanks!

>
> (And then the sign-off chain is where we describe the whole path,
> because git only has the concept of those two end-points: the original
> author, and the final committer, but no concept of the path in between
> the two, nor does it have the concept of the copyright and license
> agreement implications of the sign-offs).
>
> > I also removed my own Signed-off-by line from the pull request body
> > and included it in the commit instead of the Reviewed-by line.
>
> Good. You will get credit for the pull request in the merge commit
> itself as a "Pull xyz from Micah Morton", so that path of history gets
> encoded that way.
>
> But the sign-off chain is supposed to be there for each individual commit=
.
>
> (I don't always notice those things, but afaik there is automation in
> place in -next that should warn about commits with incomplete sign-off
> chains. Did that not trigger for some reason in this case?).

This change hasn't had any bake time in linux-next. I didn't deem it
sufficiently risky or complex to warrant such integration testing.

That said I'm a little fuzzy on where to draw the line for which kinds
of changes really should be required to have bake time in -next. If
you think this is one of those cases, we can hold off on this until we
have some bake time for v5.9.

Either way this is a good reminder for the v5.9 merge window when we
plan to have more featureful changes going in for SafeSetID (although
those will be completely internal to the LSM, so low chance of
breaking anything outside the module).

>
>                   Linus
