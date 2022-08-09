Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA98C25B0E
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Aug 2022 15:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244753AbiHIP6P (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 9 Aug 2022 11:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244778AbiHIP6L (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Aug 2022 11:58:11 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A1919C1C
        for <linux-security-module@vger.kernel.org>; Tue,  9 Aug 2022 08:58:09 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id w196so9268146oiw.10
        for <linux-security-module@vger.kernel.org>; Tue, 09 Aug 2022 08:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tyhicks-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HUXaYVwE6orHodeBsCAxKkSFqqLupHxNZ2roYGcQJ3U=;
        b=qLwOZH9UT3mHrvDuf0QBZ8Am9wtvtBRS7umuarT0r9UbJrssHJXWIg3h17TiycX1dn
         qNENXZ3y9l8gp9q5l7k7gVd+1kToWHoZlaQeyXGNtDa1Fjdv5FtAHWLTAuo0i/HDTXtu
         Ka+AzCyLNZ4IjM1vO/jXPagJT2MvcrqGBhTMTrTQldfvo9C7x7+I66tQNMdXJ+/72K87
         yjjt59mRZjWUoigeMet/tlZrmNdPLPYXuEJpvtVGq7r0+3OrCGBlvcaO0FKvBuZHkbhU
         n5a3agXQ6rwmxQV5QaRqMGukQA9NhloWit2Ndwft7b6D9v0HCU8O44NqoCkfz80MYgoW
         8ghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HUXaYVwE6orHodeBsCAxKkSFqqLupHxNZ2roYGcQJ3U=;
        b=XkBlclB/jRtFgtTRn879ecVB6Lpg4uBajAe4faE30HzPXRFE6h+b41BGMyAx6FAlA0
         mFjA+HnEgHpEABIAvLBZBQ8DFlkvg3zC8e/wBVREQBiCLnR/Q71z063evCLc1FZZw34R
         ybJfn7RU+W55ySpjyYbDLM+bUjqqCZhA/cW0YhBHD8kvpGIIa0kmuEQaP4OB3zpA21e4
         BKqVZruhvXjZVVuZWrGk7WiCRpLGmTsBLGdqhOqg3zzdh2vCaD+l1L4cYYdZWSbC2aih
         mxVzCR/7lYZ6b6ga2mo+AkvADKgQGamN0apviwRjbwdxlprNbnz647bbXxwIhY468HuH
         DtOA==
X-Gm-Message-State: ACgBeo3yYZGNz2Gx0zDAwUAqnLv6Sw7V2HQ7/H1jXbMWjhLSBvHl1TPo
        gY725dF+fr1iEmHRAwhfFrbAEQ==
X-Google-Smtp-Source: AA6agR5yALJSQiqpyuDxfVXadUjpSlKzadaxwr3uRwJCazGWMfl76Mg96IgJ2CaNNqe5ceJ+1WIb5A==
X-Received: by 2002:a05:6808:1889:b0:33b:2f70:cca0 with SMTP id bi9-20020a056808188900b0033b2f70cca0mr10801550oib.253.1660060688904;
        Tue, 09 Aug 2022 08:58:08 -0700 (PDT)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net. [162.237.133.238])
        by smtp.gmail.com with ESMTPSA id c4-20020a056870c08400b0010e81e27b99sm3179258oad.17.2022.08.09.08.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 08:58:08 -0700 (PDT)
Date:   Tue, 9 Aug 2022 10:57:50 -0500
From:   Tyler Hicks <code@tyhicks.com>
To:     Deven Bowers <deven.desai@linux.microsoft.com>
Cc:     corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org,
        axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        eparis@redhat.com, paul@paul-moore.com, dm-devel@redhat.com,
        linux-doc@vger.kernel.org, roberto.sassu@huawei.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-audit@redhat.com,
        linux-integrity@vger.kernel.org
Subject: Re: [RFC PATCH v8 07/17] ipe: add auditing support
Message-ID: <20220809155737.GA39351@sequoia>
References: <1654714889-26728-1-git-send-email-deven.desai@linux.microsoft.com>
 <1654714889-26728-8-git-send-email-deven.desai@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654714889-26728-8-git-send-email-deven.desai@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2022-06-08 12:01:19, Deven Bowers wrote:
> +/**
> + * getaudit: Read handler for the securityfs node, "ipe/success_audit"
> + * @f: Supplies a file structure representing the securityfs node.
> + * @data: Supplies a buffer passed to the read syscall
> + * @len: Supplies the length of @data
> + * @offset: unused.
> + *
> + * Return:
> + * >0 - Success, Length of buffer written
> + * <0 - Error
> + */
> +static ssize_t getaudit(struct file *f, char __user *data,
> +			size_t len, loff_t *offset)
> +{
> +	const char *result;
> +	struct ipe_context *ctx;
> +
> +	ctx = ipe_current_ctx();
> +
> +	rcu_read_lock();
> +	result = ((READ_ONCE(ctx->success_audit)) ? "1" : "0");
> +	rcu_read_unlock();
> +
> +	ipe_put_ctx(ctx);
> +	return simple_read_from_buffer(data, len, offset, result, 2);

While doing some internal testing, I noticed that some of the IPE files
in securityfs (ipe/audit, ipe/enforce, and ipe/policies/*/active) are
including the NULL terminator (size of 2) in the securityfs file
contents. This is not common to do and this busybox build that my test
machine is using even has some trouble when displaying those files with
cat. I see all three instances of this pattern with this command:

 $ git grep simple_read_from_buffer\(.*,\ 2\) security/ipe

I think going to a length of 1 would be best.

Tyler
