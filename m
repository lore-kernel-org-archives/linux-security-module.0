Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630A117DFE7
	for <linux-security-module@vger.kernel.org>; Thu, 31 Jul 2025 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753996686; cv=none; b=g7pLvz+PDgrYWQlE5Oumgf606EQIpC88DrvP+TinMXU27vCePEu3L0pgkDeRwKvQ9vxX1lAdA2erVn7l7J0a6l4rBfBLAomoZbLRAWKg+UGIHF0fCube8svs3XkO3np1MZXLJLbXZDOjHCRXkfOWcQp+sJWu9IJNA9QoMcs+DMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753996686; c=relaxed/simple;
	bh=xnqfoHl/fAflSNusyAXjqlvBsKleVOAowvjUT28kdYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYgTNkNwhg7e6HKj7+SfaKwN9WW1RYwTlJcSiHLDoBHfSe37Q4EQEdTFVSjLJXk6hHe+2woYS/5GoHg2Zure8oo+7nDObVuZW7nIBLVdniyVoO9BDb3m4ujb9mdNs05qWmjmstQ1pMIplDYglbkSxqUp0fiznhqvLYHZ9qxvtB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FP1llkH+; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FP1llkH+"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e8e2b50f8f1so198740276.0
        for <linux-security-module@vger.kernel.org>; Thu, 31 Jul 2025 14:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753996683; x=1754601483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ls3ljTCIq9ppiuzc0Wfe6Xw973/8/AHKNAw2u1Z5GXw=;
        b=FP1llkH+uEChsRrp/2iGioBV81TydSGOJJ+O08d9ZdmIHuThvGYNVsuKvSMbZv8E9R
         4RWT3H1pItj39I3VBmJhgsDNUFqueF+Nq1eigtLPRtdOAdev8EeGucGcxeXVjBxlUsHu
         f5hGx1Zpm6/QmLQL/SIxXpDrSZb0vNWQRji4dQ6KUGTnD2ksK8CJJkTYvOz98NJaHriN
         YiURPQ4mQmUMMwq56oqfzasaANjtUG2/20PtXA/ZiwVDa1HD6hZWbYwrxg993t6NQ4M1
         VXkZLrDWwcKuy0lKWrKHuP7nMmEG1KkCjsjrjLhqUGkOXdDVjDFFfXKuSSK/2NjCpUyQ
         UjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753996683; x=1754601483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ls3ljTCIq9ppiuzc0Wfe6Xw973/8/AHKNAw2u1Z5GXw=;
        b=btXYTxDpMEhQY1gFCS9BYJba9V520U+TUKtCf+V8DkNYSR12BMVREgX6u1ohLIJMMi
         yRGOSLBtlXvAPINaX+9S0G4FXMVTbhcb++p6oRIMj88fgHZ+o0SFD9gaxI1HfRy/C4SK
         ReSELNX4HVCcCAmVlXtJVYQM4BFRZgt64yU/Lk4ct3xX7RTDxL4U43+xVxWN5a7uEeNs
         l+euGlgvwpBOW3El//hyWKEI2xPY98B9OIiT4B5gxV8uQcbMOq+BylCxVQQKR9cEl67E
         uCkBqwTlIo9Zn2g1U5bF39m30mRMZTiRrCbZw05K5Q6ojmnffOudKkJT34k9I5s4R9eD
         sLww==
X-Forwarded-Encrypted: i=1; AJvYcCXlK165cQNqex7+9SJg0LpIbO3rg2Dt/S3W8uRGJwKggAWabcd42ChoyzTiyOYs8BL3a2l47/KGBa4DYZjEZvwqwT/CPOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnVIdQQD9zUVyBVoPJOQGarr7xWkA6CcsJ4IU/BS4Vsgghi38B
	KimnTQPRCxrwcyUmxh22mh+nT1eTw5oDpOcwGpDv6qymHJEaf92cXY5xTiTisKjYETAcHnydfel
	MABwiFN6IXiqYHQecaoG4qqiS6CCRf+58DN4PU8Y2
X-Gm-Gg: ASbGnct3Og/vD5PEz4/k6jURg9hVBXgBhqdn3q1sDn0nbZrCHZo1UHYvVPgqS2tl2JW
	b/FQ1J/ZGekxAzOhUS1Pkm/e8HGMEyp5wje5VUJwoDO60QAEyt8BLZpqTJqX+9ptftzrUi8rdvc
	lHpkgx03+E8N1Toitpm+B1y70gK2F3wRsr2S0WwfgoRG3vC5hZZ51dI0L6BFARSoCvJ7u6cZ/Rx
	Axmw+k=
X-Google-Smtp-Source: AGHT+IHxbVoakma6E5jErYw+J2tjsiw5SbLEOoBRBZciJg4VRe6z14ff6hn9lTo1rNUbsfCgHuhhJ7lH5Xg5cyv1L3k=
X-Received: by 2002:a05:690c:6c04:b0:719:f1b0:5c1e with SMTP id
 00721157ae682-71a4696e8dfmr120573597b3.41.1753996683352; Thu, 31 Jul 2025
 14:18:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729090933.94942-1-tianjia.zhang@linux.alibaba.com>
 <e81ba8e7-8938-4b76-ae7b-bfee6021aeac@schaufler-ca.com> <CAHC9VhQAVvvXUoFu7xnh0uBhmvgYinP=AhiC4y17JJ02M9s5Nw@mail.gmail.com>
 <2aa4da27-28fc-46e0-8d1a-d9e63b03d502@linux.alibaba.com>
In-Reply-To: <2aa4da27-28fc-46e0-8d1a-d9e63b03d502@linux.alibaba.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 31 Jul 2025 17:17:51 -0400
X-Gm-Features: Ac12FXyQLeqW73x4_ifris7ry6grmpz8fDB0kTkhm4CDJTOwER1qhgRNQOhJ-y8
Message-ID: <CAHC9VhRS2DrGoSb72uY61yVNXXZjOqKSkEdK7vNgPJxVdZgujA@mail.gmail.com>
Subject: Re: [PATCH] lsm: simplify security_inode_copy_up_xattr()
To: "tianjia.zhang" <tianjia.zhang@linux.alibaba.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 7:59=E2=80=AFAM tianjia.zhang
<tianjia.zhang@linux.alibaba.com> wrote:
> On 7/29/25 11:09 PM, Paul Moore wrote:
> > On Tue, Jul 29, 2025 at 10:43=E2=80=AFAM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> >> On 7/29/2025 2:09 AM, Tianjia Zhang wrote:
> >>> The implementation of function security_inode_copy_up_xattr can be
> >>> simplified to directly call call_int_hook().
> >>>
> >>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> >>> ---
> >>>   security/security.c | 8 +-------
> >>>   1 file changed, 1 insertion(+), 7 deletions(-)
> >>>
> >>> diff --git a/security/security.c b/security/security.c
> >>> index 596d41818577..a5c2e5a8009f 100644
> >>> --- a/security/security.c
> >>> +++ b/security/security.c
> >>> @@ -2774,13 +2774,7 @@ EXPORT_SYMBOL(security_inode_copy_up);
> >>>    */
> >>>   int security_inode_copy_up_xattr(struct dentry *src, const char *na=
me)
> >>>   {
> >>> -     int rc;
> >>> -
> >>> -     rc =3D call_int_hook(inode_copy_up_xattr, src, name);
> >>> -     if (rc !=3D LSM_RET_DEFAULT(inode_copy_up_xattr))
> >>> -             return rc;
> >>> -
> >>> -     return LSM_RET_DEFAULT(inode_copy_up_xattr);
> >>> +     return call_int_hook(inode_copy_up_xattr, src, name);
> >>
> >> Both the existing code and the proposed change are incorrect.
> >> If two LSMs supply the hook, and the first does not recognize
> >> the attribute, the second, which might recognize the attribute,
> >> will not be called. As SELinux and EVM both supply this hook
> >> there may be a real problem here.
> >
> > It appears that Smack also supplies a inode_copy_up_xattr() callback
> > via smack_inode_copy_up_xattr().
> >
> > Someone should double check this logic, but looking at it very
> > quickly, it would appear that LSM framework should run the individual
> > LSM callbacks in order so long as they return -EOPNOTSUPP, if they do
> > not return -EOPNOTSUPP, the return value should be returned to the
> > caller without executing any further callbacks.  As a default return
> > value, or if all of the LSM callbacks succeed with -EOPNOTSUPP, the
> > hook should return -EOPNOTSUPP.
> >
> > Tianjia Zhang, would you be able to develop and test a patch for this?
> >
>
> I carefully checked the logic of security_inode_copy_up_xattr(). I think
> there is no problem with the current code. The default return value of
> inode_copy_up_xattr LSM is -EOPNOTSUPP. Therefore, when -EOPNOTSUPP is
> returned in the LSM callback, the next callback function will be called
> in a loop. When an LSM module recognizes the attribute name that needs
> to be ignored, it will return -ECANCELED to indicate
> security_inode_copy_up_xattr() to jump out of the loop and ignore the
> copy of this attribute in overlayfs.
>
> Currently, the SELinux, EVM, and Smack that supply inode_copy_up_xattr
> callback all return -ECANCELED after recognizing the extended attribute
> name they are concerned about, to indicate overlayfs to discard the
> copy_up operation of this attribute. I think this is in line with
> expectations.

Perfect, thanks!

--=20
paul-moore.com
