Return-Path: <SRS0=iZqy=5M=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FDAC43331
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Mar 2020 00:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B9F20737
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Mar 2020 00:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgC0AcP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:32:15 -0400
Received: from namei.org ([65.99.196.166]:43900 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgC0AcP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 26 Mar 2020 20:32:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 02R0VcXQ018220;
        Fri, 27 Mar 2020 00:31:38 GMT
Date:   Fri, 27 Mar 2020 11:31:38 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     KP Singh <kpsingh@chromium.org>
cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v7 7/8] bpf: lsm: Add selftests for
 BPF_PROG_TYPE_LSM
In-Reply-To: <20200326142823.26277-8-kpsingh@chromium.org>
Message-ID: <alpine.LRH.2.21.2003271131180.17915@namei.org>
References: <20200326142823.26277-1-kpsingh@chromium.org> <20200326142823.26277-8-kpsingh@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 26 Mar 2020, KP Singh wrote:

> From: KP Singh <kpsingh@google.com>
> 
> * Load/attach a BPF program that hooks to file_mprotect (int)
>   and bprm_committed_creds (void).
> * Perform an action that triggers the hook.
> * Verify if the audit event was received using the shared global
>   variables for the process executed.
> * Verify if the mprotect returns a -EPERM.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> Reviewed-by: Thomas Garnier <thgarnie@google.com>

Cool stuff!

Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

