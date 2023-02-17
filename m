Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4797CC61DA4
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 00:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBQAD7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 19:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBQAD6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 19:03:58 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA3634F7F;
        Thu, 16 Feb 2023 16:03:57 -0800 (PST)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 113ED3F34A;
        Fri, 17 Feb 2023 00:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676592236;
        bh=ZgACcAfuVvB1nCcOUfv5nq99sIZJmik7xqG2SXKk2/Y=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=uuvUwD+FaXVo/b4D/YrlQUXiUUwj/K3b7ZbWNjxF8//rhJpcIV1Ji5EbAU8koQzCF
         HO1pGqlVznRRpjwwqaykPv0130Zsi54222wMyVopJhP7rHQhYZ4b7Zr1UaWIkmTI71
         HEk8q/IPRpnNrCTWGtkyuVMHu0ObHeHeiWpdmxZtjHCWYA5v65RmXPc0a3OpKT6OEO
         LWyGRO24PfKzlpQ7Afp+0kQGopA29pSDErsgZlzxA5gUC978CHkUZ5f+YPAhoNSgEl
         NjRM1shqTWQ4F9S4xZclKTgkH1tsJJ/8qv1Wp1uk9BZF932Cxk22yjJLOVv+tI9ZR7
         nR//p0xtFr+xA==
Message-ID: <7a1fc8f6-f87d-b001-a4b3-8b160ed2c691@canonical.com>
Date:   Thu, 16 Feb 2023 16:03:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: apparmor: global buffers spin lock may get contended
Content-Language: en-US
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <YO2S+C7Cw7AS7bsg@google.com>
 <cfd5cc6f-5943-2e06-1dbe-f4b4ad5c1fa1@canonical.com>
 <Y19GhTg8Q/3ym/VD@google.com>
 <dac1c2d5-367f-c8a7-c61e-c1774d98d602@canonical.com>
 <Y19JPtZbDlT4MQRB@google.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <Y19JPtZbDlT4MQRB@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I have sent up a new version of this patch that caps a situation where buffer lists could grow unbounded (at theoretically).

