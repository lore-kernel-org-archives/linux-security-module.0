Return-Path: <SRS0=upjG=ZU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D54C432C0
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Nov 2019 00:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2D5206E0
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Nov 2019 00:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ya69kFmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfK1AOM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 27 Nov 2019 19:14:12 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51202 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726947AbfK1AOM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Nov 2019 19:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574900049;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bI3FgBWOF7wCQIIRv2T8Vht0Y2ID7iTwByZG4uRF2TY=;
        b=Ya69kFmGrcgaUrlNZqkkm6HrGJUj1mKdd2qIy51dzo3X8WF8GY9sgyIe8TrN+OPROUOwba
        AFRM0J0Af5d9eGg7PR70svVN20G9s430Aczuqhl5nfQ/o8q6ptEdE+YODrK+OTsLRMk3gY
        JsK/kD3I7BQJE+VQr4QFXAnjWExjV7Y=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-U8XZugm3OrqdA6bX3wtYQQ-1; Wed, 27 Nov 2019 19:14:08 -0500
Received: by mail-pg1-f200.google.com with SMTP id e6so13665304pgc.8
        for <linux-security-module@vger.kernel.org>; Wed, 27 Nov 2019 16:14:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=81TflNEkIggalSb9xJoZHH5dIwhWptMNuIwNrPhaU8E=;
        b=Vb9eND7bKMSCQqJ0q87ag+OCQAl6kXJVo7xawR3BTODlHc0KbBgEKS/udSds94cKHD
         kvN9qxdn6SM6S55tuoyzXCZNM2raqmLPR9C+20MaTb7KQjjn99QXax8kMWQMGRNj2Otu
         /c+yZIKkJcCJC05Zwbwj/Py+YS5cR6Hp9TRqAjhrCiSZO1UEbSoWOrBW20Z29WlBXQEY
         e3SnfiYwu+upCQ68ipqrGXEcI+a87W/NubHEQ6c7/Q9R/9JtmJC6voz0p/MFzYfIEhbX
         EieN4NY1epp9XfLbsWFX/GXog9wxXxm19gZLF2578mOv+6Sgho4k1wk7KdUxpIB5JLbJ
         xLKw==
X-Gm-Message-State: APjAAAXo0MD9NDEDHFPva6UWprsLpNqyC+7QMVf24zjQQXKksn2BIS6N
        CxmPj2WjtdbVb0VanVnke1kyw4jatbZIPHj1S7WFZtcceYZ0I8bfgwxUx0xTVx7xuGtztHkvYzV
        P3bkH8pGIrZ7X5Os46yb6eQ/tlv/ku6nl9V/4
X-Received: by 2002:a62:16d3:: with SMTP id 202mr6980033pfw.118.1574900047372;
        Wed, 27 Nov 2019 16:14:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqzJc+VcxwW5kWr8ouolCeyP8fu1uzQijQ/p273FgvMFRNGogDQLIK+RwXvnf+WFq5+P1kvN6w==
X-Received: by 2002:a62:16d3:: with SMTP id 202mr6980008pfw.118.1574900047098;
        Wed, 27 Nov 2019 16:14:07 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id b1sm7823320pfi.74.2019.11.27.16.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 16:14:06 -0800 (PST)
Date:   Wed, 27 Nov 2019 17:14:04 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: Move setting of TPM_CHIP_FLAG_IRQ into
 tpm_tis_probe_irq_single
Message-ID: <20191128001404.3y4wh4hbhqpzxmfx@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Dan Williams <dan.j.williams@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
References: <20191112202725.3009814-1-stefanb@linux.vnet.ibm.com>
 <20191114164151.GB9528@linux.intel.com>
 <20191114164426.GC9528@linux.intel.com>
 <185664a9-58f2-2a4b-4e6b-8d7750a35690@linux.ibm.com>
 <20191121184949.yvw2gwzlkhjzko64@cantor>
 <20191127211109.GF14290@linux.intel.com>
 <CAPcyv4gO2T4xcZjYSYJ8-0kDPRnVYWhX_df5E94Cjyksx6WFbg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gO2T4xcZjYSYJ8-0kDPRnVYWhX_df5E94Cjyksx6WFbg@mail.gmail.com>
X-MC-Unique: U8XZugm3OrqdA6bX3wtYQQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed Nov 27 19, Dan Williams wrote:
>[ add Jerry ]
>
>On Wed, Nov 27, 2019 at 1:11 PM Jarkko Sakkinen
><jarkko.sakkinen@linux.intel.com> wrote:
>>
>> On Thu, Nov 21, 2019 at 11:49:49AM -0700, Jerry Snitselaar wrote:
>> > On Sat Nov 16 19, Stefan Berger wrote:
>> > > On 11/14/19 11:44 AM, Jarkko Sakkinen wrote:
>> > > > On Thu, Nov 14, 2019 at 06:41:51PM +0200, Jarkko Sakkinen wrote:
>> > > > > On Tue, Nov 12, 2019 at 03:27:25PM -0500, Stefan Berger wrote:
>> > > > > > From: Stefan Berger <stefanb@linux.ibm.com>
>> > > > > >
>> > > > > > Move the setting of the TPM_CHIP_FLAG_IRQ for irq probing into
>> > > > > > tpm_tis_probe_irq_single before calling tpm_tis_gen_interrupt.
>> > > > > > This move handles error conditions better that may arise if an=
ything
>> > > > > > before fails in tpm_tis_probe_irq_single.
>> > > > > >
>> > > > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> > > > > > Suggested-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> > > > > What about just changing the condition?
>> > > > Also cannot take this since it is not a bug (no fixes tag).
>> > >
>> > > I'll repost but will wait until Jerry has tested it on that machine.
>> > >
>> > >    Stefan
>> > >
>> > >
>> > > >
>> > > > /Jarkko
>> > >
>> > >
>> >
>> > It appears they still have the problem. I'm still waiting on logistics
>> > to send me a system to debug.
>>
>> Which hardware is guaranteed to ignite this? I can try to get test hw
>> for this from somewhere. Kind of looking into this blinded ATM. Dan?
>
>Jerry had mentioned that this was also occurring on T490s. Otherwise
>I'll ping you offline about the system I saw this on internally.
>

I've been trying for about 3 weeks now to get one of the laptops from
logistics here, but unfortunately they have been silent. Pinged one
of their email addresses today to see if they could respond to the
ticket, so hopefully next week I will have something.

