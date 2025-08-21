Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A4413A265
	for <linux-security-module@vger.kernel.org>; Thu, 21 Aug 2025 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755762380; cv=none; b=PG308X5bfH+qzG+DMpjLFTKoHQ54oMzWmkaBQfrvq7+hQccqMsnlKSMyrPTAAIQWLiaitvB6ckmFzY9cLW4j208mnHpARpFo99DOgQLMB0UyYqLlkm7S8OoqWYNnOupCef1SBImsEKQs6xFsqBnQiMn81eXrmI5N5Xhb2b3gCpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755762380; c=relaxed/simple;
	bh=iQQsG4ioYqyVeA+tR95ibeKPIzAxKs7VDXnxJ23wDdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oI5Vf8JmN/pZGT4Nd8Bj6ds0TwEa2XLC9K1qfE/RV0wdexKGI8iW7UPpCrn6t+5tZKPW86ib+cOBx2qZYSc+1BmKWHWMfRj/iC4rKEkmxg7BDtndXjACHG8CeqAZTHV47OTbqqdGXj+C3WoDoV2Eo7oiU7jL0VHjlqOsYQMrA5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=BXLFUFOG; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="BXLFUFOG"
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 810D43F7BB
	for <linux-security-module@vger.kernel.org>; Thu, 21 Aug 2025 07:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1755762375;
	bh=X8kBKF80NLAexYWTSEUY7zoeiW0+wySzh4pvlvvVhOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=BXLFUFOGSrtWLfpguqrHpeZ776Id9Jby7hoRLnGs1Y195fAoVe4J05nA4fqGtTi9e
	 wpAgKrA+4o9FE797HxFzXfBr9yRygGG09fWzLxQhafkiKL2AVjDR2p2+FYh4MwjLPc
	 Y9uqqzZzQkTbcPXqFDUkmp0HAQ/YsoccafinYhTspyX8blLwKktcNfDQJpC6wM9JvI
	 8hjy8iNNa/aleYkxM1UXkRUc9md3FclD+qhPipsVyumG1gn+vnBMZFLeveXLge/V70
	 x3reUTvHloKf2oNbcmqtjjXMJbxpzYXllqswlyZemdqjwybbrN5q2JVi76amqMcgZ8
	 xWPy/MD5WeZRg==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-244581953b8so9332235ad.2
        for <linux-security-module@vger.kernel.org>; Thu, 21 Aug 2025 00:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755762374; x=1756367174;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8kBKF80NLAexYWTSEUY7zoeiW0+wySzh4pvlvvVhOk=;
        b=Law5/k5fMjjrGnH5+eHvHbHYt6AC9Hr0z2ucqoyI1yGK+OYs69dCxBMMZxPByeSDyR
         /gnwuHxSiM7bIigug4nUJ58FvaBY7Dhn3oE5xru/LhbN0RvrHj46jScOE/NIPL3WBtlE
         VoaYis3ickaQ2Z8ETxfRMrCpqBTWOCHqjDJETbdt+d8E6lF7U989gqJPR7NPtbfwKJX1
         HfqvIdrSUxz6UmyDE2y0H7+nFLYPiqf8MDfXQ485aoZvLWxf8Y3GTMQ7B/1a1XTiAN0r
         O752U7y9Iyaat+eZSmbyjUCIXM7FnD055LN/fb/QFS3Oy4juwTFscKXgb83v4yJbNUXW
         TXBA==
X-Gm-Message-State: AOJu0YydXo7KkcWSIRL1w7vGfUHOshvDcCYkxKJGgXtRvGYMaR6akZaQ
	6UCuqSmBTND73upq8gLxFTrOmIsmpam4g+6Wlh0vbRRvZluLmyA9wQGbrBcrVY3N8jcIzYG1OjJ
	LL1K8N0porKKijiOnIDCf1A/09SgBA/ybhxqUZCjJ5+PXuEdSDQP1RV3WCNN8oTRTS985UdmWdM
	ibZKG1agBCRW86qrfdTw==
X-Gm-Gg: ASbGncvNRMfeEWrcC7wcUzqEcq41UzN5nKrgw6TX8mL5h0/V1Xq1E10fRhdGVGGDbqR
	Z1oBdW9VTUlQerfenYRzBT2Q+hTbwfmPireQ9o2cBSbNkAnCjZFF+HIbd773uJ0OGXh2RbQib8G
	nk8Ij8KoMtytWn6vQOgZ+RTPP34H9QiairtiiaFvp9mJKMFewEhhl+w9VbZrWK4ETUR7qZ4nhda
	eiak0TW0ECRYjKxoEMSs4uUYrCpOI7QG422PV0G1b2lqsHgNAKxmuzEumDo6Va9hdOnS2OWcUBu
	MGQLiugBRYm0ZmvyUbifE6vrdVYhVER6110Kyn5DnxxQHO8pnnWRsg==
X-Received: by 2002:a17:903:3504:b0:240:a559:be6a with SMTP id d9443c01a7336-245fed9b442mr20698815ad.34.1755762373850;
        Thu, 21 Aug 2025 00:46:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN5pv8Bm/1xHxNC3atKbOY7CJh3K/qlpGUJgYpvsqjD8vSnWNwul7ss3CHrMkSz8zRp6Yj+g==
X-Received: by 2002:a17:903:3504:b0:240:a559:be6a with SMTP id d9443c01a7336-245fed9b442mr20698595ad.34.1755762373399;
        Thu, 21 Aug 2025 00:46:13 -0700 (PDT)
Received: from [192.168.192.85] ([50.39.98.232])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-245f0d86c05sm40409585ad.93.2025.08.21.00.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 00:46:12 -0700 (PDT)
Message-ID: <67e72960-c985-48e1-aaeb-a4286cc8508f@canonical.com>
Date: Thu, 21 Aug 2025 00:46:10 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM namespacing API
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/19/25 10:47, Stephen Smalley wrote:
> On Tue, Aug 19, 2025 at 10:56 AM Paul Moore <paul@paul-moore.com> wrote:
>>
>> Hello all,
>>
>> As most of you are likely aware, Stephen Smalley has been working on
>> adding namespace support to SELinux, and the work has now progressed
>> to the point where a serious discussion on the API is warranted.  For
>> those of you are unfamiliar with the details or Stephen's patchset, or
>> simply need a refresher, he has some excellent documentation in his
>> work-in-progress repo:
>>
>> * https://github.com/stephensmalley/selinuxns
>>
>> Stephen also gave a (pre-recorded) presentation at LSS-NA this year
>> about SELinux namespacing, you can watch the presentation here:
>>
>> * https://www.youtube.com/watch?v=AwzGCOwxLoM
>>
>> In the past you've heard me state, rather firmly at times, that I
>> believe namespacing at the LSM framework layer to be a mistake,
>> although if there is something that can be done to help facilitate the
>> namespacing of individual LSMs at the framework layer, I would be
>> supportive of that.  I think that a single LSM namespace API, similar
>> to our recently added LSM syscalls, may be such a thing, so I'd like
>> us to have a discussion to see if we all agree on that, and if so,
>> what such an API might look like.
>>
>> At LSS-NA this year, John Johansen and I had a brief discussion where
>> he suggested a single LSM wide clone*(2) flag that individual LSM's
>> could opt into via callbacks.  John is directly CC'd on this mail, so
>> I'll let him expand on this idea.
>>
>> While I agree with John that a fs based API is problematic (see all of
>> our discussions around the LSM syscalls), I'm concerned that a single
>> clone*(2) flag will significantly limit our flexibility around how
>> individual LSMs are namespaced, something I don't want to see happen.
>> This makes me wonder about the potential for expanding
>> lsm_set_self_attr(2) to support a new LSM attribute that would support
>> a namespace "unshare" operation, e.g. LSM_ATTR_UNSHARE.  This would
>> provide a single LSM framework API for an unshare operation while also
>> providing a mechanism to pass LSM specific via the lsm_ctx struct if
>> needed.  Just as we do with the other LSM_ATTR_* flags today,
>> individual LSMs can opt-in to the API fairly easily by providing a
>> setselfattr() LSM callback.
>>
>> Thoughts?
> 
> I think we want to be able to unshare a specific security module
> namespace without unsharing the others, i.e. just SELinux or just
> AppArmor.

yes which is part of the problem with the single flag. That choice
would be entirely at the policy level, without any input from userspace.

I still think the policy may decide something different than what
userspace requests but that just means the namespacing of an LSM is
under the individual LSMs controls and not the infrastructures.

Eg. selinux is using hierarchical namespaces, so when asked for a
new namespace you will get the bounding hierarchy, but yama (if it
ever gets namespace support) could very well just use independent
namespaces.

> Not sure if your suggestion above supports that already but wanted to note it.
> Regardless, I have no objections to any system call or flag that can
> be used to unshare the SELinux namespace and it should be trivial to
> wire it up to the existing underlying function.
> Serge pointed out that we also will need an API to attach to an
> existing SELinux namespace, which I captured here:
> https://github.com/stephensmalley/selinuxns/issues/19

yes a mechanism to switch is needed, but I also strongly dislike
setns(2). For security purposes we definitely want to control whether
the LSM namespace is associated with other system namespaces.

> This is handled for other Linux namespaces by opening a pseudo file
> under /proc/pid/ns and invoking setns(2), so not sure how we want to
> do it.

That is a possible interface, not one that I like, so I would like to
explore other options first.


