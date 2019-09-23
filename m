Return-Path: <SRS0=2B8k=XS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70309C432C1
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Sep 2019 21:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467C7207FD
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Sep 2019 21:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569274729;
	bh=wuRvLkmAjW9scB7C3ulVTQLJ84PCN92PfL195gJrcIo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BofI61PjkJaFNFAM1r2Hey4GvS94eVTeSP5qPJNiQKeQdR5RWPeFXp60rpooTRDtd
	 6/I3exxDOXhRRMMZ1Vqj78IfcMNGBAaA6JtXD0vz6MxPXogJhw845QSWPZeUDqPJaF
	 Q+JLgUTDQUqCFI9MWCgfcKuOhaA1Mpmuh67wnb/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389058AbfIWVis (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 23 Sep 2019 17:38:48 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43977 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390047AbfIWVir (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Sep 2019 17:38:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id n14so10160951ljj.10
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2019 14:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2a5iRl0pwYddtRZuyM8DbsyUr2hb638EoJcEbjk4XVU=;
        b=JcoEGS/AI2rU99SMqow9YrwJpVhAdInWmVe0K73EpxT4IX0dSd4iV6gEYJNry3t1NZ
         czy0P2z6QFvutymUbR9Kl/JfZ7V+MTGu8fD757Q0hU9hsZCA1KKVL4ex53vmZh/jPMib
         pBCmfcv12WS9ovtx+DEcpFDjd8BQTAsbCG3Fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2a5iRl0pwYddtRZuyM8DbsyUr2hb638EoJcEbjk4XVU=;
        b=izIhUJmmnlwJ7g3X+joOS/Z3ew3Dn0V0oqSYoJyLxpiU/SYBnfDqoR+/fOGCgmZjw3
         bv5zlcA2g7LNLFra1zulHtXoTnJRUyS1E+RtNXE7UWI8T3eiVIbytxuflJh9IfQNIW/T
         LLG5KehFqCW+Q+JrJtJJFA08fw7JJZ2GOwaOk3LDWnZx9Cxd1xE7Qj19GUC6nYVuV9Tn
         6cbgXz56YqcwAhFd9BnjH72TZOSbnlqQTNlCs0xC5floittZqt+5f9hbNPWusWe1UVKt
         VV70lrCGu/ED85fUvbn00ohLP8UnHqg5UF2SKAPZoVTik9Urk/nVu7cNA0cbsIqYJZHU
         cYkQ==
X-Gm-Message-State: APjAAAVOcghTr6FPve1ycLdOT3uMgh5f4VyJNQ13h08Rd9yF5eDVPFVo
        Fe+sFVINCeQJpPNNCci1iCzNZQMZhm8=
X-Google-Smtp-Source: APXvYqzHAe3JDcL3OLvkLfE1oqz02KlyHamQHPPAIp6WJlvgy41BH4LzPICBOW5xONC+66ide2ZGsw==
X-Received: by 2002:a2e:9014:: with SMTP id h20mr807789ljg.154.1569274725116;
        Mon, 23 Sep 2019 14:38:45 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id d25sm2475939lfj.15.2019.09.23.14.38.44
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 14:38:44 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id x80so11327086lff.3
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2019 14:38:44 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr945017lfh.29.1569274723803;
 Mon, 23 Sep 2019 14:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <745ac819-f2ae-4525-1855-535daf783638@schaufler-ca.com> <CAHk-=wg1zkUTdnx5pNVOf=uuSJiEywNiztQe4oRiPb1pfA399w@mail.gmail.com>
In-Reply-To: <CAHk-=wg1zkUTdnx5pNVOf=uuSJiEywNiztQe4oRiPb1pfA399w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Sep 2019 14:38:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNi_y5SaXGS3hsxsFcU8P89O9ayJZ6yEYkvCC115J40A@mail.gmail.com>
Message-ID: <CAHk-=wgNi_y5SaXGS3hsxsFcU8P89O9ayJZ6yEYkvCC115J40A@mail.gmail.com>
Subject: Re: [GIT PULL] Smack patches for v5.4 - retry
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 23, 2019 at 2:35 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Sep 23, 2019 at 1:14 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > Thank for the instruction. I think this is correct.
>
> Looks fine, pulled.

Oh, btw, can you get more signatures on your pgp key? I actually care
more about having a key than having a key with lots of signatures (*),
but signatures and a chain of trust would be good too.

                   Linus

(*) To me, keys are more of a "yeah, I'm the same person that usually
sends these pull requests" than some kind of hard identity.
