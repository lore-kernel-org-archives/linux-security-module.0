Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CED19F118
	for <linux-security-module@vger.kernel.org>; Fri, 11 Oct 2024 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669683; cv=none; b=aAMJMlftSTkY1/w49PJ2uLsfGX4QhsJdOhapbG5FWAjb/1H0zcRCWs1RQxexXwFET7FQottt4036kBdj1mN4K+n1ManrXxBWPQhgcHspgGMaV3IQKvCjjd7NJWY12U7S8HTKe4SOqzZib7P1jkC4PWAmcYbIoHLzL6C6CmUcUzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669683; c=relaxed/simple;
	bh=h9sy3AusCRKy2qm4CUs+WPB+D2ZOAF/+JCiNkAUrUh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cRkyR9xuZMcHM8vPLu2VnUhjSDmJNIeOTwugAqHbRlOG09sS+Qa/lA2pdPEOqPhbVfvtUl/Brk7OsQZ1NEvzYLFOhaZLx3eiNq0rX/cQuErEKEu18UXkVs/FtRN5FhLQk+9YQ4Ns1lih5JixwuVqSIMTNmU8U7KZUKbhRMELwaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=rtlwow9b; arc=none smtp.client-ip=66.163.185.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rtlwow9b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728669680; bh=HIh3w2Wv5OrrOmgES6g2plZtYM+9vbHSejXtUulIfvM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=rtlwow9bUxzL0/yBy3K2qzylw5K5I8G7KQLUkmoh+i8yoSmTIRft9Av06RcprRZ3K4GjLG2wkqDntl4BEmQ3Qv3XpDH4Kkl6yjp0+tzbqJXvjfI4fyP5DN58XbjZfwOE+HzJp2Xu69dMJu0d4fFvfkl2QU0KgZoZsDB664cB/ouKwgHGiOgiPo+IuEVHhL9kgM0dHcXheujTclMN2ZiozO7uZ3NugKSnPfQpkprz8qbrWQOcOM6j23pt8belo04LiIZc/XIr81EzX/hbNp9RrrppASbyqxYXVYHTjlWIE6J0rPHJ/7tyKU59qHUhBxTZP/Z8KchbupE5HpSuCZmlJA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728669680; bh=CEp427t7pg4UNfoYMUMKQlwGtoC71xIEWh5coHwwuIW=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=V+LZwR2IH7qnPKhpoKZ6GFBTgZ1mZVbAlVHh1CYEKQnN5WC7jM9T5Z3Q9jj9+5DPCMofNr+/Z70GpailKxxemuu1JW1k57XVzmJ8qXbf+GKBfgrse18Y3qzLfJpmssa98iueE5VYJLtqyKorVUiF4JOlQAqiiPY1JO1t0EdtZatPzzFVi+d0/bT2Ddi/Uw5quzwQcWGjh+HuCnpTEo/cvbGiYkruKVsLNsLeCfGaBvpv2Q0LbyN7eZu0Liotw6tx878ckW3f9HG6QKD2pqSykNhiaqBRGW1uKRFcNAGKqfyTJPd7iEJZNwO0fMVdKnDOWrIay1MiWGeYtKVZEiHg9w==
X-YMail-OSG: nFyRJKsVM1l9ru.wT4_SHVhEUM5ex_iHy06TlEdVnUOu5FrUQsFBbb23TnhsYhp
 svvBG4Taq6zelgPhYE6BlKnUTWh47nPNyEP8Oh86P7YaloYdkH029oApT1jcmK52uISCs3tXYBNH
 q.Z.xUYgPkQQs8qZ2b15Qc5ZhRXJl_Xt8gW2vdmYyPSl3ykLKRFd5pUFq80yGCqAhaI9fFgeVaSc
 .Z9pWsXBrB.TY8DXsDU78aQoeUzX1SIck47lqLCpo7.EiGUrv0TK.FKd8l1zMd8M6FkCtCOmUR_n
 2.r7Y4FBnzhq0H3n1Y25iWmjFQ3v9tHLPDLNUuYHVrMXSYXm5jkS1y7l6uCZjHlzY7CLDR1TDqbd
 PY35c90HXWPeHzvL96sSg35DXGko2YE83_8ISP3xDZyxKxLiXThhIT0U79EZh1R956hPdXXS9kiA
 7mBQ6l9zfYKDfCaF0KzHDguECNWHjq.wjLz7WHB22cKlzvpY__qK_i4tGgCNKtb788DFl2RkIOuS
 FjmJBQV8wpioiUnblABxIVIdRzaDCRhqh4C78scLXC02ckne7lzQ3cyhcsoPuQ2IEQu.4POrJxLR
 x168N6.hK3sTJbUKskU4K57b0Y0oyaKXASv84vFknDRqYgH6y5BOryKBBZ0nlQ4jG8TSOL4aZacU
 8Kf.eWnA3.xAsU5Yg2LBPYqh2Er1LvcXcOOw9f1OWUuxxAmjasnW5OtM5czkJ_8uPquXgOiQ.gmn
 ZCj6B1BMhzHFu93oM9b6o9lx4R4ZeiKOLgHmJUs4xcp7CgIfFutdAa.5uWgpF3t8qrmTBng9zSri
 TJeuG3kBn2QPDT4Q9jSdLUZwW.M7jp8OHEvBJ_CHw_rGA5KTSMysNjV3UIhM..uHTs09MeEp9p98
 zBJXpmrh2BbGXRIWe2YJE7wI5C9QGsndkr_uNlVRZUv2zHTY_eA7lBzxfcEzMYNGELse7ji0iTGI
 B6A9LvMh1d7ZuSH8MyQE_uAmMhOKxN2AtVBfVHTp9h6xF1gSkxe2lnzB0OfnI0jwU275ME0.a_ot
 6kzhexXqXrgQtOY3EegiFO86.PtB4_D9qMhpQwnJsfPRVLtd0JBk5RAWCVk9Zx1FO39jA6FOJKJi
 GndbPLVgUHO.PgOUGwo_A_dJ72q2QuuNsR1KMoFRoSc4iabgOq3D8z9ll7EhK1CpZD1RXx29wqkP
 Os3qkkL1eOmwEJSs4GU13ncbz9KCodiqP1A0CUnTrbGWPOOKN0calGGB4HZNOuWeo8KQ.QAuYnOj
 B_uStj.5wBWsc.wWcAR0NQgXATQJ0rg2BmY2fl9zURvmNaCdGbvpHO7uVO9BXR0lIZqqqZaIhF1d
 6LpSbSdFgz6XHQSZ_Z9VvFcexyTCmEI0v3nxx8p0IUDLt1W6PRiNaY0XqVeTt0xyvlMGXIqijlm8
 rjtHmNoQnyMYp6RAJvRaHPOMj5So832QNJjJ94QiPVMgZIxwDERvJiI03tRzccpbaow0kCRR9t0B
 SE_Gn7yuIdlthdsESr3SkflTyfLvG1ju.KhH2TV_csDk4ZvCBdsRCUcdwLnm97LpR5uPsTqx.iP1
 w1PWEkdZHtaedVgCh0._jX16dK48bwYghoeCSOhkJLHKwMf3h1TM4NNSsj7LZsOZkMHN6gpkRcK.
 sGeZEl7.ftotmvX2bjMvvj5S__v85nvYn5igeKaTTMRR3vGDUyuU2JypcftBOFAKf1DHtut9phhg
 _.0VvxA0G_Pj0UZVC2nTcxTEvy1j6mHJVHCRwZ5PB0t7kBpwxRjBAlV81E3621hI3arUvQOlvoKE
 nDCzRpcSOVcWsTEhXQlFTsmcWY934iWInyRGkgV.kBMC5AFifYKzRJPqaDPNeg20ibJcdTMTYM5K
 MVhadzWGtlPEqoV5N_BecoN0kDF7cAD5niAvI.hPCtK6gxq8Q8kWYp.VwoesqtzcZW1bvc8nB1qk
 AE89VI3ZzQHJQDFGGO3EJ_3hSIoQb19G2BIwpxmW4EkTe2RQtMf2QMANoXArNVlZeUQIQ9PIIVVE
 6ljsFOxsoxKWQbkhhavotcZqhAV2LCaO6yQd8z6XDWKhGrVBbQgxt7.3c65rg99Srq4BLgxBhwXr
 oF2Ocf3Nu1Cz.1a5PD9Vvj1DwldLPUSvJAbckmWrGrxt1AKq5PakhM.kXLMzIAP_BTl508DEUOai
 qhixFDIglAma904_dHbH04ZCKgzFgqrC4AtOsQTAi7nrmRHA9gwz_Z4gtoUd0kLPKDBPoIw7Jnh4
 7HjLjvGL9.JUgTHh7LA1mylvFm1k6HeSJA_UlBbpsg2GiMpz05Rmbu7qkyxw7gGitygEQe87s_Pd
 MxubrNFZTteKjAQZM97tUMAlK
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f2ad06a5-4ca6-4aa6-bf9e-e85f44e27abc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Oct 2024 18:01:20 +0000
Received: by hermes--production-gq1-5d95dc458-rx7kt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5098af3afb1e52fb594a7de9db1133eb;
          Fri, 11 Oct 2024 18:01:17 +0000 (UTC)
Message-ID: <dee25159-4d17-4f07-9ce5-5d23dae81301@schaufler-ca.com>
Date: Fri, 11 Oct 2024 11:01:15 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: "Dr. Greg" <greg@enjellic.com>
Cc: Paul Moore <paul@paul-moore.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 LKML <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net>
 <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
 <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
 <20241002103830.GA22253@wind.enjellic.com>
 <CAHC9VhRjq4B4Ub7kbD8uLZxL_CKSm=z+poCXBMmcfs=8ETHj3Q@mail.gmail.com>
 <20241008111442.GA23889@wind.enjellic.com>
 <88954576-5e62-4d95-bdf4-3913ffea68c2@schaufler-ca.com>
 <20241011170617.GA5139@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20241011170617.GA5139@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22806 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/11/2024 10:06 AM, Dr. Greg wrote:
> On Tue, Oct 08, 2024 at 11:25:16AM -0700, Casey Schaufler wrote:
>
> Good morning, I hope the week has gone well for everyone.
>
>> On 10/8/2024 4:14 AM, Dr. Greg wrote:
>>> ...
>>>
>>> Which we also believe justifies more attention than what it has been
>>> able to receive in 20 months.
>> You're right. You're also not alone. There are things that you can do
>> that will help get the review you're looking for. Developers who attend
>> to the needs and preferences of reviewers get a whole lot more attention
>> than those who fuss and fume about not getting what they "deserve". My
>> hopefully constructive recommendations are:
> We put a significant body of code and engineering time on the table to
> try and improve the Linux security ecosystem.  We did this because in
> certain circles the value of our approach is understood and there was
> a desire to have it more generally available.
>
> We don't believe we 'deserve' anything, review or don't review, it is
> completely up to everyone involved.
>
> Believe me when I say we are perfectly capable of supporting our
> constituencies without contributing a single line of code or comment
> back to the good of the Linux security commons.
>
> Our aggravation in all of this is when statements are made regarding
> serious and supposedly well understood flaws in our approach that
> 'everyone' agrees to be the case.  Statements that are a complete and
> utter crock of bullshit meant to simply gaslight the situation that
> has gone down.

Inflammatory claims regarding motivation are not helpful.

> Hopefully our choice of lingua franca is sufficiently simple and
> unsophisticated.

Err, no, it's not. For a complete explanation see "When Jargon Becomes Gibberish":
https://www.youtube.com/watch?v=-7cUnID7vFs

> We would, again, encourage everyone to re-read our previous e-mail
> where we outlined our concerns over the status of the review that did
> occur.
>
> We do respect reviewers, but let's engage in some sense of
> intellectual honesty.  This is not a situation of some poor lonely
> overworked individual reviewing Linux code in their mother's basement
> at night in Gulley, Minnesota while they work at the Cenex Station
> during the day.

HeeHee. There really are hobbyists in situations similar to that.
I've been one of them. To dismiss them as fictional is pretty insulting.

> Paul has publically stated that Microsoft employees him to maintain
> the Linux security system because of Microsoft's concern for the long
> term health and well being of Linux.  In case anyone doubts this or
> missed it, here is the link:

It's pretty rare that a Linux maintainer is paid to do nothing but maintain
Linux code. Developers who are qualified to be kernel maintainers are usually
in demand for other, more directly profitable, projects as well. I can't
speak directly for Paul, but I would be shocked if he gets anywhere close to
half his work time allocated to the maintainer role.

> https://lore.kernel.org/linux-security-module/20230608191304.253977-2-paul@paul-moore.com/
>
> Unfortunately our experience seems to challenge Linus' mantra of:
>
> "Code talks, bullshit walks".
>
> Perhaps times have changed for Linux in this new custodial
> environment.
>
>> 1.	Lead with code. Save the documentation for later.
>> 2.	Incremental implementation. Don't drop the whole mess on the
>> 	reviewers at once. A patch set should be a story, with each patch
>> 	introducing one new element.
>> 3.	Emphasize the similarities with existing implementations. No one
>> 	wants to deal with novel or clever code. If it is familiar, it is
>> 	easy to understand.
>> 4.	Thank your reviewers. Complaints about review latency typically
>> 	increase it.
>> 5.	Do some reviews yourself. That will get in the good graces of other
>> 	reviewers.
>> 6.	Be brief. The biggest single problem with reviewing TSEM has been that
>> 	doing anything takes so long. Multiple paragraph responses to an issue
>> 	don't help. Say it, say it once, say it in small words, and use as
>> 	few of those as possible.
> We appreciate the insight and recommendations, we will see how and
> where all of this ends up getting litigated.
>
> Given the zeal for simplicity embodied in these recommendations, we
> will assume that adversaries targeting Linux from a security
> perspective will also choose to limit themselves to simple and
> unsophisticated means and methods of attack.

Gordian Knot. Alexander. Just saying. 

>
> Have a good weekend.

Likewise.

>
> As always,
> Dr. Greg
>
> The Quixote Project - Flailing at the Travails of Cybersecurity
>               https://github.com/Quixote-Project
>
