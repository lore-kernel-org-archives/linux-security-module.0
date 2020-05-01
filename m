Return-Path: <SRS0=mFfD=6P=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2E6C4724C
	for <linux-security-module@archiver.kernel.org>; Fri,  1 May 2020 03:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3957F20836
	for <linux-security-module@archiver.kernel.org>; Fri,  1 May 2020 03:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgEADqq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 30 Apr 2020 23:46:46 -0400
Received: from namei.org ([65.99.196.166]:56338 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbgEADqq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 30 Apr 2020 23:46:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 0413kPI7029780;
        Fri, 1 May 2020 03:46:25 GMT
Date:   Fri, 1 May 2020 13:46:25 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     KP Singh <kpsingh@chromium.org>
cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mikko Ylinen <mikko.ylinen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf] security: Fix the default value of fs_context_parse_param
 hook
In-Reply-To: <20200430155240.68748-1-kpsingh@chromium.org>
Message-ID: <alpine.LRH.2.21.2005011345380.29679@namei.org>
References: <20200430155240.68748-1-kpsingh@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 30 Apr 2020, KP Singh wrote:

> From: KP Singh <kpsingh@google.com>
> 

Applied to:
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git for-v5.7


-- 
James Morris
<jmorris@namei.org>

