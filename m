Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7941EEEB570
	for <linux-security-module@archiver.kernel.org>; Fri,  8 Sep 2023 20:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjIHUyA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 8 Sep 2023 16:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbjIHUyA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 Sep 2023 16:54:00 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BFE1FDB
        for <linux-security-module@vger.kernel.org>; Fri,  8 Sep 2023 13:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694206429; bh=8nyWi0CbxATxGL3nbGu5sizO26aoNcOq4yPWI++Hqxg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=d/RWcrGeADUIYin3AnQ+j9Koj1rQxI7Kknz8x76zY3GoMT1SuioX4m1p9sue+sR0dl1efulEPKahzFHlUqPMY4XpQJn4q3BgesaLm7O1IsfCBVRu83LcXRMiMBLD6H5ol4QXwXLBp7VTuUGYymTCUVu4+TZ4E7J8ueoUFSUfjjL38YUkHcSHWDpB6641n0LUw1lnUETxBBXVC12acOLkTzHYPxk9BVKdidWOi/msJqoW5QdqIUW8sh92+QyYueK5l4nwsyCxh9+otGOFe1VFcuYYwVaRxDyYgi/XWE8VGMA5p+z8Ml84GgKyVrN6/b+vmwJRzJoEVpj7h86GVZalsQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694206429; bh=ekIZCN2WiWNMn0dRspqCfmnPDuOPwLKcVjH+0QmUu40=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=bLLlQuhC8PIBajbv6bLCKDJBiWor4+M2LCgjwS6ODhTv49MsV8cDxCSmkbQ34/mvpSIe3qvLmTTz7Kus0qwaIg2d6e4gR4KJPWCwtrXj13605wqtymmiY/8cY+bjPQ/XJLUiPgdBPEUWiGpnevk7b9TXKBEBaSIMblQi4Vw0kwkTG+frb66ux2vuzJcY3Mrc01gF9WNSRcACVBH6b2YtJINWqVmSlr1dz3oV8Un9e7Wle6anBvUFPybCqVyM+Mk6guJIgEX4v4H+lMa56oHfG5t5iyKrTjFU8ERJ9vcdDlP4dcGJk5lRktHuF3XMXhsrrLeRT7KHJLT1JAabX2mgxw==
X-YMail-OSG: mFWmYu4VM1lsNH4JHb0QGUSg8BJ0ZahmvBHX651FdGiHF3uHSsOEEl01yeGM7Vi
 yb05ClG8mxLzBp8lp14YQSV8xhdI36lfvGMS8596c5MBoW4vtrjUs0zLR.Hh.Kb2n4w3LkRBVKT6
 iW7BzklPDsPvK4w5qPvaAHi.VE7wIWukadL_JZg_exFbOQFMNQGW1V4Q5s4D7KTKGeYYRIb8fogQ
 sWpcNQAk1580yc2c3Lo0YDcsdJfo2ukHSAaQGYECXZ9LimcKzdChGXvzAcN6vZgAdd5kFqDgPxeI
 9HA_zu8Cq1QbxBvlqSRxTzkGrxtGTp_y3mKQSe9UQUkmlSkU9Y0OxFXNBF60MZJjNjNIYmd5N6nr
 aTfyJ2I0g6ven2rYvrw6emXGRL27A9gUETdRXcHYtLuV4izZQHGxA9x__JUU0yQaE.9YmKQEeMMm
 ynJ9JkRhysjq4eTk8ITPeOjRE.E5GaQyLVU_fmSV7w0yx7A.Md4xfULlWRYm91AD8iEJvTky2aPZ
 2JAb1_Sbc_Y5BIxE9HbaVGw99kqpPGJ3ITwNhePHtFhlXRZ8Ngce9d.K2B_t3mtpXks7linNwUbz
 yIVB9HjtQp5GTNWY25FiLNpGZ8Po8EEKKiUiGidD580G2rfcQeNDu1d990rR8v8EEwecuTxQWfhA
 3.IMSfClsRonxnebWdc9.ZeuL1S9DBE2eIMZaFZAu5_UxxS4.MhO9_5J6i_1wuUslyG4FbVa89I7
 CZ5kjbL1Od4qjD2RyVAyQhKrWf5G7W2x8UhpzmIFPx8dME0FOWHEL_odeFv2fb8N.ba9l5koZsA.
 gndLpzABvqeZPyEG3OTAP.lsZuGWudXsKVaMactoU1thQuKfy2tKw84fGN2jsgvDT452EMaFen__
 qNnTh_XyswSM9f0LngFZ5twL9ag1fnBGa1irthqbFbaF8I2Ki3k59hdLEOSGcY8nRi3B945P08xp
 CE3NCK5cEthgvdF9HeTXKICTZWsQJp0vxlq.OlPFF.wYtCDwyn6RCItdRsf9Wb54vb7EKbB3rsgs
 9XIkHJz0y6txEI8PYh9vXfXi_yGf3jS3ZfTknitjwvAIvZhO52jOGijoDA0X2Anzjdbv6vz10tW8
 lv54Vg3V9otzpfhDJgQ16fZmb1N587KmxoYvrycUW0rV2ONEqLDfck7HKCDsmmSwc_7DVJgWV0Rw
 vnfzvB14cKW4HCMkcuAwjGIzWR72Z2NPDr.U93tDCKNvBxKmv98ahon3FUPXQZtVLISdf_aGPdbH
 KJAOBUWz2WG4KaAFjpX0CbQxVgVo1k6jz7L8039B8Kpreb1YcF81.OG7998lA2Ikt4n7DLqh_LWd
 jTM1te3QgZOzWVPVt.jEXW118zAiJqFLeHWq6oRzoQty2gqWK5d7tDoX1yUfA.uKTGzdKWF9dwjM
 w0G9IXzLLTpauS7rrdW7iyY4_rdHzaQvRKRHIUDkJJYzVu32vrbXsGm8SqeJ4UTaVZF72cDvh7Oa
 8ZDc2EJal98SD8AM_YwhGUaVc5QPNpXp_QSAVSpwLnAXubEayQEWZGJLi0qEGC33FJVWNL9b1BYp
 XlISxOXEq.4KSB1G11_fy4bMUW0zIb2ui5y9YVfzFT0xDZHRmsT7.NMTSdcVS2sN7G5zPpz9a.Pg
 Hh2MAadnUcB37w9CE6lDx4IxxJgmifKaS8IawMqMPEYs74s505Aay4pNBLEIJrtQ5JvNCrTAr_Qo
 .GWwyHemKa_n3JOANlbZmttfeWypg51BRAiOxkLyjyottWl.xxWmAut6gXIiWY08dh1aRQ4frXY3
 CyTT4W284yqAWf6KNyjeaRvHFAb0wvXGjtkCH2qhYRbR9cpXAhmqUX0eNsSQuSTmYSjDXfjifF4J
 0NuaW0Qmw.BBEnq1wHCAf3qOIaOo_kspv8ORWYXkmEMoeUuniL2PdsUQywo.AbGIFXjuGlwE2hgf
 BPrmoil3SqSyEOs248Yxx13KbznG2.ZbLKnlLEZrQrI8KYLj1.Pk8Ey2tWN7jMOr4HOyXZNM3b_2
 NclcQlsHiFyJJ2DveeyyBWGKo0WjReX2nD9jGrpwiqAh_Vt1504sdiNtUI_NDw_qzUOfp_yH6AK.
 gS4AYejz7VBnJQa0vr768bJ.olPcD8IzN3AOrKTvEH7mAH4HpcK0Drasc9fuC7dwzSB5IzOv61Z3
 Pzu2Vpp52Gg.90o4tjF4lDLSVf3EUF6wD1TWavXNUAUsZBphj1lVXcrMlZYx0lAOhtN9UTanymGH
 ToZt2C145j9DYIGFMGCxECpE-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: cf351a31-ab05-4763-9b85-7731f0f431d2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 8 Sep 2023 20:53:49 +0000
Received: by hermes--production-bf1-865889d799-5m62n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 30fdb6a4d6f36b283599a9f3ea36050a;
          Fri, 08 Sep 2023 20:53:44 +0000 (UTC)
Message-ID: <285bfbf8-9dd3-9dc5-d654-3f88134230ca@schaufler-ca.com>
Date:   Fri, 8 Sep 2023 13:53:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: ANN: new LSM guidelines
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com>
 <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com>
 <CAHC9VhSw6B5D9ru8trwcejAt_MQKN4g6R0zeTqO_BKRL06km7Q@mail.gmail.com>
 <CAHC9VhQgZ6kRQA7M8BG1H4gW=dPBhPqc5qV72EQqrSt9p0Uhkg@mail.gmail.com>
 <847729f6-99a6-168e-92a6-b1cff1e6b97f@schaufler-ca.com>
 <CAHC9VhQmOqmGHYj9SLS4_qerC-_RB3R6Zvt=NHWyUzLX+KUqiQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQmOqmGHYj9SLS4_qerC-_RB3R6Zvt=NHWyUzLX+KUqiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21763 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 9/8/2023 10:29 AM, Paul Moore wrote:
> On Fri, Sep 8, 2023 at 12:03 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/7/2023 3:12 PM, Paul Moore wrote:
>>> On Thu, Aug 3, 2023 at 5:38 PM Paul Moore <paul@paul-moore.com> wrote:
>>>> On Wed, Aug 2, 2023 at 6:00 PM Paul Moore <paul@paul-moore.com> wrote:
>>>>> On Tue, Aug 1, 2023 at 6:47 PM Paul Moore <paul@paul-moore.com> wrote:
>>>>>> I've updated the README.md doc based on the feedback, and copied the
>>>>>> two new sections below for easier review.  If anyone has any
>>>>>> additional feedback or concerns, please let me know.
>>>>> Another update based on feedback received (thanks everyone!).  Just as
>>>>> before, I welcome any comments or feedback you are able to share.
>>>> MOAR UPDATES!
>>>>
>>>> ## New LSM Hook Guidelines
>>> ..
>>>
>>>> ## New LSM Guidelines
>>>>
>>>> Historically we have had few requirements around new LSM additions, with
>>>> Arjan van de Ven being the first to describe a basic protocol for accepting new
>>>> LSMs into the Linux kernel[^1].  In an attempt to document Arjan's basic ideas
>>>> and update them for modern Linux kernel development, here are a list of
>>>> requirements for new LSM submissions:
>>>>
>>>> * The new LSM's author(s) must commit to maintain and support the new LSM for
>>>> an extended period of time.  While the authors may be currently employed to
>>>> develop and support the LSM, there is an expectation upstream that support will
>>>> continue beyond the author's employment with the original company, or the
>>>> company's backing of the LSM.
>>> Based on some off-list discussions, I've added some text to the end of
>>> the paragraph above to allow for a reasonable plan of succession in
>>> cases where the original LSM authors are not able to commit to long
>>> term support.  Just as before, comments are always welcome :)
>>>
>>> Here is the new paragraph:
>>>
>>> "The new LSM's author(s) must commit to maintain and support the new LSM for
>>> an extended period of time.  While the authors may be currently employed to
>>> develop and support the LSM, there is an expectation upstream that support will
>>> continue beyond the authors' employment with the original company, or the
>>> company's backing of the LSM.  If the authors are not able to commit to
>>> supporting the LSM for an extended period of time, a reasonable succession plan
>>> must be submitted along with the LSM."
>> This makes it sound like LSMs are always developed for corporate use.
> I'll agree that I could probably phrase the paragraph above s little
> better, but I disagree with the assertion that the paragraph implies
> "LSMs are always developed for corporate use".
>
> How about the following:
>
> "The new LSM's author(s) must commit to maintain and support the new LSM for
> an extended period of time; this applies both to authors that are employed to
> develop and maintain a LSM as well as those that develop and maintain a LSM on
> their own time.  If the authors are currently supporting a LSM as part of their
> employment, there is an expectation upstream that support will continue beyond
> the authors' tenure at their current company.  In either case, if the authors
> are unable to commit to supporting the LSM for an extended period of time, a
> reasonable succession plan must be submitted along with the LSM."

Better. Thank you.

