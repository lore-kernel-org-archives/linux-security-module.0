Return-Path: <SRS0=coct=7B=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B4CC433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 18:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 605672075F
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 18:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589913290;
	bh=HZKEgrtuNgZRRPBzTp902XaYAA8c4pKFHwBwB+tAhbA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=D9fQcCIpGFuNhb18ZmPM+pnvkWFJwFC36+n6KRaFskmmNK4snFtgWNsltobgPz+ZD
	 2mwONPe+u9EMkUzCA4BE2lAKkNTmMAos2GoUjMCVLR+MW67l5USTvYU/Tllq9jDPZK
	 M9tQOMlir/r2hsvY52CjaY9vd9cOIBlWn9nWe2pc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgESSeu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 May 2020 14:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESSet (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 May 2020 14:34:49 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B03AC08C5C0
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2020 11:34:49 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id be9so405966edb.2
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2020 11:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RAQPJr9ukcoBKjOXNq0ngI2FbToix/GR1U4DwPpfSy0=;
        b=JjHp/TA1wdi209GQDxk83iIpqXnffl3eJS5MEEAgukuWcKDbwj37gts7DFLkHruGuU
         nuDn1vvGhdSeq273vqMgVsMiaMP4nc1F6Pk64YouAMejNS/pKU4WwKHY+HH7P561hq9G
         XIbucUyW2ftN8EdLLtxsWXuyZC+00nekrisfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RAQPJr9ukcoBKjOXNq0ngI2FbToix/GR1U4DwPpfSy0=;
        b=d0Ho3ZP2XqjDlM9rmd3o9b2Bv+0oN5rsTML7ae8A/VV4PzUEbYpuGKizT4JFmf0HMA
         2QYxvW1z9YzXP/XjQSMxXfrciZIUt/SxHKtspHQr+pUvm5WtRp7WKx66Tb64jLEUMbj3
         jhTIvZGKgKUu0kNBsIcyTXs5IsMfbvv3E93CIKllWFIkUD6r4+NqbJnSoGpy7T4abOz3
         OKr4qp95tArEemMUP7vre/n2jvPBj/pS8zdBtH5cidWCyHReU2Rex7g0vSIAfAByaMAZ
         ROjccD1QTKM6oLJxjxs/gMRpUHIzvOu8Endsnfe/haUiQ/lr1qQaiNWH3ta5tTaJ/exQ
         hgCA==
X-Gm-Message-State: AOAM532ab71tPd0dlXFO7iYjl50F/1XJ58lhPf7Q7UM0UUDd9NuvtJEm
        nZ9ZWioa95+NdQj7kywLlOsDG/YgGgU=
X-Google-Smtp-Source: ABdhPJzgOGHW9RY5XV85DMN4q055t55fjwBkH48jlBFj+ggtZ3SikpwAwOZI/mOBnMmHcFQb5SVTKg==
X-Received: by 2002:a50:9d46:: with SMTP id j6mr248479edk.362.1589913287650;
        Tue, 19 May 2020 11:34:47 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id d15sm138032edr.3.2020.05.19.11.34.47
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 11:34:47 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id e10so414448edq.0
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2020 11:34:47 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr156726lfn.10.1589912910469;
 Tue, 19 May 2020 11:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <871rng22dm.fsf_-_@x220.int.ebiederm.org> <202005191101.1D420E03@keescook>
In-Reply-To: <202005191101.1D420E03@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 May 2020 11:28:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeoeh-F-PJmpYRpR_HoiB4r4qYgd3U6igtrUD6q5d_cg@mail.gmail.com>
Message-ID: <CAHk-=wjeoeh-F-PJmpYRpR_HoiB4r4qYgd3U6igtrUD6q5d_cg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] exec: Teach prepare_exec_creds how exec treats
 uids & gids
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, May 19, 2020 at 11:03 AM Kees Cook <keescook@chromium.org> wrote:
>
> One question, though: why add this, since the repeat calling of the caps
> LSM hook will do this?

I assume it's for the "preserve_creds" case where we don't even end up
setting creds at all.

Yeah, at some point we'll hit a bprm handler that doesn't set
'preserve_creds', and it all does get set in the end, but that's not
statically all that obvious.

I think it makes sense to initialize as much as possible from the
generic code, and rely as little as possible on what the binfmt
handlers end up actually doing.

              Linus
