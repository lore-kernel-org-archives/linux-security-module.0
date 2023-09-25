Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8CECE7A94
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Sep 2023 11:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjIYLW4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjIYLWy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Sep 2023 07:22:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB1AD3
        for <linux-security-module@vger.kernel.org>; Mon, 25 Sep 2023 04:22:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38F7C433C7
        for <linux-security-module@vger.kernel.org>; Mon, 25 Sep 2023 11:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695640966;
        bh=9B0VMWVCC/JnnEl+dQaf/YsS5ypMm+klOTZzH+rWoWQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c3iyGDiqBpp8eLHl/BU8sccyPXnhuLvfQVf23ABFxEL6vrMXgluyo7MuG8P116VC8
         tR7uF1w4zhHchu2HVXrzMWVAb2aYy/bIUbWMwP78wlQYCOptoJQANX6tsM3KBJqpuL
         ZhRQBw3F/uwkTEaK9U025gkq2FOKkVNFB5rPJvMix6a1KT3+IKCcLE1AUzu34NhRXv
         WlI4IJS+4/FBeDHV47TxCNtHnp9lcdVswgdj4Oim0TXXwkWHmAfdl88qAW921leeZf
         oqlKWBKqzDmDKjww8VndBK6STi2dr83LNzxaBZkifv1v0CUyHmmqB848HkZLXJ72OS
         T6KKm+yX+s8Zw==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-533edb5ac54so2828452a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 25 Sep 2023 04:22:46 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz/crrZQ03i4Q6JR/1/09ySq4lywkVZ/3Ks28QV3wIDjodZZg8D
        b0tKXWtNeFv/eZe7BTRhId5i6X6eR2ggYr/5WkrDnQ==
X-Google-Smtp-Source: AGHT+IGtn6AgZOvnNk7P2eY7QpV59/VNCHiQT4Ka4mGDL7IHPTeC0MbtLyjGiv+4fvLujL7GdF/pMU1wn+TkCjrR22s=
X-Received: by 2002:aa7:ca54:0:b0:532:c08a:eac0 with SMTP id
 j20-20020aa7ca54000000b00532c08aeac0mr4682310edt.26.1695640965276; Mon, 25
 Sep 2023 04:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230918212459.1937798-1-kpsingh@kernel.org> <20230918212459.1937798-3-kpsingh@kernel.org>
 <cb67f607-3a9d-34d2-0877-a3ff957da79e@I-love.SAKURA.ne.jp>
 <CACYkzJ5GFsgc3vzJXH34hgoTc+CEf+7rcktj0QGeQ5e8LobRcw@mail.gmail.com>
 <dde20522-af01-c198-5872-b19ef378f286@I-love.SAKURA.ne.jp>
 <CACYkzJ5M0Bw9S_mkFkjR_-bRsKryXh2LKiurjMX9WW-d0Mr6bg@mail.gmail.com>
 <ed785c86-a1d8-caff-c629-f8a50549e05b@I-love.SAKURA.ne.jp>
 <CACYkzJ4TLCMFEa5h-iEVC-58cakjduw44c-ct64SgBe0_jFKuQ@mail.gmail.com> <6a80711e-edc4-9fab-6749-f1efa9e4231e@I-love.SAKURA.ne.jp>
In-Reply-To: <6a80711e-edc4-9fab-6749-f1efa9e4231e@I-love.SAKURA.ne.jp>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 25 Sep 2023 13:22:34 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4AGRcqLPqWY65OC778EPaUwTBpyOMfiVBXa4EmnHTXGQ@mail.gmail.com>
Message-ID: <CACYkzJ4AGRcqLPqWY65OC778EPaUwTBpyOMfiVBXa4EmnHTXGQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 25, 2023 at 1:03=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2023/09/24 1:06, KP Singh wrote:
> >> I was not pushing LKM-based LSM because the LSM community wanted to ma=
ke it possible to
> >> enable arbitrary combinations (e.g. enabling selinux and smack at the =
same time) before
> >> making it possible to use LKM-based LSMs.
> (...snipped...)
> >> As a reminder to tell that I still want to make LKM-based LSM official=
ly supported again,
> >> I'm responding to changes (like this patch) that are based on "any LSM=
 must be built into
> >> vmlinux". Please be careful not to make changes that forever make LKM-=
based LSMs impossible.
>
> You did not recognize the core chunk of this post. :-(
>
> It is Casey's commitment that the LSM infrastructure will not forbid LKM-=
based LSMs.
> We will start allowing LKM-based LSMs. But it is not clear how we can mak=
e it possible to
> allow LKM-based LSMs.

I think this needs to be discussed if and when we allow LKM based LSMs.

>
> Suppose you replace the linked list (which does not need to limit number =
of LSMs activated)
> with static calls (which limits number of LSMs activated, due to use of c=
ompile-time determined
> MAX_LSM_COUNT value at
>
>   struct lsm_static_calls_table {
>         #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
>                 struct lsm_static_call NAME[MAX_LSM_COUNT];
>         #include <linux/lsm_hook_defs.h>
>         #undef LSM_HOOK
>   } __randomize_layout;
>
> . If NAME[MAX_LSM_COUNT] were allocated like
>
>   NAME =3D kcalloc(sizeof(struct lsm_static_call), number_of_max_lsms_to_=
activate, GFP_KERNEL | __GFP_NOFAIL);
>
> (where number_of_max_lsms_to_activate is controlled using kernel command =
line parameter)
> rater than
>
>   struct lsm_static_call NAME[MAX_LSM_COUNT];
>
> , it is easy to allow LKM-based LSMs.
>

One needs to know MAX_LSM_COUNT at compile time (not via kernel
command line), I really suggest you try out your suggestions before
posting them. I had explained this to you earlier, you still chose to
ignore and keep suggesting stuff that does not work.

https://lore.kernel.org/bpf/CACYkzJ7Dn=3DW1Kd5M_bXOzoomzdjMXBoEZZo5k=3DcgQ4=
R6f5G+vw@mail.gmail.com/

It is used in the preprocessor to generate the static calls, it cannot
come from the command line.

> But if NAME[MAX_LSM_COUNT] is allocated in a way which cannot be expanded=
 using kernel
> command line parameter (this is what "[PATCH v3 2/5] security: Count the =
LSMs enabled
> at compile time" does), how can the LKM-based LSMs be registered? Introdu=
ce a LSM module
> which revives the linked list and registration function (which this patch=
 tried to remove) ?
> If yes, do we want to use
>
>   #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
>
> for built-in LSMs and a different macro for LKM-based LSMs?
>
> Do we want/agree to manage two different set of macros/functions only for=
 handling
> both built-in LSMs and loadable LSMs?

We will see when this happens. I don't think it's a difficult problem
and there are many ways to implement this:

* Add a new slot(s) for modular LSMs (One can add up to N fast modular LSMs=
)
* Fallback to a linked list for modular LSMs, that's not a complexity.
There are serious performance gains and I think it's a fair trade-off.
This isn't even complex.

Now, this patch and the patch that makes security_hook_heads
__ro_after_init by removing CONFIG_SECURITY_HOOKS_WRITABLE breaks your
hack. But that hack (https://akari.osdn.jp/1.0/chapter-3.html.en) is
unsupported.

>
> That's a lot of complication, compared to temporarily making the security=
_hook_heads writable.

No, that's not complicated.  All I can say is, when the time comes,
and if the community agrees on LMK based modules, this patch won't
make it any difficult or easy. There are many implementations, even
this patch, that can provide LKM based LSMs API (but hacks will be
hard, sure!)


- KP

>
>
>
> > You are trying to use an unexported symbol from the module with lots
> > of hackery to write to be supported and bring it up in a discussion?
> > Good luck!
>
> Currently LKM-based LSMs is not officially supported. But LKM-based LSMs =
will become
> officially supported in the future. Therefore, I respond to any attempt w=
hich tries
> to make LKM-based LSMs impossible.
>
> >
> > Regardless, if what you are doing really works after
> > https://lore.kernel.org/all/20200107133154.588958-1-omosnace@redhat.com=
,
> > then we need to fix this as the security_hook_heads should be
> > immutable after boot.
>
> You should learn how the __ro_after_init works. I will throw NACK if some=
one tries
> to add an exception to __ro_after_init handling before we make it possibl=
e to allow
> LKM-based LSMs.
>
