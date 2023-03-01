Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B876C64ED6
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Mar 2023 18:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjCASOG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 1 Mar 2023 13:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjCASOF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Mar 2023 13:14:05 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7329941B5E
        for <linux-security-module@vger.kernel.org>; Wed,  1 Mar 2023 10:13:59 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o15so54988054edr.13
        for <linux-security-module@vger.kernel.org>; Wed, 01 Mar 2023 10:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677694437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/asb3PYi302CsLXOXWpBQTKIfyQX2PG5Qj/oLUdH5k=;
        b=VcEiiaTfxPmiqwXoecvpahehdctu63BLGW4saFO/UrTcs1beWBHcWiztIw4qeMLbtN
         UDhVjdTYZ+U8fsUpZKjsT4dWBeA5xIObDM5vZ0oqdg6xFxGAE/ONB29DGc4bgwj08Yi/
         pe4O9bVEPFq8625OTiGntkymQ9EyiAsiFSpUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677694437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/asb3PYi302CsLXOXWpBQTKIfyQX2PG5Qj/oLUdH5k=;
        b=l0q0Bgvc5K2xVHH+ZRNw+G1rJ1MELoezIwmh2om9DHeQ1kj8KegK6FLfsne4LloxVv
         8V8xikaaqO13Eup2+lnaVY84mndVxtTCLLf8bi5tLs94N36DT6jlSDi0EosEQnm54oPm
         18cz3RsiCMqEMr5HddcC9pfb0TszyYFT716RY6K7482BMPx6caHzyce98euFYvm/62D8
         8WR2vLpHgG2GgLD6xsYXfuQHJN44XVl24BjQ4ZMUIiXHzrsIymuL/VXmjg0v1/sDu7FD
         PdFhwaQxSr6nLoIEeUlCaviqJNi77qy6fIUBxP43GGrEGSKSQJO03tHg7KX/fFZt+lGE
         E+JA==
X-Gm-Message-State: AO0yUKUxSszAZCoeOAJ2axu5yZK7uuOgYQU6X+xS3pfuWNXoDiEASVqr
        +fc09S5iVSR9HZfDmQ1pHF3JIaqg/HxoRKEz4HIPfQ==
X-Google-Smtp-Source: AK7set8eI0YbIH0sgAOHaUh4tcwyQmQgGY4akWLnUb8SXzEG0hqYnxroF3qsywnJfzn1wXMdgBAoXw==
X-Received: by 2002:a17:906:2658:b0:88a:a27c:c282 with SMTP id i24-20020a170906265800b0088aa27cc282mr7368767ejc.47.1677694437498;
        Wed, 01 Mar 2023 10:13:57 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id hg24-20020a1709072cd800b008d68d018153sm5993248ejc.23.2023.03.01.10.13.56
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 10:13:56 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id o15so54987646edr.13
        for <linux-security-module@vger.kernel.org>; Wed, 01 Mar 2023 10:13:56 -0800 (PST)
X-Received: by 2002:a17:906:2ec8:b0:877:747e:f076 with SMTP id
 s8-20020a1709062ec800b00877747ef076mr3586877eji.0.1677694436076; Wed, 01 Mar
 2023 10:13:56 -0800 (PST)
MIME-Version: 1.0
References: <20230125155557.37816-1-mjguzik@gmail.com> <CAHk-=wjz8O4XX=Mg6cv5Rq9w9877Xd4DCz5jk0onVKLnzzaPTA@mail.gmail.com>
 <97465c08-7b6e-7fd7-488d-0f677ac22f81@schaufler-ca.com> <CAGudoHEV_aNymUq6v9Trn_ZRU45TL12AVXqQeV2kA90FuawxiQ@mail.gmail.com>
 <CAHk-=wgCMTUV=5aE-V8WjxuCME8LTBh-8k5XTPKz6oRXJ_sgTg@mail.gmail.com>
 <CAHk-=whwBb5Ws8x6aDV9u6CzMBQmsAtzF+UjWRnoe9xZxuW=qQ@mail.gmail.com>
 <CAGudoHH-u3KkwSsrSQPGKmhL9uke4HEL8U1Z+aU9etk9-PmdQQ@mail.gmail.com> <CAHk-=wgsVFvGrmbedVgpUjUJaRTMVxvGkr-dcR7s30S_MyDZfA@mail.gmail.com>
In-Reply-To: <CAHk-=wgsVFvGrmbedVgpUjUJaRTMVxvGkr-dcR7s30S_MyDZfA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Mar 2023 10:13:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=whmk3EnmFU6XbLjMZW_ZBU8UJGDEyua7m5Aa3pmgtVQRg@mail.gmail.com>
Message-ID: <CAHk-=whmk3EnmFU6XbLjMZW_ZBU8UJGDEyua7m5Aa3pmgtVQRg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] capability: add cap_isidentical
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Serge Hallyn <serge@hallyn.com>, viro@zeniv.linux.org.uk,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 28, 2023 at 1:29=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That said, the old code was worse. The only redeeming feature of the
> old code was that "nobody has touched it in ages", so it was at least
> stable.

Bah. I've walked through that patch something like ten times now, and
decided that there's no way it breaks anything. Famous last words.

It also means that I don't want to look at that ugly old code when I
have the fix for it all, so I just moved it over from my experimental
tree to the main tree, since it's still the merge window.

Quod licet Iovi, non licet bovi, or something.

                 Linus
