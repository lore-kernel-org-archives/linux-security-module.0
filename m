Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF099EB64DC
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Jul 2023 17:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjGRRUy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Jul 2023 13:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjGRRUy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Jul 2023 13:20:54 -0400
Received: from sonic314-26.consmr.mail.ne1.yahoo.com (sonic314-26.consmr.mail.ne1.yahoo.com [66.163.189.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE9ABE
        for <linux-security-module@vger.kernel.org>; Tue, 18 Jul 2023 10:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689700848; bh=upHYKSTcePxr0I5wkvhGFtHeOhwH9YOTXmcjLRPgqHQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=DkPosHh5RP+9WESV4jZb5B8adc9ryy18NTsRJXpX5s1BCkqXn/oXgyCtQtcju86VZWF7UvGaoWlB2L0bLOrhCiCNozFV6JlodEDFC4e/BEij4Hr2dO1UBhEXaMm0I/575doUWw0+1t5ILDm5sPHCjohkkBuo3kITYFK7mS8r2Tzuno8E8vUhJDfVdavTPoWFM68MufjXydgszXw7GELZIYXmdeXlJw1Q8nfEkwV67x/ReDeli5bOoucSIEX/PAwqI8J5Z+EMOSow1UNpB49m5n03D3cNkofZJYeWWQtBhHQdhbXx+70qUeMH8L1PS1Kiz/28LbaZeMXgJJ6rM6yX+g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689700848; bh=8bxVvAuyDZNhyIBI7xkvwRXCChbQZ27vrWVsfO4tOT9=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=cXixY3whp1ZAG4O8hceROpK5VkRHXAe7+xRjFlV9EEATokwg0qyblrGi1vLuwQlB3gAtwB5VqirUIRaP3LwDHc5wJPR3vN5A2IdCyNgoTz7T+ap31Ot00lci/M3m6I/dEmNrX5/ypaIEiLx82y0dm+DCCKWzmrNQWtP4ZnvSJQrMOuuoEB87fAL0IwjS7L1e7dosD13XjlY9wmRkJhCEsYRE+TsspFwRFgrxQIxZLzilgXP9K6TBEI+hggDgRTZFZ+84NhaNc+faGjdDWkQzDA1e5dwZ51pJF1jJCU6WElglEtG4dBHGlMADXTVtPcJHqmJh7C0y8jv0N6cHk4JE9w==
X-YMail-OSG: OCemha4VM1lZkYbQCg2uZ6MGTCNCDqdfvS6XNAXEcs.XWvUClYKGZwEDtE9E2qq
 ljroqftzVuGEmF8oRz2AYlJJyTMDnbzgztiGRL7K2N8L2g5O9KHp6epPLY9rt0xn8dm65DkXx7im
 lFE_fdg5X4ruQ_MVLF7APk9X3I4JYyd.rORNN8bt7xqRgklUHU3sD34AzMciIeA1KOqzf9CZpf3E
 hNumGxVFxQ1XYJOoh1B93cHRZX99Whc25L9HzKMnJVvqNlXgGe3OJ9qcnoPKcafgc4C7EOojSIcz
 4nN7Zo.P80x.BIMrhW0_yE5DSPuiaYR1Q5DcgvUD2hVJg024.VnuzwYJSd6h0v9eHiFJtqsBSMW7
 25EHfG3ydDAJiHD3hy19zBVHNA.9FIfzCkf1U9jNjhE2l_mAiu8wT4rEbl35mBLuhGqO7McP5yr0
 Mg9B1LKmubZg8JR93yCdx2QS.dlCXS8Juq3RKYrElxQJ_qrSxDNUIUjicQM.gdAwrXC_YlxhrePc
 tOrevmLQgw_zb_TLMeAwhu42tKLbKT1LL8h6ZmhKbrkoF2z3V41din.UjPilIJjCjC6IsLXel1F8
 228X1g6kOjGd358CmQZPyOYlsA05IygBpe4JABkWWRX8y0hrpzM5LILTSjocoLHNbh4vbA_f_ACF
 EDQ5tBEEn70l0KOTrV0h8EReMUXWADe0_JjC1fAJc2K7kz8ovyC735Hm06urDkvqsYS89cAN_8gh
 CtmXeD_i95bpL6KbvAt79rDfgrmeSfQYHwxm4to4uEYc7CFbMNdlthU6jV_.W9XbDVfr6uyvYjFy
 VnRYz.VDvIPDxO91lFdfAqVOPXbM4uj8F5soDnNabXdScsCygkdaJFLJ_C5J16G2_RyktOYHT_nq
 FlGG5R8LPlfZL1YpiHBBz87SO_6BNlOabenvQ4MteVgniHs4XKykj37XaDFAo0drcR5eykEBSYQh
 plDeDaKBRISs1XJs3Q8hg6ptiB.8qWeSMAaun7vcB2OwJIFsshFr0HPVYHdCDXuZRDwjXjHNUOou
 fYjc3OZualgaa.tXrk2LWVWIVqIwWRKoNyzuNFP2Et_uG7AkZMcdhbrdpFBQ3rKza3twfEuIbfCv
 Izbn0xp5HWkwM7OYzukIpMY76Dal7jWNzm1sVszkjJ9qb4J07JfsWwB4knbEH75L51jimItKQbqb
 uIgTjlyYH1GvcQxg5umZ9lAN4rnt87KNKOO1SQRkKlWIzlYJ_Hn4H6J_MhSz8OEPilwek92Lxn8J
 QBxRJ_nvye32GxD2uzytPzeKvUVyV64bFPAE3oOfJJFE2Ke8ugjBcgv4X5oitNTIKiYyTZCiO8Va
 jUSAULqdU2WC057uyyq7lsnGRR3La8ARdMPoMOQBTTDGnyEmrAHJP9bsNde3QVJYYTOnZLN_9GYi
 m4iRXbZ4ZbHHK9ZOQeggmGIbDzbFJFgMlOv62gNZ2UVLRtAwkWpSSnub1qKibEVkOU5smqxlI90g
 OWfAqM8egxVQFu8v6GDAMulwE9RyieJKuR2HyEUajfhHDM8sXAKnTN0ugXZ4KANaP7ZliXukoXn7
 jjUPv90CACqkwKXwKNIARo0q4nSKTNQQcqmWu9EUsM2pIJQqgZnA2.TxF6dpXZIC4Mqzd.cR5tcZ
 yasp4kpGbGXijG_7_qstNlk7F4lJ5YAHyiJF3T0V7WnqYoDNp2E7TxssaP7kaT9CUrbl8VTOWZui
 VTJLg_FbG2e2AzmmDoh5W2ypDvIXUnhvvAWxBqqHaGZNBmqNeApE2_pp2ADmoiHrouAGXqsnGgUy
 1N7JqK5uqIoeLJXPKWS7pwx6LdDx6d_hCtUGuLfDYycBvHJtf8c97.Prd1U76xXjZWnsMmTB5qyx
 MuryMzu9cCrNuN2OZD3.w6jaoohCxbpcyHgMzIi9yTowNWONV5SQ3V8vfzJpzGyxz93TRCb4Ur3H
 8zEFL.NkwI3fV_HEUjMpRPFkWmcLiKkxG1t.cspuSRd1.S_rrA8SlblVZNiSGGpcDl06ysgZV8KI
 SFLsPAkiUNHKsADrMqrmNq6oynaqPeU2FuCWYesJkch.B_ZGkNn58yJ1lIS9XVf17j39I4_BfKaW
 klye748Tlnqq1eIes9kBz2K2dvPLiCepkuZjwbLd3offy9TFS_LUCYSz6y8gpJu5g4bxeWAI97HK
 ZC4VT6GZHSq1nRyRnJgTaMqkT28CukiOmWqEnlaKEphd.Aj6Y6EzcIXKoPFNvgGN9YF3MOpzcUdA
 shfaC4iAqkJjP.W.rrZxDPwRnQxG2dHRsN82mZDW_7BEnSFsQQTr7yH4zwGU.devraayj8WbQc9p
 3BPID
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8d1c1054-6b94-44a3-8217-d87cfaf0fe84
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 18 Jul 2023 17:20:48 +0000
Received: by hermes--production-bf1-69c9587855-9vzp7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 24be0890452210848a4ad922678d305b;
          Tue, 18 Jul 2023 17:20:43 +0000 (UTC)
Message-ID: <bc7f842f-caa3-082b-3159-cdc2c4b2dfa7@schaufler-ca.com>
Date:   Tue, 18 Jul 2023 10:20:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [LSM Stacking] SELinux policy inside container affects a process
 on Host
Content-Language: en-US
To:     "Dr. Greg" <greg@enjellic.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Leesoo Ahn <lsahn@wewakecorp.com>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com>
 <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com>
 <4ec9e7ae-e95e-a737-5131-0b57922e4fce@wewakecorp.com>
 <CAHC9VhQBbbSu6YBbnXOPMjpBxQxc1nmgA+icfN4x6s6FeQSeiw@mail.gmail.com>
 <67cb60c9-35c9-6dc3-7ef9-2540d5acf162@schaufler-ca.com>
 <20230718103432.GA19728@wind.enjellic.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230718103432.GA19728@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21647 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/18/2023 3:34 AM, Dr. Greg wrote:
> On Fri, Jul 07, 2023 at 09:50:41AM -0700, Casey Schaufler wrote:
>
> Hi, I hope the week is going well for everyone.
>
>> On 7/7/2023 7:20 AM, Paul Moore wrote:
>>> On Fri, Jul 7, 2023 at 4:29???AM Leesoo Ahn <lsahn@wewakecorp.com> wrote:
>>>> 2023-07-06 ?????? 10:43??? Paul Moore ???(???) ??? ???:
>>>>> On Thu, Jul 6, 2023 at 1:20???AM Leesoo Ahn <lsahn@wewakecorp.com> wrote:
>>>>>  >
>>>>>  > Hello! Here is another weird behavior of lsm stacking..
>>>>>  >
>>>>>  > test env
>>>>>  > - Ubuntu 23.04 Ubuntu Kernel v6.2 w/ Stacking patch v38
>>>>>  > - boot param: lsm=apparmor,selinux
>>>>>  > - AppArmor (Host) + SELinux (LXD Container Fedora 36)
>>>>>  >
>>>>>  > In the test environment mentioned above and applying selinux policy
>>>>>  > enforcing by running "setenforce 1" within the container, executing the
>>>>>  > following command on the host will result in "Permission denied" output.
>>>>>
>>>>> SELinux operates independently of containers, or kernel namespacing in
>>>>> general. When you load a SELinux policy it applies to all processes
>>>>> on the system, regardless of where they are in relation to the process
>>>>> which loaded the policy into the kernel.
>>>>>
>>>>> This behavior is independent of the LSM stacking work, you should be
>>>>> able to see the same behavior even in cases where SELinux is the only
>>>>> loaded LSM on the system.
>>>> Thank you for the reply!
>>>>
>>>> So as far as I understand, the environment of LSM Stacking,
>>>> AppArmor (Host) + SELinux (Container) couldn't provide features "using
>>>> SELinux policy inside the container shouldn't affect to the host side"
>>>> for now.
>>>>
>>>> If so, I wonder if you and Casey plan to design future features like
>>>> that, because my co-workers and I are considering taking LSM stacking of
>>>> AppArmor + SELinux in products that both policies must be working
>>>> separately.
>>> What you are looking for is a combination of LSM stacking and
>>> individual LSM namespacing.  Sadly, I think the communications
>>> around LSM stacking have not been very clear on this and I worry
>>> that many people are going to be disappointed with LSM stacking
>>> for this very reason.
>> There have been many discussions regarding the viability of the
>> using different LSM policies in containers. Some of these
>> discussions have been quite lively. I have never claimed that LSM
>> stacking addresses all of the possible use cases for multiple
>> concurrent LSMs. If people are disappointed by how little they can
>> accomplish with what is currently being proposed I can only say that
>> we can't get on to the next phase until this work is complete.
> It seems pretty clear, to us anyway, that generic user expectations
> are that advanced security controls for Linux, ie beyond DAC, should
> provide the same compartmentalization and isolation that other
> resource namespaces bring to the table.

It would have been really nice if the developers of resource namespaces
had addressed the "LSM question" when they created their schemes. But
they didn't. Namespaces are not primarily security constructs. You need
go no further than the group access problem of user namespaces to
understand where security ranks on the priority of namespaces.

>   The 10 years of experience we
> have had with building systems, and feedback we have received from
> collaborators with significant experience in critical infrastructure,
> drove the focus in TSEM on strictly partitioned and workload based
> security controls.

The 45 years of experience we have had with building systems at every
level from network appliances, through user interface engines and multi-level
secure supercomputers convince us that workload based controls can never
provide anything beyond grandiose security theater. We have often claimed that
isolation (partitioning, if you prefer) is easy, sharing is hard. Building
a system security policy based on alleged "safe" existing behavior is at best
naive.

>
> We obviously had an advantage in that we came into this with the
> opportunity for a clean design, whereas the existing, particularly
> label based solutions, have the constraint of a single ground truth
> with respect to the inode label implemented in the extended
> attributes.  Which is the fault of nobody, but rather a function of
> the fact that label based systems have a heritage from before anyone
> even thought about resource namespaces.

Resource namespaces are expensive and require extensive administration
to be useful. As one of the early developers of the inode label based
solutions you disparage so flippantly, I take umbrage with your
characterization of the design process. Of course we thought of features
which closely resemble user namespaces. They're great for isolation.
They're not so great for implementing fixed security policy, which was
the requirement and goal.

>
> Do to our objectives, and the approach we took, TSEM doesn't require
> support for 'stacking' with other LSM's, obviously other LSM's do need
> that support, not a criticism but an observation.  That opened the
> door to implement what users would consider to be an independent
> security namespace.
>
> The take away, that I assume everyone interested in Linux security
> would be in agreement on, perhaps not, is that user expectations are
> to have independent and separately administered security control
> environments that don't interact with one another.

So long as the "environments" are completely isolated this makes
perfect sense. What so many "users", and more importantly, software
snake oil salesmen, seem incapable of coming to grips with, is that
for an "environment" to be useful it is going to do some amount of
resource sharing with the host and frequently with other "environments".
That is where the lofty claims of isolation fall apart, and the real,
painful work for security developers, begins.


>>> While stacking of LSMs is largely done at the LSM layer, namespacing
>>> LSMs such that they can be customized for individual containers
>>> requires work to be done at the per-LSM level as each LSM is
>>> different.  AppArmor already has a namespacing concept, but SELinux
>>> does not.  Due to differences in the approach taken by the two LSMs,
>>> namespacing is much more of a challenge for SELinux, largely due to
>>> issues around filesystem labeling.  We have not given up on the idea,
>>> but we have yet to arrive at a viable solution for namespacing
>>> SELinux.
>> I remain more optimistic than Paul about the options for supporting
>> generic LSM namespacing. I hope to explore a couple notions that I
>> have more fully, but as they depend on the current stacking work I
>> may not get to them very soon.
> I believe TSEM demonstrates that we already have the infrastructure at
> the LSM layer for generic namespacing.  Of all the current LSM's, I
> believe we have the most sophisticated namespace implementation with
> respect to the functionality that it implements.
>
> We have implemented TSEM using both the standard Linux namespace
> infrastructure and as an independent namespace implementation using
> the LSM 'blob' infrastructure.  FWIW, we have never looked back on the
> decision to implement LSM specific namespacing using the generic LSM
> 'blob' functionality.
>
> If there is a desire to provide some minimum level of generic security
> namespace functionality I could recitate a whole list of thoughts to
> consider but will leave that to another time.

	I have discovered a truly marvelous patch for this, which this
	email is too brief to contain.

All kidding aside, there are a bunch of things we could do, but they all
introduce issues with object sharing.

>
>>> If you are interested in stacking SELinux and AppArmor, I believe the
>>> only practical solution is to run SELinux on the host system (initial
>>> namespace) and run AppArmor in the containers.  Even in a world where
>>> SELinux is fully namespaced, it would likely still be necessary to run
>>> some type of SELinux policy on the host (initial namespace) in order
>>> to support SELinux policies in the containers.
>> SELinux policy is sufficiently flexible to support what would look
>> like different policies on the host system and in the container. I
>> think that the administration of such a system would be tricky, and
>> the policy would be very complex, but it could be done, for some use
>> cases at least.
> These reflections illuminate our motivation in developing TSEM, others
> may disagree, but a lot of experience in, and observation of, the
> security industry has led us to believe that security has to get
> simpler and easier to implement rather than more complex and arcane.

Evidence would indicate this is an errant conclusion.

> We are probably at an interesting juncture in Linux development.  The
> security controls we make available as a platform can either pursue a
> path where only highly skilled administrators and technology companies
> can implement them, or, we can provide mechanisms that work to increase
> the accessibility by development teams and ultimately the user
> community to advanced security controls.

Ever hear of the "Hillbilly Hummer"? No, you don't leave security policy
development to end users.

>
> With TSEM, our design philosophy is that security controls need to
> flow from the development process in order to accomplish this latter
> objective.  CI/CD is now considered a necessary and standard practice
> in the software industry, it doesn't seem like a stretch of the
> imagination that security controls should flow from that process as
> well.
>
> One of the requirements of this model is the ability to strictly scope
> security controls to the level of a workload nee security modeling
> namespace.
>
> Regardless of motivation, it would seem from this thread alone, that
> there is a user expectation, if not a necessary technical requirement,
> for Linux to provide infrastructure that enables strictly partitioned
> and independent security controls that don't require extensive
> reasoning as to what they might actually do in practice.

You really have missed the point. By a long way. The problem of security
is not now, nor has it ever been, isolation. It is sharing. If it is
appropriate for "users" to determine sharing, we have mode bits. If it is
appropriate for "administrators" to determine sharing, we have mandatory
access controls and namespaces. If sharing is completely inappropriate,
we have virtualization.


>
> Have a good week.
>
> As always,
> Dr. Greg
>
> The Quixote Project - Flailing at the Travails of Cybersecurity
