Return-Path: <SRS0=9iMC=74=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C7DC433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 16:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 714472078A
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 16:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aUYzJCzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbgFOQpu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:45:50 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55090 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgFOQpt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jun 2020 12:45:49 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id A5BB520B4780;
        Mon, 15 Jun 2020 09:45:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A5BB520B4780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592239548;
        bh=XWqIoID6oSJi5sFAyDXKdR658vGMUI/XhOZPL0DsKnA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aUYzJCzFeQs+E1ArnYzFlomMA/IssGZNCua/12Ubl8cVtJJPgf1aW8IEd6Hb54Zuv
         6iWDu3Nyl7+Q6Nu4kCWvt/q8Yq6G05vX28voSp3QubdOutU2hmwJ6pOurhIk+bCe0D
         ScAH/mqlpvnydpdE9sHA5BOsIkhYeyDjbuQ/DqpY=
Subject: Re: [PATCH 4/5] LSM: Define SELinux function to measure security
 state
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Stephen Smalley <stephen.smalley@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200613024130.3356-1-nramas@linux.microsoft.com>
 <20200613024130.3356-5-nramas@linux.microsoft.com>
 <CAEjxPJ49UaZc9pc-+VN8Cx8rcdrjD6NMoLOO_zqENezobmfwVA@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <a9a20aa5-963e-5f49-9391-0673fdda378e@linux.microsoft.com>
Date:   Mon, 15 Jun 2020 09:45:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ49UaZc9pc-+VN8Cx8rcdrjD6NMoLOO_zqENezobmfwVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 6/15/20 4:57 AM, Stephen Smalley wrote:

Hi Stephen,

Thanks for reviewing the patches.

>> +void security_state_change(char *lsm_name, void *state, int state_len)
>> +{
>> +       ima_lsm_state(lsm_name, state, state_len);
>> +}
>> +
> 
> What's the benefit of this trivial function instead of just calling
> ima_lsm_state() directly?

One of the feedback Casey Schaufler had given earlier was that calling 
an IMA function directly from SELinux (or, any of the Security Modules) 
would be a layering violation.

LSM framework (security/security.c) already calls IMA functions now (for 
example, ima_bprm_check() is called from security_bprm_check()). I 
followed the same pattern for measuring LSM data as well.

Please let me know if I misunderstood Casey's comment.

>> +static int selinux_security_state(char **lsm_name, void **state,
>> +                                 int *state_len)
>> +{
>> +       int rc = 0;
>> +       char *new_state;
>> +       static char *security_state_string = "enabled=%d;enforcing=%d";
>> +
>> +       *lsm_name = kstrdup("selinux", GFP_KERNEL);
>> +       if (!*lsm_name)
>> +               return -ENOMEM;
>> +
>> +       new_state = kzalloc(strlen(security_state_string) + 1, GFP_KERNEL);
>> +       if (!new_state) {
>> +               kfree(*lsm_name);
>> +               *lsm_name = NULL;
>> +               rc = -ENOMEM;
>> +               goto out;
>> +       }
>> +
>> +       *state_len = sprintf(new_state, security_state_string,
>> +                            !selinux_disabled(&selinux_state),
>> +                            enforcing_enabled(&selinux_state));
> 
> I think I mentioned this on a previous version of these patches, but I
> would recommend including more than just the enabled and enforcing
> states in your measurement.  Other low-hanging fruit would be the
> other selinux_state booleans (checkreqprot, initialized,
> policycap[0..__POLICYDB_CAPABILITY_MAX]).  Going a bit further one
> could take a hash of the loaded policy by using security_read_policy()
> and then computing a hash using whatever hash ima prefers over the
> returned data,len pair.  You likely also need to think about how to
> allow future extensibility of the state in a backward-compatible
> manner, so that future additions do not immediately break systems
> relying on older measurements.
> 

Sure - I will address this one in the next update.

thanks,
  -lakshmi
