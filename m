Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADD8823DD
	for <linux-security-module@vger.kernel.org>; Tue, 27 Aug 2024 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781077; cv=none; b=Wew5zT4EWvq4nvf9l9KPh2u3r19+wfihAsefqZ7XQvEDsLH+wsBvNPM5vZV0RVqQTy0jpffTLIjQJUqBnrjoLKWLBLTdmslbyhtwaZuns61rY6vdkXUEfmnkhajKQFK6AxY1YT7AWf/f60DykEatCS1qyjRVDzkfpPW3V2fzVt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781077; c=relaxed/simple;
	bh=qWP8CZP3/ziBf/S/uz+gr64ZxrkfcLfa05tM83fnkfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LOcSYcI3jo3/4IByAnAJmN5sQWYRGyzNQmkQamKWjuhEFq4iRymKe9AC+ihdqa5ihbpN1lGr2eI3QU5DlzwpcbF7UHSwz7iCgRKZravNvJelVma4kPLyD+uY9DlwwXu4QC+5q9v/+vZiOABgX8lzNcGC2ZqrgJ12O0hci95QIDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=hJmzTOYi; arc=none smtp.client-ip=66.163.185.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hJmzTOYi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724781069; bh=u6TvPSXrn5RkJ5JkTK0PiKjELCMpf5lJXuGOFJoBdk0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=hJmzTOYi8vJYqKGAcC0pjecJqF0ktYn1eF3SY6mA5Tlay2pg8MPv7z5KGs540JQtTc9mTNTPDIRCpZ6Dsf3oIsDWIRDS/szIQ4TYPPbHfmJarFaAh0nqYojrqAA61XefbTHk9DMJKfErC3E3zIa80/08nlW1xy0m7PVtC1ATJOXWn8U76oIHU85GzhaJSVOsRBM68JAmhiWClHWjYMqw8846YBS0vB4SsCRQy9M2nSFYH/jbbfaAGPQumLTZWob0eKp4ax0mxAkGHmVCWQ2Ihz0zag8gzm0/NWZ2ArMnHPjeh5QYE8RAb7jpxEfXX1/PatyRYcCUPn+oTxAZlI/Cxw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724781069; bh=BSCNOzt9Esm24SFLN9+KsANzwOpb64elG3soOKuUJDN=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=qIEffAjdx2gq7eIwGmuAAEXLaKORa3cqRMBqi050P6VdIQeUTEVBoXfMnFEd9NRWXmRyJlQ0hJXO5l8CMPRMP/5jK3Zy2MtYX4k/dMaVh0NRnBXm7TmaFWRWccAzY6mALtYVE2RaKTiUjodEi0TlNFAMz50nvgcU79uVMD/HB9Ai0Ywn0EXdNjkeUC4flZmoCUAeD3VxeeeXLcPCnfaQYVAsxAnsVl97fkTs2rhtW7gnGXkWYrhSy062Ay/OJQA0Pn/evSxr6OhclUiFRKXt9yqCUu5g41gD2hivNG3AkFCQvR44o8coot1HwN9tKZrwOhDFQTcy+03omzUgd1Hu9Q==
X-YMail-OSG: rXUUZWYVM1noaRJNUYtjCc3PbvdCnjW_ge0WMU0S6ETaOGU4F6At93cS1I2agPC
 SOGgneICm80e_91ysTe3_g3qoQH.iRdKtbPC5NqQbTg6W1ML3co8B4mHuq6pddXI.Up6aNg2aw7z
 KDaTOsFYKBOHINjeikAz.ui3dsMIIqAi0t.j5K9wO2IfmgfGBnzJU_8rCFmuZ3pAssy7kCoaST0h
 oLZwM9wxOtGTrWRZ_IBg1RmmAgLWESHbkyMg8p7EYKtAHus3vtXBwLCh5SIsJ8A45uVV8FgldPIq
 wG6Ax_Bm4zOIKhbcqU2MLuE.5eK7v9RfkoZxmmPthAU12NactiVf4f1VBVvq6TsJcJn4y2_1KqyA
 8IoVulW_sg3spcpCUZ7VyiFvqZXI3CRdgjMgbNdbZhMFLQwejejKu636lL.Tx3tkBoy0Q.A3v15z
 CNM68V2pk4m0J9P9zIXMBa.qQx4.9P6mvwVfwj6X6PpFgHOxo5SeDT.J3t_FgtZD2lpEFPZGI.ob
 G32c.DD9P5XYyk9.SNeOD29ZdoTR.YBpT6nle65H4rxQmjsWxX09NtPDXVg30JVDTsTh5rvHaEGN
 QfdRfwB1VoMiUTJwAd0OCGMvxzJ1yh_2llgCVSIgxLVEYmKcW7laCungSEFVelDgHCg0rnI9Jv1A
 MfkXMsEZ5fIo7Vu5xBm8HSwnR_7G5fIIBwtgrTxiLvmqIPpUf6r8O80Q4xPUgjhpmKW.PvfW26Wl
 6wreH7idiuJaiBkiiBQ4TkCc8nc3dG7wjzvlfOCvMwl5pdJZAJfb5SF_teUqLUqcGHmysKlUtbL7
 vkkjwAipF4db13WUKhYtM8HKo39HsBKy82Ji4NerKmCBpMm3HdZaEXbUsbwbdGzlu62XajYmxGXR
 4vnHFbVw4D9bvO7BeSLa6Ff9mjDLAA6R8aiY_3sQ1KPTl9Hd0NA5znET2_iFTHGMhwXFWnF0nCHD
 N.tKG7mmANNwXhOnudrvdRot7LZSrUcmrQaD_VupwDqbKzd8NWj1j._3AritjYVk0TLNWniV0Ce0
 HUxASbOAycZpPkRnkW6EBrwyQoJ8KarsBU2f4QtWUx9Us6MBdIQcBbwlUGkrE50Yl5t0YOGMTiII
 sauWiN454Kw_FlYQPki7BUQe8YcmFHIIP26FnCfmEmHYLBwKwNwJw5tfwSv2j33sduhTpRLaH2K6
 LFeAbGM8EhaX8pjAEl.qJeJ8i6fTPM_mtb_czXcP4dBdyz6grC1TjaIwnG_wvIP0ueWfgnxvDm13
 8dP5oqsD_cHtGYAjRuP9.ObxUUpUmg320qilbTjT4SPAAs_vSw_m2AxpdG0Zwoe3j6PM6XGXGOWs
 dMAvvKRt0km7mt3vm09wpQBfgVcwGvT4HiwzK71LjMTYnVqbsE7eUNTEf.JM6ckPQABCyE6KBVHL
 8yaIZvmpYI8Gexl.psU.eGWEfdimJZeZ6TF_FRlxTzrs7TajWl.fwlw5pZMw_7hL5.mgYEdw_6nV
 y_dHMiH_mRNTHLkcEB_Rpsu7OHix7.UN4adIDPgLhTqcJR6myeT9u.OaP4RZ_W8WLF8p3MyP8uV9
 GSUltRapNdKOcuUE0GSeyUeAzrof_4GYyJpGOKL0_L0oyhbp_G1W6PiRV11nKcwMgkU0uOT8E5cy
 1Nun9XXzze9SS81hihrcwjXcLjBW_VTvuCIo8okW0dUc84HM_0YhCz6iM59wtnh0_c0qbuIt3jty
 XFkEzKgV2dDEOiE2rApM1f6MiOTQc_NPXEC_ZYCAP2vPkM7FKNRQ6N6zmJdw_IITA0PItqKTNZPa
 o14VQeUcF.SK4URt7UQHL8n1f5WcNYylCXFLPrGJWxY8VuWGxaiBnLF_PzJhi0wfTtOg.UB86NiO
 U3lajsroWDvOmS2Mo7jFRCfI2ZWsLQpyaOZUxu1gX5gagXcGiArF_rnD9_wwRKgfkFauI0Ysy1yu
 GvMRqxJnoQ1v8HPnEeM34ZpOQPE4HPEOrWK9vylmD56pjwMb.d.rL5Nys23kx9iAussd5Zvcx7YE
 N.Np7eZZZTNRj3CuMCWgBonDi_ETWkHnVkRRPcOeiisdSs5FX9ngRGlAef_6X6oOyNGT9tiss8CS
 FBF7j9_oTuREiYYJOVXXhrq6erKVP9RLtcQol_OhwLWxh1Gs3dfOsIJYIs8KHOfqpNf9FJQZGuiW
 upEFWn3Ur00KlRnjcWBJCm_JQMW3RDRKapO5bcM.aUlAxtJII6d2QBhQHuV0fRQ8_1NLBgw4Uc64
 x8mLMjr90AhYP29QLUOq3j8ly752gfeiTdoU07UkmPq8uOcUy45Stsn2bkEPzhRfc9Ptr7OICVt5
 ZYn2EmnE.RzfX.9Q-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f79da837-4c72-44b0-923d-4473dd04ab63
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Aug 2024 17:51:09 +0000
Received: by hermes--production-gq1-5d95dc458-7jxgc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 54384085c13b42d4a6eb4d4313660637;
          Tue, 27 Aug 2024 17:51:03 +0000 (UTC)
Message-ID: <d940241d-77f2-4f41-9695-be9dabb896cd@schaufler-ca.com>
Date: Tue, 27 Aug 2024 10:51:01 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/14] Add primary TSEM implementation file.
To: "Dr. Greg" <greg@enjellic.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 jmorris@namei.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20240826103728.3378-1-greg@enjellic.com>
 <20240826103728.3378-5-greg@enjellic.com>
 <4403f4ce-21eb-47a1-93f1-c663a96de9bc@schaufler-ca.com>
 <20240827105214.GA4769@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240827105214.GA4769@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/27/2024 3:52 AM, Dr. Greg wrote:
> On Mon, Aug 26, 2024 at 08:53:31AM -0700, Casey Schaufler wrote:
>
> Good morning Casey, I hope this note finds your day starting well.
>
> Greetings to others on this 'last' week of summer.
>
>> On 8/26/2024 3:37 AM, Greg Wettstein wrote:
>>> The tsem.c file is the 'master' file in the TSEM implementation. It is
>>> responsible for initializing the LSM and providing the implementation of the
>>> security event handlers.
>>> ---
>>>  security/tsem/tsem.c | 2446 ++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 2446 insertions(+)
>>>  create mode 100644 security/tsem/tsem.c
>>>
>>> diff --git a/security/tsem/tsem.c b/security/tsem/tsem.c
>>> new file mode 100644
>>> index 000000000000..76d65b3e62b3
>>> --- /dev/null
>>> +++ b/security/tsem/tsem.c
>>> @@ -0,0 +1,2446 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +
>>> +/*
>>> + * Copyright (C) 2024 Enjellic Systems Development, LLC
>>> + * Author: Dr. Greg Wettstein <greg@enjellic.com>
>>> + *
>>> + * This file is the primary implementation file for the tsem LSM.
>>> + *
>>> + * It implements initialization and setup functions that interpret
>>> + * kernel command-line arguments and prepares TSEM for operation.
>>> + *
>>> + * In addition it contains all of the TSEM specific security event
>>> + * handlers that are responsible for handling the LSM events that TSEM
>>> + * models.
>>> + *
>>> + * Each TSEM event handler calls the tsem_allocate_event() function to
>>> + * allocate a structure that will be used to describe the event.  The
>>> + * CELL union of this structure contains various structures that are
>>> + * used to hold these parameters.
>>> + *
>>> + * Since the event characterization parameters need to be retained for
>>> + * the lifetime of the tsem_event structure that is allocated.  In the
>>> + * case of internally modeled namespaces this lifespan is the lifetime
>>> + * of the security modeling namespace.  In the case of externally
>>> + * modeled namespaces, the lifespan is until the security event
>>> + * description is exported to an external trust orchestrator.
>>> + *
>>> + * In order to support this model, the event description structures
>>> + * are typically composed of a union over 'in' and 'out' structures.
>>> + * The 'in' structures are used to hold arguments to the event handler
>>> + * that may only be relevant for the duration of the call.  These
>>> + * values are translated into members of the 'out' structure that
>>> + * retain the values until the end of the lifetime of the tsem_event
>>> + * structure.
>>> + *
>>> + * Each TSEM event handler is responsible for allocating a tsem_event
>>> + * structure and populating the appropriate CELL structure with the
>>> + * input characteristics of the event.  The dispatch_event() function
>>> + * is called to handle the modeling of the event.  This function
>>> + * returns the permission value that is returned as the result of the
>>> + * LSM event handler.
>>> + *
>>> + * The dispatch_event() calls the tsem_event_init() function that is
>>> + * responsible for translating the input parameters into values that
>>> + * will be retained for the lifetime of the security event
>>> + * description.  The populated event description is then dispatched to
>>> + * either the tsem_model_event() or the tsem_export_event() for
>>> + * modeling by either the internal TMA or by a TMA associated with an
>>> + * external trust orchestrator.
>>> + */
>>> +
>>> + ...
>>> +
>>> +static int tsem_file_open(struct file *file)
>>> +{
>>> +	struct inode *inode = file_inode(file);
>>> +	struct tsem_event *ep;
>>> +
>>> +	if (static_branch_unlikely(&tsem_not_ready))
>>> +		return 0;
>>> +	if (bypass_event(TSEM_FILE_OPEN))
>>> +		return 0;
>>> +	if (unlikely(tsem_inode(inode)->status == TSEM_INODE_CONTROL_PLANE)) {
>>> +		if (capable(CAP_MAC_ADMIN))
>> Don't you mean CAP_MAC_OVERRIDE? CAP_MAC_ADMIN is for changes to the
>> security state of the system, where CAP_MAC_OVERRIDE is for access
>> control decision exceptions. Here (and elsewhere) you use the former
>> in access checks.
> You are clearly the mechanistic expert on capabilities so we would
> take your lead on this.
>
> Some background information to hopefully assist in a discussion on the
> types of capability checks that should be implemented.
>
> The capability checks we apply in TSEM gate the following five types
> of actions:
>
> 1.) The ability to issue TSEM control commands.
>
> 2.) The ability to register an event processing module.
>
> 3.) Access to state information on kernel based modeling agent instances.
>
> 4.) The ability to send signals to trust orchestration processes.
>
> 5.) The ability to send a signal to a different security modeling namespace.
>
> If we understand the differentiation that you suggest between
> CAP_MAC_ADMIN and CAP_MAC_OVERRIDE we would conclude the following:
>
> Checks 1, 2 and 4 would seem, in our opinion, have the ability to
> change the security state of a system.  As such it would seem
> appropriate to use CAP_MAC_ADMIN for those checks.
>
> Rather than belabor the issue now, we can entertain a subsequent
> discussion, if needed, on why we believe that actions 1, 2 and 4 can
> change the security state of the system.
>
> By your definition, check type 3 would seem to be consistent with
> CAP_MAC_OVERRIDE, since it is gating access to potentially security
> sensitive information but which does not imply the ability to change
> the security state of the system.
>
> That leaves category 5 as a possible open question.  Given the trust
> orchestration model for externally modeled namespaces, we concluded
> that the only entities that should be able to issue signals that can
> manipulate, particularly terminate a process, should only come from
> within the security modeling namespace that the target process is
> running in.  Given that, we would consider such operations as possibly
> affecting the security state of the system and thus suitable for
> CAP_MAC_ADMIN.
>
> Based on what we have always understood, and that is confirmed by 'git
> grep', the only thing at this time that is using CAP_MAC_OVERRIDE is
> SMACK.  If our analysis is correct, would you have any issues with us
> changing the type 3 checks to CAP_MAC_OVERRIDE?
>
> With respect to the check that you call out in
> tsem.c:tsem_open_file(), the capability check is to avoid a model
> deadlock situation.  If we adopt the model we discuss above, we would
> need to unequivocably allow the open if the process is carrying
> CAP_MAC_ADMIN or CAP_MAC_OVERRIDE in order to avoid a control
> deadlock.
>
> We will look forward to your thoughts on if we should proceed with the
> above changes.

It seems you were right all along, that none of these capability checks
really fit with CAP_MAC_OVERRIDE. Thank you for the clarification. 

>
> Have a good day.
>
> As always,
> Dr. Greg
>
> The Quixote Project - Flailing at the Travails of Cybersecurity
>               https://github.com/Quixote-Project
