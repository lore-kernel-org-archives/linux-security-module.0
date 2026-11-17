Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794928540;
	b=3J6amdkJWjzUly4B836z96X/mOSromUlVK/OrPr4wzkgzqPSKDaEM9Gmiy/cRcixzUKu
	 dRiAvDxuNcAciYCJMGQIIHcVr8zjG7M1YkVktK/LEZsnzLwRhQD+HxxJVLO485+Z4A02L
	 PBzclTR5OM2QUGTY+ZKFe8wg6eol9dVxCiuSRfpasnRqakNz/K0yrY5AMcAxHm6MdmWwK
	 8a2W26CAbpbW+ylcSkeEHwvZV3OuNPPwmgUFXt2bn53sLOyIWR2bL7njPHN6vs31dcuoa
	 iTdEWsRbbkrF+isafE5sM46W0STyokxk+LRANPonZzLKdqNfImQd/CLo6SJQEyoxQEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794928540;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Yl1Tl7A6GTDHzu7swYybx3NWBnAXAgNBiJXglcocm34=;
	b=Fr5bLvoW+0I2BHU3oJjqq97Z/fynPExnhrN4s/9uF6V0bqibwBFPHLlBJBLZnNVlpEjA
	 QBAkHHSiEcEhZr2pH40qbL0QlJ6ddAbh0mqMEFev7sWzTNqc1WS15A9YnH6w7mDoCqy28
	 +NGroadKFLPXTosiCR/K4GG8k3CjKyS6JDll1Plq35+713RXz5gaAK6PomJVuERhLg6DG
	 qR5ILALn49NGxAWw9iXrbzX9EuZeNjTASP3GPY+lB2TautZoOIndOZkWNVIv/vyLEipqF
	 TrCax+2A58ekApFxI1Sje0l/N0slMpsj6O0qcBRuSd5+POu5566caJKMxtpNDgMxLPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=pass smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=RRNss6VV;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14995606A32F;
	Tue, 17 Nov 2026 15:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14995606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=RRNss6VV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1794928530; bh=EqbQ4qvrW/tMs8Zz0DUrZrAxrmjNOY/UJxUTy3OzqRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RRNss6VV/7OASxvaFY9gGvn6OUrsxBSj57GwA8e6OBO+KwPMz87QxPKIfi6yOmidT
	 6AfuI7jk/C1B8DkLAAttzldPv69ik2oTFz1XMYJWxhhTRc6fZwWDn1lGhDLmEKE3/l
	 MHEtjinE4IVr6JVIuY5hqSupQLh27+iD9HXPikDgfB8LA5I9M8vCxj4WCGftt9gWIL
	 JSrUslocyT60eID1OMYXaxn29rkMlMmbF7fHmM6hbxndRwvvU0nKI0JL2wtp3fgmDy
	 18BW8yfsvXCNqNAf76reRbNXK6UAuXI7xWak48lBj43XkN91yUtZ+LsH1A8CqQ06jH
	 YqeiK5skA1gWg==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id B760734F; Tue, 17 Nov 2026 09:15:30 -0600 (CST)
Date: Tue, 17 Nov 2026 09:15:30 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Bradley Morgan <bradley.morgan@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] userns: security: Inform LSMs of capability check during
 userns creation
Message-ID: <avxvkuC5SP/0c+wr@hallyn.com>
References: <20261111205814.3282968-1-bradley.morgan@linux.dev>
 <aveDlb6PlPSVoLD9@hallyn.com>
 <4A0D804A-1199-4402-91EE-E37E8D6EA9E7@linux.dev>
 <0c403a09-38cf-4953-a73a-ee57837b3799@hallyn.com>
 <5862E641-C0F8-45B2-B340-DF4506AC9FAF@linux.dev>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5862E641-C0F8-45B2-B340-DF4506AC9FAF@linux.dev>

On Sat, Nov 14, 2026 at 02:44:24PM +0000, Bradley Morgan wrote:
> On 14 November 2026 14:34:07 GMT, Serge Hallyn <serge@hallyn.com> wrote:
> >Nov 13, 2026 15:54:37 Bradley Morgan <bradley.morgan@linux.dev>:
> >
> >> On 13 November 2026 21:39:33 GMT, "Serge E. Hallyn" <serge@hallyn.com>
> >> wrote:
> >>> On Wed, Nov 11, 2026 at 08:58:14PM +0000, Bradley Morgan wrote:
> >>>> Right now security_capable() gets called in create_user_ns() to
> >snapshot
> >>>> whether the parent could setfcap, but the LSM gets zero context on
> >where
> >>>> the check actually came from. It is the same story as setid: without a
> >>>> dedicated flag, security modules cannot tell this apart from regular
> >>>> capability checks.
> >>>>
> >>>> Add CAP_OPT_USERNS_CREATE and pass it along from create_user_ns().
> >>>
> >>> This should be patch 1/N in a set that introduces a user of it
> >>> in some lsm.
> >>
> >> hmm. Did you read Christians suggestion?
> >
> >I did, when he first sent it. Actually it seems to me that what the lsm
> >would really like to know is that this is not for an immediate use of
> >setfcap, but possible future use. But that doesn't really matter. I wasn't
> >judging the patch. I was just going by what i believe is general lsm
> >subsystem policy.
> 
> ( my word wrapping client did not like that message :( )

Hm. yeah.  (Do you mean word-wrapping or non-word-wrapping?)  I see my
phone mailer made it all one line.  I'll see if there's a setting for that.

> hmm, it's pre-reqed over the patch as on the lore link, so Christian may
> want to have a look at this obe

Did this line get cut off?

> >> Let's see if Christian or anyone
> >> else could suggest a nice little lsm user for this.
>
> >> If nobody responds, in coming days, I'll go and find and do a user for
> >it.
> >>
> >>>
> >>>> Suggested-by: Christian Brauner <brauner@kernel.org>
> >>>> Link:
> >>>
> >https://lore.kernel.org/all/20261111-kommt-gischt-ohnedies-469998d2f219@brauner/
> >>>> Signed-off-by: Bradley Morgan <bradley.morgan@linux.dev>
> >>>> ---
> >>>> Thanks Christian for the suggestion :).
> >>>> ---
> >>>> include/linux/security.h | 2 ++
> >>>> kernel/user_namespace.c  | 3 ++-
> >>>> 2 files changed, 4 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/include/linux/security.h b/include/linux/security.h
> >>>> index 40831fab54709..d24666a0b4833 100644
> >>>> --- a/include/linux/security.h
> >>>> +++ b/include/linux/security.h
> >>>> @@ -75,6 +75,8 @@ struct nsset;
> >>>> #define CAP_OPT_NOAUDIT BIT(1)
> >>>> /* If capable is being called by a setid function */
> >>>> #define CAP_OPT_INSETID BIT(2)
> >>>> +/* Is capable being called from the user namespace creation path? */
> >>>> +#define CAP_OPT_USERNS_CREATE BIT(3)
> >>>>
> >>>> /* LSM Agnostic defines for security_sb_set_mnt_opts() flags */
> >>>> #define SECURITY_LSM_NATIVE_LABELS 1
> >>>> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> >>>> index 57b7f10be74e1..37480f6d8369f 100644
> >>>> --- a/kernel/user_namespace.c
> >>>> +++ b/kernel/user_namespace.c
> >>>> @@ -134,7 +134,8 @@ int create_user_ns(struct cred *new)
> >>>>      * audit: the creator may never map uid 0.
> >>>>      */
> >>>>     ns->parent_could_setfcap =
> >>>> -       !security_capable(new, parent_ns, CAP_SETFCAP,
> >CAP_OPT_NOAUDIT);
> >>>> +       !security_capable(new, parent_ns, CAP_SETFCAP,
> >>>> +                 CAP_OPT_NOAUDIT | CAP_OPT_USERNS_CREATE);
> >>>>
> >>>>     ret = ns_common_init(ns);
> >>>>     if (ret)
> >>>> --
> >>>> 2.53.0
> >>>
> >>
> >> --- Thanks!
> >
> >
> 
> --- Thanks!
