Return-Path: <SRS0=DElp=5D=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A1FC10DCE
	for <linux-security-module@archiver.kernel.org>; Wed, 18 Mar 2020 18:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2CB20724
	for <linux-security-module@archiver.kernel.org>; Wed, 18 Mar 2020 18:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCRS4f (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:56:35 -0400
Received: from namei.org ([65.99.196.166]:42008 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgCRS4f (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 18 Mar 2020 14:56:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 02IIu8gs029803;
        Wed, 18 Mar 2020 18:56:08 GMT
Date:   Thu, 19 Mar 2020 05:56:08 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     David Howells <dhowells@redhat.com>
cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        raven@themaw.net, christian@brauner.io, andres@anarazel.de,
        jlayton@redhat.com, dray@redhat.com, kzak@redhat.com,
        keyrings@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] security: Add hooks to rule on setting a watch
 [ver #5]
In-Reply-To: <158454381028.2863966.13720387027986442186.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.21.2003190555450.29708@namei.org>
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk> <158454381028.2863966.13720387027986442186.stgit@warthog.procyon.org.uk>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 18 Mar 2020, David Howells wrote:

> Add security hooks that will allow an LSM to rule on whether or not a watch
> may be set.  More than one hook is required as the watches watch different
> types of object.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Casey Schaufler <casey@schaufler-ca.com>
> cc: Stephen Smalley <sds@tycho.nsa.gov>
> cc: linux-security-module@vger.kernel.org
> ---
> 
>  include/linux/lsm_hooks.h |   24 ++++++++++++++++++++++++
>  include/linux/security.h  |   17 +++++++++++++++++
>  security/security.c       |   14 ++++++++++++++
>  3 files changed, 55 insertions(+)
> 


Acked-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

