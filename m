Return-Path: <SRS0=KC/c=AR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2CAC433E0
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Jul 2020 23:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA1942082F
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Jul 2020 23:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvDFxApz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgGFX5f (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Jul 2020 19:57:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48775 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726729AbgGFX5e (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Jul 2020 19:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594079853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5h/pRXHkSxEq61rxonlUns+UKJmDH2+YzkyLNI3P18c=;
        b=LvDFxApzmWvOyKgwYQIy2znvnixcw2o1OiwUDvNdElewoPbTSHwygw+VBJoIMnZ/sFFwjY
        sFnGa7uITwFjgNUCS29ENT7GCxAOGymGpX3fFBEnr5zRlq3RN+rxwMgdhMGlZXL8l2+2xF
        6ZqRg6/2xK+0g+NpJ3u3bgYBWtxodK4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-oAjQniXvPqW_AmehCJqEdA-1; Mon, 06 Jul 2020 19:57:31 -0400
X-MC-Unique: oAjQniXvPqW_AmehCJqEdA-1
Received: by mail-qv1-f70.google.com with SMTP id ee9so23505497qvb.6
        for <linux-security-module@vger.kernel.org>; Mon, 06 Jul 2020 16:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=5h/pRXHkSxEq61rxonlUns+UKJmDH2+YzkyLNI3P18c=;
        b=Bl/Qj+/nCq4N1C5kxoOS8WAe6WAo0Z+F5iV8gwQtHytlPiC1j0D0gScBMxo7CzfpFL
         5uZyHpioMOg/9tdAW5Hso2gD4K7Tsb2wpbBvcohHfGf9izxVH6rlftWOZ2FiE9R2UswH
         b9Vo9k4gh86IfBMm2J6beiyz48iSfMP1Sr9ZmgShIIFz3fzYn2hrGudvjivRF4jvnkPl
         5XDQt0DpmpnCMGj/j2pUMImLEOEIOhBc9kgC2KE4Yj2xSHDbhIZXzGUqLuqGjdKIbzCw
         BC/M3qNtyFt5fekE1lf/l58E34bc+XcVde7DAlDOLzdESYVbnkA4o2HP8oj9cNqkLs5I
         9zyw==
X-Gm-Message-State: AOAM530PCXoL7n9bOOvtczm2AO9y7epFCDuzDZt5EcapMnvRhg9Naki1
        +bPEI10OFta2PidK6Lllsbyg5CuUiMn/kD0zQmU0RqLEBzn5bDEJZKVi7q0zgU4DAbrjRbbGTd+
        2zy2LEbJa9Xqnx/FSJ6mLCB1p37WCCcrZFM+o
X-Received: by 2002:a37:a253:: with SMTP id l80mr49623331qke.197.1594079851023;
        Mon, 06 Jul 2020 16:57:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxr5SZNidI4OJoMWzUXi9Xjl/T41/3YcOx+9xtlh2k1eoNc3KkVBOU6fOs9TEw6tHZ9F9ixxA==
X-Received: by 2002:a37:a253:: with SMTP id l80mr49623312qke.197.1594079850724;
        Mon, 06 Jul 2020 16:57:30 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id g41sm25799385qtb.37.2020.07.06.16.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 16:57:30 -0700 (PDT)
References: <20200706181953.3592084-1-stefanb@linux.vnet.ibm.com> <20200706181953.3592084-3-stefanb@linux.vnet.ibm.com> <20200706230914.GC20770@linux.intel.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 2/2] tpm: Add support for event log pointer found in TPM2 ACPI table
In-reply-to: <20200706230914.GC20770@linux.intel.com>
Date:   Mon, 06 Jul 2020 16:57:28 -0700
Message-ID: <87mu4cjixj.fsf@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


Jarkko Sakkinen @ 2020-07-06 16:09 MST:

> On Mon, Jul 06, 2020 at 02:19:53PM -0400, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>> 
>> In case a TPM2 is attached, search for a TPM2 ACPI table when trying
>> to get the event log from ACPI. If one is found, use it to get the
>> start and length of the log area. This allows non-UEFI systems, such
>> as SeaBIOS, to pass an event log when using a TPM2.
>> 
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>
> Do you think that QEMU with TPM 1.2 emulator turned on would be a viable
> way to test this?
>
> I'm anyway more worried about breaking existing TPM 1.2 functionality
> and that requires only QEMU without extras.
>
> /Jarkko

The 1.2 bits should be functionally the same as before, right?

