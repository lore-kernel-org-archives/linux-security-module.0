Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C23C433EF
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Oct 2021 17:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA376109F
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Oct 2021 17:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhJMRZy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhJMRZx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Oct 2021 13:25:53 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665DDC061570
        for <linux-security-module@vger.kernel.org>; Wed, 13 Oct 2021 10:23:50 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so4987493pjw.0
        for <linux-security-module@vger.kernel.org>; Wed, 13 Oct 2021 10:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AReqUsvUnaE5V/ZN9b0ppTuXb1nDxknf4Hjq7OACTEs=;
        b=LzeYOVqQ36j1vI/uWUXC4KHwbsb4O+j1y6/IW2atZfL4h72eCwu7l3xYJMJflGr5FK
         Z7jY2uMPWrV7XyvZCBO3S2Wg6nh9maU5hCqRm5AEywpOziTLdJRVz1RNW5K91G5+1QH/
         DmaDwCCcurB16U92weFP6Hz/FvCnn/fEdhB+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AReqUsvUnaE5V/ZN9b0ppTuXb1nDxknf4Hjq7OACTEs=;
        b=oY/VVeVKZD4TbWXs/Ad1lFQiiQr+UdCS8hFAGj1l8WARLVAXQRHXgfKVuHAA81g3nO
         RYr/hIFyun8oai2tkyOcPt/Hn1BlGrMo7BAOAfDpmIB8oBSKQCszInEdlngJW+d6LLYf
         G/nfemevZD15dXNBOj2jka2b1Yg4+5XdQ8X+3X1d/UDntRAHu4T5BUCT28y6jHTSyFWg
         aYC/WiXrZIilhwLIITFPbRleFP/ZN7Y2SS9qIZlS38GtwpEAS4+JjVQDTjUqjPs7izpr
         xHXJ+FqwsttE/YFenSVprgglFn6NDR07lLNdZ9MUNZUQUcFVeXt5ZdHJoso2m9OTCAhJ
         tm3A==
X-Gm-Message-State: AOAM530zMXYHvMYxAjxMBl90pXCe1cMMxEdqTZK/xrZWjU5LZHv6/8H/
        tMIyyjJYK5TYf8EixfxBEzLeJg==
X-Google-Smtp-Source: ABdhPJwB3H4gvqFzLk9j4t9+PVB2J1yxAPAKBWzSDTBOtHBwL+ATEGU/JmICD28G8wuHiUdUtzrpHQ==
X-Received: by 2002:a17:90a:47:: with SMTP id 7mr643888pjb.46.1634145829789;
        Wed, 13 Oct 2021 10:23:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t28sm112484pfq.158.2021.10.13.10.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 10:23:49 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:23:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module@vger.kernel.org,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [linux-next:master 1997/7806]
 include/linux/lsm_hook_defs.h:408:18: error: 'uring_sqpoll_default' defined
 but not used
Message-ID: <202110131023.9C246EBC4@keescook>
References: <202110131608.zms53FPR-lkp@intel.com>
 <CAHC9VhQAkv=jaPM4U1umSXTFtbP4vdXo-tk9vfKGnpAmrxhj1w@mail.gmail.com>
 <64f0bc36-ce94-3572-2c07-07e36c34a266@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64f0bc36-ce94-3572-2c07-07e36c34a266@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 13, 2021 at 08:52:15AM -0700, Casey Schaufler wrote:
> On 10/13/2021 7:57 AM, Paul Moore wrote:
> > On Wed, Oct 13, 2021 at 4:17 AM kernel test robot <lkp@intel.com> wrote:
> >> Hi Paul,
> >>
> >> FYI, the error/warning still remains.
> > I'm not sure if anyone is monitoring the kernel test robot mail, but
> > this issue isn't unique to the LSM/audit/io_uring patches, it appears
> > to be a general LSM hook issue.
> 
> Looks like fallout from KP Singh's MACRO stuff for BPF.

Does this fix it?


diff --git a/security/security.c b/security/security.c
index 9ffa9e9c5c55..462f14354c2c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -706,7 +706,7 @@ static int lsm_superblock_alloc(struct super_block *sb)
 #define LSM_RET_DEFAULT(NAME) (NAME##_default)
 #define DECLARE_LSM_RET_DEFAULT_void(DEFAULT, NAME)
 #define DECLARE_LSM_RET_DEFAULT_int(DEFAULT, NAME) \
-	static const int LSM_RET_DEFAULT(NAME) = (DEFAULT);
+	static const int __maybe_unused LSM_RET_DEFAULT(NAME) = (DEFAULT);
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
 

I will go try it...

-Kees

> 
> >
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> >> head:   8006b911c90a4ec09958447d24c8a4c3538f5723
> >> commit: cdc1404a40461faba23c5a5ad40adcc7eecc1580 [1997/7806] lsm,io_uring: add LSM hooks to io_uring
> >> config: microblaze-buildonly-randconfig-r002-20211012 (attached as .config)
> >> compiler: microblaze-linux-gcc (GCC) 11.2.0
> >> reproduce (this is a W=1 build):
> >>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >>         chmod +x ~/bin/make.cross
> >>         # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=cdc1404a40461faba23c5a5ad40adcc7eecc1580
> >>         git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> >>         git fetch --no-tags linux-next master
> >>         git checkout cdc1404a40461faba23c5a5ad40adcc7eecc1580
> >>         # save the attached .config to linux build tree
> >>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=microblaze
> >>
> >> If you fix the issue, kindly add following tag as appropriate
> >> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> All errors (new ones prefixed by >>):
> >>
> >>>> include/linux/lsm_hook_defs.h:408:18: error: 'uring_sqpoll_default' defined but not used [-Werror=unused-const-variable=]
> >>      408 | LSM_HOOK(int, 0, uring_sqpoll, void)
> >>          |                  ^~~~~~~~~~~~
> >>    security/security.c:706:32: note: in definition of macro 'LSM_RET_DEFAULT'
> >>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
> >>          |                                ^~~~
> >>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
> >>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
> >>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
> >>    include/linux/lsm_hook_defs.h:408:1: note: in expansion of macro 'LSM_HOOK'
> >>      408 | LSM_HOOK(int, 0, uring_sqpoll, void)
> >>          | ^~~~~~~~
> >>>> include/linux/lsm_hook_defs.h:407:18: error: 'uring_override_creds_default' defined but not used [-Werror=unused-const-variable=]
> >>      407 | LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
> >>          |                  ^~~~~~~~~~~~~~~~~~~~
> >>    security/security.c:706:32: note: in definition of macro 'LSM_RET_DEFAULT'
> >>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
> >>          |                                ^~~~
> >>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
> >>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
> >>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
> >>    include/linux/lsm_hook_defs.h:407:1: note: in expansion of macro 'LSM_HOOK'
> >>      407 | LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
> >>          | ^~~~~~~~
> >>    include/linux/lsm_hook_defs.h:396:18: error: 'locked_down_default' defined but not used [-Werror=unused-const-variable=]
> >>      396 | LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
> >>          |                  ^~~~~~~~~~~
> >>    security/security.c:706:32: note: in definition of macro 'LSM_RET_DEFAULT'
> >>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
> >>          |                                ^~~~
> >>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
> >>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
> >>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
> >>    include/linux/lsm_hook_defs.h:396:1: note: in expansion of macro 'LSM_HOOK'
> >>      396 | LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
> >>          | ^~~~~~~~
> >>    include/linux/lsm_hook_defs.h:392:18: error: 'bpf_prog_alloc_security_default' defined but not used [-Werror=unused-const-variable=]
> >>      392 | LSM_HOOK(int, 0, bpf_prog_alloc_security, struct bpf_prog_aux *aux)
> >>          |                  ^~~~~~~~~~~~~~~~~~~~~~~
> >>    security/security.c:706:32: note: in definition of macro 'LSM_RET_DEFAULT'
> >>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
> >>          |                                ^~~~
> >>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
> >>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
> >>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
> >>    include/linux/lsm_hook_defs.h:392:1: note: in expansion of macro 'LSM_HOOK'
> >>      392 | LSM_HOOK(int, 0, bpf_prog_alloc_security, struct bpf_prog_aux *aux)
> >>          | ^~~~~~~~
> >>    include/linux/lsm_hook_defs.h:390:18: error: 'bpf_map_alloc_security_default' defined but not used [-Werror=unused-const-variable=]
> >>      390 | LSM_HOOK(int, 0, bpf_map_alloc_security, struct bpf_map *map)
> >>          |                  ^~~~~~~~~~~~~~~~~~~~~~
> >>    security/security.c:706:32: note: in definition of macro 'LSM_RET_DEFAULT'
> >>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
> >>          |                                ^~~~
> >>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
> >>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
> >>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
> >>    include/linux/lsm_hook_defs.h:390:1: note: in expansion of macro 'LSM_HOOK'
> >>      390 | LSM_HOOK(int, 0, bpf_map_alloc_security, struct bpf_map *map)
> >>          | ^~~~~~~~
> >>    include/linux/lsm_hook_defs.h:389:18: error: 'bpf_prog_default' defined but not used [-Werror=unused-const-variable=]
> >>      389 | LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
> >>          |                  ^~~~~~~~
> >>    security/security.c:706:32: note: in definition of macro 'LSM_RET_DEFAULT'
> >>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
> >>          |                                ^~~~
> >>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
> >>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
> >>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
> >>    include/linux/lsm_hook_defs.h:389:1: note: in expansion of macro 'LSM_HOOK'
> >>      389 | LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
> >>          | ^~~~~~~~
> >>    include/linux/lsm_hook_defs.h:388:18: error: 'bpf_map_default' defined but not used [-Werror=unused-const-variable=]
> >>      388 | LSM_HOOK(int, 0, bpf_map, struct bpf_map *map, fmode_t fmode)
> >>          |                  ^~~~~~~
> >>    security/security.c:706:32: note: in definition of macro 'LSM_RET_DEFAULT'
> >>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
> >>          |                                ^~~~
> >>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
> >>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
> >>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
> >>    include/linux/lsm_hook_defs.h:388:1: note: in expansion of macro 'LSM_HOOK'
> >>      388 | LSM_HOOK(int, 0, bpf_map, struct bpf_map *map, fmode_t fmode)
> >>          | ^~~~~~~~
> >>    include/linux/lsm_hook_defs.h:387:18: error: 'bpf_default' defined but not used [-Werror=unused-const-variable=]
> >>      387 | LSM_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, unsigned int size)
> >>          |                  ^~~
> >>    security/security.c:706:32: note: in definition of macro 'LSM_RET_DEFAULT'
> >>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
> >>          |                                ^~~~
> >>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
> >>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
> >>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
> >>    include/linux/lsm_hook_defs.h:387:1: note: in expansion of macro 'LSM_HOOK'
> >>      387 | LSM_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, unsigned int size)
> >>          | ^~~~~~~~
> >>    include/linux/lsm_hook_defs.h:382:18: error: 'audit_rule_match_default' defined but not used [-Werror=unused-const-variable=]
> >>      382 | LSM_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u32 op, void *lsmrule)
> >>          |                  ^~~~~~~~~~~~~~~~
> >>    security/security.c:706:32: note: in definition of macro 'LSM_RET_DEFAULT'
> >>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
> >>          |                                ^~~~
> >>    security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
> >>      711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
> >>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
> >>    include/linux/lsm_hook_defs.h:382:1: note: in expansion of macro 'LSM_HOOK'
> >>      382 | LSM_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u32 op, void *lsmrule)
> >>          | ^~~~~~~~
> >>    include/linux/lsm_hook_defs.h:381:18: error: 'audit_rule_known_default' defined but not used [-Werror=unused-const-variable=]
> >>      381 | LSM_HOOK(int, 0, audit_rule_known, struct audit_krule *krule)
> >>          |                  ^~~~~~~~~~~~~~~~
> >>    security/security.c:706:32: note: in definition of macro 'LSM_RET_DEFAULT'
> >>      706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
> >>
> >>
> >> vim +/uring_sqpoll_default +408 include/linux/lsm_hook_defs.h
> >>
> >>    405
> >>    406  #ifdef CONFIG_IO_URING
> >>  > 407  LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
> >>  > 408  LSM_HOOK(int, 0, uring_sqpoll, void)
> >>
> >> ---
> >> 0-DAY CI Kernel Test Service, Intel Corporation
> >> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> >
> >
> 

-- 
Kees Cook
