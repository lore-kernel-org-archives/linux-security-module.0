Return-Path: <SRS0=8CgQ=QF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782FFC282D0
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Jan 2019 12:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5180A2147A
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Jan 2019 12:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfA2Mde (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:33:34 -0500
Received: from mga02.intel.com ([134.134.136.20]:6551 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbfA2Mde (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 Jan 2019 07:33:34 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 04:33:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="111983217"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.127])
  by orsmga006.jf.intel.com with ESMTP; 29 Jan 2019 04:33:30 -0800
Date:   Tue, 29 Jan 2019 14:33:30 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v10 00/17] Remove nested TPM operations
Message-ID: <20190129123330.GC12883@linux.intel.com>
References: <20190116212342.24524-1-jarkko.sakkinen@linux.intel.com>
 <20190125010519.4tqcno4iaha4ww7r@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125010519.4tqcno4iaha4ww7r@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jan 24, 2019 at 06:05:19PM -0700, Jerry Snitselaar wrote:
> On Wed Jan 16 19, Jarkko Sakkinen wrote:
> > Make the changes necessary to detach TPM space code and TPM activation
> > code out of the tpm_transmit() flow because of both of these can cause
> > nested tpm_transmit() calls. The nesteds calls make the whole flow hard
> > to maintain, and thus, it is better to just fix things now before this
> > turns into a bigger mess.
> > 
> > v10:
> > * Use void pointers to avoid unnecessary casts in functions paramaters
> >  where it makes sense.
> > 
> > v9:
> > * Fixed again tpm_try_get_ops().
> > * Added missing reviewed-by's.
> > 
> > v8:
> > * Re-add the check for ret < 0 after calling tpm_try_transmit() that
> >  was dropped by mistake while moving code.
> > * Fix error fallback for tpm_try_get_ops() when tpm_chip_start()
> >  fails.
> > 
> > v7:
> > *  Reorganize series so that more trivial and self-contained changes are
> >   in the head.
> > 
> > v6:
> > * When tpm_validate_commmand() was moved to tpm2-space.c, the struct for
> >  the TPM header was incorrectly declared as struct tpm_input_header.
> > * Fix return value in tpm_validate_command().
> > 
> > v5:
> > * Add the missing rev's from Stefan Berger.
> > 
> > v4:
> > * Return 0 from pcrs_show() when tpm1_pcr_read() fails.
> > * Fix error handling flow in tpm_try_transmit().
> > * Replace struct tpm_input_header and struct tpm_output_header with
> >  struct tpm_header.
> > 
> > v3:
> > * Encapsulate power gating code to tpm_chip_start() and tpm_chip_stop().
> > * Move TPM power gating code and locking to tpm_try_get_ops() and
> >  tpm_put_ops().
> > * Call power gating code directly in tpm_chip_register() and
> >  tpm2_del_space().
> > 
> > v2:
> > * Print tpm2_commit_space() error inside tpm2_commit_space()
> > * Error code was not printed when recv() callback failed. It is
> >  fixed in this version.
> > * Added a patch that removes @space from tpm_transmit().
> > * Fixed a regression in earlier series. Forgot to amend the change
> >  from the staging area that renames NESTED to UNLOCKED in tpm2-space.c.
> > Jarkko Sakkinen (17):
> >  tpm: use tpm_buf in tpm_transmit_cmd() as the IO parameter
> >  tpm: fix invalid return value in pubek_show()
> >  tpm: return 0 from pcrs_show() when tpm1_pcr_read() fails
> >  tpm: print tpm2_commit_space() error inside tpm2_commit_space()
> >  tpm: declare struct tpm_header
> >  tpm: access command header through struct in tpm_try_transmit()
> >  tpm: encapsulate tpm_dev_transmit()
> >  tpm: call tpm2_flush_space() on error in tpm_try_transmit()
> >  tpm: clean up tpm_try_transmit() error handling flow
> >  tpm: move tpm_validate_commmand() to tpm2-space.c
> >  tpm: move TPM space code out of tpm_transmit()
> >  tpm: remove @space from tpm_transmit()
> >  tpm: use tpm_try_get_ops() in tpm-sysfs.c.
> >  tpm: remove TPM_TRANSMIT_UNLOCKED flag
> >  tpm: introduce tpm_chip_start() and tpm_chip_stop()
> >  tpm: take TPM chip power gating out of tpm_transmit()
> >  tpm: remove @flags from tpm_transmit()
> > 
> > drivers/char/tpm/tpm-chip.c       | 109 ++++++++++++
> > drivers/char/tpm/tpm-dev-common.c |  45 ++++-
> > drivers/char/tpm/tpm-interface.c  | 264 ++++++------------------------
> > drivers/char/tpm/tpm-sysfs.c      | 138 ++++++++++------
> > drivers/char/tpm/tpm.h            |  64 +++-----
> > drivers/char/tpm/tpm1-cmd.c       |  28 +---
> > drivers/char/tpm/tpm2-cmd.c       |  72 +++-----
> > drivers/char/tpm/tpm2-space.c     |  91 +++++++---
> > drivers/char/tpm/tpm_i2c_atmel.c  |   5 +-
> > drivers/char/tpm/tpm_vtpm_proxy.c |  12 +-
> > drivers/char/tpm/xen-tpmfront.c   |   2 +-
> > 11 files changed, 409 insertions(+), 421 deletions(-)
> > 
> > -- 
> > 2.19.1
> > 
> 
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

Thanks!

/Jarkko
