Return-Path: <SRS0=p5JF=63=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D83C433E0
	for <linux-security-module@archiver.kernel.org>; Wed, 13 May 2020 19:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9FEA2054F
	for <linux-security-module@archiver.kernel.org>; Wed, 13 May 2020 19:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PKR2BUB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389392AbgEMTSi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 May 2020 15:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390289AbgEMTSc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 May 2020 15:18:32 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA17DC05BD0A
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2020 12:18:32 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l73so1978487pjb.1
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2020 12:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=qcgpVTGY9wq1jzZvcaJkFQL+JrVfapS8nFhj9eA+ABc=;
        b=PKR2BUB+pog2PEu9p/br0Lry5EXdc2KN6bOwJFyF1W4C+jUuMVRpfoHaza2pnCSoJC
         C3/3pubb5sNA2c5ilG2xU+VRIP6IPZjNTi8SGl4twLBbc40AOYPQkQbFX4agaa6J5I2p
         kQkSAiHTagcd7+07Xjd3fGOAZRu3XLx6/Wy0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qcgpVTGY9wq1jzZvcaJkFQL+JrVfapS8nFhj9eA+ABc=;
        b=l69x/CqDxX+XB3UQrjIwv0BK/B7QFOiu8u2tl2QJSQ3eTCTqUxg1wvOvDjTFU4Wi51
         jNjs7FD7Q9Ac6Oa7UwwXm+wrt3TVCAh6/8sU0ol8quRg0uZZi8plnJOR8oouN2aPvSqm
         hCHkPqT9fVnD6iBUMjAEPrSDStmo2HWy28MqPAxoT1SAJ0KpSqCYYedabGzpMqDoPTh3
         Gyk2buNguo/wVNhOgbL4rM2AhbyZvdg5KCoEgqeVSH0jr/j0KV6jkIRflVtgvTXxFWHe
         ldS5KTuOvgmkmc4vr0yPgSM91Yg/MshIxZqmJi/PkGdtgFkZsIU6AyG2FE63FzakzBMU
         lieQ==
X-Gm-Message-State: AOAM532VmE55lZnjKJHvj4Mdcr7XA+LrMN2ckd6NjodGkiu2lGANcr2i
        NW0ILhCO2vQz1E7o3kIrwlFY+oP3zwpMUg==
X-Google-Smtp-Source: ABdhPJxJVr3lxhEfVIbkG1ij/W35rEZtckIrZ7uIVDMxUKUrxWF05zoes3fP2LI5LZG41vLjul9Jjg==
X-Received: by 2002:a17:902:ec04:: with SMTP id l4mr669377pld.6.1589397511978;
        Wed, 13 May 2020 12:18:31 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id y6sm15938924pjw.15.2020.05.13.12.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 12:18:31 -0700 (PDT)
Subject: Re: [PATCH v5 1/7] fs: introduce kernel_pread_file* support
To:     Mimi Zohar <zohar@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
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
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
 <20200508002739.19360-2-scott.branden@broadcom.com>
 <1589395153.5098.158.camel@kernel.org>
 <0e6b5f65-8c61-b02e-7d35-b4ae52aebcf3@broadcom.com>
 <1589396593.5098.166.camel@kernel.org>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <e1b92047-7003-0615-3d58-1388ec27c78a@broadcom.com>
Date:   Wed, 13 May 2020 12:18:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589396593.5098.166.camel@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 2020-05-13 12:03 p.m., Mimi Zohar wrote:
> On Wed, 2020-05-13 at 11:53 -0700, Scott Branden wrote:
>> Hi Mimi,
>>
>> On 2020-05-13 11:39 a.m., Mimi Zohar wrote:
>>> [Cc'ing linux-security-module, linux-integrity]
>>>
>>> On Thu, 2020-05-07 at 17:27 -0700, Scott Branden wrote:
>>>> Add kernel_pread_file* support to kernel to allow for partial read
>>>> of files with an offset into the file.  Existing kernel_read_file
>>>> functions call new kernel_pread_file functions with offset=0 and
>>>> flags=KERNEL_PREAD_FLAG_WHOLE.
>>>>
>>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>>> ---
>>> <snip>
>>>
>>>> @@ -941,14 +955,16 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>> The checkpatch shows this as kernel_read_file when it is actually the
>> new function kernel_pread_file.
>> Please see the call to kernel_pread_file from kernel_read_file in the
>> complete patch rather this snippet.
>>>>    
>>>>    		if (bytes == 0)
>>>>    			break;
>>>> +
>>>> +		buf_pos += bytes;
>>>>    	}
>>>>    
>>>> -	if (pos != i_size) {
>>>> +	if (pos != read_end) {
>>>>    		ret = -EIO;
>>>>    		goto out_free;
>>>>    	}
>>>>    
>>>> -	ret = security_kernel_post_read_file(file, *buf, i_size, id);
>>>> +	ret = security_kernel_post_read_file(file, *buf, alloc_size, id);
>>>>    	if (!ret)
>>>>    		*size = pos;
>>> Prior to the patch set that introduced this security hook, firmware
>>> would be read twice, once for measuring/appraising the firmware and
>>> again reading the file contents into memory.  Partial reads will break
>>> both IMA's measuring the file and appraising the file signatures.
>> The partial file read support is needed for request_firmware_into_buf
>> from drivers.  The EXPORT_SYMBOL_GPL is being removed so that
>> there can be no abuse of the partial file read support.  Such file
>> integrity checks are not needed for this use case.  The partial file
>> (firmware image) is actually downloaded in portions and verified on the
>> device it is loaded to.
> It's all fine that the device will verify the firmware, but shouldn't
> the kernel be able to also verify the firmware file signature it is
> providing to the device, before providing it?
Even if the kernel successfully verified the firmware file signature it
would just be wasting its time.  The kernel in these use cases is not always
trusted.  The device needs to authenticate the firmware image itself.
>
> The device firmware is being downloaded piecemeal from somewhere and
> won't be measured?
It doesn't need to be measured for current driver needs.
If someone has such need the infrastructure could be added to the kernel
at a later date.  Existing functionality is not broken in any way by 
this patch series.
>
> Mimi

