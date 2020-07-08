Return-Path: <SRS0=/FKR=AT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF3CC433E0
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 03:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF30E2078B
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 03:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JKld2quK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgGHDGf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 Jul 2020 23:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbgGHDGe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 Jul 2020 23:06:34 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E931C061755
        for <linux-security-module@vger.kernel.org>; Tue,  7 Jul 2020 20:06:34 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w3so1379352wmi.4
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jul 2020 20:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=clG40jEocuU8wd1OMuvgXzRO4UKlf5Hl17E/FM+Odb4=;
        b=JKld2quKagE5gZ7N0UONxJhyhzqQiCZ7vZJrP/oWaxIhLdQat6EFYBsSXfR1z5xzFR
         tDEe0PNwSAPdlTgrGPYC65QJ1XEpGrvK9l53W1ipZx7Ps7WFZblPfvXRVXl6SNIO6H59
         qMuWBigh6gQ2kZDXFV/FnmErnLC8LhAArcCgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=clG40jEocuU8wd1OMuvgXzRO4UKlf5Hl17E/FM+Odb4=;
        b=aoBR/bjgRNbFM8eI4/JfUMaJ36N3/8PlqnhJcWwVIU22o0SK29cluavrPraNVJ+cpf
         aH+V20D31iVLzshmBZGDwirqLbLcdHLBt9BVvrw6XlTPmhgjGRFkvKU/fHcG/1NqafcL
         eGURCPH8JuC8ajdvKZsQFzZltMF3OW6/LOkLrtdMzfEb1JcCqrFL0ZzwFzoNWpk08iyV
         zvhX/3BwDvgqSbPWU/nUxk8CpYCe9efQsBe6TR3HtvK2cMnLMwAMgjjYYdbV46pBG9JO
         DlqLZ7bld4/hsujAT3OREV2wd1+4TTXdNob3frHK+n5K2WvrFllwpziH02Z6wlJvW35r
         7yRg==
X-Gm-Message-State: AOAM531NzODY2EZ8i4ZX1O1LtPK3DkbL5cDfTXGDK24uPh931FVeXDcP
        Y6hCnfig8mAm72fcFoXzJD5jzUP/tvXmbg==
X-Google-Smtp-Source: ABdhPJwDURq126yewbHhgEiHcWbVtS6SzLoFi5wd0CcswuGQSAZ8LL58AC9V+QfEVIgEfQYx34dymg==
X-Received: by 2002:a1c:2402:: with SMTP id k2mr7012367wmk.138.1594177593142;
        Tue, 07 Jul 2020 20:06:33 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 92sm3769255wrr.96.2020.07.07.20.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 20:06:32 -0700 (PDT)
Subject: Re: [PATCH 2/4] fs: Remove FIRMWARE_PREALLOC_BUFFER from
 kernel_read_file() enums
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20200707081926.3688096-1-keescook@chromium.org>
 <20200707081926.3688096-3-keescook@chromium.org>
 <0a5e2c2e-507c-9114-5328-5943f63d707e@broadcom.com>
 <202007071447.D96AA42ECE@keescook>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <c2e4f5ae-0a2f-454e-6847-c413ca719abf@broadcom.com>
Date:   Tue, 7 Jul 2020 20:06:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <202007071447.D96AA42ECE@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Kees,

Thanks for looking at my patch series to see how it relates.
I see what you're trying to accomplish in various areas of cleanup.
I'll comment as I go through your individual emails.
1 comment below.

On 2020-07-07 2:55 p.m., Kees Cook wrote:
> On Tue, Jul 07, 2020 at 09:42:02AM -0700, Scott Branden wrote:
>> On 2020-07-07 1:19 a.m., Kees Cook wrote:
>>> FIRMWARE_PREALLOC_BUFFER is a "how", not a "what", and confuses the LSMs
>>> that are interested in filtering between types of things. The "how"
>>> should be an internal detail made uninteresting to the LSMs.
>>>
>>> Fixes: a098ecd2fa7d ("firmware: support loading into a pre-allocated buffer")
>>> Fixes: fd90bc559bfb ("ima: based on policy verify firmware signatures (pre-allocated buffer)")
>>> Fixes: 4f0496d8ffa3 ("ima: based on policy warn about loading firmware (pre-allocated buffer)")
>>> [...]
>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>> index 3f881a892ea7..95fc775ed937 100644
>>> --- a/include/linux/fs.h
>>> +++ b/include/linux/fs.h
>>> @@ -2993,10 +2993,10 @@ static inline void i_readcount_inc(struct inode *inode)
>>>    #endif
>>>    extern int do_pipe_flags(int *, int);
>>> +/* This is a list of *what* is being read, not *how*. */
>>>    #define __kernel_read_file_id(id) \
>>>    	id(UNKNOWN, unknown)		\
>>>    	id(FIRMWARE, firmware)		\
>> With this change, I'm trying to figure out how the partial firmware read is
>> going to work on top of this reachitecture.
>> Is it going to be ok to add READING_PARTIAL_FIRMWARE here as that is a
>> "what"?
> No, that's why I said you need to do the implementation within the API
> and not expect each LSM to implement their own (as I mentioned both
> times):
>
> https://lore.kernel.org/lkml/202005221551.5CA1372@keescook/
> https://lore.kernel.org/lkml/202007061950.F6B3D9E6A@keescook/
>
> I will reply in the thread above.
>
>>> -	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
>> My patch series gets rejected any time I make a change to the
>> kernel_read_file* region in linux/fs.h.
>> The requirement is for this api to move to another header file outside of
>> linux/fs.h
>> It seems the same should apply to your change.
> Well I'm hardly making the same level of changes, but yeah, sure, if
> that helps move things along, I can include that here.
>
>> Could you please add the following patch to the start of you patch series to
>> move the kernel_read_file* to its own include file?
>> https://patchwork.kernel.org/patch/11647063/
> https://lore.kernel.org/lkml/20200706232309.12010-2-scott.branden@broadcom.com/
>
> You've included it in include/linux/security.h and that should be pretty
> comprehensive, it shouldn't be needed in so many .c files.
Some people want the header files included in each c file they are used.
Others want header files not included if they are included in another 
header file.
I chose the first approach: every file that uses the api includes the 
header file.
I didn't know there was a standard approach to only put it in security.h
>

