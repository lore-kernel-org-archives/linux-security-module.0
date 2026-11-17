Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933063;
	b=TbDDq40vBzcq618nVyHUwFvBaN7SfIqhQv9A3Vudd9xHKzL1y9LPYvd/ft1bq+gDotRn
	 sg1imU/LMwkgfB/viQxMS+JgiwqKWZlkuql3KWxNZHbSRXxeyRw19t7LE+X/iusVOtAxX
	 5PwbrG3CqFd6UpnOMvk+L+fLmcatcjyGL2rypGmMoEB4T9Tmw+hNYNq0IHRyzimjkmctn
	 mKBLvaF2/rRgQtdLq+TzEUkUu6AnRih1EtSJhFVdHjqofImOHkwsrtz4P2AxEDDw4AJtu
	 cohH/RwEyjUXHFaMy/40pM6W6hnVJGwsBfj802fgJgWKilwL23Dkv58jWq60StlabcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933063;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HlPsciMakqHxogcwZn6G56EduTgwLmVnkkwhdl+HHIw=;
	b=m4VAmXeFuMK0bdr/MpommYGneo+MPyQpXP5dDmogwV7PPznnDSyIaeyIGYjHNu5ykJJS
	 ulcpgybCyXnWOuQxlA6J1lwgIFwpFVthkbzwRaXVUO2ow986xQZs0olkfD8NpL81sQnrd
	 uETZSmQMJvzd099e6Xa+SpqNVZARrV8/0Lp5WJSsyTCwv3aOVuiStWV20A2AphhBOm7X2
	 /r9BUPYuBxq2J35TuP/BTeyx6z5olJ4OFCoCLvo6H8cGSsAtTtX5kmg+4CPBA0xZpV5vj
	 ZuphHLN+Gfs9sbgEUTyTuYHaPXHn14UaG+YVFmmk8+1YY846vNZKl20wnzFNryjEMtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="E8/sdJLC";
	arc=none smtp.remote-ip=91.218.175.128
Received: from mta0.migadu.com (out-128.mta0.migadu.com [91.218.175.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A11E606A32C
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 16:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A11E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=E8/sdJLC
X-Envelope-To: linux-security-module@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1CJxAMst/a0YkFBUufJxsVituEPUQaeTbx1GNn2J5Zk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794933060; v=1; x=1795537860;
 b=E8/sdJLC83hWL0W0GpKAmpCm1zYSbTCaBMpaterKlRrleBcwUXPXpNzF5ZY3es7pyzz2GZwt
 F6fdEjiZPx2eys9xGfrz6dIAXNPtpMUQiGkY1/9WhlbIzcdvXcV8RiTBYnmxD3xSCutTHAqAiCQ
 zgGXudsqtYoNHtIoJfps+hBo=
X-Envelope-To: linux-security-module@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4cdd130d40791c1a;
	Tue, 17 Nov 2026 16:30:59 +0000
X-Mizu-Trace-ID: 4cdd130d40791c1a
X-Migadu-Flow: FLOW_OUT
Date: Tue, 17 Nov 2026 16:31:00 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: "Serge E. Hallyn" <serge@hallyn.com>
CC: Christian Brauner <brauner@kernel.org>,
 =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 Josef Bacik <josef@toxicpanda.com>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_userns=3A_security=3A_Inform_LSMs_?=
 =?US-ASCII?Q?of_capability_check_during_userns_creation?=
In-Reply-To: <avxvkuC5SP/0c+wr@hallyn.com>
References: <20261111205814.3282968-1-bradley.morgan@linux.dev> <aveDlb6PlPSVoLD9@hallyn.com> <4A0D804A-1199-4402-91EE-E37E8D6EA9E7@linux.dev> <0c403a09-38cf-4953-a73a-ee57837b3799@hallyn.com> <5862E641-C0F8-45B2-B340-DF4506AC9FAF@linux.dev> <avxvkuC5SP/0c+wr@hallyn.com>
Message-ID: <665E8F15-963D-4D0A-8297-ED140B70A89D@linux.dev>
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

On 17 November 2026 15:15:30 GMT, "Serge E. Hallyn" <serge@hallyn.com>
wrote:
>On Sat, Nov 14, 2026 at 02:44:24PM +0000, Bradley Morgan wrote:
>> On 14 November 2026 14:34:07 GMT, Serge Hallyn <serge@hallyn.com> wrote:
>> >Nov 13, 2026 15:54:37 Bradley Morgan <bradley.morgan@linux.dev>:
>> >
>> >> On 13 November 2026 21:39:33 GMT, "Serge E. Hallyn"
><serge@hallyn.com>
>> >> wrote:
>> >>> On Wed, Nov 11, 2026 at 08:58:14PM +0000, Bradley Morgan wrote:
>> >>>> Right now security_capable() gets called in create_user_ns() to
>> >snapshot
>> >>>> whether the parent could setfcap, but the LSM gets zero context on
>> >where
>> >>>> the check actually came from. It is the same story as setid:
>without a
>> >>>> dedicated flag, security modules cannot tell this apart from
>regular
>> >>>> capability checks.
>> >>>>
>> >>>> Add CAP_OPT_USERNS_CREATE and pass it along from create_user_ns().
>> >>>
>> >>> This should be patch 1/N in a set that introduces a user of it
>> >>> in some lsm.
>> >>
>> >> hmm. Did you read Christians suggestion?
>> >
>> >I did, when he first sent it. Actually it seems to me that what the lsm
>> >would really like to know is that this is not for an immediate use of
>> >setfcap, but possible future use. But that doesn't really matter. I
>wasn't
>> >judging the patch. I was just going by what i believe is general lsm
>> >subsystem policy.
>> 
>> ( my word wrapping client did not like that message :( )
>
>Hm. yeah.  (Do you mean word-wrapping or non-word-wrapping?)  I see my
>phone mailer made it all one line.  I'll see if there's a setting for
>that.

like I had to scroll right in order to read all of your text.

>
>> hmm, it's pre-reqed over the patch as on the lore link, so Christian may
>> want to have a look at this obe
>
>Did this line get cut off?

s/obe/one , typo.


>
>> >> Let's see if Christian or anyone
>> >> else could suggest a nice little lsm user for this.
>>
>> >> If nobody responds, in coming days, I'll go and find and do a user
>for
>> >it.
>> >>
>> >>>
>> >>>> Suggested-by: Christian Brauner <brauner@kernel.org>
>> >>>> Link:
>> >>>
>>
>>https://lore.kernel.org/all/20261111-kommt-gischt-ohnedies-469998d2f219@brauner/
>> >>>> Signed-off-by: Bradley Morgan <bradley.morgan@linux.dev>
>> >>>> ---
>> >>>> Thanks Christian for the suggestion :).
>> >>>> ---
>> >>>> include/linux/security.h | 2 ++
>> >>>> kernel/user_namespace.c  | 3 ++-
>> >>>> 2 files changed, 4 insertions(+), 1 deletion(-)
>> >>>>
>> >>>> diff --git a/include/linux/security.h b/include/linux/security.h
>> >>>> index 40831fab54709..d24666a0b4833 100644
>> >>>> --- a/include/linux/security.h
>> >>>> +++ b/include/linux/security.h
>> >>>> @@ -75,6 +75,8 @@ struct nsset;
>> >>>> #define CAP_OPT_NOAUDIT BIT(1)
>> >>>> /* If capable is being called by a setid function */
>> >>>> #define CAP_OPT_INSETID BIT(2)
>> >>>> +/* Is capable being called from the user namespace creation path?
>*/
>> >>>> +#define CAP_OPT_USERNS_CREATE BIT(3)
>> >>>>
>> >>>> /* LSM Agnostic defines for security_sb_set_mnt_opts() flags */
>> >>>> #define SECURITY_LSM_NATIVE_LABELS 1
>> >>>> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
>> >>>> index 57b7f10be74e1..37480f6d8369f 100644
>> >>>> --- a/kernel/user_namespace.c
>> >>>> +++ b/kernel/user_namespace.c
>> >>>> @@ -134,7 +134,8 @@ int create_user_ns(struct cred *new)
>> >>>>      * audit: the creator may never map uid 0.
>> >>>>      */
>> >>>>     ns->parent_could_setfcap =
>> >>>> -       !security_capable(new, parent_ns, CAP_SETFCAP,
>> >CAP_OPT_NOAUDIT);
>> >>>> +       !security_capable(new, parent_ns, CAP_SETFCAP,
>> >>>> +                 CAP_OPT_NOAUDIT | CAP_OPT_USERNS_CREATE);
>> >>>>
>> >>>>     ret = ns_common_init(ns);
>> >>>>     if (ret)
>> >>>> --
>> >>>> 2.53.0
>> >>>
>> >>
>> >> --- Thanks!
>> >
>> >
>> 
>> --- Thanks!
>

--- Thanks!
