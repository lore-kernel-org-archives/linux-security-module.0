Return-Path: <SRS0=6WpB=QM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EEBC282CB
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 19:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31072083B
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 19:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rc4BBB9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfBET0H (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 Feb 2019 14:26:07 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:37655
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbfBET0G (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Feb 2019 14:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1549394764; bh=/qsW/Pd426cHo/B7R8naYP56lva7qCiCRkfhwxEfzWo=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=rc4BBB9KHqeAN/nRhL8xZszaXuZhUN5Rnx0No2998Bfr0YFyQuJo3d9Y5d2gCHpvUcRjEPLgO2rq0wz+y6j5xh9OzUoGfxyQnzdGRYyRyto6pRa5+laxFj+pX7lGQXG/jaEVRdbsSoXp7+Mx1ZTIXeMNWUWzucluDTVRTEGUcQlROyByTeBnmAbO/EQCM8TXfhC504ScIed1wIl+CmPjhmxsAwwM/o89HeCgR583R2S/EaTBcMXtY9B3tQAPkNITYw4oei/qZXJxyTZDktRctLFMuEE5GNeSKIfrzih9uhLsAfrEjS+HyTlYvosAIfCEpVAsEo1PIbgWsukNDy9LAw==
X-YMail-OSG: Bz8eJHMVM1kKyZODViJCqFXAAwCDmXz4INBNbfNUj9.ENcSXRqsyy4liUCfAT26
 m8XrdEMVclN4zg28QRYBUXqigcJ_PDqh4B66Log2W.2379jYmu1scdpfmH8axXAk5ibb.hhUaAGD
 mYT6quf642OpipxgBDclXsLDb_Qi5q17doZtdUbs.EbUaSa4.DJrZAfwGULIViN2CP4K0ysdLuzJ
 wKjBJv6UL2MMFIcxTWE3sxMKmy5hxJsAX.BJycq_1vj.PuDj3ts3K8e2r0HcV2r3j9vNEVqiduHo
 SXUOkGZRq1xusI9jbf6jaRdPeJKSXQTYqg3BjYV_pqfoDpTnNpTs7WuvSo.mspIuX1s7SVGo_uEo
 7WyAPxFeN3VTE33v9pxMzBDmND2FQYMIzEBCR2gm5msIB2BX1f959quJXwXd3ezXcU7ruUBEBSUe
 lEi2GwEF.ZN1co3htnRdn2LYXwPkTdyJAiXgs6HFuyUDKVjB9B7lK1zDLnp95SlX6C.QuZb4UYG3
 yFvOJSAq7xBO01tPgJeCgFo4dR_Kgy87ejqxL.E5fsASmkNXHp7Rg.hUyI71eIqwbPdUT3BppFAp
 fe9f2.81Nh_nSxys4OcK23sK0E0Vr.tYNlo6.Aw6yticJ3pmt1bpX54S15BUUz_LlBVf1SVoGmtv
 qbDJMc6ZNxKgkjqFHQFsuFYjc3iiMQliHjtGWWina4Ww5_zDC5w0puEJWChDms.Eq1X9pFqMfdpi
 6UNQaPgpyMlNiawbRoa8PBPO1OfM_mN1iaEVidYznw8Y7TzeCprIlo0PPU94Shs5GyguzRxDjDTA
 yR.ClDbNRECy0_rCj9ktj0G7TogTLdv4HKZKE.WJ8sMHRq4_EUinQJmRBI.tJKTW.bskuEWSYRMJ
 FfiZi40SkHHR13oHix.TV8kvYkjhU5ybc3JhwuRi4spAjvxWucNwG7GwQLPvA_AgZHNHFk5SXd1H
 C_adPYn9Nu6P3u1hBvOXLZiym6Pyq4yzsoCB4jIehtYCYMIdsg2FOJOXxxnwPz973HIbJiNbAcLN
 T8rB6LVRKYmX2oMgFi3_1H.wkIn2GjqGqWj3rTSWh9rVF.2gZgPyvF2dJi.SflSrw6LcTbrmJnhJ
 JdIallZg-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Tue, 5 Feb 2019 19:26:04 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp432.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 666cd487cc651b8877386a4050e01ef4;
          Tue, 05 Feb 2019 19:26:01 +0000 (UTC)
Subject: Re: New LSM hooks
To:     Edwin Zimmerman <edwin@211mainstreet.net>,
        'LSM' <linux-security-module@vger.kernel.org>
References: <61766e1d-496e-6a7d-d4b8-52e2c99a78c3@schaufler-ca.com>
 <000001d4bd80$8b9442c0$a2bcc840$@211mainstreet.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <c15e8f04-df2e-40f4-d227-754d03de3dd0@schaufler-ca.com>
Date:   Tue, 5 Feb 2019 11:25:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <000001d4bd80$8b9442c0$a2bcc840$@211mainstreet.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/5/2019 10:28 AM, Edwin Zimmerman wrote:
> On Tuesday, February 05, 2019 12:40 PM Casey Schaufler wrote:
>> Full disclosure: This is all about me and my interests.
>> ...
>>
>> What do I want, I hear you cry? I want some sanity in the way
>> LSM hooks are introduced. I want some standards or conventions
>> on what is appropriate to pass into and out of LSM hooks. I
>> want push back on special purpose hooks that are required to
>> fix the deficiencies of a filesystem or bizarre hardware
>> implementation. I want to stop spending all my time trying to
>> deal with new, crazy LSM hooks. There are enough old ones to
>> keep me entertained, thank you very much.
> I agree.  We need a roadmap of where we want the LSM infrastructure to go.
> Without such a guide, LSM code is going to end up as a rats nest of
> confusing, partially implemented, partially supported code.

We've achieved rat's nest already. I'm working to untangle it as
part of the stacking work.

> Here's my suggestion for starters. According to kernel documentation, new 
> LSMs must be documented before being accepted.  Perhaps we need a 
> similar requirement for LSM hooks.

That would be handy. The documentation would need to cover
the purpose for the hook and how a security module would be
expected to use it.

> As I see it, LSMs are security additions,
> not functionality patches for the rest of the kernel or for special hardware or
> whatever.  Therefore, I also suggest that all new hooks be implemented in 
> at least two LSMs before being accepted.

I can't say this makes sense. The binder hooks are only
useful for Android, and requiring Smack or AppArmor hooks
be implemented isn't reasonable. It would be reasonable for
the kernfs hook, as the kernfs hook is a workaround for the
fact that kernfs doesn't use inodes.

