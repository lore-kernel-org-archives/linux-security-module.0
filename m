Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD03CC433F5
	for <linux-security-module@archiver.kernel.org>; Sun, 22 May 2022 17:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbiEVRis (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 22 May 2022 13:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiEVRir (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 22 May 2022 13:38:47 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622B714086;
        Sun, 22 May 2022 10:38:46 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id A91883F4; Sun, 22 May 2022 12:38:44 -0500 (CDT)
Date:   Sun, 22 May 2022 12:38:44 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v12 12/26] ima: Only accept AUDIT rules for
 non-init_ima_ns namespaces for now
Message-ID: <20220522173844.GA24519@mail.hallyn.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-13-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420140633.753772-13-stefanb@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 20, 2022 at 10:06:19AM -0400, Stefan Berger wrote:
> Only accept AUDIT rules for non-init_ima_ns namespaces for now. Reject

This sentence gives me trouble - i keep thinking you mean that you'll
reject AUDIT rules for init_ima_ns :)  Can you rephrase it as something
like

For non-init_ima_ns namespaces, only accept AUDIT rules for now.

:)

> all rules that require support for measuring, appraisal, and hashing.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Christian Brauner <brauner@kernel.org>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> 
> ---
> v9:
>   - Jump to err_audit when unsupported rules are detected
> ---
>  security/integrity/ima/ima_policy.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 59e4ae5a6361..45a997709200 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1812,6 +1812,17 @@ static int ima_parse_rule(struct ima_namespace *ns,
>  			result = -EINVAL;
>  			break;
>  		}
> +
> +		/* IMA namespace only accepts AUDIT rules */
> +		if (ns != &init_ima_ns && result == 0) {
> +			switch (entry->action) {
> +			case MEASURE:
> +			case APPRAISE:
> +			case HASH:

So... what about DONT_MEASURE and DONT_APPRAISE?

> +				result = -EINVAL;
> +				goto err_audit;
> +			}
> +		}
>  	}
>  	if (!result && !ima_validate_rule(entry))
>  		result = -EINVAL;
> @@ -1824,6 +1835,7 @@ static int ima_parse_rule(struct ima_namespace *ns,
>  		check_template_modsig(template_desc);
>  	}
>  
> +err_audit:
>  	audit_log_format(ab, "res=%d", !result);
>  	audit_log_end(ab);
>  	return result;
> -- 
> 2.34.1
