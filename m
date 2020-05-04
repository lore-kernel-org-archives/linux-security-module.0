Return-Path: <SRS0=JC4w=6S=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA63AC47254
	for <linux-security-module@archiver.kernel.org>; Mon,  4 May 2020 22:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88C9E206C0
	for <linux-security-module@archiver.kernel.org>; Mon,  4 May 2020 22:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SmNRMKW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgEDWvx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 4 May 2020 18:51:53 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54530 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgEDWvx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 May 2020 18:51:53 -0400
Received: from [192.168.0.109] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id A901720B717B;
        Mon,  4 May 2020 15:51:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A901720B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1588632712;
        bh=TlGQvxa4ZoTlkS3uwvgeQHJhmGCbxfklMLyyEyAa7OY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SmNRMKW9loVFwCG/K0n82fcbSosLA5AlKHNh9PPxohuV+WIHiV7kQqXjgu1kId1Tz
         M7Znn2wPlci5ysddHzsZQCaXDe1/ZZEy7U73IFQ1h2apD6MkOAaEk8/FhAlnl3VQgg
         8R1enS/nld1g/KsJUf28+R+pyifNpF+kq0BnCvgo=
Subject: Re: [RFC PATCH] ima: verify mprotect change is consistent with mmap
 policy
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1588627060-7399-1-git-send-email-zohar@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <7812a3a7-f47d-c924-c12e-f417bb6f43dc@linux.microsoft.com>
Date:   Mon, 4 May 2020 15:51:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588627060-7399-1-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 5/4/20 2:17 PM, Mimi Zohar wrote:

Hi Mimi,

> +int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
> +{
> +	struct ima_template_desc *template;
> +	struct inode *inode;
> +	int result = 0;
> +	int action;
> +	u32 secid;
> +	int pcr;
> +
> +	if (vma->vm_file && (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {

Just a suggestion:
Maybe you could do the negative of the above check and return, so that 
the block within the if statement doesn't have to be indented.

> +		inode = file_inode(vma->vm_file);
> +
> +		security_task_getsecid(current, &secid);
> +		action = ima_get_action(inode, current_cred(), secid, MAY_EXEC,
> +					MMAP_CHECK, &pcr, &template, 0);
> +
> +		if (action & IMA_APPRAISE_SUBMASK)
> +			result = -EPERM;
> +
> +		if ((action & IMA_APPRAISE_SUBMASK) || (action & IMA_MEASURE)) {

action is checked for IMA_APPRAISE_SUBMASK bits in the previous if 
statement. Does it need to be checked again in the above if statement?

> +			struct file *file = vma->vm_file;
> +			char *pathbuf = NULL;
> +			const char *pathname;
> +			char filename[NAME_MAX];
> +
> +			pathname = ima_d_path(&file->f_path, &pathbuf,
> +					      filename);
> +			integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
> +					    pathname, "collect_data",
> +					    "failed-mprotect", result, 0);
> +
> +			if (pathbuf)
> +				__putname(pathbuf);
> +		}
> +	}
> +	return result;
> +}

thanks,
  -lakshmi

