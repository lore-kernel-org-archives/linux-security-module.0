Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794667470;
	b=kajMI2FTfZpL2OxWJXCVBm7p59nmYxfQJEcA/QbbVVxGU/LVqtzagIFRxeUCFGAeT3Ox
	 /8KB6i7QxJBZezi50AmXNnr9b8lXUlTu3HMCE2yoM4eiJD7YLcx/BwCArEdTsYQQS1GTE
	 J73CMuhZ3jRk3bpalDPDt4r+RqMMoXRlMufRA2Cs9P/h1WQTPgt31Tkuxe8KoOd/P0mij
	 B9BB88r5mdSyjvGR/klxnt7Nmn50Yjxr/TT/ls/4/a3HYXJq9c11RS1k0x8CxbjM68llp
	 NX+SHnmVPs2ynukNjh/vGZMCF9JEjjprbcP0FeerzKJxebeEZYUra5Sn07Oo9VJ+j2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794667470;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OP0vgetmo06fw+6Ku1MloBTkuCbq87Y5ewowZhc30e0=;
	b=F3obJBWaWGptBFj+utT4prjw5sIFkMQ7u3mtNB034rFT/IID5QfxrvrDnp949+Hj7XHv
	 i6uQluqVMG8zSnclDlwfmLrrJIa6wrFTdzgv48zhNza4bskVFCNGE1U9k/2JY9eycfOO8
	 CXTqvrgbya/4ifpPtoSPqzxKQUMjWbgsYELsHlckz9Cf02P3hYv7ZOBSiJAWjmQIY9/uS
	 dORLGo47sA+XFJSChAuFr4d/T33qxoFiGscAvd8TaXuQZdgfp04bIADAVYgfkANz9oquV
	 7YZxD7cA8X8tQHERcHLjfNpRhjHkPDfvOHg7/n4NkO5X4CcNStkrxmytVZMo/gHGsOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=U54Hy3eC;
	arc=none smtp.remote-ip=95.215.58.20
Received: from mta1.migadu.com (out-20.mta1.migadu.com [95.215.58.20])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C0F606A337
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 14:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00C0F606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=U54Hy3eC
X-Envelope-To: linux-security-module@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OP0vgetmo06fw+6Ku1MloBTkuCbq87Y5ewowZhc30e0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794667467; v=1; x=1795272267;
 b=U54Hy3eC9ZstXijv4wLZYjyF/Zt7ElV4nKZ3LF7Z2r+KJyjo6lCS+AzzxrwLXt84HBl/hz2n
 KJOqdnH4cUYNoo3EBCtgEc/WfODge0bs8X5AZe2hI0Az3o6Ko27ahYUZMdeNkVmzegXCx9LJtTH
 +PQIj8s26VJ4fwyCM7aY1J8Q=
X-Envelope-To: linux-security-module@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c9a3662b80fe0a15;
	Sat, 14 Nov 2026 14:44:27 +0000
X-Mizu-Trace-ID: c9a3662b80fe0a15
X-Migadu-Flow: FLOW_OUT
Date: Sat, 14 Nov 2026 14:44:24 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: Serge Hallyn <serge@hallyn.com>
CC: Christian Brauner <brauner@kernel.org>,
 =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 Josef Bacik <josef@toxicpanda.com>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_userns=3A_security=3A_Inform_LSMs_?=
 =?US-ASCII?Q?of_capability_check_during_userns_creation?=
In-Reply-To: <0c403a09-38cf-4953-a73a-ee57837b3799@hallyn.com>
References: <20261111205814.3282968-1-bradley.morgan@linux.dev> <aveDlb6PlPSVoLD9@hallyn.com> <4A0D804A-1199-4402-91EE-E37E8D6EA9E7@linux.dev> <0c403a09-38cf-4953-a73a-ee57837b3799@hallyn.com>
Message-ID: <5862E641-C0F8-45B2-B340-DF4506AC9FAF@linux.dev>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 14 November 2026 14:34:07 GMT, Serge Hallyn <serge@hallyn.com> wrote:
>Nov 13, 2026 15:54:37 Bradley Morgan <bradley.morgan@linux.dev>:
>
>> On 13 November 2026 21:39:33 GMT, "Serge E. Hallyn" <serge@hallyn.com>
>> wrote:
>>> On Wed, Nov 11, 2026 at 08:58:14PM +0000, Bradley Morgan wrote:
>>>> Right now security_capable() gets called in create_user_ns() to
>snapshot
>>>> whether the parent could setfcap, but the LSM gets zero context on
>where
>>>> the check actually came from. It is the same story as setid: without a
>>>> dedicated flag, security modules cannot tell this apart from regular
>>>> capability checks.
>>>>
>>>> Add CAP_OPT_USERNS_CREATE and pass it along from create_user_ns().
>>>
>>> This should be patch 1/N in a set that introduces a user of it
>>> in some lsm.
>>
>> hmm. Did you read Christians suggestion?
>
>I did, when he first sent it. Actually it seems to me that what the lsm
>would really like to know is that this is not for an immediate use of
>setfcap, but possible future use. But that doesn't really matter. I wasn't
>judging the patch. I was just going by what i believe is general lsm
>subsystem policy.

( my word wrapping client did not like that message :( )

hmm, it's pre-reqed over the patch as on the lore link, so Christian may
want to have a look at this obe

>
>> Let's see if Christian or anyone
>> else could suggest a nice little lsm user for this.
>>
>> If nobody responds, in coming days, I'll go and find and do a user for
>it.
>>
>>>
>>>> Suggested-by: Christian Brauner <brauner@kernel.org>
>>>> Link:
>>>
>https://lore.kernel.org/all/20261111-kommt-gischt-ohnedies-469998d2f219@brauner/
>>>> Signed-off-by: Bradley Morgan <bradley.morgan@linux.dev>
>>>> ---
>>>> Thanks Christian for the suggestion :).
>>>> ---
>>>> include/linux/security.h | 2 ++
>>>> kernel/user_namespace.c  | 3 ++-
>>>> 2 files changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/linux/security.h b/include/linux/security.h
>>>> index 40831fab54709..d24666a0b4833 100644
>>>> --- a/include/linux/security.h
>>>> +++ b/include/linux/security.h
>>>> @@ -75,6 +75,8 @@ struct nsset;
>>>> #define CAP_OPT_NOAUDIT BIT(1)
>>>> /* If capable is being called by a setid function */
>>>> #define CAP_OPT_INSETID BIT(2)
>>>> +/* Is capable being called from the user namespace creation path? */
>>>> +#define CAP_OPT_USERNS_CREATE BIT(3)
>>>>
>>>> /* LSM Agnostic defines for security_sb_set_mnt_opts() flags */
>>>> #define SECURITY_LSM_NATIVE_LABELS 1
>>>> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
>>>> index 57b7f10be74e1..37480f6d8369f 100644
>>>> --- a/kernel/user_namespace.c
>>>> +++ b/kernel/user_namespace.c
>>>> @@ -134,7 +134,8 @@ int create_user_ns(struct cred *new)
>>>>      * audit: the creator may never map uid 0.
>>>>      */
>>>>     ns->parent_could_setfcap =
>>>> -       !security_capable(new, parent_ns, CAP_SETFCAP,
>CAP_OPT_NOAUDIT);
>>>> +       !security_capable(new, parent_ns, CAP_SETFCAP,
>>>> +                 CAP_OPT_NOAUDIT | CAP_OPT_USERNS_CREATE);
>>>>
>>>>     ret = ns_common_init(ns);
>>>>     if (ret)
>>>> --
>>>> 2.53.0
>>>
>>
>> --- Thanks!
>
>

--- Thanks!
