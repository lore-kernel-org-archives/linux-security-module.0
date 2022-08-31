Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0C0ECAAD3
	for <linux-security-module@archiver.kernel.org>; Wed, 31 Aug 2022 17:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiHaRRp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 31 Aug 2022 13:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiHaRRo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 31 Aug 2022 13:17:44 -0400
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B96C9EAD
        for <linux-security-module@vger.kernel.org>; Wed, 31 Aug 2022 10:17:42 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MHrTc66q2zMqYNd;
        Wed, 31 Aug 2022 19:17:40 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MHrTb4yvlzlh8kv;
        Wed, 31 Aug 2022 19:17:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1661966260;
        bh=PLDmy6QE9ULYcykru9cCBInkUY8IxGGhzb63p5U0Lo0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m+d4QLhHSArHMX3Wc8HTRts5m+KNxDiNCP3+SAMqbfS3C60YCU7qclJjzIB0qXsXe
         ybNTNnjfSNexWEPDniTkP6/cT28h/en+EdQFFBFeZ3GYKxp2I+Cn64zSnargOq28Za
         tRtL2Hdg0Auwkt6k6oZyng4Zs72Cz/n35a7jKAz4=
Message-ID: <95a54cd3-374e-2f98-ac8e-041151eda861@digikod.net>
Date:   Wed, 31 Aug 2022 19:17:39 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v1] landlock: Fix file reparenting without explicit
 LANDLOCK_ACCESS_FS_REFER
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
References: <20220823144123.633721-1-mic@digikod.net> <Ywf0okWNl4gRXTYL@nuc>
 <bd085c93-5814-e701-bdcb-54e9d5fbe8db@digikod.net>
 <CAHC9VhQy9nf+v0hp3fVofPvf3vTsWWor-fexqXLi+42CKSK=gQ@mail.gmail.com>
 <Yw5WFjiRBTiESwcd@nuc>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <Yw5WFjiRBTiESwcd@nuc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 30/08/2022 20:25, Günther Noack wrote:
> On Fri, Aug 26, 2022 at 10:39:56AM -0400, Paul Moore wrote:
>> On Thu, Aug 25, 2022 at 6:27 PM Mickaël Salaün <mic@digikod.net> wrote:
>>> This patch fixes the (absolute) rule access rights, which now always
>>> forbid LANDLOCK_ACCESS_FS_REFER except when it is explicitely allowed
>>> when creating a rule. Making all domain handle LANDLOCK_ACCESS_FS_REFER
>>> was may initial approach but there is two downsides:
>>> - it makes the code more complex because we still want to check that a
>>> rule allowing LANDLOCK_ACCESS_FS_REFER is legitimate according to the
>>> ruleset's handled access rights (i.e. ABI v1 != ABI v2);
>>> - it would not allow to identify if the user created a ruleset
>>> explicitely handling LANDLOCK_ACCESS_FS_REFER or not, which will be an
>>> issue to audit Landlock (not really possible right now but soon ;) ).
>>
>> I like this explanation much better!
> 
> +1 I agree.
> 
> Phrasing wise, I'd also recommend to put the summary first, for example:
> 
> This patch fixes a mis-handling of the refer right when multiple
> rulesets are layered. The expected behaviour was that an additional
> ruleset can only restrict the set of permitted operations, but in this
> particular case, it was possible to re-gain the "refer" right.
> 
> Does that sound like a reasonable summary?

Hmm, it's not exactly to regain the "refer" right because there is no 
issue when it is handled by the ruleset/layer.

I pushed this patch with some rephrasing in -next Monday: 
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/commit/?h=next&id=7e4c602a992a7cb635ae0c87f5ec2e49136f620c
I can still improve the description though. I plan to send it to Linus 
very soon.
