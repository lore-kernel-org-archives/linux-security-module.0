Received: from sonic316-19.consmr.mail.bf2.yahoo.com (sonic316-19.consmr.mail.bf2.yahoo.com [74.6.130.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D092E419
	for <linux-security-module@vger.kernel.org>; Thu,  3 Oct 2024 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727973378; cv=none; b=jr5OcVjb++a6HOthVofxN94wl2FPAPS/8H22i3ykm3z37vUHMDYZQi7Yf1+96Dy8FsVpgeU/4bpUmyHiRYBrPSgcWbb9Y1phlwUVQBN6TqV1eFZK5fO4Ji9Xw0jSx2F1hLkgKN4iFlQb9Ela00tLliE1j9H2qL07hafxNh9IPRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727973378; c=relaxed/simple;
	bh=s7QZZcpi9B4rX23ZRXsCMiOnQAss1WO1VkpkP9CYRE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lEMKJ7Fa9iJu2k6ty5/YzceUUi2EcxX0NajNrfujr94YOgiA59mikiN84fVktczXrGDVrNvrkpOQmHPS35a7Ys1BqnyUjwLU1gthAyxXY+I9+zqGoCD0/6LPrAUqJ+0qxTa9XT6jeKL1frJAE3TiC1tk0ZDTpnl7PLtajo8O+fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=WFCalRkL; arc=none smtp.client-ip=74.6.130.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WFCalRkL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1727973369; bh=nrv5tTZLZCLIhT50nEMZ0ytjIdzKQCQ1wHK7QRSlwdk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=WFCalRkLg8lWukKCzAe7U4iJfQwjGD9XlU80GcuKgWNaNoTD9noSG7bgQYn8wTF4Dc9M59mk99yIYIwLiRbn5d/zrOyTD0+FxyFbuner75lOxGIvG4w6fWzRTtoKzJyuj1ypI9EXFSfaC83xTLMb/zvAUebD6zq6/XE2GyCLx0t53NYu7w1i0SZlUrtmESXqwXIIXlTVIOFL6A5qak1YpVqTlWntZWGnv7DRXmRW+cJNFl7fRs9lxXDYexOKtIxVZfS29lCUZz5QV5AAldpDyh9BSSA22Gqz2R6pMzVf5IViYq+54L2gWViiAjfWfK7adxS2ewiASXUpJU8oZMnOtw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1727973369; bh=NE8gWpbmAsA2ncD5KGHholnqu/H3CteZJehWMlOScMJ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=rwmCZ6+gSmVPgJXx5mYQr/95v8IfTPARJ40AL0DsiA6ryFrRCeeYKnQOtyUIBIHymzke8lykWX4HO9TwcvhF2EUCXcJ+BmdHVpjFEN6WO3C/B9v4emGhBX4KYLyP0x8HVUNdN1DU93pukdf73/1FR17GmWB1LSAWNCONrX3jrs70pnWXE2hjvdBz7Ty7gGnYxTganEhhK2qsNiLlPUHxdgmIq1KlbBLIHdQADFTbHx6xJdgCLnU1jU2GVuBWOHfgo2RuXT5usUjdFKdXxw5WMkQXY5vs7nAZJWtOYe4VfDQxmgxNrTKv27SfM3GTP4dhAJXUzOE2/9JNqebCjxfQxA==
X-YMail-OSG: jDFsXAUVM1m3VZ3QmJr7T6v51y5uxJ0ZLYN7qrnfxrbN6XclCp8qOu_9psj0SIy
 voLJkGnFJ4k_4ETtegnu0KhENa6DyRMXyJmhaF7C8uK01ZapRNFy.aH4jnBC0sFqiqTCz_hNqO_u
 3OTGk_C2KsQv1V72GgJl0kyhF9EYqTXa5r24R6PWA9Bw1YJOdQXQ1gJamJWob1vgaLs_Y2T15R7.
 TsIxa5ArEEo3SpHmfVrOkQ_1NDNDX1FBQF5EwgiLGmNvA_Kxw_uRQ3JeWK2iXvFUhfNO9zUCBIyx
 gKj4bwb45tNOMeEkgW.vjcYPnJYsHGWcCfpMDPOMtJm_XUSzAFTnMmUgfnETVPMHIeX0mkrN_K7P
 v238laghdaTOTEvkJGu2ZHVo2QAbVNcCEtUuQubmJu0vRyYlGxTDQrJzjI.I2mnnRyvOgfxfB5AY
 YRwCknnU6l.AUYqAyszIU._yUT4n1r8IZTU_FKdTU5ieVoKB.9TiZSpKJ4.Rgbr0Ft_vxMq4PEDt
 wysPS6o.bRXiqC3lRtt2u3bdp.EfL0ThbsV1_0_h6dSfAk5CEZ3S3mTJps.wTSNcgGe7N2EoOupv
 U.PG5XWoyxIwt6vfD2ehGBd37Mg0M9ryGMKlXALfaX_F5IljyCtjXwZJr7D1WF2OKpq3V1nFa5R1
 UTuOmKZsgEqE7mH9Vou8Jv4XSbj_mu.Fp_0Z8TrP__3z2vwqVT.ubRcpKleH8Cai80OPMqJ.EL3p
 qbOiLzCoTV8kuEIUn1h9tpvmkYWvJcjw59hXsP6GztLIj2BYFqQLbOebFLt024Kz_fvFyO6Dh7k.
 BWAFqdssujdseS8_B6ia9IoF1fh2FYUweQ7ZZCMk1u8rcbpLiPRx0tQpFRywMURbGfSIfygeMBfx
 sVQrJUnwnll1ud4QdEhHMxzhO.6fSgTkr8NHapdoRlr1LK1zlXqbrcScrLKFK.6zYIcHGLJe_1Ya
 hYX4aWD3_81oreqeppj2OV.lwHnduqFGR0XBeIudTmXOagBMvgIaZWjvwlbbZuqKoVxHKGYWUmFh
 WSK_BO9oqPYSb8HuPh9q_M_Ag4fg0ASN5O09A.zX4TqI0qVuHyOQwAtPYicEChsx4xSaqU0Y.BNG
 Vt9XMi3kQchRpuyApE.BZxuOPc0GOrglNkoItBIjbhl3gVN0P.VRlqqBGYpWSMMx_0hjBKud_7HM
 csx.1hRjByNtk775dfnpOn_ElAqOren1hI6WGMNscDnN1VRA0X08Tei_Sgy1ehsaYPppwR3ObVta
 s0g_JF08UJN2Oow7cnKPIBhjKEQFI1tpAuBPBe7KL5.y8aI4m1GuR2k7tV2xNZ2RRSKGt05bhFt1
 dENcr6LZHM.wdGFmruKoMn_9PETRvTeTKCNcPyjIBncTCdxn1lY54NXSyKcU6W8VF3F7brWrbUFl
 Xu1o0WfbBhs5xs3dGGI3rYvpE_rv4YoVVeD7YU7By0IeFr7xPZIAvWiI6IkKMRwer4coiK5YgAQv
 h4HT3gSsVfR.zywGkp..r5pBIDBrLJ1Xsafvm9wtILYykCFi5Dg3SC3hpKSh4phWcf2sgVWS1.iu
 HKqcqV9FcS9.61jMxO9Ab4rkBjQcYylQ1Fq96WcceneZj0h3sxUdWRKTZD7mTum8ySlIlivRP1Hx
 wwrziBKJTOhM4cxIQKRXLa5.hyGyYKs9PVsaJ13Rs.yXX_4bWAzPkxHvD21GwxgXluSTOPQRH68Q
 xnSinRWLDB9Wsq0skkPCU.whM5tcnLQZ9ZmLX3gMKEOgVfJY4NeGd4EbUiqnEeMOrbIOPSzebhuq
 K_weodsb.EwiGExsTIXAVh6Fb4beZyoyBW5Ehc4ckZvH0MYb6GArVTMbRh_1ZXtVU0Yg.uDL.5ME
 GILJ1HD8SlgB6A6vUIgPyYAMnryvg1aFamyOxVLnIS4uU0Hn00kUNsPQeR5rh2BFxpSx_spPnLh7
 p_eb1_Wywpj3mhBdLXtY9NHZxlqZXDjhmxExiNId8yydEF696GrPoG8mNEkSj_MD7kKj9zzGvLWD
 thGc6ziQ5bCEFwhvwcTVpDjQzyTXiFISwhlkskrU3xb77iY_4V1h0_AeZ9Kb74WFtHhtL0goMa0P
 GJ2CuSOJLzGDl7RxBA.0zl9gSwz1r1bvGGFGFDsg0owP0ZsvdHTUJYCb3BVWtlPyv4DTi69E_PSw
 AAmtUpwnahRljNa7hFxg.f7cQZ63O9LuF6Z3t9VFyU5gIsQ1HQM6XAC2qT.zMvUEJl0ZyWautjie
 OcYxlaOwYysbKU.8tu5.ujW7ipplT3Oi._HhjEOV8kS4wtU.hYxg8bJbTD_6MaSXZepqWBGWfA9T
 Unar5Ul2QA6MmeRhyQTW67i7jWIU-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e842fb60-7bfa-47dc-8964-48f095ba964b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Thu, 3 Oct 2024 16:36:09 +0000
Received: by hermes--production-gq1-5d95dc458-sd55t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9ddbe4344cfe1c7549e684b08005d938;
          Thu, 03 Oct 2024 16:36:03 +0000 (UTC)
Message-ID: <f0fc9923-c91a-48b2-ae61-30dd7287ecc2@schaufler-ca.com>
Date: Thu, 3 Oct 2024 09:36:00 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TOMOYO's pull request for v6.12
To: Paul Moore <paul@paul-moore.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Fan Wu <wufan@linux.microsoft.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, Mimi Zohar <zohar@linux.ibm.com>,
 Micah Morton <mortonm@chromium.org>,
 John Johansen <john.johansen@canonical.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, KP Singh <kpsingh@kernel.org>,
 Kees Cook <keescook@chromium.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/2/2024 1:12 PM, Paul Moore wrote:
> Hi all,
>
> Hopefully by now you've at least seen the TOMOYO v6.12 pull request
> thread; if you haven't read it yet, I suggest you do so before reading
> the rest of this mail:
>
> https://lore.kernel.org/all/0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp
>
> Of the three commits in the pull request, the commit which concerns me
> the most is 8b985bbfabbe ("tomoyo: allow building as a loadable LSM
> module").  The commit worries me as it brings management of the TOMOYO
> LSM callbacks into TOMOYO itself, overriding the LSM framework.
> Jonathan raises a similar point, although his issue is more focused on
> the symbol export approach itself, rather than conceptual issues
> relating to the LSM framework.  I will admit there are some high level
> similarities to this approach and the BPF LSM, but I believe we can
> say that the BPF LSM exception is necessary due to the nature of BPF,
> and not something we want to see duplicated outside of that one
> special case.

We wrangled with the BPF developers over a number of issues,
and in the end gave them something that's a lot more dangerous
than I'd like. With that in mind I can argue either of:

	Let's not do that again, revert.
	We need to trust our LSM developers in their own code, keep it.

What Tetsuo has implemented is a scheme that's been bouncing around for
some time. It is neither especially novel nor elegant. It is intended to
solve a particular issue, which is that Redhat distributions don't include
TOMOYO. [I should be corrected if that statement is not true] When we
talked about loadable modules in the past it was in the context of a
general mechanism, which I have always said I don't want to preclude.

I seriously doubt that this change would achieve the goal of getting
TOMOYO included in Redhat distributions. It seriously increases the
complexity of TOMOYO. It increases the attack surface on systems that
include TOMOYO. I don't see it as a win for TOMOYO.

As I look at the patch I see a proof of concept for a general mechanism.
If some of us were 30 years younger I would suggest that it be the basis
for research in that direction. I can see value in it, although it would
have to be complete and well reviewed. Perhaps someone with a decade to
spend on it can take what's been done and produce that implementation.

There has been a shift in the LSM community since Paul took over as
the maintainer. While he and I don't agree on much^H^H^H^H everything,
we are getting the sub-system under better control. For a long time
it was so hard to get anything into the LSM tree that Linus requested
the individual maintainers go to him directly. It's a lot easier now,
even without allowing for a significant backlog. It is a good thing
that changes within the LSMs are getting review. 

> As I wrote in my original response to this pull request, this is not
> something I would accept in a new LSM submission and thus I feel
> compelled to speak out against this change and submit a revert to
> Linus.  However, as the LSM framework exists to satisfy the needs of
> the individual LSMs, I've tried to ensure that significant changes
> like these are done with support of the majority of LSMs.  I
> understand that in a case like this, reverting LSM-specific commits,
> individual LSM maintainers may not want to speak up on the issue so
> I'm going to let this message sit on-list until Friday morning, unless
> I see the majority of the LSMs voicing support *against* reverting the
> TOMOYO commit above (and the other related commit) I will proceed with
> submitting the revert to Linus on Friday.  I would prefer if all
> responses are sent on-list, but you can also mail me privately with
> your objection to the revert and I will include it in the count.
>
> Thanks.
>
