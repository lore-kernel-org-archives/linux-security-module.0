Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E720C7EE24
	for <linux-security-module@archiver.kernel.org>; Fri,  2 Jun 2023 20:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbjFBUIN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 2 Jun 2023 16:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjFBUIM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 2 Jun 2023 16:08:12 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A211AD;
        Fri,  2 Jun 2023 13:08:11 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5149390b20aso3612863a12.3;
        Fri, 02 Jun 2023 13:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685736489; x=1688328489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZlFpNzQF3lllSw9SxuI6Yh1D0NKEdvTwNPHySVcAWI=;
        b=FQEEDdC3x25z6kb6549RM2f4Rbwgi4CYJfrqnfw8XQBfvU3AwvuMkPbqqDBXYLfckh
         Xsna3a7GldosnhfLA15gZbw0w0WGmITXhtNQ/F+tli4nw/lIXCJrPt2ZnVAsgLSEcq/H
         mafxv3EYjNEnHu6ED14H0g9fT22oJFbxdpuY1cL1vnEeX/gZFiBxvq6kYRLsCE1F9k4n
         nQ8dZke3eJPg4iAqumPPyZooFNDLTuTKLJeq9poRg5UwLEFuK1Q32pUAVCCis9XXgh8K
         08QawiTzSAl2jwHE2jLPyxqc+bT51PM0Uti168ebyK72X8UodAnFRJCmLasXS1UfIdaN
         /MZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685736489; x=1688328489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZlFpNzQF3lllSw9SxuI6Yh1D0NKEdvTwNPHySVcAWI=;
        b=kig6+t9oHhoy1UNAKjwKT5bUhyJ7RlBvdW9DMboZp0GWtbWnRuzz8sVrzxpyVMi6q0
         GtYRhzrzjeTqBn5P7jjeznWlSxMDlMiS5p7Kau1aCY/cng1sZJG5BwF5c1MmJKnzeVpk
         +DgBHSW7KFQhzllds8HtZd37r29ZOLb+IW+C6C1G8KMGIB9gER32NY9TaPG6Ejbk3Y/b
         beP/4tiTwZDMYah+JLwiv98e9J94h2W82rOfgg+WAmhlkBOaL1Ak5o6GQ9948tYp/C/N
         DkuJpWcmqd+r9NhPkdQniQRCPuN9IyS8E34nhmH6L3Hd5MAUFi01anBWpyvx5av2olUg
         Q63A==
X-Gm-Message-State: AC+VfDzufkI1m4+cZd/N607n3/uOaFklH+E+Z9h6GburAPGFW0LmkS1g
        6blhYXJKrNVNeFZnlqGYOEDvxbALUtb+D7huQbM=
X-Google-Smtp-Source: ACHHUZ4+fnLJdbMy/TCSRBGSTiggZuGtoZGmm03LGSptxz8dF4WNWu+fXhQRDLyDvwGecdHvYMZzsQ64mvsQk++cuHE=
X-Received: by 2002:aa7:c44a:0:b0:514:a685:aa3b with SMTP id
 n10-20020aa7c44a000000b00514a685aa3bmr2326733edr.41.1685736489410; Fri, 02
 Jun 2023 13:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230602150011.1657856-16-andrii@kernel.org> <202306030252.UOXkWZTK-lkp@intel.com>
In-Reply-To: <202306030252.UOXkWZTK-lkp@intel.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 2 Jun 2023 13:07:57 -0700
Message-ID: <CAEf4BzYawY7bYcQem8BVbrSAeBTXC72=Wu8jOhS4mYdi-5z0cA@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next 15/18] bpf: take into account BPF token
 when fetching helper protos
To:     kernel test robot <lkp@intel.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com,
        luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 2, 2023 at 11:48=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Andrii,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bp=
f-introduce-BPF-token-object/20230602-230448
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
master
> patch link:    https://lore.kernel.org/r/20230602150011.1657856-16-andrii=
%40kernel.org
> patch subject: [PATCH RESEND bpf-next 15/18] bpf: take into account BPF t=
oken when fetching helper protos
> config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/2023=
0603/202306030252.UOXkWZTK-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/3d830ca845b075ab4=
132487aaaa69b70a467863c
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Andrii-Nakryiko/bpf-introduce-BP=
F-token-object/20230602-230448
>         git checkout 3d830ca845b075ab4132487aaaa69b70a467863c
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=3D1 O=3Dbuild_dir ARCH=3Dum SUBARCH=3Dx86_64 olddefconfig
>         make W=3D1 O=3Dbuild_dir ARCH=3Dum SUBARCH=3Dx86_64 SHELL=3D/bin/=
bash
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306030252.UOXkWZTK-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from include/linux/bpf_verifier.h:7,
>                     from net/core/filter.c:21:
>    include/linux/bpf.h: In function 'bpf_token_new_fd':
>    include/linux/bpf.h:2475:16: warning: returning 'int' from a function =
with return type 'struct bpf_token *' makes pointer from integer without a =
cast [-Wint-conversion]
>     2475 |         return -EOPNOTSUPP;
>          |                ^

bad copy/paste, this function should return int. I forgot to test that
everything compiles without CONFIG_BPF_SYSCALL.


>    net/core/filter.c: In function 'bpf_sk_base_func_proto':
> >> net/core/filter.c:11653:14: error: implicit declaration of function 'b=
pf_token_capable'; did you mean 'bpf_token_put'? [-Werror=3Dimplicit-functi=
on-declaration]
>    11653 |         if (!bpf_token_capable(prog->aux->token, CAP_PERFMON))
>          |              ^~~~~~~~~~~~~~~~~
>          |              bpf_token_put
>    cc1: some warnings being treated as errors
>
>

hm.. maybe I'll just make bpf_token_capable() a static inline function
in include/linux/bpf.h

> vim +11653 net/core/filter.c
>
>  11619
>  11620  static const struct bpf_func_proto *
>  11621  bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf=
_prog *prog)
>  11622  {
>  11623          const struct bpf_func_proto *func;
>  11624
>  11625          switch (func_id) {
>  11626          case BPF_FUNC_skc_to_tcp6_sock:
>  11627                  func =3D &bpf_skc_to_tcp6_sock_proto;
>  11628                  break;
>  11629          case BPF_FUNC_skc_to_tcp_sock:
>  11630                  func =3D &bpf_skc_to_tcp_sock_proto;
>  11631                  break;
>  11632          case BPF_FUNC_skc_to_tcp_timewait_sock:
>  11633                  func =3D &bpf_skc_to_tcp_timewait_sock_proto;
>  11634                  break;
>  11635          case BPF_FUNC_skc_to_tcp_request_sock:
>  11636                  func =3D &bpf_skc_to_tcp_request_sock_proto;
>  11637                  break;
>  11638          case BPF_FUNC_skc_to_udp6_sock:
>  11639                  func =3D &bpf_skc_to_udp6_sock_proto;
>  11640                  break;
>  11641          case BPF_FUNC_skc_to_unix_sock:
>  11642                  func =3D &bpf_skc_to_unix_sock_proto;
>  11643                  break;
>  11644          case BPF_FUNC_skc_to_mptcp_sock:
>  11645                  func =3D &bpf_skc_to_mptcp_sock_proto;
>  11646                  break;
>  11647          case BPF_FUNC_ktime_get_coarse_ns:
>  11648                  return &bpf_ktime_get_coarse_ns_proto;
>  11649          default:
>  11650                  return bpf_base_func_proto(func_id, prog);
>  11651          }
>  11652
>  11653          if (!bpf_token_capable(prog->aux->token, CAP_PERFMON))
>  11654                  return NULL;
>  11655
>  11656          return func;
>  11657  }
>  11658
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
