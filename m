Return-Path: <SRS0=88KC=QN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804BDC282C2
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 18:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D17218B0
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 18:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="A4OvrYLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfBFSSQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:18:16 -0500
Received: from sonic315-14.consmr.mail.gq1.yahoo.com ([98.137.65.38]:39989
        "EHLO sonic315-14.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727896AbfBFSSQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Feb 2019 13:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1549477095; bh=SzuAqWFof/SPnLXs+le7QnZJqwxzkFgIiE7ylVx5Kwo=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=A4OvrYLIMQ/78tlC8+Gu8RGmU31Lxst5bvt2f/qwFzFeIH/DCvDqYe/ykmbtpi8xXvBV5Aw5VHzDYm42yxGNKks1c27sQQJGml1gQaAA62wCVs53d4Cumzf5FXbWk8xDvyv+Lb6lpx+BQKFWDvl372493M3GDROb3EKf3C3WrLYbuEsigcU7psDhKZjwCnZl6MsjXFb3LipwikUyTZjJI26xhExcpZ7EZui5D+3TGRBwcv5EsDrSR3M23Rju1Tty8r4U+Bu41LBRaSyzgPZRHO0D91pb5dmFL6Jda1dQllhvU5aGHWx3k48QTD7XrL1Qq1pJKpV/WiuTcFSBE5H7kw==
X-YMail-OSG: _74fGBUVM1l.dmrLth70S80hfjba81UCf5NEUqLWMlN11Ye3I9oeZFMrNQJFacK
 IZk261lNP4ABzhA2ZFCcXdVSBTA35l8fKOAhRcA7N4U9.VvCoCDWyiAOQLYj5xm5J3M4vRli6XN6
 YuXm10iNrLGy9YT2pZbg.eXYriMmXAsl9TQ12bkeSTT7r5i91Q2YMX0O38Y6DVLda32qZRjzbEiY
 p9Zqx.JY4w4mIF.VXSkZv_zBQhvw8Rs7JZIIZ9h5R_ezF0MOJVGhY1ISNcBmGrKo55ieP8Bg5U9Z
 w2jXp2vq.3fIYF1qgH7KCoprYIZEhzyb_LjCZNSG1whbUpQxw7kP8lIYd8UwFKeTGZXt_FdlMt73
 mYrgEcf6qEvXufeoDE8d3mlFtOnn9tj30y9nbsdUvkuJS2k6CfVXhCQLk2.Ht9qelbT8HUuRa1TE
 a8dJwaaLPpchd.OlH5Gt6rdoJHhLgYUZIHwWqaxmgS8z_vzHFZXNPLpSb5VBYafYPV.pRn0KQ_ap
 PhVdI3NEtWkLcTGbqv2ADAh79y8qF0gaw804lrfi1tvcAABFHU3rp1kC6I6J2LbSINzQclFLPsT5
 cj8l7RPSbPJF0gGIXYWp.19exlgznLdCI0ji_ySdbFhse8fjvIjs9fxnQbwlLUIXLsaaVaO7e8xd
 jCjnJwPKc0U9xEjA9dt3fa.U0lzgP2ETarLrEz1nh3nNQ4Xve9JV5EcJQMaH_S62uWWpAD9F3_0d
 s.Dh5xzGXh.u17_XI8S126ZSC079Dx3bC9Tq95Uc6DF7fBqyhva_fGczlyo8_tP4pkY4cuXeGhQ5
 IvbTQFPXJm0JeyYk4CRrNY9f_SIadwhpUMXksI1ltXosgQQG.K38IQnocuL4CyoMDSnZJTbsRHj8
 8tvqSsLDzt8dSlVp2PhzF76T0e9xFAb_LNr3novbfiOw2vgEujQJceumr2MppY3qMgGh8HuCem2f
 sMo7XqkYzTxhexVJn73OBT2mOVwQLx1vG8MHs1SLCVLGAneS0NKdPZU3a5hV5Ab7R1AnjzRTXuxk
 XgB00S6rYxOv6WbYBOayf4EwN5BAYrx0rSMadGNxgY1ziJaIngQKFBVfjOnQsEOkEMyDVdozjK4t
 wPH7pIQdU7UUdBw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Wed, 6 Feb 2019 18:18:15 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp422.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 89ef58291dd0a92b7733b19cd53f1fd5;
          Wed, 06 Feb 2019 18:18:14 +0000 (UTC)
Subject: Re: New LSM hooks
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     LSM <linux-security-module@vger.kernel.org>
References: <61766e1d-496e-6a7d-d4b8-52e2c99a78c3@schaufler-ca.com>
 <CAHC9VhQoruL70fUScgYH8WGDP2Hc1=G2j_fjoS24VMUm3xA=aQ@mail.gmail.com>
 <a852b633-a777-c353-85cd-c5a1545b4ef9@schaufler-ca.com>
 <CAHC9VhQ6p=LoEN6Rqze48FrVDsX0mfXHY4BvEaxU97w1azP4YQ@mail.gmail.com>
 <alpine.LRH.2.21.1902061207010.19811@namei.org>
 <84c96e67-6668-b954-0a6b-2bccb00c124c@tycho.nsa.gov>
 <ca70d18c-3576-fce9-a65b-faf585a536b2@schaufler-ca.com>
 <bd373344-fdfe-ff58-ff06-3b36df623648@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <9042828c-841d-6c19-e102-12358317c79a@schaufler-ca.com>
Date:   Wed, 6 Feb 2019 10:18:12 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <bd373344-fdfe-ff58-ff06-3b36df623648@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/6/2019 9:44 AM, Stephen Smalley wrote:
> On 2/6/19 12:24 PM, Casey Schaufler wrote:
>> On 2/6/2019 5:20 AM, Stephen Smalley wrote:
>>> On 2/5/19 8:11 PM, James Morris wrote:
>>>> On Tue, 5 Feb 2019, Paul Moore wrote:
>>>>
>>>>> I believe that will always be a problem, no matter what we do.  The
>>>>> point I was trying to make was that everyone, especially the
>>>>> maintainers, need to watch for this when patches are posted and make
>>>>> sure the patch author posts to the LSM list in addition to any of the
>>>>> relevant LSM specific lists.
>>>>
>>>> Right, and there is no way a new LSM hook should ever be added to the
>>>> kernel without review and ack/signoffs from folks on the LSM list
>>>> (especially those who are maintainers of in-tree LSMs).
>>>>
>>>> Casey, do you have any examples of this happening?
>>>
>>> Most of the times I've seen that it has come from vfs folks or other subsystems as part of some major reworking of that subsystem rather than from security module developers, e.g. the mount hooks overhaul.
>>
>> David Howells did contact me directly on the mount hook
>> changes well in advance. I'm more concerned with special
>> purpose hooks like we have for binder, kernfs, nfs, tun,
>> Infiniband and bpf. I'm not saying that we never need to
>> provide hooks with a single user, but you do have to
>> wonder about security_ismaclabel().
>
> binder is an IPC mechanism, so just like all the other IPC mechanisms, we needed hooks to mediate it.  No different than having hooks for System V IPC or Unix sockets. If LSM were a proper abstraction layer like the Flask architecture or even the BSD MAC framework, then we'd have some general purpose access control interface with a small number of entrypoints to invoke, but instead we just push all of that behind the LSM interface.  I wasn't an advocate for the LSM approach at the time but it is what was adopted and we have to live with it.

I didn't get what I wanted, either.

>
> kernfs doesn't follow the usual rules for inode setup, so we have to play by its rules. Not our choice to make, and there is a reason why kernfs is the way it is.

I don't believe that kernfs has to be as unusual as it is,
and should never have been included without working LSM
integration.

>
> NFSv4.2 chose to support MAC labels as a first class citizen rather than just xattrs (and there was a reason for that too), so we need a different path for getting and setting those labels.

And I *still* disagree with those reasons.

>
> And so on for tun, infiniband, and bpf.  Remember that LSM by design does nothing more than expose the kernel objects and operations to the security modules and leaves it up to the module writer to do everything else.
