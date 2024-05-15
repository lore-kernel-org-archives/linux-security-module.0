Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8013032A
	for <linux-security-module@vger.kernel.org>; Wed, 15 May 2024 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715793498; cv=none; b=lHRa+vewk8S8ArEPpA4HifvWmv2rEbYcrb3VqLkgy4SpD6Dd8mtI0mdFZDhH2Rdnt56mlTARk6qFlqF6FTAh8w95QQmeYaGJqgIUXlvcNR5bBYMuDbrco+NNUH6xTtNAgzZpdl0KWCab94j1MJ9UGUHCAcnc0Fz+YcWf1OsbdLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715793498; c=relaxed/simple;
	bh=FuQ04REmGffcGsqjbHPI2/gx1ByZTAL1K497JGN1/C0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJhxAOG7cTuElijs3hNFhJWMOaGcJsGnsVfOiMtzLiiQq9n1NxtaFd5juE4mzOw/qpt2+4xWQk9eBj8mPO9YTtjJgEpXCyFkEax724/pb+hdvF1v7GWkdrrhHfH6YFhxtXECOjX9K6tcHuJXIHJwxdSGzpjS3fYym7uxxGNxHEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=EwOypzCu; arc=none smtp.client-ip=66.163.191.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="EwOypzCu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715793490; bh=BHtED/hV1EglizoZ7UB9rfbSISlPGqcXx7k64DsATk4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=EwOypzCu9Z7S3fyhhu6zjc/k6BGoZJ17LKEHVf7HpDxIDgBBFLUg6YkhQUhL6PPtqKVz+Mdy0/M4rt3EKgXUXB2GPoPicUdXtE/wfQZFLgBgq/P5ydQIuGay0wLZI6hadw0CYd0AA/kIzzXB3qD3RMci93kai6S/d2JP/MMWuVEngJs3mJD6S/JNXk7KEt+duHJXQF3vt7nJJnsVeqlf3NcitE12SB9+Fg0exrKB9N1uN8QyO8mKcgU8u9J/sDtL32dusYGqwgW3rSkvkZ8rNo56njDFCcDkMQmjEIkgru9IdUDW3KfXoUndIwljlNBqHs4upg540FOWwunj2VsJZg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715793490; bh=/tC0xUldOwFQ+eZkuXe2gvCWlqvFh9Xt4qXj8PnPCGA=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=LPCxPdliDeoput4vpp6Ak3NH6IrCOCmZlFk/j0jYGJVOd39pEwS51Tl2UCakFks8najxS4p8QqH8oGX3mtzX8NnGg2hbNYc2MqSh82rPU2POBj706CJZ5savVXpVyAM9yra3qPZZeRFTFOoBWCSCWS6a7niXt3rHw6m/72I9x/qvaSFUYMb9Qo4mO7biPaQe+g3SuLtTKPLTSAOr9uwnY76iySkr2Si2/QkJ1rttd/V3/bsUvGUaUDCYymGE3YEmg04S0quyF1DQZZp1c9EbKIc0PrteWefVjYqvdsG+XF87mnCh0wo2ngdbVMKSkLm9UF5V+SWKvX2GDGnXpSejZA==
X-YMail-OSG: Fz8CMNQVM1kepLNI7k2wqLwHLU4ofaOCDUM3G.zDJdj29CYYhgKPJkkt.PTzPCe
 ihLtPBL3hSdFSAxMGRz5v_BFae_kCVUm8J22EC7sALXgigPVQvZ9Tbqa7wvl6C3wArpMqnKkqSFW
 IDIouRSjdkbQv1HqggohRr4seOPazSeh5OHllOzbdTSHuI9T4Bgz4mSWY96_9zTOcZ9.NofPU9k6
 NHtbHC91ZEXgn8eSyUS9WZ6EYWxrN2ratGt8QLgnT7NHl5GNGDBOx8ybcmuXQC8Fl8ssv7zOFkg5
 RgX_6ZLfkynWi0TOrdFWwMTBbVXuFkzISrXgm6VnpOo3oqjU7X0bnqnfmBRMTKd4em6TJHjDq4H2
 4V1xw.MnJgfgWKcGGsc_9vLtGDP.N8zFM_R0FoiKrVNtLWu0cbr0hMHHzhOlJKSOOETQQYLBRh4m
 CkRWPqhxd8kJioAR50__QuAUYIO3OnrM9_nb9L0ROpF71tuhUmB0oKU5kIeXJ0SNzNar9JhC.8Nq
 egXgSZ6gq0E8N38xHCPO.dZauowAfIJSewhkC7t9Rtwo_M7c_AsavOI20RSratElLtTgsZ1DvMZv
 5bEP6B5v.9LVslvmIH2i3pATYn8_k4CMO_tlE0Db8vQJhmBMyxgWDl5h2XzWB9DQnd9LFrTKSWX2
 ChXCmYBIsQkf98q1BjyZyW9Bwz1qXmRtQSXX6AzAWnJUIpnlJ.r22FUPWEEgeDxg5WcZI7HRUdvS
 pFEsuByKN4eyF4imWhZrEiGAbBYCsOhFH6voZUMTQWvbSJtRzbvojjw82sK76A5T.JcEtiPXiyBM
 wys3C8XpEwSj52ekVebF.nOJWHBvCZr.VJLMi0G6hirPFhSJplfbBxdUJb.JQIk00jPY8hM5S6zp
 Vv_yL1vqDYaC83zYPPz.qtlC3MO2MpQTnsW5EAbClw3OExY0yIxGevZPl6WmmEHZJuTIMkA.QbF4
 jmtI3CD0PEy6hzK37B137GPqpOZcQU9tGyGTq2nv01Pk9LB5B8gh4lbzWyKkucYGtYzY7IM96fHi
 r9XgOfA0dMpK92dM_gjgA1eujSuMwXIbcVlWZjdCfzlpBm.j2C2s.g25E9bXi5dv9gRQt4Roe7vE
 pWn16ac5wx.bBZ.bVH1NRTES1XgRWSunsWJ4zmLht80O6hvF8Eqh4yVOuWR4SfBC84dsxwDITYf3
 PT5J8CUStj3KjyHs8OUxabKUsDYDcl49GWUM5bsj8VJibZEOEzONtBBtmR.js9or8jXit4Lgen4q
 zdXLsgdjPL58YOEweKtohQ8wMcx..0rCbOgzSpOVWEjOHylTnaOOrnCytRd75AvYAgrbT5oi0hK1
 BOAvZVUO9tiCk6xqlgRp2hqeS1a5VWmmFMx9OnrJb4Zx5rjHpKFEkG8YuulJYfaa96ugyF2rUcoF
 X7iRd16gp3L5ibDr0RmX7gM4ppABTIVZBNmws0SYZMCeJ8mG7b5qFwnEvkFURV8MQc2oCYL5yO1z
 Gf_EiGPGUcANSWHd5pdibatuUvcbqKmTXv1gRnrWCcHyRBtdpbEn0iYf6YVdZkgqHXJ9tqFS5sJm
 JP3NZZ3FhS9wubi8B.c5xv9GbJeU7XoRelvf..dKQdOVv3jyL0GkwRguhPY1zpAmjdSkJ1EwqlyK
 J4SECMZ2QtNIrRH9nGSGeKF2hpv.qNqf3rKC4HI8vj2flhj.t9mstQlLwbO0FkJwhXzMSbwVgHde
 YRDhaTCtW_GTqn0HTWNeOYc4RTm.X.QnBxVxKEkj1RiO0IqSRskNWWpa8km9fO5FLPHw6H8i92pV
 nN0MStOtE13Uor2ZQ7HKUBKJxqbDIDdgOECoZ4hwrnOG9.V0rE3fqepgdD8NIgOdCFQGvoFDoWGb
 26dTzAX9g8Z6wiRz08QuukJ5hH9S8TZ06jBe_3Nyy.bsFThCct3JNFCq6Xxta0ZE3V9bsw3oK5_6
 NOmQksUnEDiA4P7Ir4PkBQpq19HiHdvGcxjWXT7of5Q7GuyS2OWGNiz2bKvUS8I3bnyrP0M.SWy2
 fZzFkuMqg_kY4iDXDSmaRJZenY8hNv9hhc3W4RoTTevSHyN1AgPz8d5Ufssj_aajLtrR4cYqt5Q9
 Ok1uXuB_VgrOvvH421mlf67WRMAEqwRaA3zS5YCGkDNKrZLPoQ_ssNvM16Q.XMngWmeiF8bZ99oq
 u3Cmc1gchxx3k9hpxlPSI8dFD9ma4uT3sAx8FOKIA.YN2sJ2vtwSyC15XUbny6QpuBh2dJ2ZgumC
 KTU8zqchv47tjVJNk7SOlIaxCyMoTaSkf.S3fqEnm.llGKcMSKxIhdAfPXUgP_TqBND8Mm8z3R2V
 XOI39XQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3901528f-0538-4a91-b39a-ce062f5e2ba8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Wed, 15 May 2024 17:18:10 +0000
Received: by hermes--production-gq1-59c575df44-84j4c (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 16318b1a3d83a1a0f92eb78fd460e873;
          Wed, 15 May 2024 16:57:50 +0000 (UTC)
Message-ID: <812fbcc0-9d68-4a58-ae93-15dfc61c82e9@schaufler-ca.com>
Date: Wed, 15 May 2024 09:57:50 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v10 5/5] bpf: Only enable BPF LSM hooks when an
 LSM program is attached
To: KP Singh <kpsingh@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc: Kees Cook <keescook@chromium.org>, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, jackmanb@google.com,
 renauld@google.com, Song Liu <song@kernel.org>, revest@chromium.org
References: <20240507221045.551537-1-kpsingh@kernel.org>
 <20240507221045.551537-6-kpsingh@kernel.org> <202405071653.2C761D80@keescook>
 <CAHC9VhTWB+zL-cqNGFOfW_LsPHp3=ddoHkjUTq+NoSj7BdRvmw@mail.gmail.com>
 <0E524496-74E4-4419-8FE5-7675BD1834C0@kernel.org>
 <CAHC9VhS6hckf+xzhPn9gNQfFDiQhiGyJuzGVNXB=ZAr=8Af37w@mail.gmail.com>
 <D58AC87E-E5AC-435D-8A06-F0FFB328FF35@kernel.org>
 <CACYkzJ4wH258JZMN4gqSs-BxU1QgeHMJ2U=bouYf+xLUW8+ttw@mail.gmail.com>
 <EFEB4187-0F14-41BD-B145-319CBE22701E@kernel.org>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <EFEB4187-0F14-41BD-B145-319CBE22701E@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22356 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/15/2024 9:44 AM, KP Singh wrote:
>
>> On 15 May 2024, at 10:08, KP Singh <kpsingh@kernel.org> wrote:
>>
>> On Fri, May 10, 2024 at 7:23 AM KP Singh <kpsingh@kernel.org> wrote:
>>>
>>>
>>>> On 9 May 2024, at 16:24, Paul Moore <paul@paul-moore.com> wrote:
>>>>
>>>> On Wed, May 8, 2024 at 3:00 AM KP Singh <kpsingh@kernel.org> wrote:
>>>>> One idea here is that only LSM hooks with default_state = false can be toggled.
>>>>>
>>>>> This would also any ROPs that try to abuse this function. Maybe we can call "default_disabled" .toggleable (or dynamic)
>>>>>
>>>>> and change the corresponding LSM_INIT_TOGGLEABLE. Kees, Paul, this may be a fair middle ground?
>>>> Seems reasonable to me, although I think it's worth respinning to get
>>>> a proper look at it in context.  Some naming bikeshedding below ...
>>>>
>>>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>>>>> index 4bd1d47bb9dc..5c0918ed6b80 100644
>>>>> --- a/include/linux/lsm_hooks.h
>>>>> +++ b/include/linux/lsm_hooks.h
>>>>> @@ -117,7 +117,7 @@ struct security_hook_list {
>>>>>       struct lsm_static_call  *scalls;
>>>>>       union security_list_options     hook;
>>>>>       const struct lsm_id             *lsmid;
>>>>> -       bool                            default_enabled;
>>>>> +       bool                            toggleable;
>>>>> } __randomize_layout;
>>>> How about inverting the boolean and using something like 'fixed'
>>>> instead of 'toggleable'?
>>>>
>>> I would prefer not changing the all the other LSM_HOOK_INIT calls as we change the default behaviour then. How about calling it "dynamic"
>>>
>>> LSM_HOOK_INIT_DYNAMIC and call the boolean dynamic
>>>
>> Paul, others, any preferences here?
> I will throw another in the mix, LSM_HOOK_RUNTIME which captures the nature nicely. (i.e. these hooks are enabled / disabled at runtime). Thoughts?

I think the bike shed should be painted blue.

Sorry. Seriously, I like LSM_HOOK_RUNTIME.

