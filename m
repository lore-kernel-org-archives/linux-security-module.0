Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F81CC6FA8E
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Mar 2023 19:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCBTLF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Mar 2023 14:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCBTK6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Mar 2023 14:10:58 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712723D099
        for <linux-security-module@vger.kernel.org>; Thu,  2 Mar 2023 11:10:45 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id i34so1127192eda.7
        for <linux-security-module@vger.kernel.org>; Thu, 02 Mar 2023 11:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677784221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjZUS58uO/4cp4F+HOOvaFHdemHu/dQSnYjcnUBCECA=;
        b=XS9jwU97vp2iRecHS67+yW7nKfBIjGIVzjTCrxTZji4bmZ/TtJNTQFZcHTB67qLslK
         vg4hnoT/zFqmLndtWoXwBhXFKB/ARtUn24UU95MilbxGow59e08QdvIZhx1hn6hJNUC7
         HryP3hmdj9llUUHbeaUHyKTOPtsywMF4rTFl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677784221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjZUS58uO/4cp4F+HOOvaFHdemHu/dQSnYjcnUBCECA=;
        b=zBXPk+0yZacQ/OEDTDmw1a03yxl7Cwbm/I+CVZ22MP4WVEoa3DWLHFix4JKAFVre33
         F2vS2ZU5jVbSaTJ7UUU6Dh0Gvga8tk436T9AHGw6AWcLTEYTa/H3Ue5l9+WQMsCjcqVS
         aV77U+BZIxMvSY4cBs6R0mGBqvukt7A7lS344A9zqa9QeR5La7kqOtmT6+FpB9ULmSHC
         TRjJ/dIqn6OvJLIPXeqKc5CzdhIy8UuON7OpggJK0jxeU4ictW/WD6JdGKBPjvqFlXP5
         8XcqNHwzAI8w6gSmml0TadA2bZCblu8v6XVwJk7BYDmu5kO2zs8GH2MPhvtwZTGra1H/
         QS6A==
X-Gm-Message-State: AO0yUKUXFR7Hepu0ZUhSXpsDg1D3WbqowAAHedmKLK5wV4Ufy80ozFCI
        k9EL3IBbfH0U8ZDg+1Rr9x1oI3Ctp6KZDy1c164=
X-Google-Smtp-Source: AK7set8R9jIEQHnBQqE4Karmtuqom6fnmRo9BkcfglPTvHdeuNMhE5ArJEt4a8r9iIFnMWD2UNiIzw==
X-Received: by 2002:a17:906:4ccb:b0:8b1:7ab0:a462 with SMTP id q11-20020a1709064ccb00b008b17ab0a462mr10640633ejt.7.1677784221153;
        Thu, 02 Mar 2023 11:10:21 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id z92-20020a509e65000000b004bc11e5f8b9sm216641ede.83.2023.03.02.11.10.20
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 11:10:20 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id s11so1108883edy.8
        for <linux-security-module@vger.kernel.org>; Thu, 02 Mar 2023 11:10:20 -0800 (PST)
X-Received: by 2002:a50:cdd5:0:b0:4bc:13f5:68a5 with SMTP id
 h21-20020a50cdd5000000b004bc13f568a5mr3966173edj.5.1677784219765; Thu, 02 Mar
 2023 11:10:19 -0800 (PST)
MIME-Version: 1.0
References: <20230125155557.37816-1-mjguzik@gmail.com> <20230125155557.37816-2-mjguzik@gmail.com>
 <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein> <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV> <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
 <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
In-Reply-To: <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Mar 2023 11:10:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
Message-ID: <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 2, 2023 at 11:03=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It might be best if we actually exposed it as a SLAB_SKIP_ZERO thing,
> just to make it possible to say - exactly in situations like this -
> that this particular slab cache has no advantage from pre-zeroing.

Actually, maybe it's just as well to keep it per-allocation, and just
special-case getname_flags() itself.

We could replace the __getname() there with just a

        kmem_cache_alloc(names_cachep, GFP_KERNEL | __GFP_SKIP_ZERO);

we're going to overwrite the beginning of the buffer with the path we
copy from user space, and then we'd have to make people comfortable
with the fact that even with zero initialization hardening on, the
space after the filename wouldn't be initialized...

            Linus
