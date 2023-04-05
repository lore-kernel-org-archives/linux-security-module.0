Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7CAC76188
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Apr 2023 20:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjDEUpw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Apr 2023 16:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjDEUpv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Apr 2023 16:45:51 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940FF2127
        for <linux-security-module@vger.kernel.org>; Wed,  5 Apr 2023 13:45:38 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id j7so44125115ybg.4
        for <linux-security-module@vger.kernel.org>; Wed, 05 Apr 2023 13:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680727537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0UeBOixLMx1/cwwlyY3v1wGnqeW+j/bgN/ib4krdBY=;
        b=TRn3CL/q99AzGptSrOeZtnVsKF41kG2zO/Mqmx39s8EWQEDWiIJcFmGzjLNtTFArLc
         07/oVPzc/kPj9E37FTsEk5z2DNfcD9enN6mol2qejUMGimkmZWvXojlEU70AAv/CaJQ3
         moyXiz6PYBNcwLCBITw6pxloM0XfGyjoqGzq0V+bqFb37jAvAqdwQzkn3bRxZAtnrrNO
         MlX4mbX8T+PCpFCo4v6FdQ7BHiWq46Ul/+n3fi2WbbNYd5FD+8XMwffnUVP2RT3pV3Ym
         ct5FB64krA489a6r7lPBwUi2Cfy8wr2NTmnV87GI02qFLJwfjF4xJJqEr7FYXi9f2ZZT
         eRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680727537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0UeBOixLMx1/cwwlyY3v1wGnqeW+j/bgN/ib4krdBY=;
        b=245H3JzQ1+S0Xc5eCxVYo2dWefVo+y3Vhry3vwW7b1S+12HNeC82x9Bm3eQZQ37vO+
         A1IB02fVyvuC6MA7U4/eQZ7euQX/V0LiYeczNnPfH3XOiukuu42IT5lbbz3meHvXPd/m
         hQPCbG4Z+GIg3bF9yRKTCw2qdBZ8Rv/0IjCysdtFs7qi/Io664lkSU/Iy57duI5cM4uK
         SeX5CSpgDuiuVcjuESsUYIToRw6dO7OWutx38ZCrlD1zvaPoSqUgK6GLFUWHYdGbRoBw
         4Ot7r7ji8KsZs9q7RnBkLUWujBOJ99AzmE+Aaxs+/79xed2a17Der1Pvfl3LH4lztLvU
         ESMw==
X-Gm-Message-State: AAQBX9d9bnlDpsjENPnNp7+cqH6up/wviDUcD+S+HY3QP30uWLt6eAQC
        FWNYniPbB8NASSRwvdJCN3VhXBKBDYPD8C83N9QYpYQEqkaqDIoJSw==
X-Google-Smtp-Source: AKy350Z/eeYzwlTjAipSYJYuiiIebGn4Q0mwc/FsHOIoNoCYUxVJ815mA1JdAIvg8BDeH+rG0esdGa1WwB6Z2cKayO0=
X-Received: by 2002:a25:cc42:0:b0:b76:ceb2:661b with SMTP id
 l63-20020a25cc42000000b00b76ceb2661bmr466502ybf.3.1680727537267; Wed, 05 Apr
 2023 13:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230204050954.11583-1-greg@enjellic.com> <20230204050954.11583-3-greg@enjellic.com>
 <CAHC9VhQnZhczVRifSnM-zv46Cb9OFuh=6ha+1zKJaOUK15=K5A@mail.gmail.com>
 <20230214115822.GA28408@wind.enjellic.com> <CAHC9VhQoj-aWrN5SxfkT2zaNmaKCG7VyYVvGsaHAbp5iA8OBZw@mail.gmail.com>
 <20230313225227.GA23057@wind.enjellic.com> <CAHC9VhSfQOw-q6b-DHL=zXFr7_Dw=44VxkDTpPp_=4XAZk2k7g@mail.gmail.com>
 <20230330033442.GA1014@wind.enjellic.com>
In-Reply-To: <20230330033442.GA1014@wind.enjellic.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Apr 2023 16:45:26 -0400
Message-ID: <CAHC9VhTQCLHQjEnBbGBZ7ya5s01hMr6WLLf_N54AmfYp_6TwsQ@mail.gmail.com>
Subject: Re: [PATCH 02/14] Add TSEM specific documentation.
To:     "Dr. Greg" <greg@enjellic.com>
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 29, 2023 at 11:35=E2=80=AFPM Dr. Greg <greg@enjellic.com> wrote=
:
> On Wed, Mar 22, 2023 at 07:45:26PM -0400, Paul Moore wrote:
> > On Mon, Mar 13, 2023 at 6:52???PM Dr. Greg <greg@enjellic.com> wrote:
> > > On Thu, Mar 02, 2023 at 11:15:56PM -0500, Paul Moore wrote:
> > >
> > > Hi Paul, thanks for sending along further comments.
> > >
> > > You note below that you haven't had time to look at the code since yo=
u
> > > wanted to confirm the TSEM security model before moving forward.
> > >
> > > From a development perspective we are now three weeks into what will
> > > become version 2 of the patch series.  So at this point I wouldn't
> > > advocate spending a lot of time on the current patchset.
> > >
> > > That being said, if you some have time, we would appreciate a quick
> > > look at the code on your part, with respect to style changes and the
> > > like we can enforce in the second series, ie. ordering of local
> > > variable declarations by length and the like.
>
> > To be perfectly honest I'm still very concerned about some of the
> > issues that I've seen in the docs, until that is sorted out I'm not
> > sure there is much point in looking at the code.
>
> I think those concerns can be resolved, see below for more
> information, the second patch series that we are closing in on should
> help address the concerns that are currently on the table.

In that case, I think it might be best to wrap up this thread and we
can resume the discussion on the next patchset.

> That being said, since TSEM is a new codebase, we were hoping that you
> could give us some guidance on function local variable ordering.
> Reverse Christmas tree seems popular writ large in the kernel, I
> believe that you commented in a posting a month or two ago that you
> prefer standard Christmas tree, SMACK and SeLinux don't seem to
> religiously embrace a style.
>
> Our codebase uses ordering based on least complex to most complex
> variables and has worked for us, both in the kernel and elsewhere, but
> we are ambivalent, as our primary objective is to avoid wasting
> everyone's time on issues such as this.

The canonical guidance on coding style within the kernel is in the kernel d=
ocs:

https://www.kernel.org/doc/html/latest/process/coding-style.html

When in doubt, I would recommend following that as closely as possible.

As far as local variable ordering is concerned, I don't believe I've
ever rejected patches due to that.  My own personal preference usually
follows what you've described above: the least complex (simple
scalars) at the top, with the more complex variables (composites) at
the bottom.  In practice this tends to result in a "Christmas Tree"
ordering, but it can be a bit lumpy (?) in some cases; that is fine.

There are two style nitpicks which annoy me enough to make it worth mention=
ing:

* Stick to 80 characters as much as possible, yes we all have
terminals that can go wider, but I like to have several terminals on
my screen and if they all need to be 100 chars wide I can't fit as
many.  There are going to be some exceptions, e.g. error message
string literals, but that should only happen a few times in a given
file.  If you are finding that every function you write has a line
that goes past 80 characters you are doing *something* wrong.

* If/when you split a single line across multiple lines due to the
above, make sure the
lines are indented properly such that they line up properly with the
code above.  It's tricky to give all of the different examples so I'm
not going to even try.  I realize that is garbage guidance, but the
kernel coding style is a help here.

If you are really lost, I use the following 'astyle' command in other
projects, and it should produce fairly kernel-style friendly code:

% astyle --options=3Dnone --lineend=3Dlinux --mode=3Dc \
    --style=3Dlinux \
    --indent=3Dforce-tab=3D8 \
    --indent-preprocessor \
    --indent-col1-comments \
    --min-conditional-indent=3D0 \
    --max-instatement-indent=3D80 \
    --pad-oper \
    --align-pointer=3Dname \
    --align-reference=3Dname \
    --max-code-length=3D80 \
    --break-after-logical

--=20
paul-moore.com
