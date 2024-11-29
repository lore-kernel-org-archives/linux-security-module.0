Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6AC155382
	for <linux-security-module@vger.kernel.org>; Fri, 29 Nov 2024 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732900242; cv=none; b=k0tcj3/EvEeA2Ol0j/q/hCeh3cC1JZuKg6ZJCn+9j6MTWw2UuXRFbm2oiOoLJJqgHdtkX8EpSz4a0xw9ZQF3JjxFVjOa9oKrIew04iYMNJil8Yne6rBqrVWFqMRUVtSEAqkCZpWuPyz+UUD+Oy09Gf27G+Olar6gm8/ZAkUA1Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732900242; c=relaxed/simple;
	bh=ipUAWFQyVuqgDsInlRPqbW5Hf4uelukuCerDJuamUZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XcAArLQx1bm5zZ7FWU8K7JQrIoL0bPoTQjolMNS2PXqwdMViOlOyamr0SqinHk1DagpDaZt0LQ09Fb/Mo7+0r0yAfj0fhrVaKNR+lwM04DOYOd0fKb9ifeEhneg+fps23+5mFIVC5nTEggFvY/Luciu9n799J0lxzd0aek19eE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=E+/gkd8w; arc=none smtp.client-ip=66.163.188.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="E+/gkd8w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732900239; bh=LsteooxahflkvrSmZUSQdAFxTsvTjXmkNywNvuu+Vig=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=E+/gkd8wonCjtFty7rs5UMVQ3cidsQ8udCRQAhXaPEf34mzL5lTma4EfpgsJHnpxEn44h16JKJfd3DCcwBddkWUzQ0+N0+n6SSApKCDsPYj3QX2ShMKSozuD6o1G38MmB3CYaLrsFqVpJx+t6q0W4GgrhUeT8f0C54jAeVe6ne4upJK1X04Rsakp4mwyC+z+Nmx4krkfi88/rredpgRrIb56tLq7eQbHtExmlC8NbGuyxKgM1gvk/RvmRSX7buBDeQROUL1V0s/hCzT3ZNkQRQYTi6CX/LUNNilyybArAuPRGdRWC+8UG8r+8M9e4r/DQ2crLyAkh/s3m7gcMeOcsQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732900239; bh=c9DKUZ+woQS5GXCDRwCY7a/BmPeo+M5asVyXptjwAZ/=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=OBkNX6lUR9TzTcohgZTtmfCtBVaJOR+VEahCa/EXUSM0BItxJZi6RpOz9SEoDqrHo4oTMpe3koM/L2NZWY3aTG4J3YSMmoNkfiMlHbA5pwRfZoFbXnqj5iE4f+QFpwOkwd0OHSY40ZnH1N95MWjKuOO63IsY3IRomTGi2otUpPMxNXGv30N9VlU7fqwF4wVsLHmRH0B4myHLXffDd5gitTrGUxY1Jsmi+4D/nuBUB9EtcFn2Gp4aDJBP1591fXROObq6wOqcxiUws2blsW3Kb69SdUPLnS1/lFQ0vKX4yoylCy15fzVYCHHycbyLvoQp2o9sB1z5JsXAao36a+xOmg==
X-YMail-OSG: liKcyLMVM1n8Jj9XybF56sxrjYinMTYpvZF9bkJoO1FVKtn9Q.JyzM2HNql5_BA
 Xi_exKGPjkgN3HEPXCg5YjH_Zssp6ZM4pYIb2gWUuNOxxK2bW.kyErR.0JjZF_9sNT9XArV8n4kR
 uqrzyJPEvFk8iu4fQMiTDT5K0g6xfIHX_3a4g08kP9VrlIgeLLDs8FT279o5tEdSZHFKotOX4wZ1
 Y7fWw6j70JS.3r5CN_jBtS_XZo6JOBHcWaIs9LItSazEix4DBto.gV1ebX3MOoeYqcHLVcL.mlWn
 63_chFr27pgDA7otGShgciFwzxdmVmBWrvrGUNSuH6HvQiLkIXZu.g1Y4JF52z3pT74aS4ZU4O4a
 8CDfv.6Zeb3UwGzuftJGCdvsNGlw82gcrCW8e1pkGiwiDk7pn4ijHVZdkEdJHLnroXqaUzrxH5xM
 fAjnelKF.oqrHzK6.R7ZIKDqjga7nOp5.REF3CDo0WH5V4k7nvYbNqVjU8gRzcw7qOh6pljSo4pQ
 qWZStsGC91uYeV4RxcOVJM25lv65BOzsJWfYCht1_igI176VM6qy6AQpSiD8NJqVfutbJYXAkTuj
 Fr2v8zCvIAQUljFqYw6mCusGvzANUNJv_V2H9yPhGnQU61ijxjnMc4gaUIjRafN4XdGckW4dBNje
 ph7E3l1SKHc3uGlb6m3g72QKzRKTdSOqE.qbLVhpDiCTBQKTX_SHTP0gEnqrVU7MHgebXKoy0LGd
 nTaKxrKvd2gDTz9ivXOOGmTvIhWjSPjVyeyc10DF_jSftjVRx1Ajb2w4EA.mwQ2AwFH3qRWcaRlm
 5gIu7qZ71Ybcf2Ym6.s3Lm8wJ5V2qY95J8xgP5xo1F7klL8k3vVe4UppfdS7eprL8bgmPPdgKLAo
 3rAyjWpBhtPpvxswBV_OpnvFStCW2_nNa4g_STQxRfZ3BYB6JHrOwz8CcEz1VujDWt5RIaYEtZzg
 _1dXgMYG7VA9g02T_aTNVg9z88NLk0l3ZExBKI37mObLEyzzKM3KNSOpBJY99hf0oDbLR7FAsrsg
 vWHciipR9unT13YRt_HqZmHObM2IuGyrVo3y4mRLsXCBR7Au6g26GUhfrAU6kOhDcsrSenlC7IXm
 bPMzKLVS7tihbTAGxPLq3UnTbs.W_werZ4BSx0cjCeSdq8PHdovbCqA..rYwQM.HSDOo4PFUhCB7
 SSPOa56kgh6OfhrTkzm8YO_ukesvd6lUwht8Rq7kfUoMdGTOceAmrp73HmdBtVdg5XwqGHv2RWb2
 MV4PgaVOrNJuJ22P55OJEFLRugZAxNoygrfI96xawWNRcMGmxXVBGVRfqFia.84Zs1IZxP6BtbFs
 yBREX0E8qpqEl9AIJhbbpF1oGN5xrj8rruTDvtjJ4wOHbrpXGyBypFkK6dUbLAAC6gtYd312_R_R
 A.dYcYqf5gdL2t5Xekn_se2.5KyujHPCuY3OiIQdEA1Hdpf0ijjvbZf2qWndV_pj48JARnCSzdrp
 50DJmeoTLKuh23EchUNGkAA_It8q0vJMTIOm_jMMerfFck_Ije2PlixNGLi8LB1pfunyKeluZuy.
 _p2ZaQTEOp8yNbwCld2tH2U67RaQvTzVMcj3QFS5SM93mSkJHwTOvj_OFNsWwkvvm8faEDzM1YsZ
 pzXlD7XdpaIAk6jVIAwM00C1eKdgf_uSNZZsjtxgxSiy1_dIeV8f7O6ECOGqQvBOW.LyKCnChW3o
 Alh404y3qC2h8q4M6cyB.kkj0wNQ1Q5sw8Mc2LYlD29QZOdhWvWNb0EfEmTsYtLSNLPBmtuY545y
 8SepLGZP0ch.Zczrc9yk8lJE1z4oZ3eKZ6zmlqjWm2qPjSClIR3EkrkrRtRie76ici91mMI4N6u3
 H.EV.Lz19L0kbYUElfW.MKhNZeQQdPBOnOuVMc0ENlr8wuZd4tige._6n8uLQ9i3jo9F4m0ZvQcF
 Leis_mIiK.2DWlbLqks8WYdEVkpHUt0aD8a5mPtqllIMqZKa.yryAgjnRcBIKxobN8QsScZKvz2E
 ni6EBMOat0dykpq9hTiOuIYT7oxnzeRV9fUm5daD82NC7TxSWiVuk5ABLLDsV7yS9PMfCR4kPbuw
 ncxAN5V92fcqEp76EaqqQwe6iCUpqn7Dq3P_hpb.4eFojIsWWo9A4eUj.goobMMzYWDma1oWfy06
 1zF4ZKTU0WsLmiFMH9RAGDvK7aHQyJqaLkXUQGcKpputoAyADgxhjk5X_nqxp4pUSUOXdKEuG3zt
 TGFVINviOGGss8fZ6EbJ8TJVzQEAF_by4Ja__ZdKQH5Rjh4l80gvbDzWa.mFp8st.B5GIoKEVeAz
 UzcoQ2IG4cI6QomLpLA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8803b311-60b0-4ae3-884e-6b73b1a936c4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 29 Nov 2024 17:10:39 +0000
Received: by hermes--production-gq1-5dd4b47f46-5kxd4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 84647aa89b54ce4dc39773525eb9a6bf;
          Fri, 29 Nov 2024 17:00:27 +0000 (UTC)
Message-ID: <ed4edfaa-3dcc-4cb5-9a01-bd04d41b602b@schaufler-ca.com>
Date: Fri, 29 Nov 2024 09:00:25 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] execve updates for v6.13-rc1 (take 2)
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Nir Lichtman <nir@lichtman.org>, Tycho Andersen <tandersen@netflix.com>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 linux-security-module@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <202411210651.CD8B5A3B98@keescook>
 <CAHk-=wjMagH_5-_8KhAOJ+YSjXUR5FELYxFgqtWBHOhKyUzGxA@mail.gmail.com>
 <05F133C4-DB2D-4186-9243-E9E18FCBF745@kernel.org>
 <CAHk-=wgEjs8bwSMSpoyFRiUT=_NEFzF8BXFEvYzVQCu8RD=WmA@mail.gmail.com>
 <202411271645.04C3508@keescook>
 <CAHk-=wi+_a9Y8DtEp2P9RnDCjn=gd4ym_5ddSTEAadAyzy1rkw@mail.gmail.com>
 <20241128020558.GF3387508@ZenIV>
 <CAHk-=whb+V5UC0kuJkBByeEkeRGyLhTupBvpF-z57Hvmn7kszA@mail.gmail.com>
 <13223528-74FF-4B68-B0CF-25DCC995D0A0@kernel.org>
 <CAHk-=wgKgi5eqo6oW0bBS2-Cr+d4jraoKfVq6wbmdiWWsZbMLw@mail.gmail.com>
 <20241129033419.GI3387508@ZenIV>
 <87h67qoeh5.fsf@email.froward.int.ebiederm.org>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <87h67qoeh5.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22941 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/28/2024 8:23 PM, Eric W. Biederman wrote:
> Al Viro <viro@zeniv.linux.org.uk> writes:
>
>> On Thu, Nov 28, 2024 at 06:43:31PM -0800, Linus Torvalds wrote:
>>> A sane setup has lots of options
>>>
>>>  - just use execve() with the actual name of the executable
>>>
>>>  - use hardlinks and use execveat()
>>>
>>>  - use open() on a symlink and then execveat() of that file, and get
>>> the actual name of the executable behind the symlink
>>>
>>>  - disagree about comm[] being relevant at all, and don't use it, and
>>> don't use tools that do
>>>
>>> and none of those are wrong decisions.
>> Just one thing - IMO we want to use the relative pathname when it's
>> not empty.  Even in execveat().  Because some wanker *will* decide
>> that newer is better and make libc use execveat() to implement execve().
>> Which won't be spotted for about a year, and when it does we'll get
>> seriously stuck.
> For clarity the only patches I have seen so far have been
> about the fexecve subset of execveat.  AKA when execveat is has
> not been supplied a path.
>
>> I agree that for fexecve() the only sane approach is to go by whatever
>> that opened file refers to; I'm not sold on the _usefulness_ of
>> fexecve() to start with, but if we want that thing, that's the way
>> to go.
> The craziness is that apparently systemd wants to implement execve in
> terms of fexecve, not execveat.
>
> ..
>
> Wanting to see what is going on I cloned the most recent version of
> systemd.  I see some calls that are generally redundant.  That is
> systemd opens the executable and fstat's the executable to make
> certain the executable is a regular file and not a directory symlink.
>
> Which seems harmless but pointless unless something is interesting
> is going to happen with the executable_fd before it is passed to
> the kernel to execute.
>
> The only case in systemd that does something interesting with the
> executable_fd (that I could see) has to do with smack.  Please see
> the code below.
>
> Casey do you have any idea why systemd would want to read the label from
> the executable and apply it to the current process?  Is the systemd
> smack support sensible?

Smack supports an attribute SMACK64EXEC, which identifies the label the
program should run with. I haven't looked at how fexecve() treats this.
I would think that fexecve() would have to respect this behavior just as
it would support setuid and setgid bits. I am looking at the systemd code
and it emulates the exec() behavior, so regardless of the fexecve()
behavior the program will run with the correct label.

> As it is written this seems like the kind of logic every process that
> calls execve will want to repeat.
>
> So I am wondering isn't it easier just to get the kernel to do the right
> thing and not have deeply special smack code in systemd?  Does the
> kernel already do the right thing and systemd is just confused?

The reason systemd emulates the exec() behavior is to allow for the
case where systemd starts all processes with a particular label. I
don't know why it uses fexecve().

> Right now it looks like the sane path is to sort out the systemd's
> smack support and then systemd should be able to continue using
> execve like any sane program.
>
> #if ENABLE_SMACK
> static int setup_smack(
>                 const ExecParameters *params,
>                 const ExecContext *context,
>                 int executable_fd) {
>         int r;
>
>         assert(params);
>         assert(executable_fd >= 0);
>
>         if (context->smack_process_label) {
>                 r = mac_smack_apply_pid(0, context->smack_process_label);
>                 if (r < 0)
>                         return r;
>         } else if (params->fallback_smack_process_label) {
>                 _cleanup_free_ char *exec_label = NULL;
>
>                 r = mac_smack_read_fd(executable_fd, SMACK_ATTR_EXEC, &exec_label);
>                 if (r < 0 && !ERRNO_IS_XATTR_ABSENT(r))
>                         return r;
>
>                 r = mac_smack_apply_pid(0, exec_label ?: params->fallback_smack_process_label);
>                 if (r < 0)
>                         return r;
>         }
>
>         return 0;
> }
> #endif
>
> Eric
>
