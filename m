Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C60C433DB
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Feb 2021 15:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53E2764DE1
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Feb 2021 15:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhBAPfV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 1 Feb 2021 10:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhBAPfT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 1 Feb 2021 10:35:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F12C06174A
        for <linux-security-module@vger.kernel.org>; Mon,  1 Feb 2021 07:34:39 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1l6bAp-00061s-PF; Mon, 01 Feb 2021 16:31:31 +0100
Received: from localhost ([127.0.0.1])
        by ptx.hi.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1l6bAp-0006V4-2s; Mon, 01 Feb 2021 16:31:31 +0100
Message-ID: <64472434a367060ddce6e03425156b8312a5ad6c.camel@pengutronix.de>
Subject: Re: Migration to trusted keys: sealing user-provided key?
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel@pengutronix.de
Date:   Mon, 01 Feb 2021 16:31:30 +0100
In-Reply-To: <d4eeefa0c13395e91850630e22d0d9e3690f43ac.camel@linux.ibm.com>
References: <74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de>
         <6dc99fd9ffbc5f405c5f64d0802d1399fc6428e4.camel@kernel.org>
         <d1bed49f89495ceb529355cb41655a208fdb2197.camel@linux.ibm.com>
         <8b9477e150d7c939dc0def3ebb4443efcc83cd85.camel@pengutronix.de>
         <d4eeefa0c13395e91850630e22d0d9e3690f43ac.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, 2021-01-31 at 09:29 -0500, Mimi Zohar wrote:
> On Sun, 2021-01-31 at 15:14 +0100, Jan Lübbe wrote:
> > On Sun, 2021-01-31 at 07:09 -0500, Mimi Zohar wrote:
> 
> <snip>
> 
> > > 
> > > [1] The ima-evm-utils README contains EVM examples of "trusted" and
> > > "user" based "encrypted" keys.
> > 
> > I assume you refer to
> > https://sourceforge.net/p/linux-ima/ima-evm-utils/ci/master/tree/README#l143
> > "Generate EVM encrypted keys" and "Generate EVM trusted keys (TPM based)"?
> > 
> > In both cases, the key used by EVM is a *newly generated* random key. The only
> > difference is whether it's encrypted to a user key or a (random) trusted key.
> 
> The "encrypted" asymmetric key data doesn't change, "update" just
> changes the key under which it is encrypted/decrypted.
> 
> Usage::
> 
>     keyctl add encrypted name "new [format] key-type:master-key-name keylen"
>         ring
>     keyctl add encrypted name "load hex_blob" ring

'load' (as I understand the code) only accepts an encrypted blob.

So the only way I see to have an encrypted key with a non-random key data would
be:
- create a random temporary master key and load a copy as a user key
- encrypt the chosen key data with the temporary master key (using a new
userspace reimplementation of the kernel encrypted key blob format)
- use keyctl add encrypted dmcrypt "load <encrypted blob>" <keyring>
- create new trusted master key (OP-TEE or CAAM in our case) as 
- use keyctl update to switch to the new trusted master key
- use keyctl pipe on the trusted and encrypted keys and store both for loading
on later boots

If we'd support importing a pre-existing key into a trusted or encrypted key,
we'd do instead:
- use keyctl add trusted dmcrypt "import <unencrypted key data>"
- use keyctl pipe on the trusted key and store it for loading on later boots

This way, users wouldn't need to care which backend is used by trusted keys
(TPM/OP-TEE/CAAM/...). That would make use-cases where a random key is not
suitable as straight-forward as the those where a random key is OK.

Best regards
Jan

>     keyctl update keyid "update key-type:master-key-name"
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

