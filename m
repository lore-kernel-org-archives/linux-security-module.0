Return-Path: <SRS0=Vtm6=VO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4DFC76192
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Jul 2019 23:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA0321019
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Jul 2019 23:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZLlJFwaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfGQXCW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 17 Jul 2019 19:02:22 -0400
Received: from sonic314-22.consmr.mail.bf2.yahoo.com ([74.6.132.196]:34036
        "EHLO sonic314-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727106AbfGQXCW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 Jul 2019 19:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1563404540; bh=q7E0xITt7RksiuSIhV2dxvFsSmhDxM3OJ5+cCYgIOow=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ZLlJFwaqyoGuTExuDSDwMoxMsojGgQNeOgb50rYwmyFNcZrBAR4RRTX9rV1zNoKKsSoXXcytODos5P1KESBru8Tl51wBdLrn2sY54iFMRHIZxIgEBAnpe7wDaBeiTjhn5ijdjVXfugl5ZGrPdm8AUtt8AaPx3/M7xKO+flemNw9nc1RpUIJbHr06L2L2f6cxo3B4xCkpcidTXhTxjv9FTI+ZIR4VtQNxHT5mAGl0p1qGWLUPva/Kd4Ut1ZQEEyWyOC8t1RZ38l8V9b5YArX4BEU/M5DdoHYhcVl8rN4o9JgNEUKnIFXrxbJC2zkt3nugMjJtHrE2UTF6e2b2HV5A2g==
X-YMail-OSG: AZqrjzoVM1mLh0fNzdQmiLZ6HGmIgrl.r0U8Gx6ue4i8okSH41QCsmsbZAE_JsX
 .jXg_UH4p1kv66gF7RKPdlCQVSjYcyyk9RXLAeU7zDdvi3dMq5LKXJ4IPtiI5tOyQJ0G14kv7NLO
 FHBi1KHsiKiXfzXdsA1gNaTXdytwqxE0H6TCiAD4jtTOtl0J3QmBza2vmiBQ0tkaYoUYRnjYXPIp
 oBeXyZdrnPcrGfFPwP9UjCJOjx6lPT7LVm32RY3N0fZHsrgUaCPj0Oin6EMxB2FbvvDYWSfDGUt6
 0wrl6B0lVBXmF5XQKZYJo99PtEjO22FcOWh9fx36yt9OocrmfP9ei5l5izdH0zBqtNWOl9VXIgGR
 albNr.XbyiyUSV_YJ0HUoSuEQ0ZhHe4cEeF1b37ihSu5oYl9lZ5o_h3HU5LkD.Oco0Q4aH9j29jD
 urg9k8aakl_nFq2naT2yZXlJbJazWkZ8R0C9Nf2NFO4eUmLsq1GtAgLptnbobuaHVvHA03o.bIUW
 waXmKmE4nFfsBxK.xfXUYOljd8J0du6ZXVARM2yr9.ZvbIR0Gp.zvyA6TKBS3DNmUS6auDZpQMcH
 WzHA_H5ZPfVZwquP5m95c4I7V88UnxWtit.CF1F_2cxvE4EB9QumAJIPM0RPM2tOPXhPcsXKfUIy
 1a.xYkaQNW7nrUuA5iHPTPT0jGKRjgcmdlgNme0LsJpOfnUxltprgDtyehYoKUoxD32o.4PzCzKH
 dU2vtivHxurKj2nsEBwyyxxEqhGtJAzsuI6C4iMoQ1.da0EfVp82EMRgKRHoFjax.DlnPihwJgF6
 6wG7m75qpknXj.oDpWVxXG8nfO6ZSlln_l0E6vEVWrqJymYd.2q696CBMd4A5sXRJlbUqtoRy7Sd
 EZniT8cmnzMm9j0sBCoAI9NBRMk4dx2AUJiFKeE2JULnfp3VXVHIrXpoFn8LhmSO5rFHgySgPsAp
 LO_yH4DTWnFmPwccv3Xck2muG5C2jxDcDcBODNBO3I7m83gOfaXzEIRy2wm3p5wbWs4bXOpzM0AT
 1KJbYvAEUPZmYgSBtQc6GRxobT8Q8Za12Lnayb0hG0baALlIncPLGLLNzdvRChETUOYcU6ymR7Ac
 q3L5EA0sY9UxI4vxfzeKMn.KIq.6J65Rke_68v2QE.V85NF7TEVFrVsDuB28Kf1JRXltcsMGZCHv
 PF2C5.BzkbhmmZnijpor4Om.VXZrCDtdZuh4z9uA1kViTRRrvssv1vNplwlsMKAepKUkTsuXvb67
 Ij4A.v2mmhPoLS4LtNlbtFBxvdS._
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Wed, 17 Jul 2019 23:02:20 +0000
Received: by smtp427.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 02a50f2dbf8f00fd54f8af302cb9df4b;
          Wed, 17 Jul 2019 23:02:16 +0000 (UTC)
Subject: Re: Preferred subj= with multiple LSMs
To:     Paul Moore <paul@paul-moore.com>
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
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <f375c23c-29e6-dc98-d71c-328db91117bc@schaufler-ca.com>
Date:   Wed, 17 Jul 2019 16:02:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQS9We1TNqRfuR_E-kV4aZddx9euaiv5Gzd5B5AkiDAUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/17/2019 9:23 AM, Paul Moore wrote:
> On Wed, Jul 17, 2019 at 11:49 AM Casey Schaufler <casey@schaufler-ca.co=
m> wrote:
>> On 7/17/2019 5:14 AM, Paul Moore wrote:
>>> On Tue, Jul 16, 2019 at 7:47 PM Casey Schaufler <casey@schaufler-ca.c=
om> wrote:
>>>> On 7/16/2019 4:13 PM, Paul Moore wrote:
>>>>> On Tue, Jul 16, 2019 at 6:18 PM Casey Schaufler <casey@schaufler-ca=
=2Ecom> wrote:
>>>>>> It sounds as if some variant of the Hideous format:
>>>>>>
>>>>>>         subj=3Dselinux=3D'a:b:c:d',apparmor=3D'z'
>>>>>>         subj=3Dselinux/a:b:c:d/apparmor/z
>>>>>>         subj=3D(selinux)a:b:c:d/(apparmor)z
>>>>>>
>>>>>> would meet Steve's searchability requirements, but with significan=
t
>>>>>> parsing performance penalties.
>>>>> I think "hideous format" sums it up nicely.  Whatever we choose her=
e
>>>>> we are likely going to be stuck with for some time and I'm near to
>>>>> 100% that multiplexing the labels onto a single field is going to b=
e a
>>>>> disaster.
>>>> If the requirement is that subj=3D be searchable I don't see much of=

>>>> an alternative to a Hideous format. If we can get past that, and say=

>>>> that all subj_* have to be searchable we can avoid that set of issue=
s.
>>>> Instead of:
>>>>
>>>>         s =3D strstr(source, "subj=3D")
>>>>         search_after_subj(s, ...);
>>> This example does a lot of hand waving in search_after_subj(...)
>>> regarding parsing the multiplexed LSM label.  Unless we restrict the
>>> LSM label formats (which seems both wrong, and too late IMHO)
>> I don't think it's too late, and I think it would be healthy
>> to restrict LSM "contexts" to character sets that make command
>> line specification possible. Embedded newlines? Ewwww.
> That would imply that the delimiter you would choose for the
> multiplexed approach would be something odd (I think you suggested
> 0x02, or similar, earlier) which would likely require the multiplexed
> subj field to become a hex encoded field which would be very
> unfortunate in my opinion and would technically break with the current
> subj/obj field format spec.  Picking a normal-ish delimiter, and
> restricting its use by LSMs seems wrong to me.

Just say "no" to hex encoding! BTW, keys are not hex encoded.

We've never had to think about having general rules on
what security modules do before, because with only one
active each could do whatever it wanted without fear of
conflict. If there is already a character that none of
the existing modules use, how would it be wrong to
reserve it?

Smack disallows the four characters '"/\ because quoting
is too important to ignore and the likelyhood that someone
would confuse labels with paths seemed great. I sniffed
around a little, but couldn't find the sets for SELinux or
AppArmor.

> It's also worth noting that if you were to move subj/obj to hex
> encoded fields, in addition to causing a backwards compatibility
> problem, you completely kill the ability to look at the raw log data
> and make sense of the fields ... well, unless you can do the ascii hex
> conversion in your head on the fly.

Agreed, even though there was a time when I could do
hex decoding in both ASCII and EBCDIC on the fly.

>>>  we have
>>> a parsing nightmare; can you write a safe multiplexed LSM label parse=
r
>>> without knowledge of each LSM label format?  Can you do that for each=

>>> LSM without knowing their loaded policy?  What happens when the polic=
y
>>> and/or label format changes?  What happens in a few years when anothe=
r
>>> LSM is added to the kernel?
>> I was intentionally hand-wavy because of those very issues.
> Then you should already realize why this is a terrible idea ;)

Unfortunately, I'm facing two options, one of which the
kernel maintainer thinks is a bad idea and the other the
user space maintainer thinks is a bad idea. Plus, I'm not
very happy with either, either.

>> Steve says that parsing is limited to "strstr()", so looking for
>> ":s7:" in the subject should work just as well with a Hideous
>> format as it does today, with the exception of false positives
>> where LSMs have label string overlaps.
> Today when you go to search through your audit log you know that a
> single LSM is providing subj labels, and you also know which LSM that
> happens to be, so searching on a given string, or substring, is easy
> and generally safe.  In a multiplexed approach this becomes much more
> difficult, and depending on the search being done it could be
> misleading, perhaps even dangerous with complicated searches that
> exclude label substrings.

I'm aware of this issue, which is one of the reasons I'm
asking about the preferred approach.

> It's important to remember that Steve's strstr() comment only reflects
> his set of userspace tools.  When you start talking about log
> aggregation and analytics, it seems very likely that there are other
> tools in use, likely with their own parsers that do much more
> complicated searches than a simple strstr() call.

Point. But long term, they'll have to be updated to accommodate
whatever we decide on. Which makes the "simple" case, where one
security module is in use all the more important.

>> Where is the need to use a module specific label parser coming
>> from? Does the audit code parse SELinux contexts now?
> If you can't pick a "safe" delimiter that isn't included in any of the
> LSM label formats, how else do you know how to parse the multiplexed
> mess?

Ah, but if we can ...

>>>> we have
>>>>
>>>>         s =3D source
>>>>         for (i =3D 0; i < lsm_slots ; i++) {
>>>>                 s =3D strstr(s, "subj_")
>>>>                 if (!s)
>>>>                         break;
>>>>                 s =3D search_after_subj_(s, lsm_slot_name[i], ...)
>>> The hand waving here in search_after_subj_(...) is much less;
>>> essentially you just match "subj_X" and then you can take the field
>>> value as the LSM's label without having to know the format, the polic=
y
>>> loaded, etc.  It is both safer and doesn't require knowledge of the
>>> LSMs (the LSM "name" can be specified as a parameter to the search
>>> tool).
>> You can do that with the Hideous format as well. I wouldn't
>> say which would be easier without delving into the audit user
>> space.
> No, you can't.  You still need to parse the multiplexed mess, that's
> the problem.

You move the parsing problem to the record, where you have to
look for subj_selinux=3D instead of having the parsing problem in
the subj=3D field, where you look for something like selinux=3D
within the field. Neither looks like the work of an afternoon to
get right.

It probably looks like I'm arguing for the Hideous format option.
That would require less work and code disruption, so it is tempting
to push for it. But I would have to know the user space side a
whole lot better than I do to feel good about pushing anything that
isn't obviously a good choice. I kind of prefer Paul's "subj=3D?"
approach, but as it's harder, I don't want to spend too much time
on it if it gets me a big, juicy, well deserved NAK.


