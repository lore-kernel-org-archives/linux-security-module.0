Return-Path: <SRS0=/FKR=AT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E66C433DF
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 04:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92D7B20853
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 04:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WUXj1hng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbgGHEwJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Jul 2020 00:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729554AbgGHEvu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Jul 2020 00:51:50 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A378C08C5EE
        for <linux-security-module@vger.kernel.org>; Tue,  7 Jul 2020 21:51:50 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g75so1491850wme.5
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jul 2020 21:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YM0IzGADgX2tl1Mp5AFtyEMSY+GtGZFBS0TzG37PEVo=;
        b=WUXj1hnghzt3S3Xl8PkHIhKgc4y1+imaFlRTqYId1bXkQETCFWvksi9OaC5IchDWnN
         /G3tZ3QPpXYdo0LQXnUBTJmqJT9KSLHL1W0ppqEv0GzEoRLMsgv7oAFu9hXuZV3qNwUU
         EmbTjiaI3Wsm/bQlCldA6nvGa0OVis92xbh6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YM0IzGADgX2tl1Mp5AFtyEMSY+GtGZFBS0TzG37PEVo=;
        b=bq90Ex27zGp1EHVbRC+LgjnjtC3cCbWCgveCkzt7LeCNaUeOZ+q7jrfq+No0tKSc4u
         qMbvnNMONcL8wUWyeenmdchYxgnmPdXxfgE9KTqL6aYGlQKU1sY59LCisUdgs0NNvUqu
         gQzMJPL77ElJVa7r0VT6qWZrlQR/9wRsTL/b7kZmVPv6ctUQChul+/6OTr9/v+wJ/Zvc
         RFrlyQKxq6TJsvZErm+gLHyBjxM55VHROr/C03suSp3sCdgy0Tlsp0n1hyuhZSQhk3oe
         3/vQgNefSuM+PX6xJZsywpnf29FXAesGrlG6SOd0qMzg0eXf+DO4NlxoliVMesDtN8wd
         trIg==
X-Gm-Message-State: AOAM530Wq9lQmobtRJh1iyiPNC47m7BnB0hrMDZFa5WVBnC5ru3/nK02
        P+QROxl9KK4DRLTxFc0xwGnbJNdGrTQ0/A6kJGD2PFZpFup3/sjP1V0ggdXaAe2tgnqCDuIvHdi
        yJavh8Orsjl1JGVWMg5HLl8ivBfJS+qkTNNUNlwX1qmG5J9Y94ZCktNxRw5D8sJVXRVtXeaJ1ZM
        qHy7eDmdwENQB8E3SSSWmV
X-Google-Smtp-Source: ABdhPJxCmxanR1p+Zv9NtrwZXxJyNGR3oD42FStMXE5QtLw0GpBvXi6oEnvGhedpl11EqTWK1HD1Eg==
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr7135332wmf.140.1594183908367;
        Tue, 07 Jul 2020 21:51:48 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id y7sm3843597wrt.11.2020.07.07.21.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 21:51:47 -0700 (PDT)
Subject: Re: [PATCH v10 0/9] firmware: add request_partial_firmware_into_buf
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200706232309.12010-1-scott.branden@broadcom.com>
 <c8bbabe6-0b25-a816-f95d-8af63010eaf2@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <6c6126cc-6572-b341-7808-5e573d0cfad8@broadcom.com>
Date:   Tue, 7 Jul 2020 21:51:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c8bbabe6-0b25-a816-f95d-8af63010eaf2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Florian,

On 2020-07-07 9:38 p.m., Florian Fainelli wrote:
>
> On 7/6/2020 4:23 PM, Scott Branden wrote:
>> This patch series adds partial read support via a new call
>> request_partial_firmware_into_buf.
>> Such support is needed when the whole file is not needed and/or
>> only a smaller portion of the file will fit into allocated memory
>> at any one time.
>> In order to accept the enhanced API it has been requested that kernel
>> selftests and upstreamed driver utilize the API enhancement and so
>> are included in this patch series.
>>
>> Also in this patch series is the addition of a new Broadcom VK driver
>> utilizing the new request_firmware_into_buf enhanced API.
>>
>> Further comment followed to add IMA support of the partial reads
>> originating from request_firmware_into_buf calls.  And another request
>> to move existing kernel_read_file* functions to its own include file.
> Do you have any way to separate the VK drivers submission from the
> request_partial_firmware_into_buf() work that you are doing? It looks
> like it is going to require quite a few iterations of this patch set for
> the firmware/fs/IMA part to be ironed out, so if you could get your
> driver separated out, it might help you achieve partial success here.
Originally I did not submit the driver.
But Greg K-H rejected the pread support unless there was an actual user 
in the kernel.
Hence the need to submit this all in the patch series.

