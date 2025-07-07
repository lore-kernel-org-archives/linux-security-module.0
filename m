Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A6321B9CE
	for <linux-security-module@vger.kernel.org>; Mon,  7 Jul 2025 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751918504; cv=none; b=u0ZRKWaE2CyfFPH3rSlaz0CnfJOuF+GEOwfz7CDjYP+ky1f14VZjIgZexLvzIxAWxn27gZK32fyqM5tE9ajuu2fvN1RLxOzn/1OR7aieVH6eD6/ynktxAKSFwpldPpFzo90cA+Ce0uf1UQ//HnIVBSUKYAQOEA9zrx8LydhQpi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751918504; c=relaxed/simple;
	bh=FdEbLOGjzd4t658A5Peq0X8hOkXjkWfiWfkvvcSRkzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjnksR2I4svAasRKh/oRV1OhIfJ3YSRo7rtWMADrpvOU52RxfuEhnN09shVNMK8iP3ljbm7AlhkuHb1wFxnQ1TvNSKqkD3rtRnkexMorpYtl5k3k1z1J7nfi0TlWeJMWPc2DKdGuWzrNDTZFEEPuufu9zh8C5Nm8rL06Ah6JlSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cDTLZ9TY; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cDTLZ9TY"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e7b4ba530feso2965923276.1
        for <linux-security-module@vger.kernel.org>; Mon, 07 Jul 2025 13:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1751918501; x=1752523301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKLu5W4g48bt+4yviXuICuogMC7NETqzFrH52NDnWkc=;
        b=cDTLZ9TYrPqyUZUHPV4652jc20Kjmp0EL8+jEIzcvMMdn7pIqDLFh1Tvh9Os4/PBv8
         fUdozMNQlDAbUz+Y58iFU3mklwjb4FhT1EJbksqxoxMFn6pa8IiE2v9BH3YNwThAXAUE
         yfQCA8EIE/3Qx70DBEXLLBw2Z8UhGmmljBDKGJmV4SClH3LRGhUHIC3vOpbTBt9lsm1f
         oMOrI14nU1bk6yVZlTzpWkYusvKHVHcBEhd4KylzBaaqqNYrlrCAb6TpZo8Up8al0NUn
         CgVK4KMjKVhBc11UDWZEV7/mFfygXLU64F4YmOEHzNte+S6UY74WKleTSAM3GT/0h4eY
         CnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751918501; x=1752523301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKLu5W4g48bt+4yviXuICuogMC7NETqzFrH52NDnWkc=;
        b=StFhA7bpQmjNCvcpe82KulN0mZ5SJzsvKsKYdkhysY4R1STKsi3acEZIDN6/R/Fg6I
         TQaNzR+Tbtiurp+99AseJ+ACIV8HT0wS7uDuWSvsajmv4AoS4CTFxmr9jf24gEIaD6wB
         miI/EdFg6CnJEJmkNAfZe8am5algn880zDcNR7AQOsyHzhlyi3QgNqSJDByAQqdzQbo+
         StXygTaudT2/beZinoxxzRxed2XtpcxZzNH4DSPkX5yJj0+DMTm8yq0VkqBOEIhsS3cW
         OiFs0QBQfo5mC3RcVYx4o1VUwY4y/ww91od7SxgcIe5pZRAPq7M1eemCkiG8uzP1DoM2
         kZDg==
X-Forwarded-Encrypted: i=1; AJvYcCWl1JKQED1xt4mtyjz+bYDyzZtNErnc4p7ix2Dahr6AJJIevjhIcVT4QQPbG4knlSVoN7Iu8z2F0gIHKP/b8sM5tbnT9rU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUawLqVgmopu9SFujcVv7jDLcMN0eyxhv4/c6/DVNfOSDGmaNs
	paN9ojoH7mko9vAeIHRnbO2InTZsdz6CaBKFMpfBVFen9smNrVnvZyXlGPJSqvlkUVUYgYF7Imo
	CN0YkXWivvlSXKRDSrW0unQJLmnU8APQXFNhYPUrp
X-Gm-Gg: ASbGncsp32nWm9RqQYvBHsUkCAGbYNFNn3Du8i7xn4CEf8lKMYAE91BD3vJRQAFHpJx
	b7J6mZWFoPblP+axS0BiXvgxZ3y0delqCeb7XKSwgrgdf0qLdpbrDjsqGG8yQ8weUQ+6IFE2pNa
	ojHwwUGpPTx3kYqiZi4JT2UCut05JxgULMcw9DqF5Z5WM=
X-Google-Smtp-Source: AGHT+IHLYTU4kBITzhD3jz6dc9Ywq+TkUQw8uddLaok7bGe3BDRvXBsFsPv9J8pTF74kHSNW6YoQwtEeQTNvu7SccGQ=
X-Received: by 2002:a05:690c:4507:b0:70e:2ba2:659d with SMTP id
 00721157ae682-71668ded751mr165544117b3.23.1751918500803; Mon, 07 Jul 2025
 13:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626191425.9645-5-shivankg@amd.com> <a888364d0562815ca7e848b4d4f5b629@paul-moore.com>
 <67c40ef1-8d90-44c5-b071-b130a960ecc4@amd.com>
In-Reply-To: <67c40ef1-8d90-44c5-b071-b130a960ecc4@amd.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 7 Jul 2025 16:01:29 -0400
X-Gm-Features: Ac12FXweLS9FMTeg88WL40gFmqBUb7ZnlDziG-m_E-Jv5rzfO0-ilcmo0yLCqmI
Message-ID: <CAHC9VhTXheV6vxEFMUw4M=fN3mKsT0Ygv2oRFU7Sq_gEcx2iyg@mail.gmail.com>
Subject: Re: [PATCH v3] fs: generalize anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
To: Shivank Garg <shivankg@amd.com>
Cc: david@redhat.com, akpm@linux-foundation.org, brauner@kernel.org, 
	rppt@kernel.org, viro@zeniv.linux.org.uk, seanjc@google.com, vbabka@suse.cz, 
	willy@infradead.org, pbonzini@redhat.com, tabba@google.com, 
	afranji@google.com, ackerleytng@google.com, jack@suse.cz, hch@infradead.org, 
	cgzones@googlemail.com, ira.weiny@intel.com, roypat@amazon.co.uk, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 6:41=E2=80=AFAM Shivank Garg <shivankg@amd.com> wrot=
e:
> On 7/3/2025 7:43 AM, Paul Moore wrote:
> > On Jun 26, 2025 Shivank Garg <shivankg@amd.com> wrote:
>
> ...
>
> > Thanks again for your continued work on this!  I think the patch looks
> > pretty reasonable, but it would be good to hear a bit about how you've
> > tested this before ACK'ing the patch.  For example, have you tested thi=
s
> > against any of the LSMs which provide anonymous inode support?
> >
> > At the very least, the selinux-testsuite has a basic secretmem test, it
> > would be good to know if the test passes with this patch or if any
> > additional work is needed to ensure compatibility.
> >
> > https://github.com/SELinuxProject/selinux-testsuite
>
> Hi Paul,
>
> Thank you for pointing me to the selinux-testsuite. I wasn't sure how to =
properly
> test this patch, so your guidance was very helpful.
>
> With the current test policy (test_secretmem.te), I initially encountered=
 the following failures:
>
> ~/selinux-testsuite/tests/secretmem# ./test
> memfd_secret() failed:  Permission denied
> 1..6
> memfd_secret() failed:  Permission denied
> ok 1
> ftruncate failed:  Permission denied
> unable to mmap secret memory:  Permission denied
> not ok 2

...

> To resolve this, I updated test_secretmem.te to add additional required
> permissions {create, read, write, map}
> With this change, all tests now pass successfully:
>
> diff --git a/policy/test_secretmem.te b/policy/test_secretmem.te
> index 357f41d..4cce076 100644
> --- a/policy/test_secretmem.te
> +++ b/policy/test_secretmem.te
> @@ -13,12 +13,12 @@ testsuite_domain_type_minimal(test_nocreate_secretmem=
_t)
>  # Domain allowed to create secret memory with the own domain type
>  type test_create_secretmem_t;
>  testsuite_domain_type_minimal(test_create_secretmem_t)
> -allow test_create_secretmem_t self:anon_inode create;
> +allow test_create_secretmem_t self:anon_inode { create read write map };
>
>  # Domain allowed to create secret memory with the own domain type and al=
lowed to map WX
>  type test_create_wx_secretmem_t;
>  testsuite_domain_type_minimal(test_create_wx_secretmem_t)
> -allow test_create_wx_secretmem_t self:anon_inode create;
> +allow test_create_wx_secretmem_t self:anon_inode { create read write map=
 };

I believe this domain also needs the anon_inode/execute permission.

>  allow test_create_wx_secretmem_t self:process execmem;
>
>  # Domain not allowed to create secret memory via a type transition to a =
private type
> @@ -30,4 +30,4 @@ type_transition test_nocreate_transition_secretmem_t te=
st_nocreate_transition_se
>  type test_create_transition_secretmem_t;
>  testsuite_domain_type_minimal(test_create_transition_secretmem_t)
>  type_transition test_create_transition_secretmem_t test_create_transitio=
n_secretmem_t:anon_inode test_secretmem_inode_t "[secretmem]";
> -allow test_create_transition_secretmem_t test_secretmem_inode_t:anon_ino=
de create;
> +allow test_create_transition_secretmem_t test_secretmem_inode_t:anon_ino=
de { create read write map };
>
> Does this approach look correct to you? Please let me know if my understa=
nding
> makes sense and what should be my next step for patch.

[NOTE: added selinux@vger and selinux-refpolicy@vger to the To/CC line]

Hi Shivank,

My apologies for not responding earlier, Friday was a holiday and I
was away over the weekend.  Getting back at it this morning I ran into
the same failures as you described, and had to make similar changes to
the selinux-testsuite policy (see the anon_inode/execute comment
above, I also added the capability/ipc_lock permission as needed).

Strictly speaking this is a regression in the kernel, even if the new
behavior is correct.  I'm CC'ing the SELinux and Reference Policy
lists so that the policy devs can take a look and see what impacts
there might be to the various public SELinux policies.  If this looks
like it may be a significant issue, we'll need to work around this
with a SELinux "policy capability" or some other compatibility
solution.

--=20
paul-moore.com
