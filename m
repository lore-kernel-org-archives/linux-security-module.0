From: sbuisson.ddn@gmail.com (Sebastien Buisson)
Date: Wed, 17 May 2017 17:43:03 +0200
Subject: [PATCH v5 1/2] selinux: add brief info to policydb
In-Reply-To: <CAFftDdqtXKMkPOmrHx_RcwQuhi7e+Utqnh=4nn0O+4+wgAS=6Q@mail.gmail.com>
References: <1494928281-11128-1-git-send-email-sbuisson@ddn.com>
	<1494967240.21557.18.camel@tycho.nsa.gov>
	<CAPkE-bWykonYBssXGphktM7jANY_nbtQi7EVc4uLwjm-fdM8Kg@mail.gmail.com>
	<CAFftDdo=xDMNpC1F6M+w8Cr4=Ws8f-WyKm27EU_kv2ZE7ATHsQ@mail.gmail.com>
	<CAPkE-bV3DymWqYfkahxYLwSPy_G=YMzJMvc5jj3qJu1ywteJng@mail.gmail.com>
	<CAFftDdqtXKMkPOmrHx_RcwQuhi7e+Utqnh=4nn0O+4+wgAS=6Q@mail.gmail.com>
Message-ID: <CAPkE-bU-XSQHobkAQzed+fM14sKku56oPq=P=KoCOwuUqcFosw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

2017-05-17 17:34 GMT+02:00 William Roberts <bill.c.roberts@gmail.com>:
>>>>> Is there a particular reason to not just return policybrief_len here as
>>>>> well, for consistency in the interface?  How do you intend to use this
>>>>> value in the caller?
>>>>
>>>> As called in the other patch to expose policy brief via selinuxfs
>>>> (sel_read_policybrief), the intent is to provide the caller with the
>>>> length of the string returned.
>>>> Or should I set *len to policy brief_len here, and just make the
>>>> caller aware that the returned length is in fact the length of the
>>>> buffer (i.e. including terminating NUL byte)?
>>>
>>> What is the caller supposed to do with length? This interface seemed kind of
>>> odd. If it's guaranteed NUL byte terminated, do they even need length?
>>
>> The length is useful as an input parameter in case the caller provides
>> its own buffer (instead of letting the function allocate one), and as
>
> This is what I don't get, why doesn't the function just always allocate?

For performance reasons mainly. The caller would have a statically
allocated buffer, reused every time it needs to get the policy brief
info.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
