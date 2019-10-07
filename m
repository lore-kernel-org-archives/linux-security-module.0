Return-Path: <SRS0=9mRN=YA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A3AC47404
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Oct 2019 16:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6970206BB
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Oct 2019 16:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="FpFHy4pe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfJGQnG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:43:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43836 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfJGQnG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Oct 2019 12:43:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id i32so1239418pgl.10
        for <linux-security-module@vger.kernel.org>; Mon, 07 Oct 2019 09:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DqRaKKb4MIDZkPIzMIF26YB72N9deabH6QrKCDZ4VYg=;
        b=FpFHy4peK4L70f64OcM9wSee5GAAbdr7kct1DpldnL87yT1hCZqb7C0VCWf4+b4t1K
         m2Gt4RHACh7KJdMxbnHVgbHN1E4eyp46IJDFySJl5gKSaXFspgau0JGltITbFAd10qr5
         k8+hb7KPJHZfyhXXVhSQ6D1YpEZc4SIh8jKU5f4BX6qF3jvaSKNSs4290NYCBD3FaEhF
         /KbgTDIx7dE2pzirfxZS+3aXejWSaw9I8blAqhnR4ud6KZxHgIy5UyX0KlgR9xucLRTo
         zmcEl/M5GRgA9u7h0aY5OIFpHjdeySpzLImv3Y8Kq2GizltfOww40DIfER4lL3+YQyXT
         MiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DqRaKKb4MIDZkPIzMIF26YB72N9deabH6QrKCDZ4VYg=;
        b=KUMj+w2Q5ViWm72BCj1tkTpsHOXPvI6wkn46rELA0KYuocj2UFOB9vVIddkp/dESLE
         3/7LoJ9yv64ZUiCJ95A4qQzS1Y2Wv174w7Y1AwaMe/NfOVGBC81N9M7H1fCreU1FjqPL
         bWQiZqlVt/ido2XUAOGu3hUh4Ct5RX7yHQPh1yin0ZM6njBlAm53shSNoCw/W4KLkVz8
         +C8jKT230ZZqpCL4iGFZSBtkGYuLCiHp+5AUJDXAvIVRzCSEvQBI/y9kuDTjiAcNK/0L
         StqaNj+7cnw3A17F4nbxssO4WxXlevf+vrSz10slow3ImwlPBavMitXp1mI1SkzFeAC4
         VnqA==
X-Gm-Message-State: APjAAAUbe7O7kc8R9KeNrLJS4mP00Jm2ioFqHtpGspNZwCKXT0kYxmP/
        aKY6RRp850Wv8kubC07hWyqu+g==
X-Google-Smtp-Source: APXvYqyIFfiIX8M8ZKiZ25hUlwGaFhNL6pVrJMMdwvYiiyg8No4RMZKuFIF8exLb9Ld1x7axYzWV+A==
X-Received: by 2002:a63:e558:: with SMTP id z24mr6194458pgj.379.1570466585019;
        Mon, 07 Oct 2019 09:43:05 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id k5sm14054281pgb.11.2019.10.07.09.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 09:43:04 -0700 (PDT)
Subject: Re: [PATCH] ovl: filter of trusted xattr results in audit
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        linux-security-module@vger.kernel.org, stable@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
References: <20191007160918.29504-1-salyzyn@android.com>
 <20191007161616.GA988623@kroah.com> <20191007161725.GB988623@kroah.com>
 <20191007164037.GA1012698@kroah.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <75330715-b83c-fa26-5dbd-745f71e9d592@android.com>
Date:   Mon, 7 Oct 2019 09:43:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007164037.GA1012698@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/7/19 9:40 AM, Greg Kroah-Hartman wrote:
> On Mon, Oct 07, 2019 at 06:17:25PM +0200, Greg Kroah-Hartman wrote:
>> On Mon, Oct 07, 2019 at 06:16:16PM +0200, Greg Kroah-Hartman wrote:
>>> On Mon, Oct 07, 2019 at 09:09:16AM -0700, Mark Salyzyn wrote:
>>>> When filtering xattr list for reading, presence of trusted xattr
>>>> results in a security audit log.  However, if there is other content
>>>> no errno will be set, and if there isn't, the errno will be -ENODATA
>>>> and not -EPERM as is usually associated with a lack of capability.
>>>> The check does not block the request to list the xattrs present.
>>>>
>>>> Switch to has_capability_noaudit to reflect a more appropriate check.
>>>>
>>>> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
>>>> Cc: linux-security-module@vger.kernel.org
>>>> Cc: kernel-team@android.com
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: stable@vger.kernel.org # v3.18
>>>> Fixes: upstream a082c6f680da ("ovl: filter trusted xattr for non-admin")
>>>> Fixes: 3.18 4bcc9b4b3a0a ("ovl: filter trusted xattr for non-admin")
>>>> ---
>>>> Replaced ns_capable_noaudit with 3.18.y tree specific
>>>> has_capability_noaudit present in original submission to kernel.org
>>>> commit 5c2e9f346b815841f9bed6029ebcb06415caf640
>>>> ("ovl: filter of trusted xattr results in audit")
>>>>
>>>>   fs/overlayfs/inode.c | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
>>>> index a01ec1836a72..1175efa5e956 100644
>>>> --- a/fs/overlayfs/inode.c
>>>> +++ b/fs/overlayfs/inode.c
>>>> @@ -265,7 +265,8 @@ static bool ovl_can_list(const char *s)
>>>>   		return true;
>>>>   
>>>>   	/* Never list trusted.overlay, list other trusted for superuser only */
>>>> -	return !ovl_is_private_xattr(s) && capable(CAP_SYS_ADMIN);
>>>> +	return !ovl_is_private_xattr(s) &&
>>>> +	       has_capability_noaudit(current, CAP_SYS_ADMIN);
>>>>   }
>>>>   
>>>>   ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
>>>> -- 
>>>> 2.23.0.581.g78d2f28ef7-goog
>>>>
>>> Thanks for the backport, this one worked!
>> I spoke too soon:
>>
>> ERROR: "has_capability_noaudit" [fs/overlayfs/overlay.ko] undefined!
>>
>> That function isn't exported for modules :(
> But, if this really is needed, and it fixes the issue, I'll go export
> that symbol with EXPORT_SYMBOL_GPL() to fix the problem.  Any
> objections?
>
> thanks,
>
> greg k-h

Ok, you just answered my question in cross-emails. Yes, 
EXPORT_SYMBOL_GPL() (my option 2).


Thanks


-- Mark Salyzyn

