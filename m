Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C30E8FDC1
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Oct 2023 00:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjJDAJi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 3 Oct 2023 20:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjJDAJh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Oct 2023 20:09:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21209A7
        for <linux-security-module@vger.kernel.org>; Tue,  3 Oct 2023 17:09:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F52BC433CC
        for <linux-security-module@vger.kernel.org>; Wed,  4 Oct 2023 00:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696378173;
        bh=vrnRPWM6Kr3/W+0dTr26haKGsMORQjydvq6viPCKkmk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XTZNDbXVg0R4EL9jY1t+hUPy2nwaJwoH0u45Tik3tBf6FiQnuZJ4NXSZSZW5kH5OX
         vVn5RCP1l6o/dtKhigeMhAwmVcTZG2T7RrMRmAsJ8+FNRFRaDuCop3+ydKoRtJNZyf
         xch4nO3zVbbaX4qy6+vkn/I1i49ZNPpHZzEZ60Xhn/zBzQcLudOxCHKNvBK7a9s6t0
         00N5pQd/FzQfTo/DfaEIh+hZlIub0hPj4imhzTHwC8/ajzMLvosF1fjxPD9xIAztTJ
         73w0O/YUdZnrT/AMoKzWqClgtAk43dNuRMQR8mfNo+agHasQBHa3eteySP9OZAFQYt
         MPTiPMuHSj36g==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5335725cf84so2502155a12.2
        for <linux-security-module@vger.kernel.org>; Tue, 03 Oct 2023 17:09:33 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz8NetutCz3v+4ImRtnmlLH5CzRowL4H5TJ/UMJPzmTsSXEPFGu
        UApZsYD1/T1CJFCAVpJZko8TMJ/YcL9d33k/JXHVdw==
X-Google-Smtp-Source: AGHT+IHnPlBo64FODszbU+aqzD5eI2HjwuuXXoOBiH6iDnwvOl1+bhrD6W+8DUhNtxUI2dxY/NsQyQTsY8PxT3ExkjA=
X-Received: by 2002:aa7:dd12:0:b0:51e:4439:f474 with SMTP id
 i18-20020aa7dd12000000b0051e4439f474mr560493edv.35.1696378171771; Tue, 03 Oct
 2023 17:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230928202410.3765062-4-kpsingh@kernel.org> <202309302332.1mxVwb0U-lkp@intel.com>
 <202309301339.8196ECC78@keescook>
In-Reply-To: <202309301339.8196ECC78@keescook>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 4 Oct 2023 02:09:20 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6C6bit69DJQbX4=SozkL+YcRt-w41sjgistUvA2KVCwA@mail.gmail.com>
Message-ID: <CACYkzJ6C6bit69DJQbX4=SozkL+YcRt-w41sjgistUvA2KVCwA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] security: Replace indirect LSM hook calls with
 static calls
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel test robot <lkp@intel.com>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, paul@paul-moore.com,
        casey@schaufler-ca.com, song@kernel.org, daniel@iogearbox.net,
        ast@kernel.org, renauld@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Sep 30, 2023 at 10:40=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Sun, Oct 01, 2023 at 12:13:06AM +0800, kernel test robot wrote:
> > Hi KP,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on bpf-next/master]
> > [also build test ERROR on bpf/master pcmoore-selinux/next linus/master =
v6.6-rc3 next-20230929]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/KP-Singh/kernel-=
Add-helper-macros-for-loop-unrolling/20230929-042610
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.gi=
t master
> > patch link:    https://lore.kernel.org/r/20230928202410.3765062-4-kpsin=
gh%40kernel.org
> > patch subject: [PATCH v5 3/5] security: Replace indirect LSM hook calls=
 with static calls
> > config: i386-randconfig-001-20230930 (https://download.01.org/0day-ci/a=
rchive/20230930/202309302332.1mxVwb0U-lkp@intel.com/config)
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20230930/202309302332.1mxVwb0U-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202309302332.1mxVwb0U-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> > >> security/security.c:139:1: error: Only string constants are supporte=
d as initializers for randomized structures with flexible arrays
> >      139 | };
> >          | ^
>
> Uuh, where is there a flexible array here?

I cannot seem to reproduce this with my gcc

wget https://download.01.org/0day-ci/archive/20230930/202309302332.1mxVwb0U=
-lkp@intel.com/config
mkdir build_dir && cp config build_dir/.config
make -j  64 W=3D1 O=3Dbuild_dir ARCH=3Di386 olddefconfig
make -j 64  W=3D1 O=3Dbuild_dir ARCH=3Di386 SHELL=3D/bin/bash
history

on bpf-next/master builds the kernel for me:

Kernel: arch/x86/boot/bzImage is ready  (#1)

The reproducer does not seem to come with a tool chain, and I even
hacked the make.cross from another similar reply for gcc-9 and it
still seems to work. Not sure what happened in the CI there.




>
> > vim +139 security/security.c
> >
> >    118
> >    119        /*
> >    120         * Initialise a table of static calls for each LSM hook.
> >    121         * DEFINE_STATIC_CALL_NULL invocation above generates a k=
ey (STATIC_CALL_KEY)
> >    122         * and a trampoline (STATIC_CALL_TRAMP) which are used to=
 call
> >    123         * __static_call_update when updating the static call.
> >    124         */
> >    125        struct lsm_static_calls_table static_calls_table __ro_aft=
er_init =3D {
> >    126        #define INIT_LSM_STATIC_CALL(NUM, NAME)                  =
               \
> >    127                (struct lsm_static_call) {                       =
               \
> >    128                        .key =3D &STATIC_CALL_KEY(LSM_STATIC_CALL=
(NAME, NUM)),    \
> >    129                        .trampoline =3D LSM_HOOK_TRAMP(NAME, NUM)=
,                \
> >    130                        .active =3D &SECURITY_HOOK_ACTIVE_KEY(NAM=
E, NUM),         \
> >    131                },
> >    132        #define LSM_HOOK(RET, DEFAULT, NAME, ...)                =
               \
> >    133                .NAME =3D {                                      =
                 \
> >    134                        LSM_DEFINE_UNROLL(INIT_LSM_STATIC_CALL, N=
AME)           \
> >    135                },
> >    136        #include <linux/lsm_hook_defs.h>
> >    137        #undef LSM_HOOK
> >    138        #undef INIT_LSM_STATIC_CALL
> >  > 139        };
> >    140
>
> *confused*
>
> -Kees
>
> --
> Kees Cook
