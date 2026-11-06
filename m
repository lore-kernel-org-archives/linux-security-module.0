Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793978003;
	b=MF4P71f2Q7VBGcR7MmT/3E7upLlE/PtYAyHijnAddlQGihjnUnp3tb+Gs2YQ6Vd5QOhu
	 lYik/MjDv2kzxWolbJkEdYrp4ucAgIgRP4DIhgGEpv1d4lryY2vB9+lDqQiGgE1fAsfQ/
	 F1uCg4pCKMogFPxPhbjxdfE6xlSP/nB7ls8oxvYBwwhdlCeeSGXSzpjU7lH0YuSSvey0z
	 1KoYBFeIVb11+WJLQpV3XNJ0t1rNxcd5UDanMHWJIXZRm5zP/bUPz5cr8+rajnreIdaO7
	 SO7rZ0VGG3RhVopgkEJpm0Y+1+TWD7GuiODXXW5PhzvbrXoqIA3Y+8oH3bHbPI2Fuvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XBmSnRChClP6iNYWaXtFsz94mV4OC9GOlfJtmgX0gdU=;
	b=JdRj9UCpUg7bxqc6jg9qz41u6Is3rBshGDciE0vi8PzdJNAqRGC23yKlam7Z76YKq4Du
	 NuPW1T63suWMPD2O8QOGrQXbtPAJfUWQYt8i/UJWnyLiqdWRUOb0GleFGb3p4X9L1sBdi
	 c4oVIOL9+JGAxp8bXgf5tzMDj3qIF/MrApaTjZZOYheBl6KHUXoSStFWtoiqIb5JRzght
	 Ybmgi8SFxObaB4NU08M6pTFJ0gbOEcx3+ST3hD1AZyEIRBGWEjkwlUb2jZBV2a0uOOA3T
	 tUntrdjCIS4B6DkmhfXNULqtQw5EH1QAwJTvvX184Z2kBQLtpWEjDeAH22Sl+/dok4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=L2AUkHgS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD5D606A326
	for <linux-security-module@vger.kernel.org>; Fri,  6 Nov 2026 15:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDD5D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=L2AUkHgS
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ed06b725fdso11447235ad.0
        for <linux-security-module@vger.kernel.org>; Fri, 06 Nov 2026 07:13:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793978002; cv=none;
        d=google.com; s=arc-20260327;
        b=MkIyIr2R09qmQj221TXi8KjQjRHR8uNiKo6dzV2WwWD2mbyKjfNMeiAFEkS5z00Qhm
         PUuMZpIeyWEbSF7obtzh+kf2gxBjmUVS32BigPHi/7ZgWd2Ljd+gVpe4QNXzsVyqDWYr
         gnb18c2Fo8YYh1OtJfVKcnDFPhEyidik+SJPIg8LpN3dIS689oATb0NmRoYRDDU8N4ai
         MSJ0wyOZxPJavugp2fzbwA7fp+hWEwGBkR3bCXtCGuXTSqlP5Ml1UKWset6eKnGMFPMM
         uzVjd6yhcT/6nKN6mxbGv9jwv9K7mGh5ik1fFHytZCv8AHwwfRqXZwF032s9ffZ9E7jT
         gziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XBmSnRChClP6iNYWaXtFsz94mV4OC9GOlfJtmgX0gdU=;
        fh=oTmuW5pyXn/TzLQmWH22A0t2bUayssthlXB3o6pIy4o=;
        b=KmKRNVeE+1io60uFZx//TDJzpayKptq0J1pC3FNOmCBwSBI4R79bo/Xx1OWmyIm3iB
         HoSQ2oQSag1kx9UdnqIV/DHHtJ7C7o5Qo7sYciLixNwPCxbuzHKhVlm+77yCHDPNonDj
         x1aDQgLq3wkyaIAYaS0/rV63e7WfZRp7qiB1E04sUY1Hk1xdXHEzmW8rjXLERjKPl6eA
         PuP/U/2vgWaNVDio2II+DeYaBuHvndQMXgZrqxq/u8k0uTLSVWFWs5OhWx6C2dGn+GMO
         Cdb/1Z8RbCpLM8bvZYQPaGSlkGj+ARkKv/04BOWcARMvI8r6Cf5WApCeRfrsT/0/bBVy
         eW4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793978002; x=1794582802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XBmSnRChClP6iNYWaXtFsz94mV4OC9GOlfJtmgX0gdU=;
        b=L2AUkHgS6I3MOmePcsJp6yLWr0PZtdfRSHggx4hPyL8GN9ViTDaTxhDGKKs/j76iiW
         0r+CnyVXYQw3g3DTKzWSsim+ejoCi+hCvoO4hUahm9IYiMpgiYni7bPAOIiBGh41ojMJ
         FyLoanxgufFUytJ8TZPKZmyyBt7419qNrgnFCNrzXc03velAnCyUKy+om71XEASO8oIQ
         xA3b03GRCEAeGJVyRmaUpw2Gr2KUrBEoxSH+ZUARWyM5LR+vkRzN4FrEAN1McwBbsQTh
         KI4mH1ckbtlg80kczDs/ucugMuREaFKYZZ9MuydrBFU3LRLNYiLc2NVCweM0YdTzAqDW
         JvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978002; x=1794582802;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XBmSnRChClP6iNYWaXtFsz94mV4OC9GOlfJtmgX0gdU=;
        b=FBOZ9duCnnKK3kA/UQUeW8+Q0X5aXNDNmD58VqyFzbx5PsewVxRNaTtR385Nwp2IqG
         aF0YTUxCnd413WHwMBTZrMQPSIb5crokTfz/4nGV81EGfoTKF08e/CJtO4BjD18HzMZs
         qLcYRmKJvjmC0p39T6SYeQ5pIeiA/jAPQBhePfloBvroyYILqBBvcp1YrJVPJWQBvJfH
         4OM1S0sGEi5BlzDSvqpQs7+k+Rds0J7IAJuqm6yM2x6HJ+aF4lwvuRLUQnnAzV2xBi+R
         JTRiQgzR9vbNKnX0NQRFc0X02h/2Nbw+2aLJ9o9wpQLxOB1fTJ5Id3mQMxfBzE2PD3bs
         i4nQ==
X-Forwarded-Encrypted: i=1; AL+hErGoXiX1DZzKylQVmc4qE4Da9oiFE7Sl/pPkQ04eusbjORwFz99s6jMGTxTVl3384ArYFLEfql4KeztUtNlR5pvicoF7WJw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+trcoglk8anbrBV7HYOn6FCCPsYnz9C6f2FEs5esb6peGOTfJs
	o10pEIh+uaJ+/ywLsQcyMGg6YHdNqRc9sV310KSrd8zPuDJIEsqrdXg7NPTgUz8wL945RDhkShQ
	turfBEUeu+tCbgyvecw+PaOc8HHlBLHTajlHjTaEH
X-Gm-Gg: AYBFou0lQ/paw0H8Nir0oPxohcIHuFdUxjvW/nS35QLNyCKI2hAqwRAxotHZeft5g71
	TsakjIgyw4SoYYL+h9thZ1khHudIxV7IwAMkGLNQaiYZ8pyaG2WH9WdC+RM3GRTS26t3Lymms8/
	fuA9KG9+9lAMPP9aJDj8uqa6/a8TjjfsBG1n6GYjrkOE1s0ehNHLRwsMiBntK1wQMk8d3IkMz7k
	puRZMZr/+7DvAisJyzQ1R+HlhgVD9sS3O3YbIZIk4mPlmARwdEGkMFLMUdo0UBliOrmLZldJFvV
	Bhsbi9hW6yEfXszXl8uynQmLoNwRBsqvAjlc1jz3dJnWfI8E7R7mwhJmUWfoLdpQQ5EnnBEthoq
	WLa0f4Z2p7vmmqMIyf0ccXywjcb7o8Qby2lGAjC0+jA2nQqQ8miB7XjJDD3cxxfohhX2m
X-Received: by 2002:a17:902:ea11:b0:2e9:5e06:3345 with SMTP id
 d9443c01a7336-2ed23e5428cmr47695025ad.2.1793978002129; Fri, 06 Nov 2026
 07:13:22 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ca90b945049ac3c27f3e1d9b8181137feb892436.camel@kjb.biglobe.ne.jp>
In-Reply-To: <ca90b945049ac3c27f3e1d9b8181137feb892436.camel@kjb.biglobe.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 6 Nov 2026 10:13:10 -0500
X-Gm-Features: AclHuK-tlApNDEP2ZzEdt9Zr-7HOMsS-EkDGhCGPsqM9Fwqn-JDsHX-3WkpyEKQ
Message-ID: <CAHC9VhTB-obhgEM3g0VagzNaRUaF_tWTDu1FmX7SHeVU4pwfOA@mail.gmail.com>
Subject: Re: [RFC idea] Kernel API Firewall (kaf): subsystem-level attack
 surface reduction for the post-AI-CVE era
To: Nakashima Seiichi <s-nakashima@kjb.biglobe.ne.jp>
Cc: kernel-hardening@lists.openwall.com, keescook@kernel.org, mic@digikod.net, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 6:15=E2=80=AFAM Nakashima Seiichi
<s-nakashima@kjb.biglobe.ne.jp> wrote:
>
> Hi,
>
> This is an idea I've been thinking about as a Linux user
> who has seen the CVE flood firsthand.
> I don't have the kernel development skills to implement this,
> so I'm posting it here for feedback from people who do.
>
> (This RFC was drafted with the help of Sakana AI's Namazu assistant.)

...

> 2. The idea: Kernel API Firewall (kaf)
>
> Instead of whack-a-mole with individual CVEs, restrict the *classes* of
> kernel APIs that unprivileged processes can invoke.
>
> Key insight: many kernel CVEs require specific subsystems to be
> reachable.
> If we can restrict access to dangerous kernel APIs at runtime, we can
> mitigate entire vulnerability classes without waiting for patches.
>
> 3. What kaf would look like
>
> Not syscall-level filtering (seccomp already does that). Subsystem-
> level
> semantic restrictions:
>
> - bpf: disallow BPF_PROG_LOAD for unprivileged users entirely
> - module: disallow init_module/finit_module after early boot
> - kexec: always forbidden for non-root, even with CAP_SYS_BOOT
> - ptrace: restrict to same UID or explicit allowlist
> - userfaultfd: disable by default (historical exploitation vector)
> - perf_event_open: restrict to specific events, disable hardware PMC
> - io_uring: restrict ring size, disable specific opcodes
> - namespace: restrict unshare of specific namespaces
>
> These are semantic restrictions on kernel subsystems that multiple
> syscalls may touch -- not individual syscall filters.

It should be possible to do most, if not all, of these things with an
LSM.  Wearing my SELinux hat, I can say that SELinux currently
provides access controls for most of these things today.  I would
expect similar capabilities with the BPF LSM, although I can't speak
to the coverage of any specific BPF LSM tools.  I believe AppArmor and
Smack cover some of these things, but I can't say for certain.

--=20
paul-moore.com
