Return-Path: <SRS0=nw36=QY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA68C43381
	for <linux-security-module@archiver.kernel.org>; Sun, 17 Feb 2019 18:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153AA217FA
	for <linux-security-module@archiver.kernel.org>; Sun, 17 Feb 2019 18:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbfBQStI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 17 Feb 2019 13:49:08 -0500
Received: from mail.hallyn.com ([178.63.66.53]:58134 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbfBQStI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 17 Feb 2019 13:49:08 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 6DCB4615; Sun, 17 Feb 2019 12:49:06 -0600 (CST)
Date:   Sun, 17 Feb 2019 12:49:06 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     mortonm@chromium.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        casey@schaufler-ca.com, sds@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/2] LSM: SafeSetID: gate setgid transitions
Message-ID: <20190217184906.GA20247@mail.hallyn.com>
References: <20190215222228.133709-1-mortonm@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215222228.133709-1-mortonm@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 15, 2019 at 02:22:28PM -0800, mortonm@chromium.org wrote:
> From: Micah Morton <mortonm@chromium.org>
> 
> The SafeSetID LSM already gates setuid transitions for UIDs on the
> system whose use of CAP_SETUID has been 'restricted'. This patch
> implements the analogous functionality for setgid transitions, in order
> to restrict the use of CAP_SETGID for certain UIDs on the system. One
> notable consequence of this addition is that a process running under a
> restricted UID (i.e. one that is only allowed to setgid to certain
> approved GIDs) will not be allowed to call the setgroups() syscall to
> set its supplementary group IDs. For now, we leave such support for
> restricted setgroups() to future work, as it would require hooking the
> logic in setgroups() and verifying that the array of GIDs passed in from
> userspace only consists of approved GIDs.
> 
> Signed-off-by: Micah Morton <mortonm@chromium.org>
> ---
> Tested with slight mod to test in tools/testing/selftests/safesetid for
> testing setgid as well as setuid.
> 
>  security/safesetid/lsm.c        | 263 +++++++++++++++++++++++++++-----
>  security/safesetid/lsm.h        |  11 +-
>  security/safesetid/securityfs.c | 105 +++++++++----
>  3 files changed, 307 insertions(+), 72 deletions(-)
> 
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index cecd38e2ac80..5d9710b7bb04 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -26,27 +26,30 @@ int safesetid_initialized;
>  
>  #define NUM_BITS 8 /* 128 buckets in hash table */
...
> +int add_safesetid_whitelist_uid_entry(kuid_t parent, kuid_t child)
>  {
> -	struct entry *new;
> +	struct id_entry *new;
>  
>  	/* Return if entry already exists */
>  	if (check_setuid_policy_hashtable_key_value(parent, child))
>  		return 0;
>  
> -	new = kzalloc(sizeof(struct entry), GFP_KERNEL);
> +	new = kzalloc(sizeof(struct id_entry), GFP_KERNEL);
> +	if (!new)
> +		return -ENOMEM;
> +	new->parent_kuid = __kuid_val(parent);
> +	new->child_kid = __kuid_val(child);
> +	spin_lock(&safesetid_whitelist_uid_hashtable_spinlock);
> +	hash_add_rcu(safesetid_whitelist_uid_hashtable,
> +		     &new->next,
> +		     __kuid_val(parent));

Do you care at all about the possibility of duplicate entries?

> +	spin_unlock(&safesetid_whitelist_uid_hashtable_spinlock);
> +	return 0;
> +}
