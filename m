Return-Path: <SRS0=88KC=QN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876ECC169C4
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 17:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541A32081B
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 17:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IPKS5N0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfBFRYX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:24:23 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:45324
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726727AbfBFRYX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Feb 2019 12:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1549473862; bh=jb2klyamtfjhprb8FJdgfn/qxaDGxU5jpP19IcxwfKQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=IPKS5N0t1NBIwFDGmJ35ZP7ek1GcoVCAx6XNBK6pjdiQeP96t0aM/6r0nAj/VPaHkKXohMFBZoFJOm3Jz1lN29qN7f9dnuCeaRIdTc13hGv1ndeLw3XAcMVSpeewlOY4crajt7FuLrkV1szA+DG09MrQpUinBi0VIoLJI6eseZQIAI1hdTwjlFmDl31xtJ6iXNCZtlxpD8eVkfXSfMXByIywx5vPP7Lt2dBe7MvYD5AXo/UAKLolLv3ZpMquUS4MPmoRkkT99CLx8an5suWfWrHNWp17B7l4e9Mn71ea/M3EOyEaYWhFDVuY701qy91FgLvtYdyRZcbzQS96I/GzLg==
X-YMail-OSG: VbtF4rwVM1lgW4Gs0lhiQGpmoFeJSvL_yqGhZMZYB3w3ErscBmRM5vLvALkB9yJ
 Ml3DoP5NivZ9p3tWRx0_xWfVM_968Zz9HOP5qulD9ACgSkw1MNujoQmc8EF8X9EyYNye6k2ei5fL
 ImERPi7lGYRAcBxFwy9HqEC6x_iUlYiXtsaxPry9uQBPUAyEgQpujs2eJJS8G6SfkSz.HUEj5egk
 jLKQlZLxqbIbAFYRtopnpT7rw.RL8LFdXwwdTl_.Iprz3xNaxpiMh1FM65FwkjGPWGdCbmr.3E7i
 v7kZbXS30mpWMqsVBsJT_WaNuDZUKW43twzHFBnZDAO81GL3wz1JgBqgXnZM_cxCylvbrAR1vhX.
 4sVrqNB2PslNtUuNG2l9WfdHGw16zbCuEfmx707M0rHT4iKmet.OOD0nvjBC16PFx7ryw8t.pz4.
 Xx5GDEuVbT8sl2AQyx8.rG7d2Vj.o8iIv5PkU18GIlF3qoY1gjUoYhPGPmzUjhU5Rsw.Y9og.aSp
 pgzeyQXjwpJ6l5tWzaz8jwEAd34Ne_RyaBb4BFbCJ9cyj0.6.Rq7WdZ5_o.juEirXGiR0NxObKUB
 yO4hJhyA6XDBQHfZgy5Bnzwc4U1BYmgiYpZ0HJ93nyUzbRaxNfZzq_qDfuWZk1qX329Jm_NDW0bP
 SupeZUt7HgUw0Zg2jC6VrauFpAg212nwMIYZ5Wa95LtI9htt2yzxrObi7BFFUIiFmpn7eeYIwis5
 qz51.eUiHv5U0xw3vVb1eaSrJ5_scq6FDpi02V4ti.yBTfNWDSynSUUfPC2yaCsPFXtBWid90.5W
 JfobhQzx_4_GBhVTjrZbGDSTiYxjo2xYRkTmF7MsndB4vIT81270pOFSzmsIAq0XKGiF2lTHyXx_
 eIhMPab4rYHeJWrTqanimLXxaJAuNgGacKUKNZjnSGNSyn2PIf4wsf3JpiecVTvuHbQaUHoDGU5i
 Bka0zyQjjLMZkock9jHU8hBOgtSFYCvriDriNeLCS5lThbMP1BP3zIAky_gSQzb0l1Ey5pEq45mp
 MESvM96MS791xulTYzFCat2FC2PrhWlRZHcTvsC.E1Bd5jgGaRgbA2RNoFDi9duxiJY6AAb5U0hG
 hUwnYpJvSPDNFw1x5M3s-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Wed, 6 Feb 2019 17:24:22 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp427.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4fa1d8b9a17bb3fe522f2a99692f23cf;
          Wed, 06 Feb 2019 17:24:21 +0000 (UTC)
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
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ca70d18c-3576-fce9-a65b-faf585a536b2@schaufler-ca.com>
Date:   Wed, 6 Feb 2019 09:24:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <84c96e67-6668-b954-0a6b-2bccb00c124c@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/6/2019 5:20 AM, Stephen Smalley wrote:
> On 2/5/19 8:11 PM, James Morris wrote:
>> On Tue, 5 Feb 2019, Paul Moore wrote:
>>
>>> I believe that will always be a problem, no matter what we do.  The
>>> point I was trying to make was that everyone, especially the
>>> maintainers, need to watch for this when patches are posted and make
>>> sure the patch author posts to the LSM list in addition to any of the
>>> relevant LSM specific lists.
>>
>> Right, and there is no way a new LSM hook should ever be added to the
>> kernel without review and ack/signoffs from folks on the LSM list
>> (especially those who are maintainers of in-tree LSMs).
>>
>> Casey, do you have any examples of this happening?
>
> Most of the times I've seen that it has come from vfs folks or other subsystems as part of some major reworking of that subsystem rather than from security module developers, e.g. the mount hooks overhaul.

David Howells did contact me directly on the mount hook
changes well in advance. I'm more concerned with special
purpose hooks like we have for binder, kernfs, nfs, tun,
Infiniband and bpf. I'm not saying that we never need to
provide hooks with a single user, but you do have to
wonder about security_ismaclabel().

