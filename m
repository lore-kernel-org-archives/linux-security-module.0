Return-Path: <SRS0=LaDg=AG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8BDC433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Jun 2020 23:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F5DB20707
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Jun 2020 23:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="W/x9KWlZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405577AbgFYXAB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:00:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36440 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405113AbgFYXAA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Jun 2020 19:00:00 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4C7A620B7186;
        Thu, 25 Jun 2020 15:59:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4C7A620B7186
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593126000;
        bh=u9Eo30gB1UDanI1UscOvm3lWCDfLJWXFx0NmDlChXv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W/x9KWlZNjDJUZORUyRweT9BcdXHF2T2UNJ0ImVlp6qJc9k79gwbHd+Xhy4d6y28J
         9CnMDdJ4sE7AHcq1FOf9M2SUHl39wxz5PKnXfYZjnmxM6fwc8ATWvA9jZkEcA7SrhQ
         2J2eGtIhCD2wvDpsGtI1kBbJqXMzzE7qMdvGQbvI=
Date:   Thu, 25 Jun 2020 17:59:57 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org
Subject: Re: [PATCH 12/12] ima: Support additional conditionals in the
 KEXEC_CMDLINE hook function
Message-ID: <20200625225957.GC4694@sequoia>
References: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
 <20200623003236.830149-13-tyhicks@linux.microsoft.com>
 <1593125804.27152.426.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1593125804.27152.426.camel@linux.ibm.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2020-06-25 18:56:44, Mimi Zohar wrote:
> On Mon, 2020-06-22 at 19:32 -0500, Tyler Hicks wrote:
> > Take the properties of the kexec kernel's inode and the current task
> > ownership into consideration when matching a KEXEC_CMDLINE operation to
> > the rules in the IMA policy. This allows for some uniformity when
> > writing IMA policy rules for KEXEC_KERNEL_CHECK, KEXEC_INITRAMFS_CHECK,
> > and KEXEC_CMDLINE operations.
> > 
> > Prior to this patch, it was not possible to write a set of rules like
> > this:
> > 
> >  dont_measure func=KEXEC_KERNEL_CHECK obj_type=foo_t
> >  dont_measure func=KEXEC_INITRAMFS_CHECK obj_type=foo_t
> >  dont_measure func=KEXEC_CMDLINE obj_type=foo_t
> >  measure func=KEXEC_KERNEL_CHECK
> >  measure func=KEXEC_INITRAMFS_CHECK
> >  measure func=KEXEC_CMDLINE
> > 
> > The inode information associated with the kernel being loaded by a
> > kexec_kernel_load(2) syscall can now be included in the decision to
> > measure or not
> > 
> > Additonally, the uid, euid, and subj_* conditionals can also now be
> > used in KEXEC_CMDLINE rules. There was no technical reason as to why
> > those conditionals weren't being considered previously other than
> > ima_match_rules() didn't have a valid inode to use so it immediately
> > bailed out for KEXEC_CMDLINE operations rather than going through the
> > full list of conditional comparisons.
> 
> This makes a lot of sense.
> 
> <snip>
>  
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index c1583d98c5e5..82acd66bf653 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -731,13 +731,15 @@ int ima_load_data(enum kernel_load_data_id id)
> >   * @eventname: event name to be used for the buffer entry.
> >   * @func: IMA hook
> >   * @pcr: pcr to extend the measurement
> > + * @inode: inode associated with the object being measured (NULL for KEY_CHECK)
> >   * @keyring: keyring name to determine the action to be performed
> >   *
> >   * Based on policy, the buffer is measured into the ima log.
> >   */
> >  void process_buffer_measurement(const void *buf, int size,
> >  				const char *eventname, enum ima_hooks func,
> > -				int pcr, const char *keyring)
> > +				int pcr, struct inode *inode,
> > +				const char *keyring)
> >  {
> 
> The file descriptor is passed as the first arg to
> process_measurement().  Sorry for the patch churn, but could we do the
> same for process_buffer_measurements.  As much as possible lets keep
> them in same.

Yep! That makes sense to me.

Tyler

> 
> thanks,
> 
> Mimi
