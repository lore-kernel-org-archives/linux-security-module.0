Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793378831;
	b=yYMBDkWZc+zVbHVABIzMzSDl+82cXba2NqP1Pp81B8VSV6VjGyScR1h6wjUQx8DFVnZh
	 cBibRIqkXFroQuZqfsyVW5q+3TboxugijstLoWfwXMUZKKXArTloPWw0m9Voi5Jx/7C27
	 3Fk93GRjMa4Tx/vFR/4kXzFVuk7bHjwbzpvpFX7eBSeXwv647BA6d03RnZc5m+qJiFcCB
	 cXqZrwZMejtNps/WoDjsV8gw6pCty8obdHYeIA18IKWlKRCxKFs9H3moaqYrCMJXLN5+m
	 FyMXNTo1Iw689jccHGhwMCglBgR+a15PsEt6VJplx4l/QWQ7GDYkBqN+gRsB0QHY5IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793378831;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:From:Subject:To:Cc:Content-Language:Autocrypt:Organization:
	 Content-Type:Content-Transfer-Encoding;
	bh=xwNGuw4Ozbcpsh9nyjMpfj+blaoYv/xAB7dUoROBvWs=;
	b=VMTgJeIbtnChWBHzRtahb2cf3pD4vUCvqLDIvYFNTy5+qIjx0rvy1DzOsS9IAfWkJdf2
	 UZHqL6oCG46YuXLJ8FgDaq6IF1ILZwMWs0uxdZlU0XoWpq7EhYygaJd+JSkHH9I9MZ0sY
	 ZLvihKINdUOeyab+2a16NwwJK4VwLuS7bBhNQY7PkyL2xLEmA/4jNiGj9zPK/C0GOoM4w
	 3domCqJ8sU3jx8aLc6IzgWiLAm2B3MnZM8uthOMk6V15BRSuYqix1SaHqAieOsqwMsC20
	 amI6vKzIpOrrPs68xDIRNVjJRYhuWuGvPSosUodS9VRJdqh7Uz7qnJr4pk1ZtOC7E/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b="AH3l/SjB";
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6EE606A334
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 16:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F6EE606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=AH3l/SjB
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A938D40130
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 16:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1793378821;
	bh=xwNGuw4Ozbcpsh9nyjMpfj+blaoYv/xAB7dUoROBvWs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type;
	b=AH3l/SjB7sKQdqeBr5mY+TiB3TY9gbxaxPdHkcsU85dbK/1I64Um44QuB+TgxmYkb
	 CesNpfu/tvy7vVcdPXk2zllf1X8WmZ2B1Vz142b6eudAQqDsjZ3mh/wM9ddb/MRLST
	 EdLJsKz2FcdX7+axP83OX6zZBTO1P2ezM4RTR6URfjeYg+AUtDm11LD0eR4w1CvPV/
	 WhgS6yAttKbOLrZnZ3gyQIjerDZCDra08EraBcYAhS+b5NA5dYEM8fr5bhCc2PWHkU
	 50lMX0LUG9W/73SvwcDPpHrgYRKzIDiAOBad/Luz7QGYWnIiFRJmGpWypi6mOBLkSC
	 w1U72srG0XYaH3GWXvsgzbXhWRMSuV54f74kTWEUik+YvPZta7ijRWKJ6d6AloiN1V
	 AKJjNIRmMSWGJV7rNTW7W+AxqaQijkwOPMV1AVb6tFWwyceOzAtWbhvJR45vKO0eGa
	 Vl+cU3GYnGQbloCqSwTF7yiAEdlyaPHbDO0DRDqC/6Hz9lPaffpkEf8PJsfv+JQnK4
	 Gku+0SgvZLN5ajPsMdFbWQH1BJVOBKz6z9FRIO+DksOYc5assUMUt/ZVuK9pVEn3CT
	 bF04+slMD47GuXGKLxEoPh0rnxCBp8K7R+Gx7mgERWEY+rZK0hTAbAiuzZ2wyvnu72
	 fbJymvkOwEWV+fenGrzL1FBk=
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-6798c43a3bfso1491659d50.0
        for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 09:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793378820; x=1793983620;
        h=content-transfer-encoding:content-type:organization:autocrypt
         :content-language:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xwNGuw4Ozbcpsh9nyjMpfj+blaoYv/xAB7dUoROBvWs=;
        b=AYDfao19x+GpE2NOXqoTFMFQRJ1im5mKLfR0oMGDVELP453ObLej96Pz10ceoUUHbg
         1ZkGR7Sf0sAoEdErPHzV/8NCbH8xwMOoEifUploQBy45p4QEd7hRDPVh2v3mblFVB70W
         OlhnkJsH73GyHmyIOxKd+Phdew3wOmWjposbuVqM4TRq52UmZ9ieqUo69iyciTjH6617
         qYC+/CXW4ZTzegnXPLBh/oC5zYxKvivlB3gtfpz1VfKKaxMI9xVdWOQlwRXH168Cuj7r
         5MmBzmHVU3CwBlroesQysMBl8mouT4Zs2Oevsz6jxxgEztyuxVFVMsyE/dFwEOB+Kfef
         wEbw==
X-Forwarded-Encrypted: i=1; AKwUvBy4kboGRvVwEjxs7e5jWbUuq9rsm/gemITHI0kSIvPlRsfYy4puD/HgrLSL6xXY8tIWBxXwR6WUG466I/v09txxWDYCwtc=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+w6ZDgDqU0Ubu/DciP+MdlNIIiGAcAiXDIH839CM/txqAgbw3
	8eLkrFoY2j84rnTDRhx7l6NNGJAOC+aACNY0lVUqoCYwu9wlseA0V6Cw2v+8VNm6BgIt0nHG0wV
	OB1b6ps1wf8uyyB55t+Tq8MwqC9vxJo26MI6sgn04TtSJCjkmaHsfvpyIWgmrFg+QPgdzoJLbx/
	CVRAmgPGFYYjOuq9sPog==
X-Gm-Gg: AYBFou1R17nF+gmdXWmFWQS75rVw1mkLrAJOwAWYrn6d6OsndcenJr4cir3/HXHk9KR
	+FI7na/NhV+ZtXuqA9qMYNHhQKmOZprod1SWoCF0GuFEAvt2QscImYVMs/dRRt0d1JHlB5g7xXv
	z4L23D8ZInLX1hWtkQTxhUzI/fJcr/mNk0ED7ijR3MM7XBJ08YzPmFm37gRDemWl0B79vrk3k2u
	x4Yb6brB+NfA1W70PBrt1Ol9kT83gnsHUWichmNa/7bGCdJUwuwutMpTYvWI75KJsL/+Jq79mVE
	x98GCTiysWgfc7QHPT1zH3MMumlpiQlkQaa01TUVGtmCBDCYYVk1bgKD76mm0KuS0RwMAYiyk7g
	d+mCSDiTfpDWruJmcV81o94qwLUh41pQMg7JbrEvbDQdjb76e5boflpY4oCq8IGUcrM4aE4tUsA
	Fqirf7FhQ4pg9sFRn0twRpp7PxIF8j6A==
X-Received: by 2002:a05:690e:1686:b0:675:68f6:a6e2 with SMTP id 956f58d0204a3-67ba4eea269mr1465526d50.43.1793378820532;
        Fri, 30 Oct 2026 09:47:00 -0700 (PDT)
X-Received: by 2002:a05:690e:1686:b0:675:68f6:a6e2 with SMTP id 956f58d0204a3-67ba4eea269mr1465516d50.43.1793378820125;
        Fri, 30 Oct 2026 09:47:00 -0700 (PDT)
Received: from [172.21.9.52] (host-209-35-187-178.broadbandcancun.mx. [209.35.187.178])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-8b2b71a1c70sm11698577b3.42.2026.10.30.09.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 09:46:59 -0700 (PDT)
Message-ID: <ca16996b-2917-4869-8e22-e6731804e4e6@canonical.com>
Date: Fri, 30 Oct 2026 09:46:57 -0700
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: John Johansen <john.johansen@canonical.com>
Subject: [GIT PULL] AppArmor bugfixes for 7.4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKLM <linux-kernel@vger.kernel.org>,
 "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Content-Language: en-US
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

This is the current set of outstanding bug fixes that have passed,
merge, build, and regression testing. Integrating new tests for all
this has been a lot of CI "fun", but it is looking good now.


The full break down of the fixes by issue type is in the tag message
below. All the patches have Fixes tags except for the trivial
kernel-doc fix.

The big one to call out in this set is
   4de32fd05ce9e apparmor: fix NULL ctx->peer derefs in unix socket ctx updates
which can be trivially be used to cause an oops.

I can split this up into smaller sets, and resend if you would like.

thanks
- john


The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

   Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2026-10-29

for you to fetch changes up to ed35bbe7d06e6505401eff3f3c7a36bd1f167a17:

   apparmor: fix uninitialized variable warning in aa_inherit_files (2026-10-29 17:02:50 -0700)

----------------------------------------------------------------

* Bug Fixes
   - Leaks
     - fix a leak on a rejected string table entry
     - fix refcount leak in aa_get_newest_profile()
     - fix profile leak when a policy load fails
     - remove fs entries created by a failed policy load
     - on failed load ensure profile files are removed before parent
     - Fix namespace reference leak in __aa_find_or_create_ns()

   - Use after free/double free
     - fix a use-after-free in aa_lookupn_ns()
     - avoid potential double free when remapping DFA tables

   - Bounds checking by-passes
     - fix table_size() integer overflow on 32 bit
     - check accept index + 1 is in bounds

   - Mediation fixes
     - Fix AF_UNSPEC mediation
       - check address length before reading AF_UNSPEC bind address
       - mediate AF_UNSPEC socket disconnects
     - Fix sctp connect/bind by-passess
       - advertise that sctp is being mediated
       - fix check SCTP bind, and connect permission checks
       - check connect permission for SCTP

     - incorrect state machine traversal
       -  convert duplicated dfa transitions to match_char()

     - locking issues
       - don't revalidate inherited files under files->file_lock
       - fix uninitialized variable warning in aa_inherit_files

     - Bad dereferences
       - fix NULL ctx->peer derefs in unix socket ctx updates

   - unnecessary warnings
     - remove unconfined_profile() check in inet socket mediation

   - Kernel Doc
     - Fix the return value in split_token_from_name() kernel-doc

   - Misc
     - fix query_data() output overlapping the lookup key
     - report a label allocation failure as -ENOMEM

----------------------------------------------------------------
Binbin Deng (1):
       apparmor: fix a use-after-free in aa_lookupn_ns()

Cen Zhang (Microsoft) (1):
       apparmor: fix query_data() output overlapping the lookup key

Georgia Garcia (3):
       apparmor: don't revalidate inherited files under files->file_lock
       apparmor: remove fs entries created by a failed policy load
       apparmor: fix profile leak when a policy load fails

Guanglei Zhu (1):
       apparmor: check accept index + 1 is in bounds

John Johansen (6):
       apparmor: fix refcount leak in aa_get_newest_profile()
       apparmor: remove unconfined_profile() check in inet socket mediation
       apparmor: fix check SCTP bind, and connect permission checks
       apparmor: advertise that sctp is being mediated
       apparmor: on failed load ensure profile files are removed before parent
       apparmor: fix uninitialized variable warning in aa_inherit_files

Jérémy Jean (1):
       apparmor: check connect permission for SCTP

Karl Mehltretter (1):
       apparmor: Fix the return value in split_token_from_name() kernel-doc

Li RongQing (1):
       apparmor: avoid potential double free when remapping DFA tables

Maxime Bélair (5):
       apparmor: fix NULL ctx->peer derefs in unix socket ctx updates
       apparmor: fix a leak on a rejected string table entry
       apparmor: report a label allocation failure as -ENOMEM
       apparmor: fix table_size() integer overflow on 32 bit
       apparmor: convert duplicated dfa transitions to match_char()

Michail Andreas Michalopoulos (1):
       apparmor: check address length before reading AF_UNSPEC bind address

Wentao Liang (1):
       apparmor: Fix namespace reference leak in __aa_find_or_create_ns()

shaos (1):
       apparmor: mediate AF_UNSPEC socket disconnects

  security/apparmor/af_inet.c           |  5 ++-
  security/apparmor/af_unix.c           | 20 +++++++-----
  security/apparmor/apparmorfs.c        | 15 +++++++--
  security/apparmor/file.c              | 61 ++++++++++++++++++-----------------
  security/apparmor/include/label.h     |  6 +++-
  security/apparmor/include/match.h     | 11 ++++++-
  security/apparmor/include/policy.h    | 20 ++++++++++++
  security/apparmor/include/policy_ns.h | 16 +++++++++
  security/apparmor/label.c             | 15 ++++++---
  security/apparmor/lsm.c               | 19 +++++++++++
  security/apparmor/match.c             | 61 ++++++++++++++---------------------
  security/apparmor/net.c               |  4 +--
  security/apparmor/policy.c            | 19 +++++++++++
  security/apparmor/policy_ns.c         |  8 +++--
  security/apparmor/policy_unpack.c     | 23 +++++++++++--
  security/apparmor/procattr.c          |  3 +-
  16 files changed, 212 insertions(+), 94 deletions(-)


thanks
- john



