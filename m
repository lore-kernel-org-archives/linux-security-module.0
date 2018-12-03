Return-Path: <SRS0=6aHe=OM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C6BC04EB9
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Dec 2018 16:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7CE2082F
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Dec 2018 16:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JGkPuv+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7CE2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbeLCQNq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:13:46 -0500
Received: from sonic308-17.consmr.mail.ne1.yahoo.com ([66.163.187.40]:44634
        "EHLO sonic308-17.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbeLCQNq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Dec 2018 11:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543853618; bh=LhQXQ9BZZ/ZMCS/pwQbvIMnAz4UngjFxiY2xD1/ajPs=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=JGkPuv+MWSE7ARVAhYxc/o0m1lw0FglKV2ferYP4dp1pnGpufzUynvrdMo3+9bJEdzcwe1Ev/eZXWcMUGAX7fq2JPI9IfadxNQdX942LwzmaPo4hM02MLQWeG/cxmmvYq5JDD8cg9PFDZMJSJ5sur1ZSlOKyh2hsRWKRIWAyvU4jxxUK1qeOl2uHtB6JGYGqMuI5tAY+vY0JaN19EUk0QPKD5F3sxgwjRi5qQ70hClncHeJPON2heWD991NHH8Axu5bWI/LQtD9borb/bpknMUPGX2bx9ZbdPS+VQDoTGZiQQilpYt2FdrzQ4E4jKIZvwiv81v+coKz2FyCXx5SeFw==
X-YMail-OSG: XmA6nYUVM1lj6ItdTl6rDFfF1Dk4RWTtnQnEE2mdX_RBstbsKG2SAZrjuwexZYz
 P6QmpWjMbDeIxpHSTspG.ir2Mb3pNSe.EOIWtZaZ_N5833UrP4oyZvzzj.mMvBcYlBCXqhqeX_Zs
 ciELjf9ja5kn17lPZm7xevTkuHPGWIAxlnl7G2QB70Jn1IVRuE9mTDtNcD7jjP_fW_jupW56Wt7d
 6rkdfBk3nEWJAjWlq_oPbYgTaHadma9M8ayyaVzgs3MHtl6ghjYqD7yGVN96K3Qc551_UIxlZB.j
 HVmXXzLYVvEadVCCKTHhgpUXOlWp6EWQl1SsLoNeEUgzvfXJyncoYHrdcCCnH9dGG4.RLI9hys8i
 45DH1G_E0.PwUWez6voh0lCpGbtA02Z9.l6ISLEfaKkQyxKTtHXCL6Xs7neyBTg5kYiefG5v8QIB
 jygAs.tZziQKFRj6jAtWVY5nuNXaTqUE2lyTnLinykf7f4mzQdS.qBbeER.EA_IT0mkLFaXE5UZS
 7M2L6c.M9.W_yHhPnTIkq6Yvxl8gUSK7HWcy1gDDZFnk1Of7pc0ttbMvTH0cEV27_OFzrCpETAyb
 eypnHVen4ofYYl15wSyXZOrXY.1zwlym6MhlVOP2KmGm2PrVgWz0A2OKqGb7bJATBHfbhWc1bjTU
 aDpDm86m2dgOULFCCdD6kKSFyrl176H_ggu_jlD5ajQ1FLcaalodN_aGPuej_k0tYTHSyBO3sk2F
 F8Ko8_eqtvfXXKTlfILDqyu2IeZTtTKA8fy_9oEpu3JSLOr0icos0rwkNjlM.q86Xk5UkZUUndtp
 xoJhBZvhAwM8WHrYAsJf6_bRy.INoxAdKEMOOxprDt10Y3ADAzYNvDJnG6SAtK.6nneZsdd26psk
 gEvfv2TN91T3hhQtJczVP0ji.3qHHRCqgpORh92hYMLlANkTEWFo0crloac3zw3xIP708bXiL2T5
 cLqLyzORij1FED3byzflumt.argn3963Gb3y6BAqs8pibP3PSPxFXH5kKpozDvVnGvwj3ubAK7Hn
 MlYWmsoQV9937U3U.FqrgBzEIYoPK8FOP3x0lyOyA9BXLmcmudbGw3CItxfUhAYXWMIcGu4QDNHo
 n
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Mon, 3 Dec 2018 16:13:38 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp413.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 38a342a0a057460213820e97438570bb;
          Mon, 03 Dec 2018 16:13:36 +0000 (UTC)
Subject: Re: LSM hook for module loading and unloading
To:     Tamir Carmeli <carmeli.tamir@gmail.com>,
        linux-security-module@vger.kernel.org
References: <CAKxm1-F9XOExo0F1QuR+ekHkpqCi+BVpMyAVRGN26t=Q1McB8g@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <8a74fb14-47bf-3415-2742-bec56b19e6f6@schaufler-ca.com>
Date:   Mon, 3 Dec 2018 08:13:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKxm1-F9XOExo0F1QuR+ekHkpqCi+BVpMyAVRGN26t=Q1McB8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 12/1/2018 7:49 AM, Tamir Carmeli wrote:
> Hi,
> I believe that this is the right place to ask the question, but if it
> isn't please let me know of a better forum to ask.

This is the right list.

> Is there a reason why LSM hooks for kernel module deletion and loading
> don't exist? (for delete_module syscall and load_module kernel
> function)

security_kernel_load_data() is the hook for loading.

> Is there some design problem I'm not aware of, or whether the
> necessity hasn't come up from any of the mainline LSMs?

No one has seen the need for a hook during unload.

> I'm considering to write such patch, and I'd like to hear reasons for
> why it might be a bad idea.

To what end? Look at the Loadpin security module in security/loadpin
for one approach to protecting module loading.

> Thanks.

