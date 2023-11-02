Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447C5C4332F
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Nov 2023 02:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjKBC0i (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 1 Nov 2023 22:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjKBC0i (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Nov 2023 22:26:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF09BD;
        Wed,  1 Nov 2023 19:26:34 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9c603e235d1so59643566b.3;
        Wed, 01 Nov 2023 19:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698891993; x=1699496793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MU3HEKMjwjEss86nUM6Tt7NRWy8sERl+rS/cY5fhYNQ=;
        b=bi865bJSao3a73O0O4bT8Lv0J0eyMymzN1mpfwggjfhTmDTPiR2+7FqrDRs1Af+bhM
         m1M5Tfq9fRpBUxUyt6XlOQkMWBhP2OwurhUB8UEC7SMu+arfNEr2YYIZjrziCRoz53ZG
         OGIdO3/2ylyqb7fs0OxjqnQ/P0SzBHRMl72R335I24nR7DGw/lEpVEaY30DQFUMQSrmV
         e2jgUiFRyMYLNknTvViJgCikTLt7zy7PNhlGBiWq7LYZyZ/mxvVGNFBBJGlx7pwogm2O
         4vO+DZH/TvBJ2mmBKWVKPWQVq/mZRRVXoJamGdY7nGkylDimLkw5SPN2k03g4+0dpSv8
         XaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698891993; x=1699496793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MU3HEKMjwjEss86nUM6Tt7NRWy8sERl+rS/cY5fhYNQ=;
        b=dVFaLMPncJECKW1fq63BemqNTJSERC1qpdk4Nnpn1tWbtB67GEKjipt260Tf3CoEvu
         iMTNvF/3vdBZ2Ay1OT0O5U8LpcE1dHd0haWxmGw0l/LpLuiV4K6tL4gOt4cLYeXCdz29
         7Re0FlatqSSSIa1D1HOts9P6KrJPejmlg9gPshRJnx3J/mPJHOVfKt0muUvEU68vdVrH
         s4zvjP6at3ZKScLTtOEpW/rsdW+7Cb37JTfp7QlPhZVUObnuMutxzDNetVkkK1fsxCPj
         OSujLqIYCYoFAtVQbNoe91G1QOLp0vwuiNR5dVrYqUcy8KtO4idtFRmvPopT+bZuApZI
         +8Ng==
X-Gm-Message-State: AOJu0YySiKixQcc50mM/mJ39u9cWGlubCaQr3NJZ0bFehTXn/VAQKXHA
        6gQN2u3TyNkOC5Re/5iA+aAsEBxfonMjaPWnIvE=
X-Google-Smtp-Source: AGHT+IFdha8UB19M7i0O4HOOeRACGtwNPqrnTLhtDvDIUlAaVtwujhYaxNPlygHjgeVrm/uI/SiJQ0ebNjb+RGpLvAI=
X-Received: by 2002:a17:907:944e:b0:9ae:4054:5d2a with SMTP id
 dl14-20020a170907944e00b009ae40545d2amr2745382ejc.16.1698891992974; Wed, 01
 Nov 2023 19:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231102005521.346983-1-kpsingh@kernel.org> <20231102005521.346983-5-kpsingh@kernel.org>
In-Reply-To: <20231102005521.346983-5-kpsingh@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Nov 2023 19:26:22 -0700
Message-ID: <CAEf4Bzakdg3pxQZtjYZGrvZPo-nmpsxB0=Ymp9q+KFYOPViu=Q@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] bpf: Only enable BPF LSM hooks when an LSM program
 is attached
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        renauld@google.com, pabeni@redhat.com, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 1, 2023 at 5:55=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
>
> BPF LSM hooks have side-effects (even when a default value is returned),
> as some hooks end up behaving differently due to the very presence of
> the hook.
>
> The static keys guarding the BPF LSM hooks are disabled by default and
> enabled only when a BPF program is attached implementing the hook
> logic. This avoids the issue of the side-effects and also the minor
> overhead associated with the empty callback.
>
> security_file_ioctl:
>    0xffffffff818f0e30 <+0>:     endbr64
>    0xffffffff818f0e34 <+4>:     nopl   0x0(%rax,%rax,1)
>    0xffffffff818f0e39 <+9>:     push   %rbp
>    0xffffffff818f0e3a <+10>:    push   %r14
>    0xffffffff818f0e3c <+12>:    push   %rbx
>    0xffffffff818f0e3d <+13>:    mov    %rdx,%rbx
>    0xffffffff818f0e40 <+16>:    mov    %esi,%ebp
>    0xffffffff818f0e42 <+18>:    mov    %rdi,%r14
>    0xffffffff818f0e45 <+21>:    jmp    0xffffffff818f0e57 <security_file_=
ioctl+39>
>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^
>
>    Static key enabled for SELinux
>
>    0xffffffff818f0e47 <+23>:    xchg   %ax,%ax
>                                 ^^^^^^^^^^^^^^
>
>    Static key disabled for BPF. This gets patched when a BPF LSM program
>    is attached
>
>    0xffffffff818f0e49 <+25>:    xor    %eax,%eax
>    0xffffffff818f0e4b <+27>:    xchg   %ax,%ax
>    0xffffffff818f0e4d <+29>:    pop    %rbx
>    0xffffffff818f0e4e <+30>:    pop    %r14
>    0xffffffff818f0e50 <+32>:    pop    %rbp
>    0xffffffff818f0e51 <+33>:    cs jmp 0xffffffff82c00000 <__x86_return_t=
hunk>
>    0xffffffff818f0e57 <+39>:    endbr64
>    0xffffffff818f0e5b <+43>:    mov    %r14,%rdi
>    0xffffffff818f0e5e <+46>:    mov    %ebp,%esi
>    0xffffffff818f0e60 <+48>:    mov    %rbx,%rdx
>    0xffffffff818f0e63 <+51>:    call   0xffffffff819033c0 <selinux_file_i=
octl>
>    0xffffffff818f0e68 <+56>:    test   %eax,%eax
>    0xffffffff818f0e6a <+58>:    jne    0xffffffff818f0e4d <security_file_=
ioctl+29>
>    0xffffffff818f0e6c <+60>:    jmp    0xffffffff818f0e47 <security_file_=
ioctl+23>
>    0xffffffff818f0e6e <+62>:    endbr64
>    0xffffffff818f0e72 <+66>:    mov    %r14,%rdi
>    0xffffffff818f0e75 <+69>:    mov    %ebp,%esi
>    0xffffffff818f0e77 <+71>:    mov    %rbx,%rdx
>    0xffffffff818f0e7a <+74>:    call   0xffffffff8141e3b0 <bpf_lsm_file_i=
octl>
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
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/bpf_lsm.h   |  5 +++++
>  include/linux/lsm_hooks.h | 13 ++++++++++++-
>  kernel/bpf/trampoline.c   | 24 ++++++++++++++++++++++++
>  security/bpf/hooks.c      | 25 ++++++++++++++++++++++++-
>  security/security.c       |  3 ++-
>  5 files changed, 67 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index 1de7ece5d36d..5bbc31ac948c 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -29,6 +29,7 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>
>  bool bpf_lsm_is_sleepable_hook(u32 btf_id);
>  bool bpf_lsm_is_trusted(const struct bpf_prog *prog);
> +void bpf_lsm_toggle_hook(void *addr, bool value);
>
>  static inline struct bpf_storage_blob *bpf_inode(
>         const struct inode *inode)
> @@ -78,6 +79,10 @@ static inline void bpf_lsm_find_cgroup_shim(const stru=
ct bpf_prog *prog,
>  {
>  }
>
> +static inline void bpf_lsm_toggle_hook(void *addr, bool value)
> +{
> +}
> +
>  #endif /* CONFIG_BPF_LSM */
>
>  #endif /* _LINUX_BPF_LSM_H */
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index ba63d8b54448..b646f6746147 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -110,11 +110,14 @@ struct lsm_id {
>   * @scalls: The beginning of the array of static calls assigned to this =
hook.
>   * @hook: The callback for the hook.
>   * @lsm: The name of the lsm that owns this hook.
> + * @default_state: The state of the LSM hook when initialized. If set to=
 false,
> + * the static key guarding the hook will be set to disabled.
>   */
>  struct security_hook_list {
>         struct lsm_static_call  *scalls;
>         union security_list_options     hook;
>         const struct lsm_id             *lsmid;
> +       bool                            default_state;

minor nit: "default_state" would make more sense if it would be some
enum instead of bool. But given it's true/false, default_enabled makes
more sense.

>  } __randomize_layout;
>
>  /*
> @@ -164,7 +167,15 @@ static inline struct xattr *lsm_get_xattr_slot(struc=
t xattr *xattrs,
>  #define LSM_HOOK_INIT(NAME, CALLBACK)                  \
>         {                                               \
>                 .scalls =3D static_calls_table.NAME,      \
> -               .hook =3D { .NAME =3D CALLBACK }            \
> +               .hook =3D { .NAME =3D CALLBACK },           \
> +               .default_state =3D true                   \
> +       }
> +
> +#define LSM_HOOK_INIT_DISABLED(NAME, CALLBACK)         \
> +       {                                               \
> +               .scalls =3D static_calls_table.NAME,      \
> +               .hook =3D { .NAME =3D CALLBACK },           \
> +               .default_state =3D false                  \
>         }
>
>  extern char *lsm_names;
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index e97aeda3a86b..44788e2eaa1b 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -13,6 +13,7 @@
>  #include <linux/bpf_verifier.h>
>  #include <linux/bpf_lsm.h>
>  #include <linux/delay.h>
> +#include <linux/bpf_lsm.h>
>
>  /* dummy _ops. The verifier will operate on target program's ops. */
>  const struct bpf_verifier_ops bpf_extension_verifier_ops =3D {
> @@ -510,6 +511,21 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_t=
ramp(struct bpf_prog *prog)
>         }
>  }
>
> +static void bpf_trampoline_toggle_lsm(struct bpf_trampoline *tr,
> +                                     enum bpf_tramp_prog_type kind)
> +{
> +       struct bpf_tramp_link *link;
> +       bool found =3D false;
> +
> +       hlist_for_each_entry(link, &tr->progs_hlist[kind], tramp_hlist) {
> +               if (link->link.prog->type =3D=3D BPF_PROG_TYPE_LSM) {
> +                       found  =3D true;
> +                       break;
> +               }
> +       }
> +       bpf_lsm_toggle_hook(tr->func.addr, found);
> +}
> +
>  static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struc=
t bpf_trampoline *tr)
>  {
>         enum bpf_tramp_prog_type kind;
> @@ -549,6 +565,10 @@ static int __bpf_trampoline_link_prog(struct bpf_tra=
mp_link *link, struct bpf_tr
>
>         hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
>         tr->progs_cnt[kind]++;
> +
> +       if (link->link.prog->type =3D=3D BPF_PROG_TYPE_LSM)
> +               bpf_trampoline_toggle_lsm(tr, kind);
> +
>         err =3D bpf_trampoline_update(tr, true /* lock_direct_mutex */);
>         if (err) {
>                 hlist_del_init(&link->tramp_hlist);
> @@ -582,6 +602,10 @@ static int __bpf_trampoline_unlink_prog(struct bpf_t=
ramp_link *link, struct bpf_
>         }
>         hlist_del_init(&link->tramp_hlist);
>         tr->progs_cnt[kind]--;
> +
> +       if (link->link.prog->type =3D=3D BPF_PROG_TYPE_LSM)
> +               bpf_trampoline_toggle_lsm(tr, kind);
> +
>         return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
>  }
>
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index 91011e0c361a..61433633d235 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -9,7 +9,7 @@
>
>  static struct security_hook_list bpf_lsm_hooks[] __ro_after_init =3D {
>         #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> -       LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
> +       LSM_HOOK_INIT_DISABLED(NAME, bpf_lsm_##NAME),
>         #include <linux/lsm_hook_defs.h>
>         #undef LSM_HOOK
>         LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
> @@ -39,3 +39,26 @@ DEFINE_LSM(bpf) =3D {
>         .init =3D bpf_lsm_init,
>         .blobs =3D &bpf_lsm_blob_sizes
>  };
> +
> +void bpf_lsm_toggle_hook(void *addr, bool value)

another minor nit: similar to above, s/value/enable/ reads nicer


> +{
> +       struct lsm_static_call *scalls;
> +       struct security_hook_list *h;
> +       int i, j;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(bpf_lsm_hooks); i++) {
> +               h =3D &bpf_lsm_hooks[i];
> +               if (h->hook.lsm_callback !=3D addr)
> +                       continue;
> +
> +               for (j =3D 0; j < MAX_LSM_COUNT; j++) {
> +                       scalls =3D &h->scalls[j];
> +                       if (scalls->hl !=3D &bpf_lsm_hooks[i])
> +                               continue;
> +                       if (value)
> +                               static_branch_enable(scalls->active);
> +                       else
> +                               static_branch_disable(scalls->active);
> +               }
> +       }
> +}
> diff --git a/security/security.c b/security/security.c
> index aa3c87257533..58e93614037f 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -406,7 +406,8 @@ static void __init lsm_static_call_init(struct securi=
ty_hook_list *hl)
>                         __static_call_update(scall->key, scall->trampolin=
e,
>                                              hl->hook.lsm_callback);
>                         scall->hl =3D hl;
> -                       static_branch_enable(scall->active);
> +                       if (hl->default_state)
> +                               static_branch_enable(scall->active);
>                         return;
>                 }
>                 scall++;
> --
> 2.42.0.820.g83a721a137-goog
>
>
