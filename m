Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714D6280327
	for <linux-security-module@vger.kernel.org>; Thu, 15 Jan 2026 18:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768502098; cv=none; b=rdsKlKMESWuLE2aOvTU04PLsZVf3/VwV3/i0dgHq5E7YYfKFOdtYLEYhD51vDhDywnZ/5jdUQi/9k6/bKNgttGUTSPba9XHsGZPKGLGY5IDBglEQZPSkCFCmX/QNxfzzEOTOSVsqB4Su2BdI+yhWVEgluxwOAiXZR87dF9IWzn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768502098; c=relaxed/simple;
	bh=kddtF3EoprNiFPUGFu+MgcOtELtCi2QxdQsy5nmYYHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvTkwyZnbMWdUdJof44Xby5IWvvqpWkg0J5eCnttsxB6uxQycwEG+VZlfCMqnk+wTfx02lYBL06K/49kHUNeQCIr4NkpN4Zv9MIEr5kNEjAsypJ9SNeaSJg4TK8ttiZsYBUx7hyj/lMQCdO4xrUe85wRqhXiyAyOcO0ft92mO6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=pSmfpvaz; arc=none smtp.client-ip=66.163.190.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pSmfpvaz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768502095; bh=Vq9U0YWpZIrR0wIe28KH902cdNqdtrMv2q+R4a2WfTs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=pSmfpvazcKzwHkoXSgnHKVSbpkcfgczRSuy8iHuZYqkbl1AGPbLHmS8JdWba6XML5T80+HxVXSGrs7AEtxYux1cMN0/SSNEC3GEqCPDmRL3GQZWzAKjuGC7zsqWcJPYNrynJ2vwBEnV6VqdUKNKsXycPLd72u9lS0h8apYMU9FxigaSkKBH0YACjyoXVEFhLhvId617euHiBUeLPM34Q5YhFJFekH1Vzx66nFxjBpB89aLYZmdrKxdAfmJOF6JdxJALu0fh1NXvAC6nKHINOPz/BLrKoUiJkpOO3LfJo+745/bU80NScpsAZsVeyygb+0bfehmGN1LMYLb26NtS7fQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768502095; bh=5owzNNAOeVmrTjkolpeVb1zRPeIHTjxS+ZHcP6zQjMJ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=rhiStAVPT6CSGWRkA2NdsueOEvVLbmyAMoJoaj/X4OMkcO98Fk243uKIn4PLRjzWWAuVwB879FgaJCxEzO9BL+S4IJklWOLr5KrCy0UG1Q75iQ10RAQ9jzRa4LqG/hg/pTwDuWsCNv5fDhpwCrD7trtbcl7pplhbabeTWaCOgcDO94NluRT5vGBfQgf1QM2VMm8rU/TuYJKeWXq6khIloC08ozc4zjJzmhfB21/GPOEjNlCgsLA16TI5zwEnPpiIVELlUZgk1+GpkVv2YzrKr5c9Yoh/OaHg7N/03yWoMMFQmmkAc+PN7j1yjiX7HrkYixTj5oy/j/kkglEWaTAY1Q==
X-YMail-OSG: bO6RSS8VM1mSVGpLrpWQq427eZq4Ie6L2GFV6H1gKEJMGKXv2C6QjCsK5MZ_OTs
 6pzWiIrIZTXC6fdA9e2UgO4AnuEdatE9PW0zUlaecgtGG0A6v5VNgBq8ANyaFI4fno._N3bUsqxW
 5MU_DpiPpr7dqi7MztLF1bUfS4becnSf5zvp4g6s.CqnSgQ18zJfs1OQcLq9Y6GtY9Io0ACDXFa5
 0quxZfXWso7ILXIoHWJSP1IWJURfK23n0q13.CEYDSAk9hbwFfe3OZm.GS2BuhZGzxKpoPCBdjPp
 sVPbPP6hZzehrZ7JUW0MA6vX3JCsmDIZ_e9K1qjDnFbIkLih..DxNFb.2Yzc3ld3Sm.5M85CJDqT
 IfHVNd5t.5yViMc_82eI69vRhRmpLtgpn4ZkvHuh6fRUAbXop_9oixUe1eXldCtcWrjlTdv52ZCY
 PTanNKWJAPJKQ5q4WuF.gdVB7s80sIzpFOFegNAjSGAjE5u5S8TK.AgAWXSWXybdsLyGHuenFOv6
 x9TvYjbcbsar4Nfc8Wpt9f.Tjy9lwTJ.WgrM05fFcPFywv44CN8vmHDY9GEzDBuqeqGkzrwI1cyr
 iIpQMumnQz3TmeWzZlPaBJFldOGQQ94XslcXycf_6_5V8T6_PDnaJed7Zf4BqRIs3DXFZLbfXN87
 njGkMepaQkKNbs__KdTA9OsRQJjuuA38TSOA05qN1W1ucm6EGbfhIO6kvDkNuqLWZh3h84RfQce1
 5qrkMdMTBE5JkQ3MPs4rJip15kajbcXRdC1snkMOdm_7xzA9yRTU.0TknZFnUUeTDI1uDjNKrmgm
 qzzRhxusEeHWabmZCjG7Gj0ZYxL9a.9Wk915zrh83U5Z4h0gDHoKqXTU4CK4GaKsXCrxch2E4__7
 JcRD.M_xHh46_D1n1WvJtSIUSYlLQDyd4poHJ0s2zkh3A2.7ghKh07IhRL73qTeaiRtTNH4Ld5X.
 woz4p1X4SxADjtCsBx8X.LdsXfyjlao5T2rZklf.oBytvBqIg0Rfq69YEdiEyE6qE7ArhyHVDW.a
 Gx7KcV4Nw0bvuTzkpwzKU3T5KX4_4O9vKnPkOO81wH_qivwbpZZ2dLhmbWvXn8o3ZjG6Jukh7vSu
 Cc4NTExu6xCshnhXmuhZdfpE0_EZZqklIovAXocrEULCPsme.RUkEIXb.F2AY_Dsqk3uMbigU6Ud
 uUu3xZEksGQELzHLrhFVI5zz5e1_J4qtmKET2NpyfAK9bEqPpzXWA_.2pNHOMYhPn2tPECPrOhum
 208EVOaiMo8Xam1DnnCx7Z4950TDhPaZGdyTxrbiqE7dmzxX9uvFVFArFLR.8Jx40FqOxUdfuwTt
 FdhKsgc4CGDIaZas4iZU3CO0QRlLka_6vElO_9.7G9S0mzue0t9sXv3PY6.VKLFtyOa0rk1zjgcU
 OZ5t.f7VceqWMlJ7Rv.tqMcQrOggHBTUQXsON2mwHlEIu.hpvUNSjLOKxWc8pRSNCRqjo9RHGMG6
 NdU9qjTwg6O6LDJTWmDpSWjOFxi.TXznxtkwdMPCtJIc9kZc_FeMe7W.yeaF6nzIcjG5FWj5RVfN
 j5jfyykjgM8YnH3zBsyoAtZESkg7e1U7P3t2DUZmZwbNR4w3HR1tcvmgf2vLBV98tofKTxEQb_C7
 3okjpDlaVQRv3UOlx19FGs.Aquc0jvAi8MCb_7hDg.EQ4mbl5WQMlp1mPtRuY6PhKVv5pzQb9TSI
 bFt48ACvc1gOjy9JnfyyolONOht6LMcGF.n3rylgexcvCaM18YJEn8QrwuQyAG3UjHIMoxZkCdXU
 H3dbbwpwAA3pDqYgEbKoicxHnwLyA4HpYhKDctt8uXVL0WaGeQHg52mD_ZHP1yzM30S6ZgI1h0Sq
 oh3rIaevga91L86F29bKQ6uck8TgHtEgDrmrZ_Nw_E55OOZmSMZ8iSg3GX.t28MpGWdJnZf8OgT4
 jMsyl7g51JJhxsfSy5P1evxsGs2bKorph4RRLfxln373I0tw_U86l4hqJkIZr7OIcwnQ.ptM6zTv
 mspGDArFMOHNzZihZjfkgbaKDGfCqWaBIGOHMoMQ8Jm38F6DQDQv2AQNlYjS8CQDEj1eBHY8VQND
 62o6R7pc9hap_py.T9qhGoOSn_T1jOWTw0gOz6Fl6Q8CSua9_XBwQMEJBtVvFtSDkomiwYW_Emz4
 QTLKhu6.WqqDFIyLFHjz7A2RA1P53PiQHgskSeb96rLl0sMm4crNY34f1E7o1XLhGUmneWDaVwlC
 RpT78YZdUWCLFcMwHHwnenPACEvdSCVb8pHmUFyXOOWif5rBoxi07alX.DjeI1ImnA5n2yF.MYE_
 yhGk-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a23fce29-23e6-41b6-ad6a-596306b58adb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Thu, 15 Jan 2026 18:34:55 +0000
Received: by hermes--production-gq1-86969b76cd-f4c4c (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6341698a9cc5041e6319a1aa5897f7ef;
          Thu, 15 Jan 2026 18:24:45 +0000 (UTC)
Message-ID: <038790fd-840f-4b32-81ab-058a6845a0bf@schaufler-ca.com>
Date: Thu, 15 Jan 2026 10:24:46 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Improved guidance for LSM submissions.
To: "Dr. Greg" <greg@enjellic.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20260108154604.GA14181@wind.enjellic.com>
 <CAHC9VhTyvEVLGLJkkyQnSZYSj4-YHPz82BnDEUwMjU7hHdbFoA@mail.gmail.com>
 <2ea2e67e-8fcd-43d8-8cda-7df8d678d2b0@schaufler-ca.com>
 <20260115155555.GA18668@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20260115155555.GA18668@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24987 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo


On 1/15/2026 7:55 AM, Dr. Greg wrote:
> On Fri, Jan 09, 2026 at 11:58:39AM -0800, Casey Schaufler wrote:
>
>> On 1/9/2026 10:51 AM, Paul Moore wrote:
>>> On Thu, Jan 8, 2026 at 11:08???AM Dr. Greg <greg@enjellic.com> wrote:
>>>> What is not clear in these guidelines is how a virgin LSM should be
>>>> structured for initial submission.  Moving forward, we believe the
>>>> community would benefit from having clear guidance on this issue.
>>>>
>>>> It would be helpful if the guidance covers a submission of 10-15 KLOC
>>>> of code and 5-8 compilation units, which seems to cover the average
>>>> range of sizes for LSM's that have significant coverage of the event
>>>> handlers/hooks.
>> Good day Greg, I hope you are well.
> Hi Casey, thank you, I hope your week has been going well.
>
>> If you would review the comments I made in 2023 regarding how to
>> make your submission reviewable you might find that you don't need
>> a "formal" statement of policy. Remember that you are not submitting
>> your code to a chartered organization, but to a collection of system
>> developers who are enthusiastic about security. Many are overworked,
>> some are hobbyists, but all treat their time as valuable. If you can't
>> heed the advice you've already been given, there's no incentive for
>> anyone to spend their limited resources to provide it in another
>> format.
> As Paul noted in the following:
>
> https://lore.kernel.org/linux-security-module/20230608191304.253977-2-paul@paul-moore.com/
>
> Microsoft employs him to maintain the Linux security sub-system, and
> related infrastructure, secondary to Microsoft's concern over the long
> term health of the Linux community.
>
> Given that, it is disappointing that Microsoft isn't providing
> sufficient resources to enable him to provide guidance to the
> community they desire to support,

In January of 2019 (oh so long ago) I gave a talk at Linux Conference Australia
about the amazing popularity of Linux kernel security. At the end of the talk,
someone asked how long I expected it to last. Without hesitation, I replied
"18 months". Operating system security has never been on a major vendor's
priority list for more than about 2 years. Even the "C2 in '92" era was of
seriously limited duration. *We don't whinge about the limits of Microsoft's
support. We revel in it's continuation.*


https://www.youtube.com/watch?v=GFGJ3e3oj2c

>  regardless of that, we now have
> 'official' guidance as to the requirements for submitting a virgin
> body of LSM code:
>
> https://docs.kernel.org/process/submitting-patches.html
>
> Paul notes the 'separate your changes' section as his only specific
> recommendation for the submission of new code, that section recommends
> that each patch represent a logical change.
>
> A careful read of the document suggests that our submission did not
> violate what is the 'official' guidance for virgin code submissions.

I'm sorry that you have come to that conclusion. You're wrong.

> Absent the utility of specific guidance, Paul recommends reviewing the
> mailing list for community norms and expectations, so we did.
>
> The following URL provides a full reference to Microsoft's submission
> of their IPE LSM:
>
> https://lwn.net/Articles/969749/
>
> Their strategy mirrored ours with respect to submitting each major
> functional unit as a single patch, a strategy that was sufficient for
> the review of Microsoft's submission, 16 separate times.
>
> You take exception with a single include file containing structures
> referenced by every compilation unit, indicating that a structure
> should be introduced with the code that uses it.

Indeed. You have identified a problem with your submission. You are
encouraged to fix your submission.

> For the good of the community, it would be helpful to have
> clarification as to how you do that without including all of the
> compilation units in a single patch, which would clearly be rejected
> as an inappropriate submission.

Sure it would. Sometimes you have to work it out for yourself.
I have work that's been in flight for 15 years now, not because it's
a bad idea, but because staging it in an acceptable way isn't easy
or obvious.

> Best wishes for a productive New Year.

And the same to you.

>
> As always,
> Dr. Greg
>
> The Quixote Project - Flailing at the Travails of Cybersecurity
>               https://github.com/Quixote-Project
>
