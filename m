Return-Path: <SRS0=Cnd7=VT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53600C76190
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Jul 2019 22:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA0521951
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Jul 2019 22:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oHlUuhSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfGVWBm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:01:42 -0400
Received: from sonic316-13.consmr.mail.gq1.yahoo.com ([98.137.69.37]:44815
        "EHLO sonic316-13.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732780AbfGVWBj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Jul 2019 18:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1563832897; bh=I9bcQNpfoJEO3iI8jKIjCEF2Rv3i5NtalUR5Ip82M7w=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=oHlUuhSXHRrcviYxNa8p1VaOVhobsk5NScPs+oeuH7T+ehDPhN1/M0rFtsRQ2AByn3fCnl5HmkgPuO0s/zxpIlfPdge2uHsHHROEjlEwFny2MrOcg1q7oQ/5mmBxHN5+Mw5wA893zCketTPm7xBM9vwVLGmtEb+M+FmcmmNcICHuosAYHl+ObDSKPLSGtJqNuzfUxre3jrNpkSHaPnWC1EeIapvLP2fnKLb9e7J/avSb+/58FEiLq8R5YMYsD/WVXIRLXZ9nfMEiAc1PUYmvUdAs6rEdqiAGt3Cd5u09gBwMqvNNXs4sHojcDHUQo3t6GGn1n/b08xWRCl0uVesBLw==
X-YMail-OSG: Ir8t37IVM1lgJCz1CbXTdzmQX_LpFf2Nq3B_ILrm3C60.Ub9D3n2FdG.vIpA.FD
 HOOaaVDo5bzIp_6_WKBCraipXpd_fi17MEiAqXKTY1zz62SRAxvMHJeOZlwnIMvtm7KcqkqnaZb0
 jrriG009T9eOuOuiZI8LDub2A4Q.Qydd3wMHcSYscJwYKUnbizacLKhB0IUhXLYrk.cOXMUo1Nx7
 _4ofYtgtW8P_WAM1mvej7svcVSRpGwYgrxQP2ARIRQJlWB9OJRT7RQcsxY8UPoAT_muKyak_Xscq
 oka_v4CqZdD7PRmkFmhDY0Rb9U0a5lXU4._zWR8bi8skuYC5wJPimv9LODlP9WRB9UjNjkvblWSX
 uiQLVAEwxBYUBUTBfCkK3o1VAkx0KQcjgEqG7fufL08uQj1QXB4_1hvLvyK0k22T0MEMuAEcXL2n
 8aXZfhPhds9ZXE2OehOedrjrlo_EWlBh4O.AQLqaPZEpu0O026stqd5VPdAgLQvT0lZpRzQ7Bq_0
 me.j7FqEq7W0B5YOx3bTf7kuEFVSgwXRAtohuER8RHcXvJMVxuOiEKCUeQMLx8CufBP9CVfMQjIu
 aS3D4TEWJpt0lya_LdPjZz24LDURQtRqTMcwhVZntvKPI9t2yY0yZYyZhULqTHwXAu1gI4D4vF_q
 5Qsvd2qo9VfJrJTvTo0087dXbAeD3jHZ8TWcV61abOzwdzOLuuFZmjrSfkDSfXLfEeQ_lyUSiRhp
 adPlU3cMm88hdciga9CKA8U7NrOF0YWwEB0jkjQ6H41nNkCIGNSDJCFBHR1dXInhJ_FlLBZjyQX5
 A0Rzu9jQDGLL_2W7lbKfRdrQQbiD0eeSuHghfO0PNnjseoAADqyN0CtUgSHYLjD7I0nz1GBd9tUd
 w0l.dXotLR60FmDUcymH25DZ1K6Gb7cTQ4B_zsLbRN0p5P3PZJ5dD2azxyQt8mbn._7fa_jrnQJ5
 vGc8y9_fD3KoLApvF_PDdAtOYV4thYI67zXXCpnT_h7PDrIUbXQ0bP9Lzo342135p6Q8zAzzeoF_
 smGc9GTHGwxC3iD0GWSgnOVRr9SMjKz0Vf2c0MWLFGyXx9qK7JuYLnT1K1vl7Wfqd9YeenplPjGj
 VnVwiLglcFRjRtHwXj9UgOieizNYIUni0qCET9LDiIw0xlakKt_vhLt2X60C9S0Kvb1_GwANtShy
 o01ORlhNg2742qpBd08iiuf_lzW5nE5DCsI9bjjGAO4vnX.axjAY4fPx5JjsIv976ucExHfLmv7b
 UlULzhKPqzM2OJA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Mon, 22 Jul 2019 22:01:37 +0000
Received: by smtp422.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a55ac94f9e43f945e423f906269ce5f2;
          Mon, 22 Jul 2019 22:01:35 +0000 (UTC)
Subject: Re: Preferred subj= with multiple LSMs
To:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>
Cc:     Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, casey@schaufler-ca.com
References: <f824828c-5c9d-b91e-5cec-70ee7a45e760@schaufler-ca.com>
 <d1a237d3-4b72-48b0-27d6-fb168354ad31@schaufler-ca.com>
 <CAHC9VhTQLihNQ1iGjJB=LAn=C6BQokFsjsRcj8O_O9AjqQ7HBg@mail.gmail.com>
 <2517266.eHZzEmjMsX@x2>
 <27e2c710-efe6-d9cd-d4f9-bc217df5ede3@schaufler-ca.com>
 <CAHC9VhTpcnyGg5j3b6Z7Yi0Ob01JETRiBmz1AuLqPWqP9tEAnA@mail.gmail.com>
 <5ea2a25b-364f-3c30-79c6-cfb18515d7ba@schaufler-ca.com>
 <CAHC9VhQ9MSh5zCkhMja4r9j0RT952LwKSaG5dR-BqXzXrtEAUw@mail.gmail.com>
 <e9cf875a-0d0f-a56f-71dd-c22c67bdcc2d@schaufler-ca.com>
 <CAHC9VhQS9We1TNqRfuR_E-kV4aZddx9euaiv5Gzd5B5AkiDAUQ@mail.gmail.com>
 <f375c23c-29e6-dc98-d71c-328db91117bc@schaufler-ca.com>
 <CAHC9VhTf0yYDZBxOtfv2E5=GtrBYonoqr46hyBy7qdNdjVLoVg@mail.gmail.com>
 <alpine.LRH.2.21.1907230649460.18217@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <ca22ea45-3f3b-4f79-8d77-7528877b8b36@schaufler-ca.com>
Date:   Mon, 22 Jul 2019 15:01:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1907230649460.18217@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/22/2019 1:50 PM, James Morris wrote:
> On Fri, 19 Jul 2019, Paul Moore wrote:
>
>>> We've never had to think about having general rules on
>>> what security modules do before, because with only one
>>> active each could do whatever it wanted without fear of
>>> conflict. If there is already a character that none of
>>> the existing modules use, how would it be wrong to
>>> reserve it?
>> "We've never had to think about having general rules on what security
>> modules do before..."
>>
>> We famously haven't imposed restrictions on the label format before
>> now, and this seems like a pretty poor reason to start.
> Agreed.

In a follow on thread

https://www.spinics.net/lists/linux-security-module/msg29996.html

we've been discussing the needs of dbus-daemon in a multiple LSM
environment. I suggest that if supporting dbus well is assisted by
making reasonable restrictions on what constitutes a valid LSM
"context" that we have a good reason. While there are ways to
present groups of arbitrary hunks of data, why would we want to?


