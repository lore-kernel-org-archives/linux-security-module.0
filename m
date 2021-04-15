Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8B4C433ED
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Apr 2021 16:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB7916115B
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Apr 2021 16:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhDOQXi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 15 Apr 2021 12:23:38 -0400
Received: from namei.org ([65.99.196.166]:43726 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhDOQXi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 15 Apr 2021 12:23:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id BC10C4E1;
        Thu, 15 Apr 2021 16:19:35 +0000 (UTC)
Date:   Fri, 16 Apr 2021 02:19:35 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     linux-kernel@vger.kernel.org, Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] security: commoncap: clean up kernel-doc comments
In-Reply-To: <20210412005528.3326-1-rdunlap@infradead.org>
Message-ID: <f1b7edf3-2df-64c-91a5-f9989b745136@namei.org>
References: <20210412005528.3326-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, 11 Apr 2021, Randy Dunlap wrote:

> Fix kernel-doc notation in commoncap.c.
> 
> Use correct (matching) function name in comments as in code.
> Use correct function argument names in kernel-doc comments.
> Use kernel-doc's "Return:" format for function return values.
> 
> Fixes these kernel-doc warnings:
> 
> ../security/commoncap.c:1206: warning: expecting prototype for cap_task_ioprio(). Prototype was for cap_task_setioprio() instead
> ../security/commoncap.c:1219: warning: expecting prototype for cap_task_ioprio(). Prototype was for cap_task_setnice() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: linux-security-module@vger.kernel.org

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v5.12

-- 
James Morris
<jmorris@namei.org>

