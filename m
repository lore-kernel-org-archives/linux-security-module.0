Return-Path: <SRS0=vzfn=CV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CD3C43461
	for <linux-security-module@archiver.kernel.org>; Sat, 12 Sep 2020 00:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE6A221E3
	for <linux-security-module@archiver.kernel.org>; Sat, 12 Sep 2020 00:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgILAE5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 11 Sep 2020 20:04:57 -0400
Received: from namei.org ([65.99.196.166]:56740 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgILAE5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 11 Sep 2020 20:04:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 08C03NpA018202;
        Sat, 12 Sep 2020 00:03:23 GMT
Date:   Sat, 12 Sep 2020 10:03:23 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     kernel-hardening@lists.openwall.com, John Wood <john.wood@gmx.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RESEND][RFC PATCH 0/6] Fork brute force attack mitigation
 (fbfam)
In-Reply-To: <20200910202107.3799376-1-keescook@chromium.org>
Message-ID: <alpine.LRH.2.21.2009121002100.17638@namei.org>
References: <20200910202107.3799376-1-keescook@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 10 Sep 2020, Kees Cook wrote:

> [kees: re-sending this series on behalf of John Wood <john.wood@gmx.com>
>  also visible at https://github.com/johwood/linux fbfam]
> 
> From: John Wood <john.wood@gmx.com>

Why are you resending this? The author of the code needs to be able to 
send and receive emails directly as part of development and maintenance.

-- 
James Morris
<jmorris@namei.org>

