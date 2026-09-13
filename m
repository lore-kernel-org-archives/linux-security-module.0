Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE3739CD16
	for <linux-security-module@vger.kernel.org>; Sun, 13 Sep 2026 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789328502; cv=pass; b=os2Hwn4qp2OyMjKPvexGK82RHbYfd2iw9RlRTN/9z4jC/ueuiS01bsVfc8U9XhPdWCQb/IWRV7g0K3SCUzBj5UThZaAm2hGMQsCxxQj5nSJFQ8zIfMuPw+V1biYmRpgRerQRa3ywZYr9LTcPc4S5bFn419E+mxhDlaQX4PsAVPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789328502; c=relaxed/simple;
	bh=o9YibIUfRxMjjHC8/Y22RaQ2wOjqg0OE/+77r3xl3ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taSBdBB0IMWZNRcplccwA8JUos+7LbefOHqR29mj8A/G+0wE+BbwJO8WNGGDruKZ7AoUUtGzJ7/Y3YnbDn4mxPG9HV3yfIHdPAzzKCP7DOsmuW/PA4ooYQmjMty8Bc0xPb24RU/IL5g0bjiFrfHsFFBcDiJvWVljs42sB5IDo3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I8sFL6Q+; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I8sFL6Q+"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334ddcso14949545ad.0
        for <linux-security-module@vger.kernel.org>; Sun, 13 Sep 2026 12:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789328500; cv=none;
        d=google.com; s=arc-20260327;
        b=oqXG02X3IzDqBkHd88XJXHyMpLHwS4SsVqzPDcJW7n1nupCkBK/4gfkxX/DH861aYY
         hBbEI1shmnKe9VGGSfUNioP34ZnmFaq9qQs8+ofkyKD1H83TtEF8/HW4dsQ2OqxCGNPB
         pW+ao0tY7M5HiJEud9daigoAj9vsAoeywNVVloko+LZiOt8Oj/LLny2IYWWFpzOZ7dh/
         OjikP3ie6T6BaprVCEuSQK80NNpHXHEpRZx3lF7tFrS1XSfNDZUi/dk0xTEkivi0bNh4
         QZXt6ADEHZaTUwfQhoEwUlIVH/ZZKhC1MMKdS+YpQn39K6NFADfEnkGuhKRyGtfFX29d
         SUMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2oFQ8qNlHBe3RYmZfeSmFS5X2SDU60h3feX9FkdQ3Ds=;
        fh=WDx/wHSU1EK9ceJUN2B2e2Go7DYVXQhMpBAIuHqgOgU=;
        b=CMZnwZIqu3HdGr5P/8ZT+C5G1BBicUZv4BrkBWiDRBSiigc49pp5wKFpMJ64Tui3Zz
         bMm2rYb/zoOCcOOl/ygbCl7eGPwyTGDneEVn4XR3456NRM0D1n/i6vgbV3s1aGdKnF6N
         w4ZDxz61JG91ODvtVPtyvIREh/50Vu36ExToef6xyvdgv58p+/Bns6OCJvuzUCUpqKuf
         8//bTPmwsE1qoPGLilECYCF11Ac1DRyRERtROvURh7JdEaceXYLnUVzKo4LUJZ1cxTY4
         MFbN84G1nJ+TULSbzJ65rVAPQo81Vno0CLzW9AKKJZRMju+0hKgi5DLeXxOkalyrWQ/W
         h9AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789328500; x=1789933300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2oFQ8qNlHBe3RYmZfeSmFS5X2SDU60h3feX9FkdQ3Ds=;
        b=I8sFL6Q+DM54DS1jqLpHl8LRDH2BH3wEv2VVMVdWWX4l+pUbhvP+mXRK1LwfswtI5I
         LD7tXObHzqTooDWMioIjKrFTteqZd3F4ORV5tAOdJGwYq3OlCV8oCQWcc7SSUdXldKCq
         cqVIjuwPKnq61r2HBBrk+adoCp9DvIE0IgEBeWV1Z0ts8JRcIPrwfdWqRBPNS2unhtBm
         2NE6/mJLRJc4noJZ1zBUITBSFVMcarub7AnSWNG+1y6VkPibRKC5m5oHY2WosF58Xjtq
         7M2wPsAyaGi0jOjGYFpCj0hyCwbNtFFsTXCM2olkmAaF3EN5yIXsPR85Bq7Tv8+fDeK/
         I7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789328500; x=1789933300;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2oFQ8qNlHBe3RYmZfeSmFS5X2SDU60h3feX9FkdQ3Ds=;
        b=fD2GwZ8b/6V+JxSz7zyjrCWlY1+/8D1ruRPCWs1B/MPJIw+XtmNoX2DXWsyXBbMtiF
         J8etDsrp1OlLCk+d8ertg57ioEKRfj1TCekqAJI5uKWW+YPTTXrV3pnHCHunGcLGNH6q
         v5ufyxkQgbxo/D0CG2NAcqb3RF2EZS9CEVul5zsRzAbmuJksg+ChvPppBbVZQxw9jZQv
         Z3wr+hGfek120g/QE009Xe1bZZCpIx7SNzEbtKgbFmoJnO2Ij5/eHRTmacPOTThTKya3
         43qikMa0BCCOBLAGLDMSfxKEVk0yeJccZZz/ldN6wuvPsdtdTGeyrEdaWNxjpI+uaYJf
         1XxQ==
X-Forwarded-Encrypted: i=1; AKwUvBwedXoGngbEgZ1z6b2wwaFskWDCq+cldvR/hVsouHOTfGNZ3rR0T5iABP392FR4XCUXiVRuEYLfcjnhV/qrOzGFRk1QSps=@vger.kernel.org
X-Gm-Message-State: AFuF++mD3QXbeD7HuMb4yfcKAeeOeT6nMlxaEWQ1U9xc3fhskBj8svbE
	DlNVKdTmtIm5h99K7MGOjHT+16FzgbNuKurWASskpxkmG5xNEkGqMBQ6S0NvPBXFC1totC0Aa4Y
	NHTmQq8FpsRx0PcmeREVfMaztMLadbzEaOFVtXPHN
X-Gm-Gg: AYBFou17cHl/6wd1bkGxBdTRRHEaa1ZS29uoZ4mt9W4jasGYfczTCcum+k4G4bqdWNG
	E7Wm2tUiP+abbTmOSK+vnjAq9SRViGb9y8uZ4EVqCIPHL59w5YkOSgM7kShd2qowNIzmlq8VqN1
	UH6oyspTh5D62w17+TgSJgSYKrMo64/9JM+yWcJYEKVNsc7ISx7ZAe1DgkXDxQQE+TDcCzk4G1D
	mxjXp+OLgoDdUZGCbtOZ6sxCLq3LvBcHZb3l4aALATUOUnJE472e65J/H8rFv2kpMoXU4tnWZ3d
	spfyWlSSYCQsujnQDB9R3WR7cuEGxa1K7uApiKQ+9HheiEcnkAjFwSdjIKHJN+Pm2HAFlB6q0tv
	TZQuH6Knq6CJcX01P95tBrw==
X-Received: by 2002:a17:902:f691:b0:2dd:4168:7bd3 with SMTP id
 d9443c01a7336-2dd41687cc9mr192016495ad.12.1789328500077; Sun, 13 Sep 2026
 12:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-5-utilityemal77@gmail.com> <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
 <aqHUw6k0Mf83CGFT@zenbox> <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
 <DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gmail.com> <aqTZdCz6JaoK16Fp@zenbox> <DLDL7KK3FZKU.17ADLLWJVXB5F@gmail.com>
In-Reply-To: <DLDL7KK3FZKU.17ADLLWJVXB5F@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 13 Sep 2026 15:41:27 -0400
X-Gm-Features: AcwNN1VcrFQxF6bGTrpFFvwHMnFPs9vUMnDUrZbPiYQYi52EcDs3N2117Jy3gRM
Message-ID: <CAHC9VhS0JckwfomqLTUJkZZkDSgeRXYOjMmPQYErgYynQYqMKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 04/15] lsm: Add the bpf_lsm_policy_release
 kfunc and policy object destructor
To: Justin Suess <utilityemal77@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, kpsingh@kernel.org, matt@bobrowski.net, mic@digikod.net, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, 
	casey@schaufler-ca.com, gnoack@google.com, jack@suse.cz, song@kernel.org, 
	yonghong.song@linux.dev, martin.lau@linux.dev, eddyz87@gmail.com, 
	memxor@gmail.com, jolsa@kernel.org, m@maowtm.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 3:33=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Fri Sep 11, 2026 at 10:26 PM PDT, Justin Suess wrote:
> >
> > If fs/, mm/, drivers/, net/, are permitted to have kfuncs, then why not
> > security/? kfuncs.rst doesn't seem to forbid this.
>
> because fs, mm, net see the value in bpf. bpf helps these subsytems
> to focus on their core technologies and moves policy decisions out of
> kernel and into bpf.
> while lsm people treat bpf as arch-enemy.

It's amusing to read this when just this week we merged a patchset
into the LSM tree for the benefit of those writing BPF LSMs.  If you
look at the discussion around patch 2/2 you will even see a reasonable
exchange between Matt Bobrowski, a BPF LSM maintainer, and me about
the patch.  Alexei is obviously welcome to his own opinion, but I
would encourage those reading this thread to look beyond his comments.

https://lore.kernel.org/linux-security-module/20260904-lsm-mount-idmaps-v3-=
0-920a1963675d@amutable.com/

> kfuncs are not stable. we keep refactoring them.
> while lsm folks treat anything within *lsm* and *security* as stable apis=
.

Most everyone involved in LSM development knows that statement is
simply incorrect.  A quick glance at the git log, our process
guidelines on modifying LSM hooks (look in the MAINTAINERS file for a
pointer), or even just the patch I referenced above should provide
quick confirmation.

--=20
paul-moore.com
