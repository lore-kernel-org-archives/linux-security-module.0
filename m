Return-Path: <SRS0=K480=5P=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A7AC2D0ED
	for <linux-security-module@archiver.kernel.org>; Mon, 30 Mar 2020 19:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894BA20714
	for <linux-security-module@archiver.kernel.org>; Mon, 30 Mar 2020 19:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgC3TcK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 30 Mar 2020 15:32:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:26385 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbgC3TcK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 30 Mar 2020 15:32:10 -0400
IronPort-SDR: 9nQNIce38zDX+EOlAHrdsvNku3zHucufngpairgM63JJgimoOFzsue7IdKbAB3vMZX0cmwvyqy
 GOj5Kg5Md1bg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 12:32:09 -0700
IronPort-SDR: oGtmBpHAXQquKOfCIar5HWX9TCbmIuZ34VV17MuXWY3J6LAePl1ZKZG6JChmFP8ua1TnAdmoCQ
 LtQE1jhD+LJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; 
   d="scan'208";a="239899016"
Received: from plachner-mobl.ger.corp.intel.com (HELO localhost) ([10.252.35.129])
  by fmsmga007.fm.intel.com with ESMTP; 30 Mar 2020 12:32:04 -0700
Date:   Mon, 30 Mar 2020 22:32:02 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] tpm: Rearrange ACPI log code to easier extend for
 TPM2 case
Message-ID: <20200330193144.GD1384380@linux.intel.com>
References: <20200330151536.871700-1-stefanb@linux.vnet.ibm.com>
 <20200330151536.871700-3-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330151536.871700-3-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Mar 30, 2020 at 11:15:35AM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Rearrange the ACPI table based log code to allow for easier extension
> for the TPM2 case.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

I think this change does not do anything useful.

/Jarkko
