Return-Path: <SRS0=iZqy=5M=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992E6C2D0E8
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Mar 2020 00:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8BF20719
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Mar 2020 00:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgC0AYq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:24:46 -0400
Received: from namei.org ([65.99.196.166]:43802 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgC0AYq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 26 Mar 2020 20:24:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 02R0OCMP017800;
        Fri, 27 Mar 2020 00:24:12 GMT
Date:   Fri, 27 Mar 2020 11:24:12 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     KP Singh <kpsingh@chromium.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v7 4/8] bpf: lsm: Implement attach, detach and
 execution
In-Reply-To: <20200326142823.26277-5-kpsingh@chromium.org>
Message-ID: <alpine.LRH.2.21.2003271119420.17089@namei.org>
References: <20200326142823.26277-1-kpsingh@chromium.org> <20200326142823.26277-5-kpsingh@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 26 Mar 2020, KP Singh wrote:

> +int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> +			const struct bpf_prog *prog)
> +{
> +	/* Only CAP_MAC_ADMIN users are allowed to make changes to LSM hooks
> +	 */
> +	if (!capable(CAP_MAC_ADMIN))
> +		return -EPERM;
> +

Stephen, can you confirm that your concerns around this are resolved 
(IIRC, by SELinux implementing a bpf_prog callback) ?


-- 
James Morris
<jmorris@namei.org>

