Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6951F6667
	for <linux-security-module@vger.kernel.org>; Tue, 21 Jan 2025 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737483012; cv=none; b=mPhsmRd9vGPAMVDvCNJ691LWQhVF4D/zZWp6RTwLLKf674v56n5uZAlGoNQvh564UYolocM9phQfL5305STBqKiPh67OfIvQ31Vn6//pj+9/PRlHaLpNQNivZR81+L5975B/paAm5keO1+JSW46uThghBzcPbMwFqdQO+aMTQ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737483012; c=relaxed/simple;
	bh=kQ46DTC406UDl/2Ymo9WgXs6JwmqnkDytQ4vQ8pihIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JE54lOLWjTH/i58KjZvhlhCKJZGHSLnIvmP+8K+ojRv8kuPkKdxl4agYvBvDbNnRi0xTnmqMfVgD1E7YE6Xxpo+LvtCURABwJ/mQQp1PkPUGirvcIdPD/qKcomiXZjw85Q5tR15P7vjGeTIA2fTcdzsLRLuLeOcY+FWaDJs5Zwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=PFTsvV1z; arc=none smtp.client-ip=66.163.191.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PFTsvV1z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737483004; bh=bENKwb71nO21H3Ixtiy9hwJLu92Zf8U55zOaAlFmQNo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=PFTsvV1z+Ki0ZsdvaEBmTK1mNMCQbBa/bMCuPIlRqJ3a/XxHFLwn/BR8Ho0mdxo2wmgcBjhxhy/qKOInvegRSEq20mMcmKq8glPoh6SqOjU2SL1b6WYm0xJEhlnB9z50VRZ41m3UDr9GVSvlMs4EyJd9K7F0Q6F3XE0WOgY8Ndy1Q06AXt82rOgGJWtYePp2lZQINP2ZjvHMlaafLLKyK9/R9WDGOjhxmXGGgPmvCLlAUxs1SRTKt9MmLFXu0qwvKbbhK8q3cYgGIPH0pNzVHC/9ss97kf9d28Qrl8XefiexD/CVIJjIKq2B+rV+qeG+HztcvJS/Z8lYhx9CkjdOVg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737483004; bh=EkdYx7f1x1nNhhHrfPiSy78jzbtMjKCNEAhDQji1Faw=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=nQAwioZyevU3lS2y8mX+JMUYyHL4J9H/OyamSJGAXAUdEJVMsSToFWSjprHllFc3pQTpQwJIlu2NK4guG+OaupyNnVgj9uAwUj4sFPm7OeCjsBddyztsvHfWeSwXEisApKnH3k0IgPPbhAK5SRySEcSYoJAhtt8Zq/jYxbJR6CEYeioXyhTnyvdwP83Xmc4Is+v1fONImOVtt8LhW1U/iBtKZni958TYtLZAFFn6jbdZLiRzWOgk5TAOQ2Jphpj4bymbU9NVihsQZxCzECcG82Mz4H8LzFaGCic0PXoisqYJ6gO8GZlxrK8jUW1UabT4ULaL1lClAqiAFi0V+SO2+Q==
X-YMail-OSG: NsaljrEVM1nWlRajOiPPr.gMAZYpgMkTsFkQwrqVQAMpT.ygn5mhc61bpapNv39
 lkuMmTTh.mlZgxMW320cUHQy3ilt.WwrRtYJZkNyBpPiIg4N6FfGRsDyVG4B.ZdseYnCiVSUjA3N
 WhCEMNkJweiyiXcmmP84i6KLK7uYsvk7Rl6n0PZf36Qlg2QO6mpOX9ZMqRaX5zxe6qtYMzhUMZLz
 AXVB0xUtKVJpIq9F.BayHSuJ6A.1LrPueIp_Ojpst2Bul7khZB3.HdK3qqt7X855O5zhomBZZyNi
 gYRGMvLNuznseOm1zRXTPikSJVDLouyO3ccNjCcLHCe..h4qVCX0puHmP5GzWx2oBjrYuAvFNmND
 bTJUvZp5PunG2iaLAwHa0BH2wUyKYlrZ.ai__Y1jrLGLdebvd7fV2JdjAAWvZLziiRsVN_KrbGL_
 FAXwAydU.Cn23wolvmVBuWfCb02kuHpj_Iem3X.yILUVCp5lHbad.sT4Nu5duNVtUfi.UTKJbF7j
 _k6bs2XMTdRiNtRGN5g.bHctdVgMYjQ6fjQyswv8NqAfA7tITI.3_zdTPNXGUrERGVNdjHSsUHBm
 L6FE7wo0rFjsxxUedt3ydPw5BIyJzxGvIXFBV1nhOG3lkBVnDa.AaFRW0soDCV6TVva.VfEd4BP9
 hwWh2jiyOgX2k0F_K.FZendFY5EZmR.sc5_.H5_jiPln0zqroMvGTHcqCJtdDJgFuVvzb4YhJyke
 IK0UU6TYL3doQLxr0pNNJuPPKKmWDLaZmfl6n5EzUqLfa9u5HK2hiC3Hz.2MQqXOuK4C75PNdkvI
 oy5q7qo2w3pQVR3enkdMXBP4k2q47LFKRbTN40pTiYU.5lOwGcODjAGLbLBVLs7j2FKx3pu26hiT
 jv21r32ixV95MTo4X._ZrDOmlGk76Y.EVVkQwA5yYln5FNCHwI1eZ2WifLZTtUcejruWpUWc4_Xg
 VFmOTUbOejiaKYAqlDU85dl22Y_r2qEO5wqksssfykbS4HUBMhuJJpdrqUjozeCNQQLvE6NkzqOt
 vxjKN2OkN96cCa8tukZNXIIP87bN2EAFBxloR6wGf3o6j6.Cc8yaOwhvZe4U8RrahdPkgYJV56Hq
 xQnydhN8nVNG.tuIJJVs_NcMggXp6YAiNp1zNDFemmfPP27J715zEfK7xvE03re3OQMTEAG8j7gQ
 TXYoJxdIOpCp6XxgKx7gQmC3AjLS99oVVMpnXWsX3MIPQkZ3lr.7ZjN17JT6.fE9p0k1yYi3AJ0S
 2w2atxyzRVPLbQdoKNgi10CcXGgDA.ML8pVJI8JNhJf0SbzoGK788yGO2NXHHowVoEg4gW2dzbxx
 3lg.q0MadAAwvI57UsFzl_Ou_feRUkVYLF.lU1McOHFbPvb.K1CeGCbc1ALBS09qDZVyGMN0SHNj
 epXdrwROx0q8ckrSPfLIOTsJYrOGrWA5yDRJETANZZP7DSArxSStZr4OYzpVngvvBe9BvwEhQL2p
 SxIoF82YBK4jjdyf73rOOf1d9GaLYCbG7oqd5e_EyBHaw3LLedUrZObTjN8aKR6QzJ1BSZOsWSi6
 ygcH8tkxAZvIhPAYeZ1Wsh3MP1VVCo5Tl_aRWIYD65rn7Q5uXhE4v06jpe7MnEXjMkHasTA5qmjN
 .Rd_TD83B_5qiTKDWMH4CzKaffq1NkpgK1X.2PaWCXhW8EW7o0NI04kAbwNKKR94a4f_sZK47Q._
 F9HQSXwSu9y3YwR2sZ9Rk7HMrIhwjZ7gJ7RA75lUYThqbw14EfM0WuF65uazIt8HKUT5_UoBphll
 SEXvPyXi76_mVVaGb0MffSSwG3tGGJRrvc.FG3Go_M_2Ic6INBgqMVd2ioek2oPo10uwUs4YZi8V
 52UPL8sceV1NfMIiI_n1Y0gx6SxSZ2RtSZnlGcsGXor7Ae3zGJJyfsy8iMutGT0DKqu94rnez5yr
 v.yr7ZbJpigBW92jtoZxmp1x13GZ55s3f8DYdK2XPl8OQBKRVHyBv0Imto2n11rZin88lt3BeMyg
 AkZ6qpXWZbvQlf6N_AkTZ5e3GMbawt4wVeRBtkofv8UGmHftJNusBa.oVEOUGm13d8gEAP3.HJ9f
 DEklIg1_zqYoP9wp93KUOcnR4uqnR8OiAj9WUsPEnb8d_10n5oD8_YxwarUyiolAs4sCYyKhZKm8
 qu2.9HfUvCLnUVrpQpQZv_JKAhl95sW2G.I8Q.6icwYmJtSaUnIzqTaYVVTP.aEd5uoNjnzVCarh
 F1CS_cse2EQEwj1ZV4ZPgLHz6_pXXfh5i
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9baeff52-a1b8-4ab7-9502-c5b8af608f62
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 21 Jan 2025 18:10:04 +0000
Received: by hermes--production-gq1-5dd4b47f46-9j75b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5add660a64c08cd2a16bdaa82ea6b3c7;
          Tue, 21 Jan 2025 18:10:00 +0000 (UTC)
Message-ID: <d61082f5-7426-48cb-8d64-3d8aefee68ca@schaufler-ca.com>
Date: Tue, 21 Jan 2025 10:09:59 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/14] Add TSEM specific documentation.
To: "Dr. Greg" <greg@enjellic.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, jmorris@namei.org
References: <20240826103728.3378-3-greg@enjellic.com>
 <8642afa96650e02f50709aa3361b62c4@paul-moore.com>
 <20250117044731.GA31221@wind.enjellic.com>
 <1630b5cd-c1ef-4afd-9767-7ebf3c0cc7ae@schaufler-ca.com>
 <20250118190346.GA9479@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250118190346.GA9479@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/18/2025 11:03 AM, Dr. Greg wrote:
> On Fri, Jan 17, 2025 at 10:10:30AM -0800, Casey Schaufler wrote:
>
> Good morning Casey, I hope your weekend is going well, thanks for
> taking the time to forward along your thoughts on our work.
>
>> On 1/16/2025 8:47 PM, Dr. Greg wrote:
>>> On Mon, Jan 13, 2025 at 08:29:47PM -0500, Paul Moore wrote:
>>>
>> ...
>>
>>>> Please define the CELL acronym here as I believe it is the first use of
>>>> "CELL" in this document.
>>> FWIW, CELL isn't an acronym, it is a metaphor.
>>>
>>> TSEM was conceptually inspired by and derived from the Turing Abstract
>>> Machine Model (TAMM), as applied to the problem of modeling the
>>> security state of an execution domain.
>>>
>>> As everyone reading this knows, a TAMM, in practice, consists of a
>>> head traversing an infinite paper tape divided into cells that direct
>>> the next state of the machine.
>>>
>>> In TSEM, the model consists of a Context Of Execution (COE) with
>>> security definining characteristics, traversing a finite set of
>>> measurement points of infinite length, with defining characteristics
>>> at each point.
>>>
>>> We refer to a measurement point and its characteristics as a CELL in
>>> deference to the inspiration for all of this.
>>>
>>> We will add this explanation to the documentation.
>> Communication within a community as culturally diverse as the Linux
>> kernel developers* requires that you do not assume that "everyone reading
>> this" knows much of anything beyond how to type "make". Let's face it,
>> there are kernel developers today who would look at the Turing test and
>> say "is that even a thing?" There are others who don't have an education
>> that includes mid-twentieth century technological history.
>>
>> [* Yes, an awful lot of Linux kernel developers are western males. ] 
>>
>> ...
> Sigh....
>
> It would thus appear that effective dialogue in the Linux kernel
> community is now about as perilous as attempting to square dance in a
> minefield with snowshoes on.

This isn't about Political Correctness. It's about communication.
Your documentation appears to target PHD level computer scientists.
Most Linux kernel developers are much more the BS engineer sort.
I'm not saying you need to dumb it down, I'm suggesting that you
could make it easier to review by targeting your audience better.

> When we penned the reflections above, we very specifically didot
> want to be so pejorative as to suggest that anyone involved in this
> endeavor wouldn't have at least a basic understanding of the
> computability theory that all of our work is based.  They even have a
> movie about it, presumably in multiple languages.
>
> In any event, we apologize for being mistaken.
>
> We will add a Wikipedia link in the documentation pointing to an
> article on Turing machines, for the benefit of the unwashed masses now
> involved in kernel development.

The link is a good idea.

>>> We believe there is a technical solution to this problem as well but
>>> our work on that front, at this point, is too technically immature to
>>> go into.
>> Didn't Pierre de Fermat say something like that about some theorem
>> or another?
> ...
>
> As a Quixote team we take some solace to your reference of Fermat's
> Theorem with respect to our work.  It took 358 years to formally prove
> his theorem, in the face of many nay-sayers.  It turns out he was
> absolutely right and his vision is now universally accepted as a
> foundational premise of mathematics.

If it takes the Quixote team 358 years to develop a technical solution
I expect you will miss your market window. :(

