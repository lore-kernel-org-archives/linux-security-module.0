Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281A5C64EC4
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Mar 2023 17:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjCCRy1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 Mar 2023 12:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjCCRy0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Mar 2023 12:54:26 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50DD5B5F6
        for <linux-security-module@vger.kernel.org>; Fri,  3 Mar 2023 09:54:19 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o12so13467949edb.9
        for <linux-security-module@vger.kernel.org>; Fri, 03 Mar 2023 09:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677866058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2o3rQetZgv6ewfCPpQy7L56u60VboNrnPcXuCAU8c9I=;
        b=e2Ior9ml2a6sA3xqp7/mjoi0eleFZCbAWkfIeYEfktk8tXziMAOZD/rb60OwD1S8Tq
         0ZKD5Fv3R1sSQd0bkxwWKqa3qP3F6K54E1OHOetzjSw1or205pyp9m8SbKstEClDabn9
         z96OmJ2w4kxlFMTrccZmn1jsSCSNXTRtfFVQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677866058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2o3rQetZgv6ewfCPpQy7L56u60VboNrnPcXuCAU8c9I=;
        b=i3Dw/fjfvSIN193Fwet+aVxNAEk3RNl0FB3k2mwED02Gd1hjDwrX6Ct2R7/2HZJsLL
         djNeA9kV3s1DbXEsUBZlQgCBrAG3SO1Q8ZL47/T2tQ5IDfCTc3+7kLIpGO9fn88DLl4i
         bX4n2iTOAwhwsm4LDPinC8s3i79X/B2H2extjury5MxxTyZtHu22jfSHuzwWSb6GQfms
         +jetM8mqwqgdCQCR2Od5WfrVw8QyBtZj88r0dohNvw/bORqU0LBlu0hfGqY2wwHlKi+h
         jpj375GUd1r2ecgVvNj+UAc+wUnUztpt+2apELEBM8ZhViqiCOf1/f/l7kXWQvUgKwwp
         v/vQ==
X-Gm-Message-State: AO0yUKWMcRTUJpKFMCmOcEb+nrmjbpelpXSerd3Dt4m10du8IDTevSgl
        k7pYkOmsFh5twLtkps5CFdAqtMt34sCZEDDs1p52zg==
X-Google-Smtp-Source: AK7set9unG6a/s304L1GVH4zKdRZDq9WqyPE0cqeA+jsOcWeSnpOX+H8W70bgVHyjwzdgNre3MOjsw==
X-Received: by 2002:aa7:c585:0:b0:4bf:38dc:d78 with SMTP id g5-20020aa7c585000000b004bf38dc0d78mr3078336edq.21.1677866058059;
        Fri, 03 Mar 2023 09:54:18 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id s23-20020a50d497000000b004c8948162e8sm1033798edi.67.2023.03.03.09.54.17
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 09:54:17 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id f13so13539581edz.6
        for <linux-security-module@vger.kernel.org>; Fri, 03 Mar 2023 09:54:17 -0800 (PST)
X-Received: by 2002:a17:906:b281:b0:8b8:aef3:f2a9 with SMTP id
 q1-20020a170906b28100b008b8aef3f2a9mr1190087ejz.0.1677866056901; Fri, 03 Mar
 2023 09:54:16 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein> <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV> <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
 <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
 <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
 <ZAD21ZEiB2V9Ttto@ZenIV> <6400fedb.170a0220.ece29.04b8@mx.google.com>
 <ZAEC3LN6oUe6BKSN@ZenIV> <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
 <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
In-Reply-To: <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Mar 2023 09:54:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
Message-ID: <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Mar 3, 2023 at 9:39=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> So the key is: memset is underperforming at least on x86-64 for
> certain sizes and the init-on-alloc thingy makes it used significantly
> more, exacerbating the problem

One reason that the kernel memset isn't as optimized as memcpy, is
simply because under normal circumstances it shouldn't be *used* that
much outside of page clearing and constant-sized structure
initialization.

Page clearing is fine, and constant-sized structure inits are also
generally fine (ie the compiler does the small ones directly).

So this is literally a problem with pointless automated memset,
introduced by that hardening option. And hardening people generally
simply don't care about performance, and the people who _do _care
about performance usually don't enable the known-expensive crazy
stuff.

Honestly, I think the INIT_ONCE stuff is actively detrimental, and
only hides issues (and in this case adds its own). So I can't but help
to say "don't do that then". I think it's literally stupid to clear
allocations by default.

I'm not opposed to improving memset, but honestly, if the argument is
based on the stupid hardening behavior, I really think *that* needs to
be fixed first.

               Linus
