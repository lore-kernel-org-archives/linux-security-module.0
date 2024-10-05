Received: from sonic306-8.consmr.mail.bf2.yahoo.com (sonic306-8.consmr.mail.bf2.yahoo.com [74.6.132.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3705D15F308
	for <linux-security-module@vger.kernel.org>; Sat,  5 Oct 2024 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728154735; cv=none; b=OLXqF1WQStVocZn/XwHe2L3oVzXjXKQhEaZli/igqF62cU+C0jrSbTBUHAfqQ4cLpVs56nxa3ZaFME3EozwzNCjhOaDQWP50UySnWmIeWjTNa6JaGq70lwgM0p0EyZ7F+eosd+Y0IR0Mu9mNytnyuoH5M3O4u+yYUGMPhF4BuEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728154735; c=relaxed/simple;
	bh=EGUZUsGH3bni2/O0x/J826wtUjzFB4oTmKGiEXj9zxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ard8Ln10XSqEtLEzbWy6iR8mJXEYg1iwSh874PvSu6fm0o+gldicCdxRKbz4NlGIcv+fRalsNCaU6O9uvcFOU+EGk67zGlAgKZJev2Z75zA+zwvFNhqfw3iezJcm4rQGVYK3ccu5LkYtcUPRc7s7AESwIvOfk6ogTtIwPxs0/RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=YoqV76YG; arc=none smtp.client-ip=74.6.132.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YoqV76YG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728154721; bh=/CIN2qmiMEjLe/7Uvj1NzDu8Hcy5JRL8ChgTN+w0wSQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=YoqV76YGP8oKij1RvvbWCo17mu5HPUWua1VEVBxGUOPGCjmGle9Ai6VYiIfWrsunJcxRPO4xGPfW49F7avQxoTIu9EuW07NrTr1NlhIvAQEMxeV1Yb8HmNERDqHHUO4/x1kCWq/iHo8+t2QrAadCJ3iMSuP81CBmK37BthZl29GFktO/1Uz5UJW9mHMXuQx18OzQ71ZMcLhsuMY8IKvMYf7OthcR1h23nrXEtldINeMyFJgUZUNJV682Y7CqIY0IVuV+5LJlLcbXpgxzCaefFjStcGh2f6XjSuSnxgd9iGqI4phlzGf3OP43Lco5gy0SZyRhdbkHy3c00/EAtqN6nQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728154721; bh=x4Jd3xqFN9YW9xLtkW77rUx3qYdl0WSSsMpJwARDjJV=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=HlvngCTTw6tEvzPbYMJcZ8iegiy++0eQDePns56zh8VDMmi/6MihYPymesg4HzvCtt1KL0toImhf2estQLYMpbG7ZeITODekVUX3qitC6qZ6Iv1s4ZFIJw9TDoZgYHxOqrhO9ZwNCJdGf55J+Gs4t1UHp+mamYMPh5K15qy+bme/6WYwZT9jUyO9siEId+DDgdA5wC7ZmL/kCHBG6ScQ4DXM1non4mYLnyVy+QbMXYluATUNRFygXEHrmqBK3I5sUWb6NWMNx21X+dSCCbXV1yOSshxPNhitK0I2yBtjLg51sCfULGl3IxXW9W4DWlpBPm1F3qVu9u7kmso8bXHPIg==
X-YMail-OSG: VCXPoLEVM1lCIWhFwG.9fEj8.g.RXoglIbqVVnoWWG1sybhA1BsTZDr66gQ3aIG
 jcXNrU7L2h1anYR46w5Y6K.Tm5FiQ4Hkx1y8BSM188WZaILx270sSdGKHWbtQQjVW7jjh.BsSdqF
 DFd6.vq1W732tvxaHFcnEJmHdplvLAKschcFYXlxzEcgero7JJNBE7H9ek_XSHt4MUrW.6vYyj4W
 jqNDYvyZd5FA6_Hc3q7uSq2h37_h8JAUKGH1oeh5Yxu36qqj2Vis.y5d0twZXnu_JLK8UuPJsPIg
 AmqPYgFP99nk5YD.oKWL3Oz2nJsBPMuVHcMvVkdarA8tuLfefD_9qtsmW7EnQo3wJbnIonstJRpe
 tG2snqoXgxqSq6lL84QBCEItWPIUyG8M4ZKlvzAHfkrqjEbZSD3axKR1p3G295EipYQxGomJox0x
 u1.Ng1K9tk56_LBtj61IH9XDQ7cd6jCiS8kkFbTFptz.nJKgeMlbnw7pmpQTeJ5YCI3kHdhyc4Cf
 gNIJ.DdNN7_AoqqN1RgWefsMALKI3QAJOoYuFuRBwCAukGRmHd9.aYf9lApJDgbhUVuJS4CnCaIG
 zr2mySG4xBSAWxRDisnA6KWnEGC7wOObFm2merU5vj9AV7Y7By40Apiitz6SwaI2FNyw7opvHKoG
 sjUr0EqMddRksE95ZCC1Qy7vS7pSop4DHg.u9UEJJRJRX2Qz_3b3DaI3154picYqnEXznstKjnzj
 LBiipftliBmbEBgHPkDGN33ESP02AzFNIncvGDnvliNo.UWnxvIEPkSOlc5s6iP6iFsKGRPSlPsU
 MToRqa6S6d3KBWKN06Gr06sirkv2P29frWOAzlrXMquCbxL7bP8Opo4XGdj7eX70iJTN3QnJGBBi
 pRM2yp8n0_V4r6ZDE3XVTSBTc0XK.Aq0J3UsRMaUVw6xFbKTSyj5M3yhGnTDK64Oq6wBgd8vOsP5
 Z6mFEdeJUpWBTxJ9vbUiEbqRsWMINxxYrQTXDeWA6EqPuAnmJm2_bjk8qSnmMhN3PfBT1yVFWetC
 c2ynWsOlgwGr3vmB7NqXLGaYjy23bgy7tLlNYKVJ6y4A_xK0fXzaL6h0Ys1rPvugVx7ucnqelpQw
 DpjxkSsgM3XuiN2nfLo4qmSg8ghZ9CAw3uySjMZNrG2NN2GC8LEM3xjaEbJLyhOrfG_b1Ny9dTVO
 ePNk2o8WksRKmkwlh0Heq0gEtMQFp.DpFjF29NNC_pHcz7NnMo.BuRO7sGQdfKBidlMQ1YDk1JfQ
 FOrWNQMSoZeca_FT6bTRUCQ67_QSoMzFUdDoc6zWhXsvJrEqZP7ZECmXLwT_OBr0MnCYBDTMqMOL
 oGaMdkrkLSoDYqjYYH3GthQD_A3DSr7Bbbu6W6OPTnvFC1l0.uL0R6E8BX8UtG8uN_1Iiiojp7p3
 id2mg4DjNg5_ZPmgag1RWKG2Pzxf_r1wuqOQcbZxJ37idpjz_tOFw53UqSkjwcdoyiGWB4pzt6Gg
 sP8P63QtuyL19kcToE_ur0zXfB6yEcpwpT5zob0qwUXBQ3._Mpl9QSWosA1mdVgN18f6ZxGmy03e
 JcNFb6n2QZYqOGkr8X9GPxo9f_Uc1W9.7um5xcP_bM7md3FClBcpiwqKYOSQGqN1SD5.qABDu9Sh
 G__Trn3w8QGl5sURUbnPd1jSRvAxG8piMrbIhO5U5ga7_UzetqD.HHCWCTKE0_j000oDe38Wv33n
 AusLinXqx1HChO5oZP1o2rXLFm6k.xuDoHrW9qxSynGJmhICtBPen.Ug0BSmGFa763KtSOm5nAAZ
 IvLCp5PRbUErWBTkOm5xwr5AQCEaP8CosIGpcYIegn7UWN6EMuCXZi2e55zMTTPWu9EKHGO8L9XV
 UWjkEzgBP4SNiQot3PXJegTOpBDY84cBSUJklMcikWgjpCKkX3.7HOZq3ZG.b6r0chv46mJqDXU5
 APUR5jgmUEEsnoCa_O9d0czLFXSD66AiPrvumcS3BxejLQsXipqLgJYvu7_otZ8EW7UnASaLTiL7
 G7u03whKTWbAkWtIfABl15ofUOu.fLejAtnbRi8HTzRDoCPV21MHDorh2OEoS7bbhbgL_T4bKBEp
 u.Vd7bMhHjpVlStmRz2seeZjQqRPklu7wLgloV61W3k8Gf8aohxxLUtStWHtkAN0Mb_qkQ3aEunT
 UjYJ4W30u8apD3jxGgSA3nS91xAZ0NJeDT30nWD5PFtSXMIwQnbAPiD7wpa77hLosfkV9Nhhn1Ih
 b1gpiq_nsB3PlMAyjwiKvOtCsONOSyBbus5YH5PVY3Y_8ROz1LWk7lA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a8866957-69c0-4992-bc9d-5132c8ff1d87
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Sat, 5 Oct 2024 18:58:41 +0000
Received: by hermes--production-gq1-5d95dc458-5j27b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5237929a231ee58bb549ca6053dcd9e9;
          Sat, 05 Oct 2024 18:58:35 +0000 (UTC)
Message-ID: <034409ae-5d36-49d6-8073-adbff2a4404c@schaufler-ca.com>
Date: Sat, 5 Oct 2024 11:58:32 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TOMOYO's pull request for v6.12
To: "Dr. Greg" <greg@enjellic.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>,
 Fan Wu <wufan@linux.microsoft.com>, Micka??l Sala??n <mic@digikod.net>,
 Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>,
 John Johansen <john.johansen@canonical.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, KP Singh <kpsingh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <202410041305.544EA7E4E@keescook>
 <ece0c7bd-0d28-4562-8760-c54b0077583a@I-love.SAKURA.ne.jp>
 <202410041645.27A48DA@keescook>
 <5b09909b-fe43-4a9c-b9a7-2e1122b2cdb6@I-love.SAKURA.ne.jp>
 <4eaea237-d259-44bb-a546-26a0558a4453@schaufler-ca.com>
 <20241005170235.GA24016@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20241005170235.GA24016@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/5/2024 10:02 AM, Dr. Greg wrote:
> On Sat, Oct 05, 2024 at 09:10:08AM -0700, Casey Schaufler wrote:
>
> Good morning to everyone, I hope the weekend is going well.
>
> I saw this go by while I was multi-tasking between draining the oil
> out of the lower unit on my boat motor and welding the boat lift
> canopy frame and wanted to make sure that Tetsuo's comment is
> interpreted in the correct context.

Playing with welders and petrochemicals at the same time is
not recommended. Boom! Ack!

>> On 10/5/2024 12:10 AM, Tetsuo Handa wrote:
>>> ... It is possible that an attempt to make it
>>> possible to use SELinux and Smack together is a wrong direction. Even if SELinux
>>> and TSEM conflicts about their security models (and cannot be used together), it
>>> might not be something we need to care...
>> In the past I have said that having SELinux and Smack on the same
>> system is the test case for module stacking, but that I didn't see
>> it having a practical application. I have since been presented with
>> a use case that seems reasonable. Because LSM is a mechanism for
>> additional restrictions it is impossible for two security models to
>> "conflict". LSMs *must* be written to allow for cases where access
>> is denied for other reasons. You never get to the MAC check if the
>> DAC check has already failed. If TSEM can't handle what SELinux or
>> TOMOYO decides it shouldn't be accepted.
> I believe that Tetsuo misinterpreted the discussions you and I have
> had about what represents a 'security model'.
>
> For the record, TSEM has no issue with handling whatever SeLinux,
> SMACK, Tomoyo, AppArmor et.al. decide to do, full stop.
>
> It functions like all of the rest of the LSM modules, it determines
> whether or not a security event is inconsistent with the 'model' that
> the process is running in, and if so denies it, otherwise it stands
> aside and lets the other LSM's have a run at it.
>
> If some other LSM in front of it decides to deny an event, well and
> good, the event is over with from TSEM's perspective, as well as
> anything else behind the denying LSM for that matter.
>
> You raised the issue, I believe in V1, as to where we had positioned
> TSEM in the LSM call list.  After you expressed concern we moved it to
> the front of the call list because we don't care and everyone else
> seems to want to be later in the stack, particularly at the end, which
> would now seem to be be a privileged position held only by BPF.
>
> To extend on this a bit for further clarification.
>
> As we have evolved TSEM we realized that we actually want to be first,
> if that isn't also a coveted position.

The current thought is that we frown on an LSM desiring a specific
ordering and would probably reject one that required it.

> For example, internally, we have TSEM 'models' whose only function is
> to validate that the extended security attributes of an inode match
> what the workload was unit tested to, in order to thwart offline
> modification attacks.  In this case you want TSEM to be running ahead
> of the security attribute based models, since presumably, you would
> not want those models making a decision on extended attributes that
> have been modified.
>
> Hopefully this clarifies the issue.
>
> We have a long standing question, that has never been answered,
> regarding module stacking and multiple MAC implementations on the same
> OS instance but we will leave that to another conversation.

I would be open to hearing which of the many open questions you're
referring to. 

>
> Now back to MIG welder.
>
> Have a good weekend.
>
> As always,
> Dr. Greg
>
> The Quixote Project - Flailing at the Travails of Cybersecurity
>               https://github.com/Quixote-Project
>
