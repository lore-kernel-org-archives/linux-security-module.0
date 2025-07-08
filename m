Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8497922068E
	for <linux-security-module@vger.kernel.org>; Tue,  8 Jul 2025 02:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751942739; cv=none; b=i68Fzzy4Jf1XB8DgSbLfrBBoSJ2uOakfZFJVSTyi+TXhyL6kJkhG6UV9fI6f0gud+mxVfpF2GSDyg1qJRbRjlzwcUOQlnaPmORr+dZP5+M5PETKRrg4K7ChKQzF5cSLO054AWMjA/aTveW9muhdKb7BYKnLf5d6FiSi8p1rd8wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751942739; c=relaxed/simple;
	bh=aUMMjB+yn4mSEgqXKC698aJON3QG4yYWMuKTKFB/0kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AO6Et3YCBm/Q0XRaRnEvLBwcES/w2M+icHEyi1KDP+xfrh8VbGqrDoEcjECVtQL6MfPW0KFRql0NitPdoOfo8KC3z5atKFzNJIOLlQedxQfj50VtC08mClPlLWHNmAi+WG3YHvqrLhfN7POK3bVxLdiAthE1gBVGKeZqE4LFVhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gga3JszB; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gga3JszB"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e82314f9a51so2897363276.0
        for <linux-security-module@vger.kernel.org>; Mon, 07 Jul 2025 19:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1751942734; x=1752547534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQ/NiNUPsy7bq8yRlo+N7RrKNim2+iwf68n6XJkJTqU=;
        b=gga3JszBe1+ZUdewSLprTGFloPNe7xaFU4ijUOmCJ75ENlEqPH3Ss6DurCaQ6VxqJg
         /JhbLuw9x2zIHzwmdRAwgUxfjrlQ56o8srONhdjuW6mr1oBj89VSrlF9w3nmks5q9lYi
         8Qzx8m3VRAdCdRpLJkxWD2PyAuWM+ZNIU/HoX4ejtzFat5F6BbKAqz+6r9QoTVoAX3Vv
         tRnW1Zod60EHlTMqAgIA5Gr0N6JFLTEMH5DPai4QPtlBqVBNjGDesnBBmdf8k7qQZKID
         ao2nMo/Frif/PdslDXdZ9YeaP1N5KTzAK8gt1OD57W1Tx/3GeSK/E1FErnnUOTNk1EPo
         wfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751942734; x=1752547534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQ/NiNUPsy7bq8yRlo+N7RrKNim2+iwf68n6XJkJTqU=;
        b=d/FFC0w3y33B5ib3wQbaQV1WjS1KzcBTEKRc2pUN4UBE+fjLEZxpUOcZTZzcq3d+Wt
         CbQD3K1SxPj0yGS5gUtNQ1S5IH1qxzcGMdBmyHMeicDjpttMaP4o8mXvqWC/QCw10YrQ
         sIz1W3AAXzpDoApvcVurvXqaK7J3E00B9OI17ySd/1HlZUAlhIWMuyEJrVX8g7sDxPGh
         5aV5etmNQn6xnpgQcf2aZnBnOTzoUXVCHQ/+GLM9GIQpdb78rMd1SOJd5VWZDVC3ZHVe
         ktl3wuR376AeKViqzcacEGzSgVwHUq9/O4EFO5BKOspVIM7Y8OPv8KSQDAINeFGjmBhe
         KHhA==
X-Forwarded-Encrypted: i=1; AJvYcCXylSd7BigR3cFWdX7IbuiQImatLhNoy4d7kqMhdWMfGA9CqR6KeVrwLNcJljEH731GArpil2EO3+ECadDosfbTqpXXLDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc5nPhUaYYxKdilXM+E8/WGwW1ifXm6zBrZewXlrBzZuLV25bB
	koQTmehTjLlK2Jd0ewbjLP/Kj/Pkzz9/gcN9pnBwb5JByoVlU5BiWEGTVNGdwslo2lEfF4EYtZv
	TlsniFWBYsmHCzIvXAwbYlFIoWv7EF4m2ng3lOU26
X-Gm-Gg: ASbGncvDVyZGo/eaF/BHN2L70xQkciLbDBsmmOG4C2SIhtXFwE8eIcgBJRE+5lUKwNo
	XcPoIAr4JPkAM8EmL19EDZVrD0KoWo7jfW4z5WFX4On/EkGn5muKrN5kA5U+3uvgvn9lvLtN4mM
	FkQQ6Ud7TfSEyOfDqF5CP9ofpSdyBTRq29mv0vVToXE5c=
X-Google-Smtp-Source: AGHT+IHWCYgBwFfnvQ04g7x7wixvMXAER4hy7VugO4JmRhjOft/6uFE58Yw19AkqzbY/9MfAI0j4ZrhQW/BRI9ZtxG0=
X-Received: by 2002:a05:690c:700d:b0:715:952:e8d1 with SMTP id
 00721157ae682-717a0414aeemr15148317b3.20.1751942734451; Mon, 07 Jul 2025
 19:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626191425.9645-5-shivankg@amd.com> <a888364d0562815ca7e848b4d4f5b629@paul-moore.com>
 <67c40ef1-8d90-44c5-b071-b130a960ecc4@amd.com> <CAHC9VhTXheV6vxEFMUw4M=fN3mKsT0Ygv2oRFU7Sq_gEcx2iyg@mail.gmail.com>
 <48916a70-2a89-4d24-8e36-d15ccc112519@ieee.org>
In-Reply-To: <48916a70-2a89-4d24-8e36-d15ccc112519@ieee.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 7 Jul 2025 22:45:23 -0400
X-Gm-Features: Ac12FXx48DIUvMS0yWAzdQUJMMUn3Ep5a8fVtcwuwTJZh9ePscSPqgGP30FbUrk
Message-ID: <CAHC9VhRUkKWDc39BAz6uzjRBt47wDCNkzfV=z6+Tb-RznfycsQ@mail.gmail.com>
Subject: Re: [PATCH v3] fs: generalize anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
To: Chris PeBenito <pebenito@ieee.org>
Cc: Shivank Garg <shivankg@amd.com>, david@redhat.com, akpm@linux-foundation.org, 
	brauner@kernel.org, rppt@kernel.org, viro@zeniv.linux.org.uk, 
	seanjc@google.com, vbabka@suse.cz, willy@infradead.org, pbonzini@redhat.com, 
	tabba@google.com, afranji@google.com, ackerleytng@google.com, jack@suse.cz, 
	hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com, 
	roypat@amazon.co.uk, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 4:38=E2=80=AFPM Chris PeBenito <pebenito@ieee.org> w=
rote:
> On 7/7/2025 4:01 PM, Paul Moore wrote:
> >
> > Strictly speaking this is a regression in the kernel, even if the new
> > behavior is correct.  I'm CC'ing the SELinux and Reference Policy
> > lists so that the policy devs can take a look and see what impacts
> > there might be to the various public SELinux policies.  If this looks
> > like it may be a significant issue, we'll need to work around this
> > with a SELinux "policy capability" or some other compatibility
> > solution.
>
> In refpolicy, there are 34 rules for anon_inode and they all have {
> create read write map } -- none of them have the execute permission.  Of
> these, only 4 are explict and could potentially be broken.  The
> remaining get it due to being unconfined, thus can be immediately fixed,
> since it's unconfined.
>
> IMO, this is very low impact.

Thanks Chris, I think it's worth leaving the kernel code as-is and
just patching the selinux-testsuite.  I'll send out a patch for that
tomorrow.

--=20
paul-moore.com
