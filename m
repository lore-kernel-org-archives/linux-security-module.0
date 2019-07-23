Return-Path: <SRS0=ig/x=VU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F2FC7618F
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jul 2019 00:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7A12199C
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jul 2019 00:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HCHeFRAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731235AbfGWALS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Jul 2019 20:11:18 -0400
Received: from sonic308-14.consmr.mail.gq1.yahoo.com ([98.137.68.38]:36987
        "EHLO sonic308-14.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726283AbfGWALS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Jul 2019 20:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1563840676; bh=DBV7/x3xoW7QTC3hwriPXJs6iZdKAX+urpRThTirHEU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=HCHeFRAxYN6WH22rEPudEj7YxAkFXqn2/24LQdhv65F9UbGgEpBjON0AXgGWgjNelDH/Qb23jy0NQhwJyouP85f5jVfWwTmILt1FXvQXZGsp4L2dLYX7/EpKGnbh3Zf8Ehpj0q3i2E4RPpv/I4dEDcL0HPJAFkVoYVSalGZL9yB+GLPd/aj6cg8eB1o8WMItumfUpsPr6R+/h0jk6Q99n9JP1BLoPgbS4QP9+C6owJME/Hx9GprY6PzKRIHXBKf+l7XjGDaTJCjNVYWG0N9KAh33ij9Y34qwZ6IWpXn/V3WDQu2QOB58E1ZofUq7nbjHDP3FVlXgQuSCfbjvJPppbg==
X-YMail-OSG: y.mn210VM1moypHHlL8H9hwSNTZVuELVEumtFU4XWQtSeimdTREDIaHyhsfVu6H
 92fRSLZB5w7.kNVumOzf0HnnDd1.F967QvurCdWFgJpg6u_l5QXNUARbK0qgcfMZIRxujiKst0rR
 FBq5ion0r1WRN1sf2yPFP9N_vi.1.JvISwC5CG7ZxF9On._casHqmtzkuUOsZzxh5KVEQoJix9sO
 HXcqZzmlxs2UbZIzR9GDjGispFmIAawgCOrpLxff4sNR1BDY0Qu.b_d0vYTygGQ4es27O64l9sPK
 jsAryGJmw5l0AmdihE3HeruTQ1dmh9z.9fPcAcfkOPp25hJzmiXEytG38rsVWPGIdh92y41h9r8D
 hgwkZFMs9DZpqW.s9UVEU6PZpOpd_TM.dTufvCK6IvOGu5uKmpckGEhZpdul.k3dJwa1ag6yqboA
 ohhHCw5oJ4s2aR2qlYxpUc5nKWD0oG549eQhvffH6VgS7Q8Vbi8x2yhBSwH6ZD_CxkbP1xDJ1LU0
 lgs7BrsUDCM36AJ88gcCIqLp4r_UM_gSeZPUnkWV3xgdEGVJPxdnvcToFDutBSWVZfImOZAkjl.g
 EdLbOyL4VRuDWt6eOamR2i0BI4bSxLcZCzGe0.0fYjRHhwtPfox.c5QhiU1CsWiA6eaQ81mflej5
 FUH70yA96snWFQQlfbTOqjus16EOD5tN5WKKc9PAVyYWrcOe1tfh5OWTMrR8sTgnP7MYr_25fkhJ
 JmWfALNyJn.N_lw6VSL0kIU636mwUoiinYt8tXWFwRPslse6.caVw3T5hzYQjEgXUtIe89AxEVTH
 21USXr8fAF.AXR6MAAE7ql78rblofVJK3K_Zufx6KyH1gBI.iK.sloxkZb1TqOGWaiT7qE0ud9ab
 E1zdv4Wo1jN.rkVA7VTiTsdEjQZS4t7R.7WcFqnB2D2MfQpiiZnP7zOJKg4BeQXMr6jrSFjq.81U
 sftGHKs6pFBHW3w_qPqN6G2_q.L.zvVrTeI5ZqjH.BZBlsnX8UBW9JkUpn9oojnZ_6h8TKGr6cop
 Xd8OCqXmxb9O8rt1wk7MOuVlSOglhLO9z1ecexzpEbzO454eo3dpjvg28xXuVKZTHjr4LmeTRXS0
 8hsWehBiqzMLUja4MOB2RBsk4QT8In2l6yQbDHBItDvq59nVboqyT_0qz8YaVGyXUaX9iV4u82Eo
 IDq6ApYy.VNo.n3dPB_w1lD83SIIqYMOW8v68ySBH3MeQdM6_omdn22JW.6ecuWTVyhI3sXrqklG
 EgisT
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Tue, 23 Jul 2019 00:11:16 +0000
Received: by smtp408.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 56845b65d4aaa757f603e99d53fc3c4c;
          Tue, 23 Jul 2019 00:11:12 +0000 (UTC)
Subject: Re: Preferred subj= with multiple LSMs
To:     Paul Moore <paul@paul-moore.com>
Cc:     James Morris <jmorris@namei.org>, Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Simon McVittie <smcv@collabora.com>, casey@schaufler-ca.com
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
 <ca22ea45-3f3b-4f79-8d77-7528877b8b36@schaufler-ca.com>
 <CAHC9VhSbg7BxPSA4NkQV3_1zx6cj3ej25e6fJ2FBWX9fU104rg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <7bf96896-8a6b-bec7-3bbe-3b5dad74e1f8@schaufler-ca.com>
Date:   Mon, 22 Jul 2019 17:11:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSbg7BxPSA4NkQV3_1zx6cj3ej25e6fJ2FBWX9fU104rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/22/2019 3:30 PM, Paul Moore wrote:
> On Mon, Jul 22, 2019 at 6:01 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> On 7/22/2019 1:50 PM, James Morris wrote:
>>> On Fri, 19 Jul 2019, Paul Moore wrote:
>>>
>>>>> We've never had to think about having general rules on
>>>>> what security modules do before, because with only one
>>>>> active each could do whatever it wanted without fear of
>>>>> conflict. If there is already a character that none of
>>>>> the existing modules use, how would it be wrong to
>>>>> reserve it?
>>>> "We've never had to think about having general rules on what securit=
y
>>>> modules do before..."
>>>>
>>>> We famously haven't imposed restrictions on the label format before
>>>> now, and this seems like a pretty poor reason to start.
>>> Agreed.
>> In a follow on thread
>>
>> https://www.spinics.net/lists/linux-security-module/msg29996.html
>>
>> we've been discussing the needs of dbus-daemon in a multiple LSM
>> environment. I suggest that if supporting dbus well is assisted by
>> making reasonable restrictions on what constitutes a valid LSM
>> "context" that we have a good reason. While there are ways to
>> present groups of arbitrary hunks of data, why would we want to?
> I continue to believe that restrictions on the label format are a bad
> idea, and I further believe that multiplexing the labels is going to
> be a major problem that will haunt us for many, many years.  If we are
> going to support multiple simultaneous LSMs I think we need to find a
> way to represent those labels independently.

Let's review the bidding:

Audit wants to maintain backward compatibility while also getting
the information about multiple subject and object labels. The current
proposal:

	... subj=3Da:b:c:d \
	... obj=3De:f:g:h obj_selinux=3De:f:g:h obj_mumble=3DCrivens \
	... subj_selinux=3Da:b:c:d subj_mumble=3DFeegle \
	...

where obj_<lsm> and subj_<lsm> are only provided if there's more than
one active "display" LSM.

Dbus wants an atomic fetch of the security attributes from a socket
and from a /proc entry. We don't want to break compatibility, so new
interfaces are provided:

	SO_PEERCONTEXT		- packet label in the "Hideous" format
	/proc/.../attr/context	- process label in the "Hideous" format

Legacy programs want the security attributes from a socket
and from a /proc entry. Since they don't know how to differentiate
which security module is active, these are controlled by the
"display", which defaults to the first module loaded that provides
a secid_to_secctx() hook. (not quite the definition, but close enough)

=C2=A0	SO_PEERSEC		- "display" LSM packet label in module native format
	/proc/.../attr/display	- set/get the "display" value
	/proc/.../attr/current	- "display" LSM process label in module native fo=
rmat
	/proc/.../attr/smack/current - Smack process label in module native form=
at

A classic Android, Tizen, Fedora or Ubuntu system will continue to use th=
ese
interfaces and see no difference in behavior.

A system that really wants to use multiple "display"ing  modules will
have the same issues that dbus has, and will likely convert to the new,
"hideous" interfaces, especially if a liblsm (NOT libsecurity!) is
provided.


