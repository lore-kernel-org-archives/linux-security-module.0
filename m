Return-Path: <SRS0=6WpB=QM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DE1C282CB
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 17:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586BF2175B
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 17:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FzVZdrMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfBERkd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:40:33 -0500
Received: from sonic302-10.consmr.mail.bf2.yahoo.com ([74.6.135.49]:42273 "EHLO
        sonic302-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbfBERkc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Feb 2019 12:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1549388428; bh=6k44cSLXC/RefFPCxz1S8RfBMbuDJCiSyj+7jb/RlTE=; h=To:From:Subject:Date:From:Subject; b=FzVZdrMwiUQaPEtMEFgI8ztysZkRjSzQqPeKp4plFaSR+shvMNeUl6ATTjRz8uJuYzDGr4FFit50ICOst6v09Zj1QPcd53/rFN5/LacSEDJxwNNMBv3R0hLBNl/J7z7L6lCyaDJTbmAwE4bvZLo2dAIf9j8aS50w1d8tar8sLmmcJmUMB5ZyDuObPGDuVYCND2QSukJSfMF5tjpmIGOGLByGeMtiOFpc96FnQ2YevHBq6XaBCruKT7kktZCu3rWrfeGKqMvLabVBwDk0KWdl99aJJV5g3lXVan6IBMdj9baa2M6igve/Se5E8/NooiT+l6GmHhEHkgSYK49IF+Cgpw==
X-YMail-OSG: EGqMZJYVM1lWrBf226ti7HP4lzwVeWeb2qfxzX6aB_Tj6lk2vPd2DVArFII9lAF
 vPqn2Fqfk0bYYtXzsRYglHNX5p6adeMnhjpyK40TlSD5HrZFrlLSwn9SqJG5LBfzxOXfBXDhctLB
 Zp2kw8IreRGj.Dn.4LWPKOka.hk5glxomITIV79FP03Ri.sXFWK7.42BIUk.Hn6JrvsMdJQRhHvC
 XEHeGINlfEVb.tQoGAja6FSGSGBYMWNz1z2ioezPmakYbe770az.6S8D6Mr9lv1pIE_P_4HcYXOA
 uUg_WurIScui7Ed08TOnqlRLtcO_3dmswSgavzL_Jz74T8V47HpdLHO393IBr38o_ERSv0A9m4CG
 XSqa2oBaJb8wOr1CG_QB76Xjwq2Er4tOkHzNMvnjUN91kTMykwScvxakpbJNhhPdYFjpvBn0.vDw
 EFx763A6aJojtHaLqiSXonDzLYyKpeBg6ZVuM_tQft_o7oS3KEQ6nc.fh42xgAA0Vb.v6LjXL_O9
 7wK.vNw9_EvQnM7PFTsFjsUz565MjJTwdsHmt7luuBWi4me0VoW4acSADRa5.P_zj1EWbyzxkDT7
 8EBJavgwsJPvFuRUVWf9wFnp7ALjNWxTaX04HOWxccro.oRP1sPBIpvSw2QhRx_XyttaUvtfnnKP
 pSbELcXSSlSb3OHZJxbEfMHQssOF5oiEZ.50Z.ked2P1YCBHeg8lvFz1cQytyyaE1iAd8GAbAVWO
 n7RM0BkIFD3iH1cJI35xVAg3ruil0g9GJoglxRJrZrkAVkuyXaLCOPy_5zxgx2WpqtIOC65zwB4M
 Q_d09t9iLFFQ3WLRf.DBb1qW.qwdF_pHeM5eHaKixTyg_Dy3dfWyDsvllNCvLInTyiIOysBgX2os
 YIyMA9c2gKHR.sZ9_N_WAHbotL.AOYbkSlClCIFwQcSdimRbLQ1nNagCQVzoX6LQ.gbIzG4OaJL4
 LCkw5RNDEJ7aJVqOqeh_FPh7e.qrQ80pFXFpzmRzQZsAOjiHLizu_pyERLX0.wL2DkEM6srP2eHN
 JpIwkMVG3q7rOxGENZtIA4.22_95zb9jBc2lyKnis1ZQfqZGSlmMLYBVpqAqAS1KCW.kJhKKD
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Tue, 5 Feb 2019 17:40:28 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp425.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b50c85f3990aee787e8d011d086534f3
          for <linux-security-module@vger.kernel.org>;
          Tue, 05 Feb 2019 17:40:28 +0000 (UTC)
To:     LSM <linux-security-module@vger.kernel.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: New LSM hooks
Message-ID: <61766e1d-496e-6a7d-d4b8-52e2c99a78c3@schaufler-ca.com>
Date:   Tue, 5 Feb 2019 09:40:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Full disclosure: This is all about me and my interests.

Developers propose new LSM hooks for many reasons. Often,
it's in support of an exotic feature such as Infiniband.
Sometimes it's because someone got clever when they optimized
an otherwise mundane feature and bypassed the usual hooks,
as is being proposed for kernfs. Usually there is a particular
security module (i.e. SELinux) that is targeted for the hook.
In almost all cases a hook is provided for that LSM, but not
for any other. In many cases the developers don't even include
the LSM email list in the discussions. LSM maintainers find
out about the new hooks after the fact.

Prior to 2008, when there was only one LSM, this made perfect
sense. Since then, it's been a regular practice justified by
the notion that it's the LSM maintainer's option to use the
hook or not. That also makes sense in cases where the use is
strictly optional, as it is in binder. It does not make sense,
however, when a core system facility like kernfs is involved.

I get a double whammy on these new LSM hooks. I have to try
to figure out if Smack cares, and if it does, whether to proposed
hook will solve the problem for Smack. Because Smack uses
xattrs and process attributes differently from SELinux there are
often problems with hooks that are provided with only an SELinux
implementation. I also have to work out how the new hook will
work in the stacked security module case. There are some existing
hooks that are a special challenge there, and when a new hook is
proposed that does the same kind of things (e.g. use of secid,
secctx or list of xattrs) without considering the consequences
for other modules.

What do I want, I hear you cry? I want some sanity in the way
LSM hooks are introduced. I want some standards or conventions
on what is appropriate to pass into and out of LSM hooks. I
want push back on special purpose hooks that are required to
fix the deficiencies of a filesystem or bizarre hardware
implementation. I want to stop spending all my time trying to
deal with new, crazy LSM hooks. There are enough old ones to
keep me entertained, thank you very much.

We're about to get a bunch of new LSMs. I don't think that we
can afford to continue with the current "feature A needs a hook
for LSM S" behavior.


