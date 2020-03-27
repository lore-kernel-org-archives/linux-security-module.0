Return-Path: <SRS0=iZqy=5M=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F38C2D0E8
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Mar 2020 00:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD04220714
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Mar 2020 00:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgC0A3k (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:29:40 -0400
Received: from namei.org ([65.99.196.166]:43852 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgC0A3k (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 26 Mar 2020 20:29:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 02R0T6eT018041;
        Fri, 27 Mar 2020 00:29:06 GMT
Date:   Fri, 27 Mar 2020 11:29:06 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     KP Singh <kpsingh@chromium.org>
cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Kees Cook <keescook@chromium.org>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v7 3/8] bpf: lsm: provide attachment points for
 BPF LSM programs
In-Reply-To: <20200326142823.26277-4-kpsingh@chromium.org>
Message-ID: <alpine.LRH.2.21.2003271128530.17915@namei.org>
References: <20200326142823.26277-1-kpsingh@chromium.org> <20200326142823.26277-4-kpsingh@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 26 Mar 2020, KP Singh wrote:

> From: KP Singh <kpsingh@google.com>
> 
> When CONFIG_BPF_LSM is enabled, nop functions, bpf_lsm_<hook_name>, are
> generated for each LSM hook. These functions are initialized as LSM
> hooks in a subsequent patch.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Yonghong Song <yhs@fb.com>


Acked-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

