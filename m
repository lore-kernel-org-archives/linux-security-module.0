From: me@jessfraz.com (Jessica Frazelle)
Date: Wed, 31 May 2017 18:14:25 +0100
Subject: namespaces todo list?
In-Reply-To: <c1386ea9-bd54-9f73-2bbf-9f331cfb4aa2@poczta.onet.pl>
References: <82271f8b-c366-28b1-90ac-3b0780490fa5@poczta.onet.pl>
	<CAEk6tEwqd5dxMgXSms5g7+hd+8Pufe1+1BKeUQ2Ew9sLBUtbfA@mail.gmail.com>
	<1139e982-0096-1d5c-3ea1-b7607907b9c2@poczta.onet.pl>
	<CAEk6tEyfELOy4w2AB2EAsLDQXo+atJnhatVNs9DcReqvbzLX6w@mail.gmail.com>
	<c1386ea9-bd54-9f73-2bbf-9f331cfb4aa2@poczta.onet.pl>
Message-ID: <CAEk6tEwFhm34yZH-GRP_2J9YankZuVarsM0WrrpBR-QcGoGM3A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, May 31, 2017 at 5:58 PM, Micha? Zegan
<webczat_200@poczta.onet.pl> wrote:
>
>
> W dniu 31.05.2017 o 17:23, Jessica Frazelle pisze:
>> You can catch up here[1] wrt the keyring and userns, David Howells is
>> working on more with the keyring currently[2] seems like from the set
>> of patches.
>>
>> [1] https://patchwork.kernel.org/patch/9394983/
> this patch is still in new state so not merged, hmm

The state today is as described in that patch, which also goes over
the problems and designs. as well as the other link given which has
the more recent work.

>> [2] https://marc.info/?l=linux-cgroups&w=2&r=1&s=David+Howells&q=b
>>
>> On Wed, May 31, 2017 at 4:17 PM, Micha? Zegan
>> <webczat_200@poczta.onet.pl> wrote:
>>>
>>>
>>> W dniu 31.05.2017 o 17:05, Jessica Frazelle pisze:
>>>>> 3 - keys, keyrings? are they namespace aware or not? I am quite lost in
>>>>> that regard, because I happen to hear conflicting statements.
>>>>
>>>> If you are using user namespaces, the keyring is namespaced.
>>>>
>>>>
>>>>
>>> so, from which kernel version is it namespaced? and, if it really is
>>> namespaced, then does it mean the only thing not currently resolved is
>>> request_key?
>>>
>>
>>
>>
>



-- 


Jessie Frazelle
4096R / D4C4 DD60 0D66 F65A 8EFC  511E 18F3 685C 0022 BFF3
pgp.mit.edu
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
