Return-Path: <SRS0=KC/c=AR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A811C433DF
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Jul 2020 22:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F0B420674
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Jul 2020 22:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PcBc8MJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgGFWC3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Jul 2020 18:02:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39425 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725895AbgGFWC2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Jul 2020 18:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594072947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TkXhzKLqTF0E87EA7fDsRKyQKfMvqiBc3obNNpfDHJg=;
        b=PcBc8MJMZcI2dpdUwdkWA19R12bL+zz0oGc3GVgyMKbdAGLpaBFpyalBjZ/5VvJO56MhW9
        eAzhlqDZzF9oA6r8FjkZFpIhfNyYUpl/O7we0FV8NrVAFOLBrnLxplNrwUOAgH/aLfST5E
        nlOqyjIKAGXg04dHHGS5Pv54FB1mlto=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-nn_d0tn7P9WOsxSrOO8zBg-1; Mon, 06 Jul 2020 18:02:17 -0400
X-MC-Unique: nn_d0tn7P9WOsxSrOO8zBg-1
Received: by mail-qt1-f198.google.com with SMTP id m25so24745318qtk.1
        for <linux-security-module@vger.kernel.org>; Mon, 06 Jul 2020 15:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=TkXhzKLqTF0E87EA7fDsRKyQKfMvqiBc3obNNpfDHJg=;
        b=V+ak5tK424AQZTyCw5pMW6ZT9lV7HkRHwoYtyKCm8tzwx0IC1fI9oXiy3ewjmBiT5B
         kV8Th9foBzxgOWSziqhyhGSwqQ5iSct0bhs6SKBsq1NoevqrFJFJJlRQXhbNmcf28JAE
         emC4+RtEGy92xXSuNFIktsqnfVErP6KkZQ6h97Xu1dKXflHA+nVCxAyth5M9FTlv8ibX
         o15qP19pqA3lDBlpV+YJmPr7QaPx1dfxJV0tXi4WF+aj7b79edfhHm98tQL2SE+3AFtc
         8+QUQ69OJgUAhbJfyTYcEJBOCtf5aKcUUjxppOQdRXEeH0DCRKs4BImHD9+Al3I8bo4Q
         YYmA==
X-Gm-Message-State: AOAM533sBoag2bqxl6drUjSivCpN6cSu0hUZ8/Gjjto7w/gAQTAlyEmN
        w4jfmGuIFcoL+7Q5De+ejeRIe0RHYTjOViXZjXosxQJnUw/9Iac2mrsPLL7jwdUnIwTY5faax4/
        532pzD132CQS5Bs4WZcoDeCYgEBqoCd4b0G+v
X-Received: by 2002:ae9:f002:: with SMTP id l2mr39136108qkg.437.1594072936806;
        Mon, 06 Jul 2020 15:02:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRP3z9E0tdvX8t39vt7/9u4f1ETvgBsRpRz2CaH0flMAo/xsbjQX5JZ47vfESsqw8doha+rA==
X-Received: by 2002:ae9:f002:: with SMTP id l2mr39136066qkg.437.1594072936430;
        Mon, 06 Jul 2020 15:02:16 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id a3sm20911329qkf.131.2020.07.06.15.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 15:02:15 -0700 (PDT)
References: <20200706181953.3592084-1-stefanb@linux.vnet.ibm.com> <20200706181953.3592084-2-stefanb@linux.vnet.ibm.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jarkko.sakkinen@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v9 1/2] acpi: Extend TPM2 ACPI table with missing log fields
In-reply-to: <20200706181953.3592084-2-stefanb@linux.vnet.ibm.com>
Date:   Mon, 06 Jul 2020 15:02:14 -0700
Message-ID: <87h7ukwbdl.fsf@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


Stefan Berger @ 2020-07-06 11:19 MST:

> From: Stefan Berger <stefanb@linux.ibm.com>
>
> Recent extensions of the TPM2 ACPI table added 3 more fields
> including 12 bytes of start method specific parameters and Log Area
> Minimum Length (u32) and Log Area Start Address (u64). So, we define
> a new structure acpi_tpm2_phy that holds these optional new fields.
> The new fields allow non-UEFI systems to access the TPM2's log.
>
> The specification that has the new fields is the following:
>   TCG ACPI Specification
>   Family "1.2" and "2.0"
>   Version 1.2, Revision 8
>
> https://trustedcomputinggroup.org/wp-content/uploads/TCG_ACPIGeneralSpecification_v1.20_r8.pdf
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: linux-acpi@vger.kernel.org
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  include/acpi/actbl3.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
> index b0b163b9efc6..bdcac69fa6bd 100644
> --- a/include/acpi/actbl3.h
> +++ b/include/acpi/actbl3.h
> @@ -415,6 +415,13 @@ struct acpi_table_tpm2 {
>  	/* Platform-specific data follows */
>  };
>  
> +/* Optional trailer for revision 4 holding platform-specific data */
> +struct acpi_tpm2_phy {
> +	u8  start_method_specific[12];
> +	u32 log_area_minimum_length;
> +	u64 log_area_start_address;
> +};
> +
>  /* Values for start_method above */
>  
>  #define ACPI_TPM2_NOT_ALLOWED                       0

