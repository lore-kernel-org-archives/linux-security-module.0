Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9DED520
	for <linux-security-module@vger.kernel.org>; Sun,  6 Oct 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728251452; cv=none; b=Hoz0wS7ISA4kzAzw3Ns1i1f1Um2Dssj6c1stn3sZL7yMTl5n7qJKIenaB3cZcUnFsEqGIcpI33xkx+nfjM4Sx5l+ILTHUaoG5kAgfP2M2ABvqnHYiwGzhPInjew/AXB53OFjKtqe0UX8LyINHNTFQwI24jG45hdgbYVJBXgBcUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728251452; c=relaxed/simple;
	bh=9mRYjKgygnc1njwaiMV3ggMN8ewFhgunmiuShe/GIKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhgkzMc8HTADBOXiscJefT6I/qBade9dfjwgRi0jfQi+IvFVR6pU5xCdxg55mf91tyqQF+HxTTlPWXNas+P4/dnRFHAPILcbZtT94gz6htnZ1ojA1R7ebeNzcsmDSUxWwxtJg9K4L14nUcPUrh2e5ZV54zum8kw0cBs0KWvUgek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nnLsMcxg; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nnLsMcxg"
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id AB8333F18D;
	Sun,  6 Oct 2024 21:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1728251440;
	bh=drfE5xDPCwItWPuTOnx5lou29YHBh3GRFBoQi/1sa68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=nnLsMcxghnhpIXIaYBvV1Lz0yJMR25+JCSf47qX7wvoO9ts39NG66QaZmh2Ud7WG2
	 2xfXZzfUdYBYkC0byBG5QR+uIIrayu4+LDZV/FQ1aHTbAiYq45jtZMtKgY+RAEGuZg
	 HZ0kqiq9FS+c3KnLu9Fx/8iKBIRJ3qHf4ysFRe4LlHi6lXWsoXdJuybjBWfiTGDnFh
	 Lqs6i9kTT3TotB3oOLp0zAuNHXBYQIBw6gHAiv8kJiCmWhVgqZdsO1lL80Cv3McvnC
	 5toZyeqZMSoXC9sjpq2i8Oh82xgkEV8fHDFZZTU0Ke9AtOVeaIoHvl5r8D9lq7tyTn
	 Pbe2l/uEdCiVA==
Message-ID: <1934ebd1-a0dd-40e2-b3a4-c17ae6d11930@canonical.com>
Date: Sun, 6 Oct 2024 14:50:34 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TOMOYO's pull request for v6.12
To: Paul Moore <paul@paul-moore.com>, "Dr. Greg" <greg@enjellic.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Kees Cook <kees@kernel.org>, Fan Wu <wufan@linux.microsoft.com>,
 Micka??l Sala??n <mic@digikod.net>, Mimi Zohar <zohar@linux.ibm.com>,
 Micah Morton <mortonm@chromium.org>, Roberto Sassu
 <roberto.sassu@huawei.com>, KP Singh <kpsingh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-security-module@vger.kernel.org
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <202410041305.544EA7E4E@keescook>
 <ece0c7bd-0d28-4562-8760-c54b0077583a@I-love.SAKURA.ne.jp>
 <202410041645.27A48DA@keescook>
 <5b09909b-fe43-4a9c-b9a7-2e1122b2cdb6@I-love.SAKURA.ne.jp>
 <4eaea237-d259-44bb-a546-26a0558a4453@schaufler-ca.com>
 <20241005170235.GA24016@wind.enjellic.com>
 <034409ae-5d36-49d6-8073-adbff2a4404c@schaufler-ca.com>
 <20241006161835.GA29292@wind.enjellic.com>
 <CAHC9VhQ44xEQZekVDDxPxQe-R1GynkzUPtaQP3wPg9NQ8r49LQ@mail.gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 xsFNBE5mrPoBEADAk19PsgVgBKkImmR2isPQ6o7KJhTTKjJdwVbkWSnNn+o6Up5knKP1f49E
 BQlceWg1yp/NwbR8ad+eSEO/uma/K+PqWvBptKC9SWD97FG4uB4/caomLEU97sLQMtnvGWdx
 rxVRGM4anzWYMgzz5TZmIiVTZ43Ou5VpaS1Vz1ZSxP3h/xKNZr/TcW5WQai8u3PWVnbkjhSZ
 PHv1BghN69qxEPomrJBm1gmtx3ZiVmFXluwTmTgJOkpFol7nbJ0ilnYHrA7SX3CtR1upeUpM
 a/WIanVO96WdTjHHIa43fbhmQube4txS3FcQLOJVqQsx6lE9B7qAppm9hQ10qPWwdfPy/+0W
 6AWtNu5ASiGVCInWzl2HBqYd/Zll93zUq+NIoCn8sDAM9iH+wtaGDcJywIGIn+edKNtK72AM
 gChTg/j1ZoWH6ZeWPjuUfubVzZto1FMoGJ/SF4MmdQG1iQNtf4sFZbEgXuy9cGi2bomF0zvy
 BJSANpxlKNBDYKzN6Kz09HUAkjlFMNgomL/cjqgABtAx59L+dVIZfaF281pIcUZzwvh5+JoG
 eOW5uBSMbE7L38nszooykIJ5XrAchkJxNfz7k+FnQeKEkNzEd2LWc3QF4BQZYRT6PHHga3Rg
 ykW5+1wTMqJILdmtaPbXrF3FvnV0LRPcv4xKx7B3fGm7ygdoowARAQABzStKb2huIEpvaGFu
 c2VuIDxqb2huLmpvaGFuc2VuQGNhbm9uaWNhbC5jb20+wsF3BBMBCgAhBQJOjRdaAhsDBQsJ
 CAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEAUvNnAY1cPYi0wP/2PJtzzt0zi4AeTrI0w3Rj8E
 Waa1NZWw4GGo6ehviLfwGsM7YLWFAI8JB7gsuzX/im16i9C3wHYXKs9WPCDuNlMc0rvivqUI
 JXHHfK7UHtT0+jhVORyyVVvX+qZa7HxdZw3jK+ROqUv4bGnImf31ll99clzo6HpOY59soa8y
 66/lqtIgDckcUt/1ou9m0DWKwlSvulL1qmD25NQZSnvB9XRZPpPd4bea1RTa6nklXjznQvTm
 MdLq5aJ79j7J8k5uLKvE3/pmpbkaieEsGr+azNxXm8FPcENV7dG8Xpd0z06E+fX5jzXHnj69
 DXXc3yIvAXsYZrXhnIhUA1kPQjQeNG9raT9GohFPMrK48fmmSVwodU8QUyY7MxP4U6jE2O9L
 7v7AbYowNgSYc+vU8kFlJl4fMrX219qU8ymkXGL6zJgtqA3SYHskdDBjtytS44OHJyrrRhXP
 W1oTKC7di/bb8jUQIYe8ocbrBz3SjjcL96UcQJecSHu0qmUNykgL44KYzEoeFHjr5dxm+DDg
 OBvtxrzd5BHcIbz0u9ClbYssoQQEOPuFmGQtuSQ9FmbfDwljjhrDxW2DFZ2dIQwIvEsg42Hq
 5nv/8NhW1whowliR5tpm0Z0KnQiBRlvbj9V29kJhs7rYeT/dWjWdfAdQSzfoP+/VtPRFkWLr
 0uCwJw5zHiBgzsFNBE5mrPoBEACirDqSQGFbIzV++BqYBWN5nqcoR+dFZuQL3gvUSwku6ndZ
 vZfQAE04dKRtIPikC4La0oX8QYG3kI/tB1UpEZxDMB3pvZzUh3L1EvDrDiCL6ef93U+bWSRi
 GRKLnNZoiDSblFBST4SXzOR/m1wT/U3Rnk4rYmGPAW7ltfRrSXhwUZZVARyJUwMpG3EyMS2T
 dLEVqWbpl1DamnbzbZyWerjNn2Za7V3bBrGLP5vkhrjB4NhrufjVRFwERRskCCeJwmQm0JPD
 IjEhbYqdXI6uO+RDMgG9o/QV0/a+9mg8x2UIjM6UiQ8uDETQha55Nd4EmE2zTWlvxsuqZMgy
 W7gu8EQsD+96JqOPmzzLnjYf9oex8F/gxBSEfE78FlXuHTopJR8hpjs6ACAq4Y0HdSJohRLn
 5r2CcQ5AsPEpHL9rtDW/1L42/H7uPyIfeORAmHFPpkGFkZHHSCQfdP4XSc0Obk1olSxqzCAm
 uoVmRQZ3YyubWqcrBeIC3xIhwQ12rfdHQoopELzReDCPwmffS9ctIb407UYfRQxwDEzDL+m+
 TotTkkaNlHvcnlQtWEfgwtsOCAPeY9qIbz5+i1OslQ+qqGD2HJQQ+lgbuyq3vhefv34IRlyM
 sfPKXq8AUTZbSTGUu1C1RlQc7fpp8W/yoak7dmo++MFS5q1cXq29RALB/cfpcwARAQABwsFf
 BBgBCgAJBQJOZqz6AhsMAAoJEAUvNnAY1cPYP9cP/R10z/hqLVv5OXWPOcpqNfeQb4x4Rh4j
 h/jS9yjes4uudEYU5xvLJ9UXr0wp6mJ7g7CgjWNxNTQAN5ydtacM0emvRJzPEEyujduesuGy
 a+O6dNgi+ywFm0HhpUmO4sgs9SWeEWprt9tWrRlCNuJX+u3aMEQ12b2lslnoaOelghwBs8IJ
 r998vj9JBFJgdeiEaKJLjLmMFOYrmW197As7DTZ+R7Ef4gkWusYFcNKDqfZKDGef740Xfh9d
 yb2mJrDeYqwgKb7SF02Hhp8ZnohZXw8ba16ihUOnh1iKH77Ff9dLzMEJzU73DifOU/aArOWp
 JZuGJamJ9EkEVrha0B4lN1dh3fuP8EjhFZaGfLDtoA80aPffK0Yc1R/pGjb+O2Pi0XXL9AVe
 qMkb/AaOl21F9u1SOosciy98800mr/3nynvid0AKJ2VZIfOP46nboqlsWebA07SmyJSyeG8c
 XA87+8BuXdGxHn7RGj6G+zZwSZC6/2v9sOUJ+nOna3dwr6uHFSqKw7HwNl/PUGeRqgJEVu++
 +T7sv9+iY+e0Y+SolyJgTxMYeRnDWE6S77g6gzYYHmcQOWP7ZMX+MtD4SKlf0+Q8li/F9GUL
 p0rw8op9f0p1+YAhyAd+dXWNKf7zIfZ2ME+0qKpbQnr1oizLHuJX/Telo8KMmHter28DPJ03 lT9Q
Organization: Canonical
In-Reply-To: <CAHC9VhQ44xEQZekVDDxPxQe-R1GynkzUPtaQP3wPg9NQ8r49LQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/6/24 13:20, Paul Moore wrote:
> On Sun, Oct 6, 2024 at 12:20 PM Dr. Greg <greg@enjellic.com> wrote:
>>
>> There was an LSM list thread started by, I believe a Korean Linux
>> integrator.  I believe they were on an Ubuntu OS base platform running
>> AppArmor and running a containerized Fedora implementation to
>> experiment with SeLinux, I don't remember all the details, the
>> exchange would be on lore.  They were somewhat disconcerted by the
>> fact that when they threw the switch on SeLinux in the Fedora
>> implementation things pretty much collapsed around them.
>>
>> Paul replied back and said that the LSM doesn't know anything about
>> namespaces, so the impact of enabling SeLinux was OS wide.  He
>> commented further that the above scheme could be implemented but there
>> would have to be very sophisticated mutual exception policies in place
>> between the two modeling strategies and composing something like that
>> would be the domain of experts in the field.
>>
>> I had replied back to Paul and indicated that it was our understanding
>> that with LSM stacking you get the union of all the implemented
>> security models.  We had posed the question, in this hypothetical, if
>> an unconfined system wide SeLinux policy would be needed to disallow
>> all action by SeLinux, except for subject/object interactions that
>> would occur in the subordinate OS instance, but I don't remember
>> seeing a response, we may have missed it.
> 
> When multiple LSMs are enabled on a system the goal is for every
> access decision to be only as permissive as the least permissive LSM.
> This is a pattern seen in other places in the kernel as well,
> including seccomp and the single LSM case when one considers the
> combination of both the legacy DAC controls and the additional
> controls implemented in the LSM.
> 
> The issue that sometimes confuses people is that there is no singular
> LSM namespace mechanism implemented at the LSM framework level (that's
> an intentional decision).  On a system that enables LSMs A and B, with
> LSM A implementing a A-specific namespace, switching to a
> second/child/etc. namespace in the A LSM does not mean you have
> switched out of the B LSM; operations in the secondary A LSM namespace
> must still satisfy the access control rules in the B LSM.
> 
Just Augmenting Paul's answer based on the original story of AppArmor
and SELinux. AppArmor internally support arbitrary stacking of its
policy with itself (what selinux was referring to as bounding), and
AppArmor supports policy namespacing.

This means its theoretically* possible to run an Ubuntu container using
apparmor on a fedora system that is using selinux. I was doing
presentations around this a few years ago. I think this actually led
to some confusion. I ran into several people who misunderstood the
apparmor presentations, and tried to do the inverse, but the inverse of
selinux in the container just isn't possible without work on selinux to
support it. Even if the LSM had a generic namespacing infrastructure,
individual LSMs would have to support it.

I do agree with Paul that there shouldn't be a single LSM framework for
namespacing (intentional), as different LSMs have different needs and
will need LSM module specific code to support it. But I do think the LSM
infrastructure could provide some additional support to an LSM so it
can provide namespacing. Like a security blob around namespacing, some
additional hooks, and a new lsm syscall or two.

Proposing something is still on my to do list, and I expect it will take
just as long as LSM stacking has to land something upstream.

* Theoretical because in addition to a custom kernel, it requires
   cooperation of the container manager to setup, and some modification
   of the selinux policy, and there is/was an issue around LSM interfaces
   (which require virtualization of the interface). In this situation
   AppArmor is enabled at the host level (which is required to track
   things correctly), but doesn't have a host policy installed. The
   container manager sets up the policy namespace which then allows the
   container to load a none host policy for the container.

   This whole situation requires both LSM stacking so apparmor and selinux
   can co-exist, and some kind of support for containerization on behalf
   of the lsm in the container.

