Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5C0E7D0A1
	for <linux-security-module@archiver.kernel.org>; Thu, 21 Sep 2023 23:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjIUXDY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 21 Sep 2023 19:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjIUXDX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 21 Sep 2023 19:03:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72DA8F
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 16:03:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FCBC433CB;
        Thu, 21 Sep 2023 23:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695337397;
        bh=yiAJPS7cKpcCnvkdPKJifp9st2pGuTa8PlkgrYBhlyM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dX2mvSjp7wfXE1Tjc+4tIe794raC6MxcsKr547VvZA2ukL9HWXm4+F+IVphoQdfoA
         EX+IsZX9+I2+nUJVwEVUULMqiuy0XSPGd8jDJwSxD1VbV7OLeWJTY4punVYjqzABiq
         A7IAyfgVhQ+S5onKlArxFyDLtFZ8IqsFUtjT7DwO5He+wfRXe6MdZ7V6tceirA66rf
         ClXe7dVbQYnTgQNTLxtHI4fA7kBBNxfm3sNbD35CyFyddsmyvwNCdwbQ74gFJh82fV
         oPWmx04zP1k5aan/2B2JMWgzLidzncz1lbD25lrttOMIMZq+rsIaoA+J8W4W2DP43W
         j1i3ToXmmSHGg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50437f39c9dso288462e87.3;
        Thu, 21 Sep 2023 16:03:17 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw9YNpZup638hgJcX+nY68mVvyRnuSvuIiT7ueRe6UYl2XXX5Ry
        LJd0cLENMYFFGJrVO36xbqVBQRFKncac7YjY5UU=
X-Google-Smtp-Source: AGHT+IGwkoTBc42qppCWTYzp8kbRv8cvjHGFQplKxNefKyB24GZRp2GsOnKoTooRX75pS1haD8jDx4Q/U1umWcFLSKg=
X-Received: by 2002:ac2:5b1c:0:b0:503:314f:affe with SMTP id
 v28-20020ac25b1c000000b00503314faffemr5989903lfn.17.1695337395346; Thu, 21
 Sep 2023 16:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230918212459.1937798-1-kpsingh@kernel.org> <20230918212459.1937798-6-kpsingh@kernel.org>
In-Reply-To: <20230918212459.1937798-6-kpsingh@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 21 Sep 2023 16:03:02 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5LkyY8=t-yLKpS-fNWOy+yngEy96xkvajfgqA2HKLTFw@mail.gmail.com>
Message-ID: <CAPhsuW5LkyY8=t-yLKpS-fNWOy+yngEy96xkvajfgqA2HKLTFw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 18, 2023 at 2:25=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
[...]
>    0xffffffff818f0e72 <+66>:    mov    %r14,%rdi
>    0xffffffff818f0e75 <+69>:    mov    %ebp,%esi
>    0xffffffff818f0e77 <+71>:    mov    %rbx,%rdx
>    0xffffffff818f0e7a <+74>:    nopl   0x0(%rax,%rax,1)
>    0xffffffff818f0e7f <+79>:    test   %eax,%eax
>    0xffffffff818f0e81 <+81>:    jne    0xffffffff818f0e4d <security_file_=
ioctl+29>
>    0xffffffff818f0e83 <+83>:    jmp    0xffffffff818f0e49 <security_file_=
ioctl+25>
>    0xffffffff818f0e85 <+85>:    endbr64
>    0xffffffff818f0e89 <+89>:    mov    %r14,%rdi
>    0xffffffff818f0e8c <+92>:    mov    %ebp,%esi
>    0xffffffff818f0e8e <+94>:    mov    %rbx,%rdx
>    0xffffffff818f0e91 <+97>:    pop    %rbx
>    0xffffffff818f0e92 <+98>:    pop    %r14
>    0xffffffff818f0e94 <+100>:   pop    %rbp
>    0xffffffff818f0e95 <+101>:   ret
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Acked-by: Song Liu <song@kernel.org>

Thanks,
Song



> ---
>  security/Kconfig    | 11 +++++++++++
>  security/security.c | 12 +++++++-----
>  2 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/security/Kconfig b/security/Kconfig
> index 52c9af08ad35..bd2a0dff991a 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -32,6 +32,17 @@ config SECURITY
>
>           If you are unsure how to answer this question, answer N.
>
> +config SECURITY_HOOK_LIKELY
> +       bool "LSM hooks are likely to be initialized"
> +       depends on SECURITY
> +       default y
> +       help
> +         This controls the behaviour of the static keys that guard LSM h=
ooks.
> +         If LSM hooks are likely to be initialized by LSMs, then one get=
s
> +         better performance by enabling this option. However, if the sys=
tem is
> +         using an LSM where hooks are much likely to be disabled, one ge=
ts
> +         better performance by disabling this config.
> +
>  config SECURITYFS
>         bool "Enable the securityfs filesystem"
>         help
> diff --git a/security/security.c b/security/security.c
> index d1ee72e563cc..7ab0e044f83d 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -105,9 +105,9 @@ static __initdata struct lsm_info *exclusive;
>   * Define static calls and static keys for each LSM hook.
>   */
>
> -#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)                    \
> -       DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),             \
> -                               *((RET(*)(__VA_ARGS__))NULL));          \
> +#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)               \
> +       DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),       \
> +                               *((RET(*)(__VA_ARGS__))NULL));    \
>         DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ACTIVE_KEY(NAME, NUM));
>
>  #define LSM_HOOK(RET, DEFAULT, NAME, ...)                              \
> @@ -825,7 +825,8 @@ static int lsm_superblock_alloc(struct super_block *s=
b)
>   */
>  #define __CALL_STATIC_VOID(NUM, HOOK, ...)                              =
    \
>  do {                                                                    =
    \
> -       if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM)))=
 {    \
> +       if (static_branch_maybe(CONFIG_SECURITY_HOOK_LIKELY,             =
    \
> +                               &SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) { =
    \
>                 static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);    =
    \
>         }                                                                =
    \
>  } while (0);
> @@ -837,7 +838,8 @@ do {                                                 =
                            \
>
>  #define __CALL_STATIC_INT(NUM, R, HOOK, LABEL, ...)                     =
    \
>  do {                                                                    =
    \
> -       if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM)))=
 {  \
> +       if (static_branch_maybe(CONFIG_SECURITY_HOOK_LIKELY,             =
    \
> +                               &SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) { =
    \
>                 R =3D static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__=
);    \
>                 if (R !=3D 0)                                            =
      \
>                         goto LABEL;                                      =
    \
> --
> 2.42.0.459.ge4e396fd5e-goog
>
