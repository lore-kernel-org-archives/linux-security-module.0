Return-Path: <SRS0=YDB1=EC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E70C388F9
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Oct 2020 12:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9AAC22456
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Oct 2020 12:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWMO7qNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439121AbgJ0MLp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Oct 2020 08:11:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45256 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394605AbgJ0MLo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Oct 2020 08:11:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id e17so1587734wru.12;
        Tue, 27 Oct 2020 05:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=WfciDPKN3LS+3fOztqseVE/Ebmzl7FBW7LNzYYpXqog=;
        b=eWMO7qNTnXXgGw3wGXJy8KkpHRnOwdRP+98W6uAvyCmZq7MHAsh9popALGKipDuLcy
         n/kmkElNghrsNILJyP73nR5vTMkeTD9a4CcQdYssDcOm6GtYdN/ZOotXVMIAj0MyfzHc
         2VrCHE8Fwnda40RiKnjRoCnuLOS0OHfuZ4by+BWPx8QudAXxl+/U+aESzHSj5Z/dvG9G
         ZUsGYWFaM0JeKkbjoLHN/e4rKROPicWwm8DSZqwwGOnoA7SbIpax/+Ma6vZcMhqkFVBy
         zvYbXz2kTLrZ9Umi/ebXtZXsnfTnnxvU3+nsrtVca1hb8da6oBk+nPayaYkQ0AOKl/nH
         cscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=WfciDPKN3LS+3fOztqseVE/Ebmzl7FBW7LNzYYpXqog=;
        b=GLR5Fex8l2ks0xDBp60Xp4vw3kEHjuCmpX3pyh8QFAcRW6N866O25POAxz9uRBm/qn
         Fmj6SWk5z/K0z8v+qUIqHx5K05KbASIPmp7FzymdfU+WA7XibGTIQ8eIXgG9oxZ+tbtS
         J0wZR5sMvcaL4F673OPbyV/9iHlRgiwdzRTUj85hCZKBbIcnkES83wpKNirqfgjiJpSS
         IhzbPUHCymkYcqkChPFrg7aYqeXpXCjOYhL2hvW5ZaIx9VRjiebHAOcaFs/DC9w39Xgo
         5aAzXt2AAVBvb1iQhVVwn1FFhwcCzshTrCEqi19pkhfDXW9CQcIdLZqmWjLW9b8/3fY+
         r88w==
X-Gm-Message-State: AOAM531VrUFFQdxNRtlfVXNp2tOyQi8s/y5D+7DvSbdEFQUzn7we5s+V
        Hkjtf037z1RNmPB4UE4qLPA=
X-Google-Smtp-Source: ABdhPJzIlhGIx25MEU/hlO0DPNQ+2cBOBpYzJV+/20u3dGqkeKP1T2ri/PpypOFJqs7wwJtvmn7TMw==
X-Received: by 2002:adf:e443:: with SMTP id t3mr2555760wrm.14.1603800702246;
        Tue, 27 Oct 2020 05:11:42 -0700 (PDT)
Received: from ?IPv6:2001:a61:245a:d801:2e74:88ad:ef9:5218? ([2001:a61:245a:d801:2e74:88ad:ef9:5218])
        by smtp.gmail.com with ESMTPSA id p11sm1829840wrm.44.2020.10.27.05.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 05:11:41 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
To:     Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Adrian Reber <areber@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Inconsistent capability requirements for prctl_set_mm_exe_file()
Message-ID: <7655a573-544f-05a4-36dc-0c84c73ac9ee@gmail.com>
Date:   Tue, 27 Oct 2020 13:11:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Nicolas, Cyrill, and others,

@Nicolas, your commit ebd6de6812387a changed the capability 
requirements for the prctl_set_mm_exe_file() operation from

    ns_capable(CAP_SYS_ADMIN)

to

    ns_capable(CAP_SYS_ADMIN) || ns_capable(CAP_CHECKPOINT_RESTORE).

That's fine I guess, but while looking at that change, I found
an anomaly.

The same prctl_set_mm_exe_file() functionality is also available
via the prctl() PR_SET_MM_EXE_FILE operation, which was added
by Cyrill's commit b32dfe377102ce668. However, there the 
prctl_set_mm_exe_file() operation is guarded by a check

    capable(CAP_SYS_RESOURCE).

There are two things I note:

* The capability requirements are different in the two cases.
* In one case the checks are with ns_capable(), while in the 
  other case the check is with capable().

In both cases, the inconsistencies predate Nicolas's patch,
and appear to have been introduced in Kirill Tkhai's commit
4d28df6152aa3ff.

I'm not sure what is right, but those inconsistencies seem
seem odd, and presumably unintended. Similarly, I'm not
sure what fix, if any, should be applied. However, I thought
it worth mentioning these details, since the situation is odd
and surprising.

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
