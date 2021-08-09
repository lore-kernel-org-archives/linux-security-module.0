Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE62C4320A
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Aug 2021 04:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E2861040
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Aug 2021 04:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhHIE2Q (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 9 Aug 2021 00:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhHIE2Q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 9 Aug 2021 00:28:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C13F861019;
        Mon,  9 Aug 2021 04:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628483276;
        bh=g7PphkAa3cD92atJZV/1mpJ0V0vTYF+zw05ecvPmRM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mq24T1NDmDxEicfUHFl9aisZ2oYPmgQ+AoPeZXlz2aqq7lsuXYPcP/9Rio6eLI683
         MbfYiVTQZAoFhJDi9toRhyuiTTCNaJWatjDqkgvWg3wzDhsxsIc9D3HbcWEsS6c+Ho
         VBHDFoctwN3YILvl4tkPXgsl5V8V3v0gqNC7OQz79JUUeSupnyTTtTD3+RCZMicMkk
         jhIVVaIvxs6nfIP0BXiWp8Hu+lQro/HS8Gxur1fEq+Npp0HJyWwjWu9ScjK9FMu3Nv
         lKXpaHS01/Ie/ivQ1ZuRfwccsnV8H/We13zPZgRjTMkxfVb1QxHZCT/+2WHvnYGeeE
         aGJgrhQx4EFlQ==
Date:   Mon, 9 Aug 2021 07:27:53 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] tpm: ibmvtpm: Rename tpm_process_cmd to
 tpm_status and define flag
Message-ID: <20210809042753.lmvqrvcbk6bu5bu6@kernel.org>
References: <20210805215256.1293987-1-stefanb@linux.vnet.ibm.com>
 <20210805215256.1293987-2-stefanb@linux.vnet.ibm.com>
 <20210806112557.y7q2av6pk7r4xorm@kernel.org>
 <cddf0b42-c69f-c110-9543-e16d30c9927a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cddf0b42-c69f-c110-9543-e16d30c9927a@linux.ibm.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Aug 06, 2021 at 08:08:27AM -0400, Stefan Berger wrote:
> 
> On 8/6/21 7:25 AM, Jarkko Sakkinen wrote:
> > On Thu, Aug 05, 2021 at 05:52:55PM -0400, Stefan Berger wrote:
> > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > 
> > > Rename the field tpm_processing_cmd to tpm_status in ibmvtpm_dev and set
> > > the TPM_STATUS_BUSY flag while the vTPM is busy processing a command.
> > > 
> > > Fixes: 6674ff145eef ("tpm_ibmvtpm: properly handle interrupted packet receptions")
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Cc: Nayna Jain <nayna@linux.ibm.com>
> > > Cc: George Wilson <gcwilson@linux.ibm.com>
> > Please put the bug fix first because otherwise it will be dependent of this
> > patch, which is bad thing when it comes to backporting.
> 
> Yes, and that's why I have this one here also with a Fix tag. I basically
> don't want to logically '&' with the 'true' flag but want this
> TPM_STATUS_BUSY flag first.
> 
>    Stefan

You can then just change the type to 'u8'.

/Jarkko
