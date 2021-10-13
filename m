Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28426C433F5
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Oct 2021 14:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0143561139
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Oct 2021 14:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbhJMPA3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbhJMPAV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Oct 2021 11:00:21 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06C7C0613E8
        for <linux-security-module@vger.kernel.org>; Wed, 13 Oct 2021 07:57:22 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w14so11326630edv.11
        for <linux-security-module@vger.kernel.org>; Wed, 13 Oct 2021 07:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qrTTFUPZmiVpsZWwvb9ln0mkdt5L1kVvp/pfP+2RmNk=;
        b=Qu4lId5ycWHQCdW1fg8mVBrrHhkbXU7hNFOM68PLJvPyRYe7dklHYNo2HEPO910Xan
         tcs1yx3za6pgw8AZsBlso5fvSI4KcI9bUGPk4H167cLB/x3rwgPkFhfHRLm9V7qIfq5i
         sGY7C+3TU8FDP+7fmwptTEspE4J1SsmaftnzmPLecMUkAxYnTeIAii+nI9OdJ8Z8Czq5
         6l2aexDrGSoYv71B7ffCtgOCMtJgsga3I6dCa+Mra09DWmRXUdIThJ4q+YiADzarde/A
         CIXqJn7Li/t0QZQEaisnIucV7r4IT+aH2DII+5EWLgFVkmkZ7atEXcvO/LAxOm9YEj8X
         6Q/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrTTFUPZmiVpsZWwvb9ln0mkdt5L1kVvp/pfP+2RmNk=;
        b=0FHiXhEuTJNSPLiE9qgDrlN983V8ij4qhnnFSxWJXLnj+2MuCXMYqukZ04+k9sKQmV
         xBSFaQlxqUZpLTkm0w3hB3680VVsc6jlzYogtgRiwcKv8L2MADZ1x767qalG42FXNXgS
         h0tx43w4PZdEY05xWN6tUiKoUPD98Mk0BkuZPsHXFcasRi0KJ7RrTKk+5VfbgdqjB/XI
         J5fv3ZzPhrPvS91HGmv0ta3kX8TUoAa3re16eUVtHf6Cgvr38NnvAkFkhYDfxQYuzEmn
         SgKba+H9xAvC89hFrMokxYaXp4piPzXS9h/ONfJXXdy43tOKuM17Ke9fTGWeMJRyh4Yf
         +jLQ==
X-Gm-Message-State: AOAM531fJmkt0TihaLtxCVEChpGyYCC5bplx0q7UEIZwQTxw0tdSx8YE
        HXxip2R6CHUZMmeOu9AzbfR2QbMJFqjbHc8+mzyTHai//g==
X-Google-Smtp-Source: ABdhPJz9hWiEXKdPqoIp8sdDUmHLt7JpveVSMISJ78/5NT7sQcIaxBRu58N8PG2pcA7//HQ5a+U4pqKguxBGQqAbH64=
X-Received: by 2002:a05:6402:5112:: with SMTP id m18mr10184697edd.101.1634137040764;
 Wed, 13 Oct 2021 07:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <202110131608.zms53FPR-lkp@intel.com>
In-Reply-To: <202110131608.zms53FPR-lkp@intel.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Oct 2021 10:57:09 -0400
Message-ID: <CAHC9VhQAkv=jaPM4U1umSXTFtbP4vdXo-tk9vfKGnpAmrxhj1w@mail.gmail.com>
Subject: Re: [linux-next:master 1997/7806] include/linux/lsm_hook_defs.h:408:18:
 error: 'uring_sqpoll_default' defined but not used
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 13, 2021 at 4:17 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Paul,
>
> FYI, the error/warning still remains.

I'm not sure if anyone is monitoring the kernel test robot mail, but
this issue isn't unique to the LSM/audit/io_uring patches, it appears
to be a general LSM hook issue.

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   8006b911c90a4ec09958447d24c8a4c3538f5723
> commit: cdc1404a40461faba23c5a5ad40adcc7eecc1580 [1997/7806] lsm,io_uring: add LSM hooks to io_uring
> config: microblaze-buildonly-randconfig-r002-20211012 (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=cdc1404a40461faba23c5a5ad40adcc7eecc1580
>         git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>         git fetch --no-tags linux-next master
>         git checkout cdc1404a40461faba23c5a5ad40adcc7eecc1580
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=microblaze
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> include/linux/lsm_hook_defs.h:408:18: error: 'uring_sqpoll_default' defined but not used [-Werror=unused-const-variable=]
>      408 | LSM_HOOK(int, 0, uring_sqpoll, void)
>          |                  ^~~~~~~~~~~~
>    security/security.c:706:32: note: in definition of macro 'LSM_RET_DEFAULT'
>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>          |                                ^~~~
>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/lsm_hook_defs.h:408:1: note: in expansion of macro 'LSM_HOOK'
>      408 | LSM_HOOK(int, 0, uring_sqpoll, void)
>          | ^~~~~~~~
> >> include/linux/lsm_hook_defs.h:407:18: error: 'uring_override_creds_default' defined but not used [-Werror=unused-const-variable=]
>      407 | LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
>          |                  ^~~~~~~~~~~~~~~~~~~~
>    security/security.c:706:32: note: in definition of macro 'LSM_RET_DEFAULT'
>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>          |                                ^~~~
>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/lsm_hook_defs.h:407:1: note: in expansion of macro 'LSM_HOOK'
>      407 | LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
>          | ^~~~~~~~
>    include/linux/lsm_hook_defs.h:396:18: error: 'locked_down_default' defined but not used [-Werror=unused-const-variable=]
>      396 | LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
>          |                  ^~~~~~~~~~~
>    security/security.c:706:32: note: in definition of macro 'LSM_RET_DEFAULT'
>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>          |                                ^~~~
>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/lsm_hook_defs.h:396:1: note: in expansion of macro 'LSM_HOOK'
>      396 | LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
>          | ^~~~~~~~
>    include/linux/lsm_hook_defs.h:392:18: error: 'bpf_prog_alloc_security_default' defined but not used [-Werror=unused-const-variable=]
>      392 | LSM_HOOK(int, 0, bpf_prog_alloc_security, struct bpf_prog_aux *aux)
>          |                  ^~~~~~~~~~~~~~~~~~~~~~~
>    security/security.c:706:32: note: in definition of macro 'LSM_RET_DEFAULT'
>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>          |                                ^~~~
>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/lsm_hook_defs.h:392:1: note: in expansion of macro 'LSM_HOOK'
>      392 | LSM_HOOK(int, 0, bpf_prog_alloc_security, struct bpf_prog_aux *aux)
>          | ^~~~~~~~
>    include/linux/lsm_hook_defs.h:390:18: error: 'bpf_map_alloc_security_default' defined but not used [-Werror=unused-const-variable=]
>      390 | LSM_HOOK(int, 0, bpf_map_alloc_security, struct bpf_map *map)
>          |                  ^~~~~~~~~~~~~~~~~~~~~~
>    security/security.c:706:32: note: in definition of macro 'LSM_RET_DEFAULT'
>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>          |                                ^~~~
>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/lsm_hook_defs.h:390:1: note: in expansion of macro 'LSM_HOOK'
>      390 | LSM_HOOK(int, 0, bpf_map_alloc_security, struct bpf_map *map)
>          | ^~~~~~~~
>    include/linux/lsm_hook_defs.h:389:18: error: 'bpf_prog_default' defined but not used [-Werror=unused-const-variable=]
>      389 | LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
>          |                  ^~~~~~~~
>    security/security.c:706:32: note: in definition of macro 'LSM_RET_DEFAULT'
>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>          |                                ^~~~
>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/lsm_hook_defs.h:389:1: note: in expansion of macro 'LSM_HOOK'
>      389 | LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
>          | ^~~~~~~~
>    include/linux/lsm_hook_defs.h:388:18: error: 'bpf_map_default' defined but not used [-Werror=unused-const-variable=]
>      388 | LSM_HOOK(int, 0, bpf_map, struct bpf_map *map, fmode_t fmode)
>          |                  ^~~~~~~
>    security/security.c:706:32: note: in definition of macro 'LSM_RET_DEFAULT'
>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>          |                                ^~~~
>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/lsm_hook_defs.h:388:1: note: in expansion of macro 'LSM_HOOK'
>      388 | LSM_HOOK(int, 0, bpf_map, struct bpf_map *map, fmode_t fmode)
>          | ^~~~~~~~
>    include/linux/lsm_hook_defs.h:387:18: error: 'bpf_default' defined but not used [-Werror=unused-const-variable=]
>      387 | LSM_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, unsigned int size)
>          |                  ^~~
>    security/security.c:706:32: note: in definition of macro 'LSM_RET_DEFAULT'
>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>          |                                ^~~~
>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/lsm_hook_defs.h:387:1: note: in expansion of macro 'LSM_HOOK'
>      387 | LSM_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, unsigned int size)
>          | ^~~~~~~~
>    include/linux/lsm_hook_defs.h:382:18: error: 'audit_rule_match_default' defined but not used [-Werror=unused-const-variable=]
>      382 | LSM_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u32 op, void *lsmrule)
>          |                  ^~~~~~~~~~~~~~~~
>    security/security.c:706:32: note: in definition of macro 'LSM_RET_DEFAULT'
>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>          |                                ^~~~
>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/lsm_hook_defs.h:382:1: note: in expansion of macro 'LSM_HOOK'
>      382 | LSM_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u32 op, void *lsmrule)
>          | ^~~~~~~~
>    include/linux/lsm_hook_defs.h:381:18: error: 'audit_rule_known_default' defined but not used [-Werror=unused-const-variable=]
>      381 | LSM_HOOK(int, 0, audit_rule_known, struct audit_krule *krule)
>          |                  ^~~~~~~~~~~~~~~~
>    security/security.c:706:32: note: in definition of macro 'LSM_RET_DEFAULT'
>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>
>
> vim +/uring_sqpoll_default +408 include/linux/lsm_hook_defs.h
>
>    405
>    406  #ifdef CONFIG_IO_URING
>  > 407  LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
>  > 408  LSM_HOOK(int, 0, uring_sqpoll, void)
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
paul moore
www.paul-moore.com
