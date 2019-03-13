Return-Path: <SRS0=LsZi=RQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2313FC10F03
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Mar 2019 22:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19542087C
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Mar 2019 22:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="j0Rfi9wS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfCMWzj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:55:39 -0400
Received: from sonic304-31.consmr.mail.gq1.yahoo.com ([98.137.68.212]:35042
        "EHLO sonic304-31.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbfCMWzj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Mar 2019 18:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1552517737; bh=dLGIzxTaH4duSwAJMf3mY87XpsAsI7rFzzCjP3dqgW0=; h=Subject:From:To:References:Cc:Date:In-Reply-To:From:Subject; b=j0Rfi9wS2U6iRPzu3yG88l7hWaVaWLGkUsEYDxJF/dht+Q1XBV73y/zxzNkI/hTMbgcVqwD8spjlP97uRWSKHhwXCa2h4cmTG36Tk8F8tCmz2Ldz9vnLCx8HyWKCyOb+2VE9k/ni8dvaEVjb9WReeLmILgx3FBJuhfYJuHO+Y6kLQmtddLZrQYY2c/W70966wMdoLh7uLi+o+pXUU7eJqF/VaAwoyTwqyH36TfqmhxPWACN2Od7umzoRyKz4xvllJbII23HRfHdGQqBqOmeHJkQeEQqYDm9izkKxoKnTkrq+cSQdHu12iC0Jeqn01G/mvFyRuS6zvCEHuUnJt5YbPQ==
X-YMail-OSG: R_sp6_sVM1mutfQK9aSfrgrKp_fWtmMSYefRvx56VF6LJ0mCBroYdIT3CI42bSx
 _pPmExTeg5pntQVHRxIBYEbo5zd44pP8XRDUtmvzb6fSZ3esAqEoqkdvVEpYCoSCISXLjHzrcdBF
 heVC24olmr6ig9EvLCQ7RUmg0evaZEQadmKVcOM1vR3pmZznJ_YdMxrKgQau6RAN1CxV0XYpWjUS
 2k4Qm4xNdGfQLBgkFa7q3t2b4tsqW5tjGwB1NtA1qeFWEZog7oaX1MMF1c47ONoiNH9Cx.yfFv3f
 LDuags0sPiXLhwniYcijCGEaFtbnle1Fw7TX3TMSzw2rp5FiiKI23KdyXBrF2uXvzezXIyHs.vDk
 xRWFcp9vtmn8Tzmmew2ltnqtZFZgBcqHCisxecvsT.hBjZ0UvBcvxL_iRe6bEHzCgIXEPY_13xBz
 yOhtRywXYuzPIuEI1mGcYGj.Y4cAeC.2AmRB5eMo3N.Q4.LBFalL4MZJXmu4jY7tF0w03zcWzTdG
 el5aGLagxHVIK7y3had6R9HqpvHmAdNtdlTJ56S1GFVuYJNbclw.LfPHiwu3VBoRQq7jh822gkIo
 8dEa7xp8irkiEmIkGRZ_1Jh2XvCtKGy9yYrGa5.BRJ00wDaQ6hFYrsjxG6uFwRFnGtwyDJtQ97N4
 v1Uic7Q7CiocIQps1G7K4HRuitoNXxApYkfAOjWbW8.gtD1vo4s7VF0R9eli41DN9IPVZAp3ZVYq
 0oAeYemFRULYxdv1bnkxh2Anv8ZZ3uRRT_AcTbLp4g0PXJd8yhzELHwx.GniAF9yJ5rVn.yeP.RD
 jp4T38nRK65z4RXWUndIKK04coEF7beK0EdiTGKxMyDcbLM7ZHlyHGlzxGdDbur3UeVMDHnuxKH7
 5eUHm0EavOTmo8uOMojk4SzA5mrY73hDDZIMsCTvKBKifaIVoJklH0OR8GbRnANEr0DnsgzDAdFA
 cxdB1SVk2W7eWAyKOxOLLDKfj0N2SnyMERVrh5bHOnF1v9z9.aaDvdpq.aavnxTpYVDNCtkzHgw5
 kBlPWRdBNY1RuMS9i3vj_tGaeyGBWWA0e6246YKK58oHkrEp9uesaOlA0MywnU5Way5HWy25BtKX
 CjjX10FWd_gn999nftRsyxA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Wed, 13 Mar 2019 22:55:37 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6b425229096bf8047f9a47e5b96533e4;
          Wed, 13 Mar 2019 22:55:35 +0000 (UTC)
Subject: Replacing IPv6 port labeling with CALIPSO in Smack
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     Piotr Sawicki <p.sawicki2@partner.samsung.com>,
        LSM <linux-security-module@vger.kernel.org>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>
References: <CGME20180719094732eucas1p18ac5bd15693cd06f868238c7a4951aa1@eucas1p1.samsung.com>
 <20180719094732eucas1p18ac5bd15693cd06f868238c7a4951aa1~CvBwyJxUf3081230812eucas1p1q@eucas1p1.samsung.com>
 <60d493f6-633f-e577-9947-cd41e1c762dc@schaufler-ca.com>
Cc:     casey@schaufler-ca.com
Message-ID: <2a019a5d-5024-d839-d72f-ffe5b554ef09@schaufler-ca.com>
Date:   Wed, 13 Mar 2019 15:55:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <60d493f6-633f-e577-9947-cd41e1c762dc@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I am looking at CALIPSO support for Smack. CALIPSO provides
the same sort of network packet labeling for IPv6 that CIPSO
provides for IPv4. Because most of the details are buried in
the Netlabel code this should be reasonably straight forward.
The complication is that Smack has two mechanisms in place
for labeling IPv6 already, and neither uses anything like
CALIPSO packet labeling. If CONFIG_SECURITY_SMACK_NETFILTER
is defined Smack secids are sent via the netfilter secmark.
Otherwise, the Smack label of the process creating a socket
is maintained in a table indexed by the port number.

My proposed change would make the IPv6 labeling match the IPv4
labeling. The entire port number scheme would be abandoned.
The current secmark scheme would continue to be used if it
is configured. Whereas today IPv6 labeling is only supported
locally, the new code would support labeling remote systems as
well.

Systems that use CONFIG_SECURITY_SMACK_NETFILTER should be
unaffected for local use. The host address labeling scheme
would be retained, so any system configured to use IPv6
externally shouldn't see a difference. Systems that don't
use the option should also work the same as they do today.

Are there any users of Smack that use IPv6 but do not use
CONFIG_SECURITY_SMACK_NETFILTER? Does anyone have, know of
or imagine a use case where CALIPSO labeling would not be
a viable replacement for the hackish "port labeling"?

Thank you.

