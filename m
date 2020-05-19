Return-Path: <SRS0=coct=7B=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C55C433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 20:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C410A20674
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 20:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589918436;
	bh=JLU0NEysv33MM5MucZzZQHsgeXzfaNJ7YtATqrQxrCE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xYLXfQKgyVqf51Ea0gMSexf0HK4lQO5uvS6KfJk3hGlMcExREpgETY4aKQ8mG7pYs
	 l/oeohNdQXbGyvCj48yVJ1RuF4l/fDu4MBk1mMYbWxnce8xlLY0WbIjDiMUMaOB5Xm
	 Boxcp8+CKyTvQ8xrSR1zAoEbmkC44xYXtMOqjtoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgESUAf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 May 2020 16:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbgESUAd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 May 2020 16:00:33 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C8BC08C5C0
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2020 13:00:32 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id x20so403044ejb.11
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2020 13:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=REdFGTptWqU1qPX4qurL4342JovwYtU3BmwaSdni0jo=;
        b=W9vfQUXrQkvO4DXovXCeM4zoltpY1ZvWxEMenkkAoYs6zHAKFOlS07VVGBZxcFHdnr
         5UDWGSQ+Y1VhNSe2vl8jU8Abr4KLfjA+1Yw3wmcLWjiZR9tzxuzbfsBm4Q3VARObsqvY
         bKB2U0d4amvLqbkcAdva8jfUvV9Pe5jyvgAh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=REdFGTptWqU1qPX4qurL4342JovwYtU3BmwaSdni0jo=;
        b=PEnDWb0HTXuVxse2dajbWLJs9vQFYLfmmhlxycxpSK2nxVOlVJWzRNbo0wma5oR8he
         JHVLrsR8uPNH6ByQtoE5B2D2wC6rM8A5eoFgqzW1P+Xj3c64DETfPxtgGVC0L6aQrsj4
         agti0c/QCBr7XZfH7UToRMlnB+asj1a3rNL0Gt8/dv2nlNCpYxokgyMlwCSmYEef2707
         DM3OKPG2WsrHMWJOkuBUXpWwP8yOIMI2sWVExdz+hicPySd5GSI6O1oF5/kRW49GBKiy
         9lym2GbkcLBUz3SuXgbEeUdgKm0OwylSj9K5I6UrPaKTxtUmJdqGyCLgjfGrkFt2P+mh
         ewYg==
X-Gm-Message-State: AOAM531RF+mDAiP8C10h34lvuEsmLFZwmK/SUBkFbvcQnFMvsFHXa8cY
        ZPT017k5pDtbjBPUw6KFoRO/mqooMz4=
X-Google-Smtp-Source: ABdhPJy8MkRweVxv5zTrHwVKm+971EBJ5dAOtW8zJHqJ+FrokbbZzHVO/FiZ2QRPDPIVDZUGsMSpwQ==
X-Received: by 2002:a17:906:38d6:: with SMTP id r22mr837425ejd.74.1589918430914;
        Tue, 19 May 2020 13:00:30 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id p7sm191226edj.81.2020.05.19.13.00.30
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 13:00:30 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id l18so766405wrn.6
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2020 13:00:30 -0700 (PDT)
X-Received: by 2002:a05:651c:1183:: with SMTP id w3mr641496ljo.265.1589918096078;
 Tue, 19 May 2020 12:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87y2poyd91.fsf_-_@x220.int.ebiederm.org> <202005191220.2DB7B7C7@keescook>
In-Reply-To: <202005191220.2DB7B7C7@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 May 2020 12:54:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=cHD0oZTFgj0z33=8H8yKEcbn=eNpTj19GPEgJwrQzg@mail.gmail.com>
Message-ID: <CAHk-=wg=cHD0oZTFgj0z33=8H8yKEcbn=eNpTj19GPEgJwrQzg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] exec: Generic execfd support
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

On Tue, May 19, 2020 at 12:46 PM Kees Cook <keescook@chromium.org> wrote:
>
> Though frankly, I wonder if interp_flags could just be removed in favor
> of two new bit members, especially since interp_data is gone:

Yeah, I think that might be a good cleanup - but please keep it as a
separate thing at the end of the series (or maybe the beginning)

                Linus
