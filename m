Return-Path: <SRS0=Abxs=2G=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5466CC43603
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Dec 2019 09:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EC020665
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Dec 2019 09:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCHwmvfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfLPJpA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:45:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24584 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726960AbfLPJpA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 16 Dec 2019 04:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576489500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cnDdBf82KhVXnWr+anktiJJjISUtDVrUWwe+tyMdfr0=;
        b=hCHwmvfT2Uu+WFST6guPMTWtPL2GIm0GO5eVWqws/+/lk1wcDOtThMi3lcFHSPQcA8f+aq
        /OasrTy3BJTDO4uYPnv0rw4sDGIA/azOvllVmv3UW0NQmI5SRBkkoFb1piT4CRX+hmH8ro
        YCx63sWgNb7QE6OneSzM8IaqqzrPQpo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-0tz5k8UVOIi8LsZIbUAGpg-1; Mon, 16 Dec 2019 04:44:59 -0500
Received: by mail-wr1-f70.google.com with SMTP id t3so3436151wrm.23
        for <linux-security-module@vger.kernel.org>; Mon, 16 Dec 2019 01:44:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cnDdBf82KhVXnWr+anktiJJjISUtDVrUWwe+tyMdfr0=;
        b=J2+h9QKFseXNEWVFYU+OM+1DfBWgyC3B2c1cVwF/3tEKuhgrqppA1rzXeUXSowNtqH
         4BPn8oSc6nPiHtiGhhrBBcB724wi231fcSuRh/g4PsBMXLB4sHW0ril51XhVn677g9CA
         hUyaHZ0NdhBkfUFo84lz3UN3D2dUllnsvRHqq8EgsFIqMLOQtrxmeLiShQThzx+FhpOL
         RaDoapgzfyaZ1WHymo045iozHRyLLtJv7gaKqR6p8RG9a4sEzSYH863qSZ3xX5g5O6iD
         V+j/VscBaXVu26fTD/haK35UCGVdorKiT4Qfjw8u+vAD/1PTW0vz5SASLrFwrZvNNOuN
         rt8A==
X-Gm-Message-State: APjAAAXVuQ48/KhAj43jnyg7i3HGW5SdRL9UiX5ee3D47GtpK2METZ4i
        NXU53tQhShXU8/0tvHyAvLES8ErPkKmSEavdtdhM3AA9ZQ7WAyXaZvkvD8DDTe5PRt1f5unfbsF
        azOGxwWjO5Ko6VYZVCUU6I6urm6IY0rA3/7IV
X-Received: by 2002:adf:f411:: with SMTP id g17mr28460647wro.89.1576489497550;
        Mon, 16 Dec 2019 01:44:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqwEyH6eiYWhPGokZxLoLnl2FBBKcXENk0ZwrWubb27++SVbpEDDa7w6koqgCE+ASXk2WC7KVg==
X-Received: by 2002:adf:f411:: with SMTP id g17mr28460620wro.89.1576489497258;
        Mon, 16 Dec 2019 01:44:57 -0800 (PST)
Received: from [192.168.1.14] ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id b17sm20890045wrp.49.2019.12.16.01.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 01:44:56 -0800 (PST)
Subject: Re: [PATCH v2] efi: Only print errors about failing to get certs if
 EFI vars are found
To:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Peter Jones <pjones@redhat.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
References: <20191119115043.21585-1-javierm@redhat.com>
 <bb68bacf-4982-0d86-d2cb-7799e47200f5@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <4c90fae4-422e-c805-e2f3-d3b921cc614d@redhat.com>
Date:   Mon, 16 Dec 2019 10:44:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <bb68bacf-4982-0d86-d2cb-7799e47200f5@redhat.com>
Content-Language: en-US
X-MC-Unique: 0tz5k8UVOIi8LsZIbUAGpg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/19/19 4:40 PM, Hans de Goede wrote:
> Hi,
> 
> On 19-11-2019 12:50, Javier Martinez Canillas wrote:
>> If CONFIG_LOAD_UEFI_KEYS is enabled, the kernel attempts to load the certs
>> from the db, dbx and MokListRT EFI variables into the appropriate keyrings.
>>
>> But it just assumes that the variables will be present and prints an error
>> if the certs can't be loaded, even when is possible that the variables may
>> not exist. For example the MokListRT variable will only be present if shim
>> is used.
>>
>> So only print an error message about failing to get the certs list from an
>> EFI variable if this is found. Otherwise these printed errors just pollute
>> the kernel ring buffer with confusing messages like the following:
>>
>> [    5.427251] Couldn't get size: 0x800000000000000e
>> [    5.427261] MODSIGN: Couldn't get UEFI db list
>> [    5.428012] Couldn't get size: 0x800000000000000e
>> [    5.428023] Couldn't get UEFI MokListRT
>>
>> Reported-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>>
>> ---
>> Hans,
>>
>> I'll really appreciate if you can test this patch. I just built tested it
>> because I don't have access to a machine to reproduce the issue right now.
> 
> Ok, I've given this a test-run just now, works as advertised for me:
> 
> Tested-by: Hans de Goede <hdegoede@redhat.com>
>

Thanks a lot for testing Hans.

James and Mimi,

Anything else that's needed for this patch to be picked?
 
> Regards,
> 
> Hans
> 
Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat

