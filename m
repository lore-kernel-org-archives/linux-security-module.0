Return-Path: <SRS0=nTNb=ON=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24E2C04EB9
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 01:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7703120850
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 01:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XbE7w9dX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7703120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbeLDBvy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:51:54 -0500
Received: from sonic308-18.consmr.mail.ne1.yahoo.com ([66.163.187.41]:38249
        "EHLO sonic308-18.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725937AbeLDBvy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Dec 2018 20:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543888313; bh=chU+0yHEO4+rr6/0R7LLlDpI7HCT5AthX1X7qDy4YkY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=XbE7w9dXN6FwrvseEHgFSneLUyt4IwjFhBu8RIpNjrdDErwnIVngmBkiCnTvmi7eiGngpqkwlqVuSQ58aTonesGd6GMIhRWgUoZ6o6R1Vdv0ivXdh38eFmY5fVbInh2CydDtJy8d+weGCdpxYPY7HcGVbatwUiHgO9Jm5WdOewziSvqC/5dPHWqmRnqnRsB1Ib3ee5KIMLWzkWA/YrCsMi3Rn2vi7gbVeI146OCJVJ/eCQGoATKtyTDzreg8ZGkeS/H9tGIuwFwDrsLpizjlKM8rEHZYhK+Xrt+BEqqeZ+Kwgej598Wqleq166eEgefq4TlVBdMe9GJ4B91tfLEoNA==
X-YMail-OSG: 3Cwd_SQVM1nfD120dr.YOxzOniLEvtLhQNmy35QTHCWQwdM.NdwHVQ61swX3Eet
 Uj3sgOQ4cxpuxG6J4FRZ.tgK4m45w9_NSxePaPgaxCMpANy2Z9f92wqBm.u55TeRyEuzkHisbN4E
 cybFoqLEBet.xnj6SJoQ5JQVMBa3.gijaujjwbjQqnjDNGqSo_Fj8ycYst2ctDTAtT8kXQSoCmKU
 iPGa21koEWq2kTFWfOpXVVgGO2hBObTC6g6J8.9_v4FoTiu.b_M4dR.zsc8sMXBYFtDh3YDhmgGI
 Cem5zBlO_W.H_nBtMcWr_fEImtwEClUGvxPs5mcep1Iy3UaV3otZ1k9ye6um9hokUEBKRj_dUYTb
 6h3HXTw0xrceQ8FdcSFi6eNhCC4TxarbxAieRmkLxVCuwB1AQcMcj5ZxP2UKtXH2xyBOHFzzDAoP
 A7FJQ30TdsKgkGDKwahGxCJVLHpEl9RiJdP.1QLz_lKDh0iefzTB_2IP.El.ZCdtgpYx7welm4o0
 DX72RVINoRAQ9OJOyKEWxXg_.X0XWQQYs8smtEwa77tf15cTkdkj1gqqSLSyR6ms6W_xn4S1.IGN
 qQ_CLRzTvSDqk1OjC4lR9teIhC4AL78_2nznvtxNNZsDQ_mWk9.fyV.d8W9YnMRIc2zpsE36Yylp
 3TYb3zdDeysvZYztbyxer8rkjGKkuHCfxEZXzNmtZdNrtsfSt7FXn5kFYVpZVlIuUoYOgRHxwFKW
 6vkkvp4CabJtyW5kYbpzKGuH3YRrXO6XX9P.Og.ev.LM.v8RpsDRzaC672UuqkfP9CmBSHEYWEYs
 gOa_60Zt91y8HXH_i0_Pb_vnzb9RvbyK9fx2B82Ljd87OXCWT_15wyeJ4yTeGy07IeAUz1E3sEWr
 HirSfEqi8JstVM_fjTA3eiR6yaR0RNBc0O6mSe.jqm8rjKg63Fk2ZyNWQGUFgsMgCkFyVf3CVTaj
 tlYmVtmpzjs.mh2u7SzzPKDwxo92O7GLtfGeMUohkDc.Kj61Z1AQ7_8pP_ISBqQLkaCxnmFoVEz4
 EOqcnM176YV_omPQUtEcOQtaLfkqb4AEFnLHwP84LcVnmRniYHat.G1G3sCm6pQ5nLvfhsv9oPwY
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 4 Dec 2018 01:51:53 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp425.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c4f650866c23bb02590f3184c52f4ef4;
          Tue, 04 Dec 2018 01:51:49 +0000 (UTC)
Subject: Re: LSM hook for module loading and unloading
To:     Tamir Carmeli <carmeli.tamir@gmail.com>
Cc:     linux-security-module@vger.kernel.org
References: <CAKxm1-F9XOExo0F1QuR+ekHkpqCi+BVpMyAVRGN26t=Q1McB8g@mail.gmail.com>
 <8a74fb14-47bf-3415-2742-bec56b19e6f6@schaufler-ca.com>
 <CAKxm1-GmS5zYh3W_Fz+XxrrF37p-ciqno_2BwCjz=hqOn1Xvqw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <6ae11f52-bf6a-7763-99e0-d196d4e94dd3@schaufler-ca.com>
Date:   Mon, 3 Dec 2018 17:51:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKxm1-GmS5zYh3W_Fz+XxrrF37p-ciqno_2BwCjz=hqOn1Xvqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 12/3/2018 2:23 PM, Tamir Carmeli wrote:
> Thanks for the reference for loadpin - I didn't know this module before.
>
> I understand that unloading a module is a pretty far-fetched security
> risk. I have one use case I think might be worth a shot: An exploit in
> the module unloading flow or in a vulnerable process that unloads a
> module enables an attacker to unload one of the iptable_filter modules
> before some user space process adds an ip filter, and by that, enables
> network traffic that otherwise would have been blocked.

How would a security module detect this case?

> Again, this is pretty far fetched, but an attacker that unloads a
> module that contributes to the system security might hurt the system
> security.

Without a user for the hook there'd be no reason to incorporate
it. I would suggest that if you can come up with an way to detect
and then prevent the attack you should look into adding that to
loadpin.

