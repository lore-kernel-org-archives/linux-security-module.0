Return-Path: <SRS0=n7+0=3X=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E28C35247
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Feb 2020 19:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30842082E
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Feb 2020 19:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgBCTTe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 3 Feb 2020 14:19:34 -0500
Received: from smtprelay0097.hostedemail.com ([216.40.44.97]:60096 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725372AbgBCTTe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Feb 2020 14:19:34 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 973941802912B;
        Mon,  3 Feb 2020 19:19:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pail81_530c6f1bc942a
X-Filterd-Recvd-Size: 12068
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon,  3 Feb 2020 19:19:30 +0000 (UTC)
Message-ID: <4b4ee302f2f97e3907ab03e55a92ccd46b6cf171.camel@perches.com>
Subject: Re: [PATCH] security/integrity: Include __func__ in messages for
 easier debug
From:   Joe Perches <joe@perches.com>
To:     Nayna <nayna@linux.vnet.ibm.com>,
        Shuah Khan <skhan@linuxfoundation.org>, jmorris@namei.org,
        serge@hallyn.com, mpe@ellerman.id.au, zohar@linux.ibm.com,
        erichte@linux.ibm.com, nayna@linux.ibm.com, yuehaibing@huawei.com
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Feb 2020 11:18:20 -0800
In-Reply-To: <79d7b969-9b7d-7853-356b-876e444d3390@linux.vnet.ibm.com>
References: <20200130020129.15328-1-skhan@linuxfoundation.org>
         <ab2e19123cc15e3f8039b0d36e6ebae385db700e.camel@perches.com>
         <79d7b969-9b7d-7853-356b-876e444d3390@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 2020-02-03 at 10:15 -0500, Nayna wrote:
> On 1/29/20 10:08 PM, Joe Perches wrote:
> > On Wed, 2020-01-29 at 19:01 -0700, Shuah Khan wrote:
> > > Change messages to messages to make it easier to debug. The following
> > > error message isn't informative enough to figure out what failed.
> > > Change messages to include function information.
> > > 
> > > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> > > ---
> > >   .../integrity/platform_certs/load_powerpc.c     | 14 ++++++++------
> > >   security/integrity/platform_certs/load_uefi.c   | 17 ++++++++++-------
> > >   2 files changed, 18 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
> > perhaps instead add #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > so all the pr_<level> logging is more specific.
> > 
> > This would prefix all pr_<level> output with "integrity: "
> > 
> > 3integrity: Couldn't get size: 0x%lx
> > 3integrity: Error reading db var: 0x%lx
> > 3integrity: MODSIGN: Couldn't get UEFI db list
> > 3integrity: Couldn't parse db signatures: %d
> > 6integrity: Couldn't get UEFI MokListRT
> > 3integrity: Couldn't parse MokListRT signatures: %d
> > 6integrity: Couldn't get UEFI dbx list
> > 3integrity: Couldn't parse dbx signatures: %d
> > 
> > 5integrity: Platform Keyring initialized
> > 6integrity: Error adding keys to platform keyring %s
> > 
> > ---
> >   security/integrity/platform_certs/load_powerpc.c     | 3 +++
> >   security/integrity/platform_certs/load_uefi.c        | 2 ++
> >   security/integrity/platform_certs/platform_keyring.c | 2 ++
> >   3 files changed, 7 insertions(+)
> > 
> > diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
> > index a2900c..5cfbd0 100644
> > --- a/security/integrity/platform_certs/load_powerpc.c
> > +++ b/security/integrity/platform_certs/load_powerpc.c
> > @@ -5,6 +5,9 @@
> >    *
> >    *      - loads keys and hashes stored and controlled by the firmware.
> >    */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> 
> Looks good. How about slight addition in it as below:
> 
> #define pr_fmt(fmt) KBUILD_MODNAME ": load_powerpc: " fmt

Perhaps another way to do that is to use:
---
 security/integrity/integrity.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/security/integrity/integrity.h
b/security/integrity/integrity.h
index 543d277..b78469 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -6,6 +6,12 @@
  * Mimi Zohar <zohar@us.ibm.com>
  */
 
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " KBUILD_BASENAME ": " fmt
+
 #include <linux/types.h>
 #include <linux/integrity.h>
 #include <crypto/sha.h>

That would create these string differences in security:

$ diff -urN old new
--- old	2020-02-03 11:11:46.403134346 -0800
+++ new	2020-02-03 11:12:15.407135326 -0800
@@ -43,76 +43,81 @@
 2 48 8 14 xattr_data:271 80 68 8 data:306
 2 48 8 9 entry:136 80 72 14 event_data:138
 2 48 8 9 entry:305 80 72 14 event_data:306
-2ima: ahash calculation failed: err: %d
+2ima: ima_crypto: ahash calculation failed: err: %d
 3 32 4 13 hash_algo:318 48 4 14 digestsize:320 64 8 10 digest:319
 3 32 4 13 hash_algo:339 48 4 18 cur_digestsize:341 64 8 14 cur_digest:340
 3 32 4 7 pcr:134 48 4 11 namelen:134 64 4 21 template_data_len:134
 3 32 8 8 data:277 64 8 9 datap:278 96 8 8 size:279
 3 48 4 19 datalen_to_hash:489 64 256 10 buffer:486 384 376 16 __shash_desc:474
 3 48 8 8 lnum:973 80 8 8 rule:952 112 48 8 args:971
-3Couldn't get size: 0x%lx
-3Couldn't parse db signatures: %d
-3Couldn't parse dbx signatures: %d
-3Couldn't parse MokListRT signatures: %d
-3Error reading db var: 0x%lx
-3evm: Can not allocate %s (reason: %ld)
-3evm: HMAC key is not set
-3evm: key initialization failed
-3ima: attempting to initialize the template "%s" failed
-3ima: attempting to restore a incompatible measurement list
-3ima: attempting to restore an unsupported template "%s" failed
-3ima: attempting to restore a template name that is too long
-3ima: attempting to restore the template fmt "%s" failed
-3ima: attempting to restore too many measurements
-3ima: Can not allocate %s (reason: %d)
-3ima: Can not allocate %s (reason: %ld)
-3ima: Error Communicating to TPM chip
-3ima: Error Communicating to TPM chip, result: %d
-3ima: field '%s' not found
-3ima: format string '%s' contains too many fields
-3ima: format string '%s' not valid, using template %s
-3ima: impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.
-3ima: impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help
-3ima: Invalid field with length %d
-3ima: lsm rule update error %d
-3ima: OUT OF MEMORY ERROR creating queue entry
-3ima: Prevent firmware loading_store.
-3ima: Prevent firmware sysfs fallback loading.
-3ima: %s: buf end mismatch: expected: %p, current: %p
-3ima: signed policy file (specified as an absolute pathname) required
-3ima: %s: nr of fields mismatch: expected: %d, current: %d
-3ima: template does not support hash alg
-3ima: template %s init failed, result: %d
-3ima: template %s not found, using %s
-3ima: Unable to open file: %s (%d)
-3integrity: Key '%s' is in ima_blacklist_keyring
-3integrity: no %s keyring: %d
-3integrity: Problem loading X.509 certificate %d
-3integrity: Request for unknown key '%s' err %ld
-3integrity: Unable to open file: %s (%d)
-3MODSIGN: Couldn't get UEFI db list
-3Unable to create integrity sysfs dir: %d
+3evm: evm_crypto: Can not allocate %s (reason: %ld)
+3evm: evm_crypto: HMAC key is not set
+3evm: evm_crypto: key initialization failed
+3ima: ima_crypto: Can not allocate %s (reason: %d)
+3ima: ima_crypto: Can not allocate %s (reason: %ld)
+3ima: ima_crypto: Error Communicating to TPM chip
+3ima: ima_fs: signed policy file (specified as an absolute pathname) required
+3ima: ima_fs: Unable to open file: %s (%d)
+3ima: ima_main: impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.
+3ima: ima_main: impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help
+3ima: ima_main: Prevent firmware loading_store.
+3ima: ima_main: Prevent firmware sysfs fallback loading.
+3ima: ima_main: template %s init failed, result: %d
+3ima: ima_policy: lsm rule update error %d
+3ima: ima_queue: Error Communicating to TPM chip, result: %d
+3ima: ima_queue: OUT OF MEMORY ERROR creating queue entry
+3ima: ima_template: attempting to initialize the template "%s" failed
+3ima: ima_template: attempting to restore a incompatible measurement list
+3ima: ima_template: attempting to restore an unsupported template "%s" failed
+3ima: ima_template: attempting to restore a template name that is too long
+3ima: ima_template: attempting to restore the template fmt "%s" failed
+3ima: ima_template: attempting to restore too many measurements
+3ima: ima_template: field '%s' not found
+3ima: ima_template: format string '%s' contains too many fields
+3ima: ima_template: format string '%s' not valid, using template %s
+3ima: ima_template: Invalid field with length %d
+3ima: ima_template_lib: %s: buf end mismatch: expected: %p, current: %p
+3ima: ima_template_lib: %s: nr of fields mismatch: expected: %d, current: %d
+3ima: ima_template: template does not support hash alg
+3ima: ima_template: template %s init failed, result: %d
+3ima: ima_template: template %s not found, using %s
+3integrity: digsig_asymmetric: Key '%s' is in ima_blacklist_keyring
+3integrity: digsig_asymmetric: Request for unknown key '%s' err %ld
+3integrity: digsig: no %s keyring: %d
+3integrity: digsig: Problem loading X.509 certificate %d
+3integrity: digsig: Unable to open file: %s (%d)
+3integrity: iint: Unable to create integrity sysfs dir: %d
+3integrity: load_uefi: Couldn't get size: 0x%lx
+3integrity: load_uefi: Couldn't parse db signatures: %d
+3integrity: load_uefi: Couldn't parse dbx signatures: %d
+3integrity: load_uefi: Couldn't parse MokListRT signatures: %d
+3integrity: load_uefi: Error reading db var: 0x%lx
+3integrity: load_uefi: MODSIGN: Couldn't get UEFI db list
 4 32 8 8 entry:46 64 72 13 event_data:48 176 24 7 hash:55 240 240 11 tmp_iint:47
 4 48 16 8 rbuf:209 80 16 13 rbuf_size:214 112 32 6 sg:212 176 104 8 wait:213
 4 48 8 8 bufp:358 80 8 12 hdr_mask:362 112 64 7 hdr:353 208 34 17 template_name:350
-4ima: Couldn't register LSM notifier, error %d
-4ima: rule for LSM '%s' is undefined
-4ima: Skipping unknown architecture policy rule: %s
-5ima: template with 'modsig' field also needs 'd-modsig' field
-5integrity: Loaded X.509 cert '%s'
-6evm: Error registering secfs
-6evm: HMAC attrs: 0x%x
-6evm: init_desc failed
-6evm: Initialising EVM extended attributes:
-6evm: key initialized
-6evm: %s
-6ima: Allocated hash algorithm: %s
-6ima: Allocating %s failed, going to use default hash algorithm %s
-6ima: No architecture policies found
-6ima: No TPM chip found, activating TPM-bypass!
-6ima: policy update %s
-6ima: Unable to reopen file for reading.
-6integrity: Can't allocate %s keyring (%d)
-6integrity: Loading X.509 certificate: %s
+4ima: ima_main: Couldn't register LSM notifier, error %d
+4ima: ima_policy: rule for LSM '%s' is undefined
+4ima: ima_policy: Skipping unknown architecture policy rule: %s
+5ima: ima_policy: template with 'modsig' field also needs 'd-modsig' field
+5integrity: digsig: Loaded X.509 cert '%s'
+5integrity: platform_keyring: Platform Keyring initialized
+6evm: evm_crypto: init_desc failed
+6evm: evm_crypto: key initialized
+6evm: evm_main: Error registering secfs
+6evm: evm_main: HMAC attrs: 0x%x
+6evm: evm_main: Initialising EVM extended attributes:
+6evm: evm_main: %s
+6ima: ima_crypto: Allocated hash algorithm: %s
+6ima: ima_crypto: Unable to reopen file for reading.
+6ima: ima_fs: policy update %s
+6ima: ima_init: No TPM chip found, activating TPM-bypass!
+6ima: ima_main: Allocating %s failed, going to use default hash algorithm %s
+6ima: ima_policy: No architecture policies found
+6integrity: digsig: Can't allocate %s keyring (%d)
+6integrity: digsig: Loading X.509 certificate: %s
+6integrity: load_uefi: Couldn't get UEFI dbx list
+6integrity: load_uefi: Couldn't get UEFI MokListRT
+6integrity: platform_keyring: Error adding keys to platform keyring %s
 7 48 4 7 pcr:203 64 8 17 template_desc:198 96 8 11 pathbuf:199 128 8 12 pathname:201 160 8 15 xattr_value:204 192 8 10 modsig:205 224 255 12 filename:200
 7 48 4 9 secid:706 64 4 7 pcr:690 80 8 9 entry:693 112 8 12 template:699 144 72 14 event_data:695 256 68 8 hash:703 368 240 8 iint:694



