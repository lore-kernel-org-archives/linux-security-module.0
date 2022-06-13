Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F01C43334
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Jun 2022 23:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiFMXqc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Jun 2022 19:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiFMXqb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Jun 2022 19:46:31 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E9532EFC
        for <linux-security-module@vger.kernel.org>; Mon, 13 Jun 2022 16:46:30 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h192so6988147pgc.4
        for <linux-security-module@vger.kernel.org>; Mon, 13 Jun 2022 16:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LMZMQK49gc47drd6Jd36STmC+qlFEdOKEq0ulnkEkFs=;
        b=KpQN3HSapyv/qKjWcCGtXvRNrg5pQGiNxmt8TNqgb1TKcG5DJbt9XHcO+8jhBvRA8r
         sSdkkSHdkmtN/7q7JB00iwiatLreKrwfpIv/rCQy0oTRWjxDK7urmoWJMjMKJPa4we2V
         VG34MAF0/wvkUIH61Lad0EWacF1Mz+tqeZXvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LMZMQK49gc47drd6Jd36STmC+qlFEdOKEq0ulnkEkFs=;
        b=uP03d//Q2LOyBt+xk5fdCtawCerL3l+Fq7f/2Z0wd1jN06IQN3FHyWSv2TT5fAyHmx
         6KCw6CLna2OhGcDYBNtkxVC1z4/5Trygii8kqDfc7CnQp5xeqEh2AsY/CDc/BUgSnmv9
         xLmfL1SKxqwpvFspLlms4EOwXARDd3iyhPgA8An3pvZOSozx4AFQlc+T2b8l797Wn8le
         D9q477/xjNOOm+kHenQgb6iHzciyvucQSJnQzM7N/7HHBc3JeNYwAGlYndygRrVe/vMJ
         77hjxaNkCC9r/TWJ3gNQEaTakumgXAyOD0bmPYzFgAJnJcAtB2rsARFPMkdzJHt6UosD
         M5yA==
X-Gm-Message-State: AOAM531SYP6Gx3bGQJVJ8Gw/OGKCWXk06tVapSq9f0912FiLG/W6SPz+
        7hVL2D5xkO5vZJtMjIXwoIb+BFctUFSa7A==
X-Google-Smtp-Source: ABdhPJypGRCNuj+Vs7kbnSmWhSH8m6+5HFMpQVmxKwRrzBtjzjj+MG9/XNhAPxifXiFhp6arOdMKoA==
X-Received: by 2002:a63:5248:0:b0:402:de14:ab74 with SMTP id s8-20020a635248000000b00402de14ab74mr1882926pgl.18.1655163990389;
        Mon, 13 Jun 2022 16:46:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cp15-20020a170902e78f00b00168c5230332sm5672252plb.148.2022.06.13.16.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 16:46:30 -0700 (PDT)
Date:   Mon, 13 Jun 2022 16:46:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Micah Morton <mortonm@chromium.org>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] LSM: SafeSetID: Add setgroups() security policy
 handling
Message-ID: <202206131643.4FB2340C43@keescook>
References: <20220613202852.447738-1-mortonm@chromium.org>
 <CAJ-EccOhrYG6n6As72R7YzSk+Zzy=oFFJ62hG9476njprpJuvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ-EccOhrYG6n6As72R7YzSk+Zzy=oFFJ62hG9476njprpJuvw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 13, 2022 at 02:00:03PM -0700, Micah Morton wrote:
> On Mon, Jun 13, 2022 at 1:28 PM Micah Morton <mortonm@chromium.org> wrote:
> [...]
> > +static int safesetid_task_fix_setgroups(struct cred *new, const struct cred *old)
> > +{
> > +       int i;
> > +
> > +       /* Do nothing if there are no setgid restrictions for our old RGID. */
> > +       if (setid_policy_lookup((kid_t){.gid = old->gid}, INVALID_ID, GID) == SIDPOL_DEFAULT)
> > +               return 0;
> > +
> > +       get_group_info(new->group_info);
> > +       for (i = 0; i < new->group_info->ngroups; i++) {
> > +               if (!id_permitted_for_cred(old, (kid_t){.gid = group_info->gid[i]}, GID)) {
> 
> Oops, should be:
> 
> !id_permitted_for_cred(old, (kid_t){.gid = new->group_info->gid[i]}, GID)
> 
> Guess I won't send a whole new patch just for that one line

This begs the question: are there self-tests for this LSM somewhere?
It'd be really nice to add them to tool/testing/selftests ...

-- 
Kees Cook
