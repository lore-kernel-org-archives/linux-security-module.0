Return-Path: <SRS0=XUZh=7K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A606C433E2
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 19:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F062F207BC
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 19:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590693240;
	bh=MnWgaBTeNmlOTB8V+xlxOASVA93eFmB3RvbSfIKHG2I=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=HdFg9Tx078GsUylW5fAuO8vZi9tBdFdOj1S7fdm/QlTteJwhCnnoiBLHnWE55lbZd
	 6UjOlYagu3hV2279734AjbH/Gkw4dDTEsZlmiCbcq7IA5C6KjRhtmEeqmpV0jwuVNf
	 YBfcELs1QelnNcYXIf9KU9b/53unddaHu17B8eXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406241AbgE1TN7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 May 2020 15:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406212AbgE1TN4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 May 2020 15:13:56 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AA4C08C5C8
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2020 12:13:56 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id y85so164797oie.11
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2020 12:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2Aid1A7qAbnqwEDuFuiLArV71skaojblrB/GGrrY4cY=;
        b=e/SbMRNYoY+hzrbh8kw6sZOUW7BIjelH8o7w/nPznUrHvOqGBfMGSY/ZJvwbvzX9b9
         ujhnDk+WqjX72eLW0c/Oi38lUQJGxsN4bJLsbijzFtd1H7cAGfx3r/ThZzPxX3EIUSBU
         fYXf/OsO7yEZJsIlQbVUCFveqN8DcltBNmHx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Aid1A7qAbnqwEDuFuiLArV71skaojblrB/GGrrY4cY=;
        b=K/CycZDFOLutD6vI2rgMJtnaXq4JFe+RiYAbIbmhbMkh+spyIAedUDcyowkIn9koqI
         AUPJUTH7Xzo5D50txSkZxy9t73tQi+VXmiC7mW5mKhz2FPFgpHASCv6Q+7+080+10LOE
         vyRrwhw2UW5WOrZQWpKx2Q4O7ba6NxgrMUWDxIXlWHKPirHsH1KXBljcc3zQbWyERvzn
         1eiWAGiihq5eTPiwfg4zMDWoS/1pk3iqond2BVfofkUBC9+1feZ11bPy2FawtQz/K4z5
         Zl4z4Pq/BkiF+FXjAHZ3zXBFWv04lts+4zEbc4lMzV+LzHdjNUoDlpc5eFVcnDIhX27U
         Hw+g==
X-Gm-Message-State: AOAM532lDjNprwTo4JD2tQ/mpMW8zbrf5gQ0gNurWW9ApuUE6XW/Oih7
        EgqNdv0Oa93PtO1XF2rf1O6lyQ==
X-Google-Smtp-Source: ABdhPJy8uruNUiwWVk93BXNeRvSwBhf7iaLMvdmzo0+duEh9lWnm2W57Ul89YuTANAlkrm/ZuJlOKA==
X-Received: by 2002:a05:6808:117:: with SMTP id b23mr3149973oie.143.1590693235796;
        Thu, 28 May 2020 12:13:55 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k3sm829951oia.41.2020.05.28.12.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 12:13:55 -0700 (PDT)
Subject: Re: [PATCH v3 0/6] Enable as many KUnit tests as possible
To:     Brendan Higgins <brendanhiggins@google.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        David Gow <davidgow@google.com>, skhan@linuxfoundation.org
References: <20200511131350.29638-1-anders.roxell@linaro.org>
 <CADYN=9LkA2h6dANREfPQq4iDvVEJX1wAdxjv31mpVBkaM_g0ZQ@mail.gmail.com>
 <CAFd5g452oiRpMa3S=F9wFsb9SRKBYXJFuusge+6=zCEFX74kYQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <76811e1b-c26f-53ac-5703-104aacd06666@linuxfoundation.org>
Date:   Thu, 28 May 2020 13:13:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g452oiRpMa3S=F9wFsb9SRKBYXJFuusge+6=zCEFX74kYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 5/28/20 1:07 PM, Brendan Higgins wrote:
> On Wed, May 27, 2020 at 4:49 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>>
>> Hi all,
>>
>> Friendly ping: who can take this?
> 
> Sorry, I just reviewed the last patch.
> 
> Shuah, do you mind picking this up for 5.8?
> 

Yup. Will do. I was watching this thread waiting for your
Ack. I will apply it once.

thanks,
-- Shuah

