Return-Path: <SRS0=8Njt=PS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F409DC43387
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Jan 2019 17:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D0120685
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Jan 2019 17:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FSA385wK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbfAJRtT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:49:19 -0500
Received: from sonic302-10.consmr.mail.bf2.yahoo.com ([74.6.135.49]:44442 "EHLO
        sonic302-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729480AbfAJRtS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 Jan 2019 12:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1547142558; bh=R8TSwtihpEOmcHKtWtmF/Fsxy17ZzhGXTlFeq74K3CA=; h=To:From:Subject:Date:From:Subject; b=FSA385wKwSnSmzjB4Jbj/+hala+0d7C2xahteVNgrE7aDOQmcycma7Hdq1XhRzI9cXkipzLqeua2y6hvIUr2tQCZz/g0ADCxu+PQQgHDsFq4pX6jQ7iZaP7MQIKLUOCG+V281ytiLB9uFVsNM/qytJxcUrzU8KkNsBLzQeQhmuzjn/XItuxWZ6tDVrG+4nQxFX23HRg3OG/UZD/a1SkluDh2SONktwig5hPSyuJcxjU9i0NFRoD5JlKJROcrZlbo005THuL333ZWYbKcea1q5QqUKoBdGM/nRXOXI1F7Cyr7ovN1+q1NwziI7t5ZnY1ujqoBaq0HWTRwSr0v3UGlUw==
X-YMail-OSG: K3b21B4VM1nT8iAh8Cr9uB5e8FlhzxIFoRxpI3m6V68UOujjNT6sD4wo7Bahv9X
 i_yWtlbZ7I7hjwB764r1f7D8yYcfOoNvGo0uvSNLHkqksS52SswPB0o6SRS.r9owUIKE2XGN2Zrp
 4snUjL.0Dup7OJRgPncQJevnefAB6OcSVSTuzOeUwYu2.MS5QoVwH.ZmvX97LOUYm_.F.d6H2a6H
 lZ_0Xe0zbiuaHf4Bqo7EYA1XF0NoLT0kMbd4iYzkYX0UsWn58271d4kqBYm61ihFuoR1evG0I2MZ
 vUWNJhMHxEWOOkx3PF7GGWMn0htSL8SP4igA9iR9gavYwaTbzycud.g.zwGzMYWPhxWIfO3OyKtX
 dCdlUJQ19yWuTMB6etOBwimn5aH4S82d4qvAeZhgfMepKavTetbR9h6tUsajhNMt8MIOQ.ElKV6a
 V46bzrc2BVZ00QErfv4sqJp5s7p239HkO.0cvj9WQ1tZVDPWZFYofIfdgrVAiR2p9kxu3tcwaFEk
 cWFOYu.o9FLjcFD75BZTUN8oDDSUfSPr8DBho6Mc0W_fDgpXWg_nAYmBaPT8KsaLqSZoXLT7dfIi
 nZftDN_OBDghmfqLkw1MnHruysNHNdZyQLuQeQQkEpsLMwwsTN_P6HYuo7WVTRY0zQJi7y7Kjt53
 CufbACLtgdYv.UyKvRhYQyok22AawvgScK7lHWRa051lLOgXKtjDoG55g.bZvZI6c7hWL67mb24z
 HyuCvR65Lw.uAw.rT0ma797Zi8vSyrqmllR9WxDcjwEhNjt7jfzAUhWXCUffuBjv__0xvjjbwr3S
 NWd0l_uALACEiXeBJWLnbRrKG6tZMkYi2QrpoPstmY81qZKvU07Vf.Cn4ac73pzSYfbUrOJ8Sy1t
 1MS17GUpa4I7r6mfMiILPa5USn.tvqTOyH20rFMUMFeEs65cSZdOn50PrADa6DELOwjc2XbUncoP
 1m96cLu6ksB5NawVFQc5etplayCANCk3IYCABMPPOhQjxP19A2zoclXXUDUzI15dRxqQ5ScEMHEO
 JywOPM.kjQJrCjDZqRRdxbCaNu3QDkColMNTST44RDTPCp_a_VoIxfyvm2AOqhc2jgC2Q4sMPe3y
 .82ko
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Thu, 10 Jan 2019 17:49:18 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp419.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f73f10ea561e6bf1a8d5312e3c8b5b06
          for <linux-security-module@vger.kernel.org>;
          Thu, 10 Jan 2019 17:49:13 +0000 (UTC)
To:     LSM <linux-security-module@vger.kernel.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Sorry, trying to get a message to the list
Message-ID: <f17e9678-a9bb-83c0-a0a8-815e9e388c2d@schaufler-ca.com>
Date:   Thu, 10 Jan 2019 09:49:11 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Sorry for the noise. Testing email configuration.

