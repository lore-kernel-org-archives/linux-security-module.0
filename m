Return-Path: <SRS0=8Njt=PS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FC2C43387
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Jan 2019 23:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD65208E3
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Jan 2019 23:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vhh1BNPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfAJXEK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:04:10 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39327 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfAJXEK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 Jan 2019 18:04:10 -0500
Received: by mail-yb1-f194.google.com with SMTP id n187so5128499yba.6
        for <linux-security-module@vger.kernel.org>; Thu, 10 Jan 2019 15:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YMFQW/+G1M8ookMqR3/WvTatVH1o+WnzddDyBHokWTU=;
        b=Vhh1BNPwHGJaSg79o4iDwCTviCam9kPF4OStqUqziXfrQWVMdpoie8sVGfmsFvK5HG
         bZVRP7/Xax58YC1///z93WnPJeNdE6SMaMAjR+ckAlk25Rn3UkZnmkHhTf60ECavFX5T
         yTkn62uGsooa22i9El+a8vk/lPeNRJHaOpcyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YMFQW/+G1M8ookMqR3/WvTatVH1o+WnzddDyBHokWTU=;
        b=Bj837F4WgE1i1HQ2v46rlBBZgTQaX/2F06GIySO4Nn+8PdvjdevRtvdNReRfcOI1vR
         aaSn8undNlOlPQRclEJjTvUuzGZGt5zYK3DqQ0b/nAksETSD/TElArliw7WwXDLMauz7
         DlUENC+4h8WF9HjdvqHBRLg8r0/gTcqin4N04qP0zA+fmj8ejeb6KVHAtYRd2fLqvRqC
         40UKUi7BrKsXBEHS9kprG3K843hsWSXMNnaUaglj/OYddxpSIxkW0y81WWifjWxofWWe
         ttsMASUTZI/AdmSLxieSIiOgTl+2iOE6m9E7W9R3rPQJrf3FSCdjBMBcpopLKdXGEdCE
         i7pQ==
X-Gm-Message-State: AJcUukeVLOuFKx5PIq5hG9o4XjbIHQOTI5x3e6hmGSI4ae/IvN2YenKw
        S/bAW+q4zETCcKmyOqXRerBFStAqRjI2Th5hJw4EiZ0Z
X-Google-Smtp-Source: ALg8bN7Eckz0J1kM39F6NeQEBlAIGsEmd705kmIjjFb7+smvVYwowplmwUv2vdrUK/31IGLeoeTimvqN8Qprf+hvaHY=
X-Received: by 2002:a25:9d09:: with SMTP id i9mr3845932ybp.260.1547161449795;
 Thu, 10 Jan 2019 15:04:09 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5jKoNQJ1FNVisxr6VHD9DuUFL2eLV5pD5orHe__sDGr5MA@mail.gmail.com>
 <20190108001053.235201-1-mortonm@chromium.org> <alpine.LRH.2.21.1901110930470.13638@namei.org>
In-Reply-To: <alpine.LRH.2.21.1901110930470.13638@namei.org>
From:   Micah Morton <mortonm@chromium.org>
Date:   Thu, 10 Jan 2019 15:03:58 -0800
Message-ID: <CAJ-EccOrsKmcNC_FEPedJ2KHoLvPj-zVTTqr2o81LMeSsXkX0w@mail.gmail.com>
Subject: Re: [PATCH v4] LSM: generalize flag passing to security_capable
To:     James Morris <jmorris@namei.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Sounds good, thanks!

On Thu, Jan 10, 2019 at 2:31 PM James Morris <jmorris@namei.org> wrote:
>
> On Mon, 7 Jan 2019, mortonm@chromium.org wrote:
>
> > From: Micah Morton <mortonm@chromium.org>
> >
> > This patch provides a general mechanism for passing flags to the
> > security_capable LSM hook. It replaces the specific 'audit' flag that is
> > used to tell security_capable whether it should log an audit message for
> > the given capability check. The reason for generalizing this flag
> > passing is so we can add an additional flag that signifies whether
> > security_capable is being called by a setid syscall (which is needed by
> > the proposed SafeSetID LSM).
> >
> > Signed-off-by: Micah Morton <mortonm@chromium.org>
>
> Applied to
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
> and next-testing
>
> --
> James Morris
> <jmorris@namei.org>
>
