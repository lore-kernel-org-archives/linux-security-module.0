Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794666868;
	b=ljrXQyAPNKzhnbZZwy/9K3VLOAIa9wXzjbVRpgH7fzCND6TukRQKnaa+Xa28jNIqQmB3
	 ma9YeU14+vpIslTmnKrjhXbFScBRl5lKiZNELoW17I+TS9m9frQzH8+ciXLwpTH9/TNeq
	 K/j8jBLaNoq13XAigUyJy5KAPFkxOxxtIVKYpPT4TGFpItfpdcPZ6Cbcy2VqsYRdXsckY
	 ggi8kZzb1IkQE9luTNLIjCJFR+TXR9f+wCi+EB0r+iCqsHYSEsGTkftkn5sVHeKMNy33/
	 pVey9hGjIyCFFaTNZ8G9rje3nTcYmn0Xa6qTRdSnaX6wxXTyrjbFOtoqrge1uery3xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794666868;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Message-ID:
	 In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Correlation-ID;
	bh=pUHQzOzRs1ujjJj6NvhzGNxWYRwUSfHsXRr7LxX4lvc=;
	b=jwrsjzECZ/iTDLrps46l+h5uk2eq6wGAZRDdQNQilhUv1r/njUIDgTK204NlSXcB9o4u
	 jIw/T6SeJZJsQwfu94ygu/PEnNe4BNaX+oDfGQT6BMxlCyGuvnx2JrZwFBx+Rb1RxC5oY
	 LVuHD7OxjgHbLzOy4WMrWsFBX/mMUmUZZZ8KHsA6/XzSBrsdIYeCVQ3ihN4xhLN/gVGJK
	 /95XYmDgQSybtqxUGx7FKuivNzleqKLD/tGF5jYqjtx1YFWMK/ok55bAYfZMbFSx1E1sO
	 Wq7Z2d56C9ZlGQzWi2gqNDaaNvXpmnPqbpkM8q0KlmSkK1lN9obX5J1Xi444euEqiEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=pass smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=1mrkFG38;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DA7606A337;
	Sat, 14 Nov 2026 14:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87DA7606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=1mrkFG38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1794666864; bh=pUHQzOzRs1ujjJj6NvhzGNxWYRwUSfHsXRr7LxX4lvc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=1mrkFG38M/Nnxll2yUPtdIOVb1RGXQ5F8SH5M0NSpe4OJYfzzlb+tarqAjxDAHwjx
	 MN0LHSOuHDoESq6AEvYtBTmG3lXx968tlbOVGTa3KdrevrfbBEpxLGm0Rr4gKy+ZRW
	 6Rj1nVK6es61cbHXpJSxoyzRAnKV8rnfD5aKOeC3/u00GNetTK8yUqwPzwSWdggId+
	 zFcqT/BprXfsW4fALOn6YKVkP725P3ID8T8jfC0gTdpNy8QZv9c16xWohgZwLyJ0lx
	 nexdKnLs+QRwd9wb/A2Urha4lmp22qyFLN7NIe3i3PQAUsBdrNkul7GGFJRjJdvS2n
	 eN/y5qUY5B3vw==
Received: from dummy.faircode.eu (unknown [172.56.94.249])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: serge)
	by mail.hallyn.com (Postfix) with ESMTPSA id 2F130C08;
	Sat, 14 Nov 2026 08:34:21 -0600 (CST)
Date: Sat, 14 Nov 2026 08:34:07 -0600
From: Serge Hallyn <serge@hallyn.com>
To: Bradley Morgan <bradley.morgan@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <0c403a09-38cf-4953-a73a-ee57837b3799@hallyn.com>
In-Reply-To: <4A0D804A-1199-4402-91EE-E37E8D6EA9E7@linux.dev>
References: <20261111205814.3282968-1-bradley.morgan@linux.dev> <aveDlb6PlPSVoLD9@hallyn.com> <4A0D804A-1199-4402-91EE-E37E8D6EA9E7@linux.dev>
Subject: Re: [PATCH] userns: security: Inform LSMs of capability check
 during userns creation
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <0c403a09-38cf-4953-a73a-ee57837b3799@hallyn.com>

Nov 13, 2026 15:54:37 Bradley Morgan <bradley.morgan@linux.dev>:

> On 13 November 2026 21:39:33 GMT, "Serge E. Hallyn" <serge@hallyn.com>
> wrote:
>> On Wed, Nov 11, 2026 at 08:58:14PM +0000, Bradley Morgan wrote:
>>> Right now security_capable() gets called in create_user_ns() to snapsho=
t
>>> whether the parent could setfcap, but the LSM gets zero context on wher=
e
>>> the check actually came from. It is the same story as setid: without a
>>> dedicated flag, security modules cannot tell this apart from regular
>>> capability checks.
>>>
>>> Add CAP_OPT_USERNS_CREATE and pass it along from create_user_ns().
>>
>> This should be patch 1/N in a set that introduces a user of it
>> in some lsm.
>
> hmm. Did you read Christians suggestion?

I did, when he first sent it. Actually it seems to me that what the lsm wou=
ld really like to know is that this is not for an immediate use of setfcap,=
 but possible future use. But that doesn't really matter. I wasn't judging =
the patch. I was just going by what i believe is general lsm subsystem poli=
cy.

> Let's see if Christian or anyone
> else could suggest a nice little lsm user for this.
>
> If nobody responds, in coming days, I'll go and find and do a user for it=
.
>
>>
>>> Suggested-by: Christian Brauner <brauner@kernel.org>
>>> Link:
>> https://lore.kernel.org/all/20261111-kommt-gischt-ohnedies-469998d2f219@=
brauner/
>>> Signed-off-by: Bradley Morgan <bradley.morgan@linux.dev>
>>> ---
>>> Thanks Christian for the suggestion :).
>>> ---
>>> include/linux/security.h | 2 ++
>>> kernel/user_namespace.c=C2=A0 | 3 ++-
>>> 2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/security.h b/include/linux/security.h
>>> index 40831fab54709..d24666a0b4833 100644
>>> --- a/include/linux/security.h
>>> +++ b/include/linux/security.h
>>> @@ -75,6 +75,8 @@ struct nsset;
>>> #define CAP_OPT_NOAUDIT BIT(1)
>>> /* If capable is being called by a setid function */
>>> #define CAP_OPT_INSETID BIT(2)
>>> +/* Is capable being called from the user namespace creation path? */
>>> +#define CAP_OPT_USERNS_CREATE BIT(3)
>>>
>>> /* LSM Agnostic defines for security_sb_set_mnt_opts() flags */
>>> #define SECURITY_LSM_NATIVE_LABELS 1
>>> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
>>> index 57b7f10be74e1..37480f6d8369f 100644
>>> --- a/kernel/user_namespace.c
>>> +++ b/kernel/user_namespace.c
>>> @@ -134,7 +134,8 @@ int create_user_ns(struct cred *new)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 * audit: the creator may never map uid 0.
>>> =C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0 ns->parent_could_setfcap =3D
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !security_capable(new, parent_ns,=
 CAP_SETFCAP, CAP_OPT_NOAUDIT);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !security_capable(new, parent_ns,=
 CAP_SETFCAP,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 CAP_OPT_NOAUDIT | CAP_OPT_USERNS_CREATE);
>>>
>>> =C2=A0=C2=A0=C2=A0 ret =3D ns_common_init(ns);
>>> =C2=A0=C2=A0=C2=A0 if (ret)
>>> --
>>> 2.53.0
>>
>
> --- Thanks!

