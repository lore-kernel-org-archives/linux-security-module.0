Return-Path: <SRS0=FAtl=TH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B29C004C9
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 19:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEAA320989
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 19:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfEGT56 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 May 2019 15:57:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51355 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfEGT56 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 May 2019 15:57:58 -0400
Received: from static-50-53-34-51.bvtn.or.frontiernet.net ([50.53.34.51] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1hO6Dp-00007u-HU; Tue, 07 May 2019 19:57:53 +0000
Subject: Re: [PATCH 2/2] apparmor: Switch to GFP_KERNEL where possible
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, tglx@linutronix.de
References: <20190405133458.4809-1-bigeasy@linutronix.de>
 <20190405133458.4809-2-bigeasy@linutronix.de>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <30fe30e1-2315-5e15-5371-d4b7f532401a@canonical.com>
Date:   Tue, 7 May 2019 12:57:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405133458.4809-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 4/5/19 6:34 AM, Sebastian Andrzej Siewior wrote:
> After removing preempt_disable() from get_buffers() it is possible to
> replace a few GFP_ATOMIC allocations with GFP_KERNEL.
> 
> Replace GFP_ATOMIC allocations with GFP_KERNEL where the context looks
> to bee preepmtible.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I am pulling this one is as well


> ---
>  security/apparmor/domain.c | 20 ++++++++++----------
>  security/apparmor/file.c   |  2 +-
>  security/apparmor/mount.c  |  2 +-
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
> index 1f4a6e420b6d3..b8114d9988bac 100644
> --- a/security/apparmor/domain.c
> +++ b/security/apparmor/domain.c
> @@ -524,7 +524,7 @@ struct aa_label *x_table_lookup(struct aa_profile *profile, u32 xindex,
>  				label = &new_profile->label;
>  			continue;
>  		}
> -		label = aa_label_parse(&profile->label, *name, GFP_ATOMIC,
> +		label = aa_label_parse(&profile->label, *name, GFP_KERNEL,
>  				       true, false);
>  		if (IS_ERR(label))
>  			label = NULL;
> @@ -604,7 +604,7 @@ static struct aa_label *x_to_label(struct aa_profile *profile,
>  		/* base the stack on post domain transition */
>  		struct aa_label *base = new;
>  
> -		new = aa_label_parse(base, stack, GFP_ATOMIC, true, false);
> +		new = aa_label_parse(base, stack, GFP_KERNEL, true, false);
>  		if (IS_ERR(new))
>  			new = NULL;
>  		aa_put_label(base);
> @@ -712,7 +712,7 @@ static struct aa_label *profile_transition(struct aa_profile *profile,
>  		if (DEBUG_ON) {
>  			dbg_printk("apparmor: scrubbing environment variables"
>  				   " for %s profile=", name);
> -			aa_label_printk(new, GFP_ATOMIC);
> +			aa_label_printk(new, GFP_KERNEL);
>  			dbg_printk("\n");
>  		}
>  		*secure_exec = true;
> @@ -788,7 +788,7 @@ static int profile_onexec(struct aa_profile *profile, struct aa_label *onexec,
>  		if (DEBUG_ON) {
>  			dbg_printk("apparmor: scrubbing environment "
>  				   "variables for %s label=", xname);
> -			aa_label_printk(onexec, GFP_ATOMIC);
> +			aa_label_printk(onexec, GFP_KERNEL);
>  			dbg_printk("\n");
>  		}
>  		*secure_exec = true;
> @@ -822,7 +822,7 @@ static struct aa_label *handle_onexec(struct aa_label *label,
>  					       bprm, buffer, cond, unsafe));
>  		if (error)
>  			return ERR_PTR(error);
> -		new = fn_label_build_in_ns(label, profile, GFP_ATOMIC,
> +		new = fn_label_build_in_ns(label, profile, GFP_KERNEL,
>  				aa_get_newest_label(onexec),
>  				profile_transition(profile, bprm, buffer,
>  						   cond, unsafe));
> @@ -834,9 +834,9 @@ static struct aa_label *handle_onexec(struct aa_label *label,
>  					       buffer, cond, unsafe));
>  		if (error)
>  			return ERR_PTR(error);
> -		new = fn_label_build_in_ns(label, profile, GFP_ATOMIC,
> +		new = fn_label_build_in_ns(label, profile, GFP_KERNEL,
>  				aa_label_merge(&profile->label, onexec,
> -					       GFP_ATOMIC),
> +					       GFP_KERNEL),
>  				profile_transition(profile, bprm, buffer,
>  						   cond, unsafe));
>  	}
> @@ -902,7 +902,7 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
>  		new = handle_onexec(label, ctx->onexec, ctx->token,
>  				    bprm, buffer, &cond, &unsafe);
>  	else
> -		new = fn_label_build(label, profile, GFP_ATOMIC,
> +		new = fn_label_build(label, profile, GFP_KERNEL,
>  				profile_transition(profile, bprm, buffer,
>  						   &cond, &unsafe));
>  
> @@ -946,7 +946,7 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
>  		if (DEBUG_ON) {
>  			dbg_printk("scrubbing environment variables for %s "
>  				   "label=", bprm->filename);
> -			aa_label_printk(new, GFP_ATOMIC);
> +			aa_label_printk(new, GFP_KERNEL);
>  			dbg_printk("\n");
>  		}
>  		bprm->secureexec = 1;
> @@ -957,7 +957,7 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
>  		if (DEBUG_ON) {
>  			dbg_printk("apparmor: clearing unsafe personality "
>  				   "bits. %s label=", bprm->filename);
> -			aa_label_printk(new, GFP_ATOMIC);
> +			aa_label_printk(new, GFP_KERNEL);
>  			dbg_printk("\n");
>  		}
>  		bprm->per_clear |= PER_CLEAR_ON_SETID;
> diff --git a/security/apparmor/file.c b/security/apparmor/file.c
> index e422a3f59e80c..3eb2c5369711c 100644
> --- a/security/apparmor/file.c
> +++ b/security/apparmor/file.c
> @@ -80,7 +80,7 @@ static void file_audit_cb(struct audit_buffer *ab, void *va)
>  	if (aad(sa)->peer) {
>  		audit_log_format(ab, " target=");
>  		aa_label_xaudit(ab, labels_ns(aad(sa)->label), aad(sa)->peer,
> -				FLAG_VIEW_SUBNS, GFP_ATOMIC);
> +				FLAG_VIEW_SUBNS, GFP_KERNEL);
>  	} else if (aad(sa)->fs.target) {
>  		audit_log_format(ab, " target=");
>  		audit_log_untrustedstring(ab, aad(sa)->fs.target);
> diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
> index 8a6cf1c14e82a..d73bc3ceaf9f5 100644
> --- a/security/apparmor/mount.c
> +++ b/security/apparmor/mount.c
> @@ -679,7 +679,7 @@ int aa_pivotroot(struct aa_label *label, const struct path *old_path,
>  
>  	old_buffer = aa_get_buffer();
>  	new_buffer = aa_get_buffer();
> -	target = fn_label_build(label, profile, GFP_ATOMIC,
> +	target = fn_label_build(label, profile, GFP_KERNEL,
>  			build_pivotroot(profile, new_path, new_buffer,
>  					old_path, old_buffer));
>  	if (!target) {
> 

