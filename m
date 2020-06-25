Return-Path: <SRS0=LaDg=AG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F828C433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Jun 2020 21:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8188720791
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Jun 2020 21:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406342AbgFYVfb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:35:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:21158 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403961AbgFYVfb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Jun 2020 17:35:31 -0400
IronPort-SDR: HPmykI6YZnOGrn5sQuoN8thFKQlC5ZHjeg1eDUMSOqMyTFVGhYLSMoPewIAHULdcMpZZwLVIra
 SFL5WZdF+OKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="163166331"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="163166331"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 14:35:30 -0700
IronPort-SDR: /ij78mFzAEC0wmcngtt+3FRA8yBO6Wxbgay6Vc6+cMMPiGG8kPTfrKU4u8HadKoS2v5AVX81Ml
 66tH8QOwIjMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="479786598"
Received: from jproldan-mobl.ger.corp.intel.com (HELO localhost) ([10.252.49.123])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jun 2020 14:35:27 -0700
Date:   Fri, 26 Jun 2020 00:35:26 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v6 2/2] tpm: Add support for event log pointer found in
 TPM2 ACPI table
Message-ID: <20200625213526.GE20341@linux.intel.com>
References: <20200625124222.1954580-1-stefanb@linux.vnet.ibm.com>
 <20200625124222.1954580-3-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625124222.1954580-3-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 25, 2020 at 08:42:22AM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> In case a TPM2 is attached, search for a TPM2 ACPI table when trying
> to get the event log from ACPI. If one is found, use it to get the
> start and length of the log area. This allows non-UEFI systems, such
> as SeaBIOS, to pass an event log when using a TPM2.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  drivers/char/tpm/eventlog/acpi.c | 59 ++++++++++++++++++++------------
>  1 file changed, 38 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
> index 63ada5e53f13..8b9e33d57f70 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -49,9 +49,9 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	void __iomem *virt;
>  	u64 len, start;
>  	struct tpm_bios_log *log;
> -
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> -		return -ENODEV;
> +	struct acpi_table_tpm2 *tbl;
> +	struct acpi_tpm2_phy *t2phy;
> +	int format;
>  
>  	log = &chip->log;
>  
> @@ -61,23 +61,40 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	if (!chip->acpi_dev_handle)
>  		return -ENODEV;
>  
> -	/* Find TCPA entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
> -	status = acpi_get_table(ACPI_SIG_TCPA, 1,
> -				(struct acpi_table_header **)&buff);
> -
> -	if (ACPI_FAILURE(status))
> -		return -ENODEV;
> -
> -	switch(buff->platform_class) {
> -	case BIOS_SERVER:
> -		len = buff->server.log_max_len;
> -		start = buff->server.log_start_addr;
> -		break;
> -	case BIOS_CLIENT:
> -	default:
> -		len = buff->client.log_max_len;
> -		start = buff->client.log_start_addr;
> -		break;
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +		status = acpi_get_table("TPM2", 1,
> +					(struct acpi_table_header **)&tbl);
> +		if (ACPI_FAILURE(status))
> +			return -ENODEV;

Add empty line.

> +		if (tbl->header.length <
> +				sizeof(*tbl) + sizeof(struct acpi_tpm2_phy))
> +			return -ENODEV;

Ditto.

> +		t2phy = (void *)tbl + sizeof(*tbl);
> +		len = t2phy->log_area_minimum_length;

Ditto.

> +		start = t2phy->log_area_start_address;
> +		if (!start || !len)
> +			return -ENODEV;

Ditto.

> +		format = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
> +	} else {
> +		/* Find TCPA entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
> +		status = acpi_get_table(ACPI_SIG_TCPA, 1,
> +					(struct acpi_table_header **)&buff);
> +

Remove this empty line.

> +		if (ACPI_FAILURE(status))
> +			return -ENODEV;
> +
> +		switch (buff->platform_class) {
> +		case BIOS_SERVER:
> +			len = buff->server.log_max_len;
> +			start = buff->server.log_start_addr;
> +			break;
> +		case BIOS_CLIENT:
> +		default:
> +			len = buff->client.log_max_len;
> +			start = buff->client.log_start_addr;
> +			break;
> +		}
> +		format = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
>  	}
>  	if (!len) {
>  		dev_warn(&chip->dev, "%s: TCPA log area empty\n", __func__);
> @@ -98,7 +115,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	memcpy_fromio(log->bios_event_log, virt, len);
>  
>  	acpi_os_unmap_iomem(virt, len);
> -	return EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
> +	return format;
>  
>  err:
>  	kfree(log->bios_event_log);
> -- 
> 2.26.2

/Jarkko
