Return-Path: <SRS0=6CDJ=W5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911C6C3A59B
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Sep 2019 09:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53258215EA
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Sep 2019 09:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="GRUigEr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbfIBJgs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:36:48 -0400
Received: from smtp127.ord1d.emailsrvr.com ([184.106.54.127]:56346 "EHLO
        smtp127.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731184AbfIBJgs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Sep 2019 05:36:48 -0400
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Sep 2019 05:36:47 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1567416420;
        bh=JZgC5de0uuI+0ASR26GHoZLOtatDJDlJ1lgjoNqGIG0=;
        h=Subject:To:From:Date:From;
        b=GRUigEr+i7TgMBtGuNj8oURU1bJKlY2gUZWrPmzvfabsXgSGwryZorMbY+m3RGbm9
         3sIl/Q+aiLuw/N/jPZu72Vwd6BPe1USNFrgpheg2L6ipje1np2yFDvXShy/5HeC6i4
         fdPNx3AcLVZKycrW9sfp+auhCEA4TWvprJG9hbJk=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp8.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id C43BCC00E7;
        Mon,  2 Sep 2019 05:26:59 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.173] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 02 Sep 2019 05:27:00 -0400
Subject: Re: [PATCH 1/2] staging: comedi: Restrict COMEDI_DEVCONFIG when the
 kernel is locked down
To:     Ben Hutchings <ben@decadent.org.uk>, jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
References: <20190830154549.vss6h5tlrl6d5r5y@decadent.org.uk>
 <ea330943-9d3e-d01d-a6cf-8de08e042ec6@mev.co.uk>
 <f2a2ba9da5b55cae57f1aa62983a7e6598aca128.camel@decadent.org.uk>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <0949d35c-9656-89ab-7c53-5a876359d8a4@mev.co.uk>
Date:   Mon, 2 Sep 2019 10:26:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f2a2ba9da5b55cae57f1aa62983a7e6598aca128.camel@decadent.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 31/08/2019 10:50, Ben Hutchings wrote:
> On Fri, 2019-08-30 at 18:35 +0100, Ian Abbott wrote:
>> On 30/08/2019 16:45, Ben Hutchings wrote:
>>> The COMEDI_DEVCONFIG ioctl can be used to configure I/O addresses and
>>> other hardware settings for non plug-and-play devices such as ISA
>>> cards.  This should be disabled to preserve the kernel's integrity
>>> when it is locked down.
>>
>> I haven't boned up on the lockdown mechanism yet, but just FYI, this is
>> only possible if the "comedi_num_legacy_minors" module parameter is
>> non-zero (which it isn't by default).
> 
> So do you think would it make more sense to set the HWPARAM flag on
> that module parameter?  That should have the same effect although it
> doesn't seem to quite fit the intent of that flag.

HWPARAM would prohibit the creation of a few special comedi devices such 
as those created by the "comedi_test" and "comedi_bond" drivers. 
(Although one dummy device does get created by the "comedi_test" module 
when it is loaded, and I don't know if anyone actually uses the 
"comedi_bond" driver!)

But then again, the changes to COMEDI_DEVCONFIG also prohibits the 
creation of those special devices, so I don't suppose it matters either way.

> 
>>> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
>>> Cc: Matthew Garrett <mjg59@google.com>
>>> Cc: David Howells <dhowells@redhat.com>
>>> Cc: Ian Abbott <abbotti@mev.co.uk>
>>> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
>>> ---
>>>    drivers/staging/comedi/comedi_fops.c | 6 ++++++
>>>    include/linux/security.h             | 1 +
>>>    security/lockdown/lockdown.c         | 1 +
>>>    3 files changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
>>> index f6d1287c7b83..fdf030e53035 100644
>>> --- a/drivers/staging/comedi/comedi_fops.c
>>> +++ b/drivers/staging/comedi/comedi_fops.c
>>> @@ -27,6 +27,7 @@
>>>    
>>>    #include <linux/io.h>
>>>    #include <linux/uaccess.h>
>>> +#include <linux/security.h>
>>>    
>>>    #include "comedi_internal.h"
>>>    
>>> @@ -813,11 +814,16 @@ static int do_devconfig_ioctl(struct comedi_device *dev,
>>>    			      struct comedi_devconfig __user *arg)
>>>    {
>>>    	struct comedi_devconfig it;
>>> +	int ret;
>>>    
>>>    	lockdep_assert_held(&dev->mutex);
>>>    	if (!capable(CAP_SYS_ADMIN))
>>>    		return -EPERM;
>>>    
>>> +	ret = security_locked_down(LOCKDOWN_COMEDI_DEVCONFIG);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>
>> You might consider moving that check to be done after the following 'if
>> (!arg)' block, since that should be safe.  (It detaches an already
>> configured device from the comedi core.)
> [...]
> 
> How would it have been configured, though?

It works on automatically registered comedi devices too.  I suppose that 
could be done via the "unbind" file in the driver, but that goes through 
a different path and is a bit harder to use.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
