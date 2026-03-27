Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75392E7179
	for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 01:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774573617; cv=pass; b=iIwIcyjmGVb82JrgOwtkRZNKAMl5fqYvW68vIIDQzx77xWhz40rvUIHId3Qn7JBGACF1+okPE/MCTMuvoTtgy4rmUwl1W3GaAlAVqUsM2ykBT91epTmZtJ/EG2LOf3ceS8Av7bZOisBytdGxTkzg3Djsymxfanarr8d3eGKugfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774573617; c=relaxed/simple;
	bh=KeWbF+sH5V49VasvoUwepM1LdJoATosJLZoY9VySM00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjKQWpeMn8kMnioJyZ4HDd6twp2yNVp4vNKhDRDdfEVoqJj44IjBd8osNvqzbKyj92OVcSx0CTcu1Q1ieQIAy7/MN6u5mb0EvUVRdiGHmMkvWcujBVim5B62o3roXPpnQVJ3JNAiieY1Q11Wa2IHg0fc2x74JI8+AKOHZ+Rlffw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cYL8cSf8; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cYL8cSf8"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b0b0064027so10170475ad.3
        for <linux-security-module@vger.kernel.org>; Thu, 26 Mar 2026 18:06:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774573614; cv=none;
        d=google.com; s=arc-20240605;
        b=JeRlWH+oeFQpPLC4p75dFlXxwwu+EpeEMpbZiEpZJP3Ur2y/BZMIhW/jdRDf0jQgTo
         SodXCKYSMDd4uH//Q5F8E2KFnjTFt3DaBIAbyJPjn3ZmvQk32it6S/MH+LK+Id1CuzjS
         EotvrD/827uj8eG+Em+LC3B1HiELJIStX4tQ5Gzi2dKfxFLadDLnUYQST3vF5RboTbQR
         FWCLe/GAiUFtd4GPZnbYwdMJV2xAr7ow2X22A1LotpmAncoRaGshorYNF3byR8Psg57z
         iwi6b7Zvlf28qkevTifw/oXaFGalUOnNoWu9fp/ynQcrM1p0WGp9/vMm9BzMZZr5IdCg
         GSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NnHkamm+AEobpA8psr45RG6jMwGE1Y1ScbSXU6OCnyU=;
        fh=w1ejQT3WX1RrK/+gbLMmsrZR5nduO2Kb5kj7QZ5Vc2U=;
        b=hFUOJE/51l3RQeIQaaxcVbCM7jnoupYuPlG6PIixO6KB5xkBcG7guhgjPMoNk35SpQ
         fg4YuVEGysX1ZhzmH6zo24MoGARdGftXqz35LVtj8nPL+m0VZs01qFWlQB7yd2n2Ep3/
         PAjp2kubdbCD/EmVllEUYwWhhSluaV1LVd75rI+gQcK6lswwq16SANqPOQ9WFS561kVf
         UU7w3tijilF817D5U9LyrFmgEt3QfUdR2Ystce0xQXw9hVTOVSM9vbevReq6zsUt/3Q+
         ORQrpuXg9HyMYnqNIVvwtOYBuu/5vmEUvttrgksPHPMQTRCLUZK2H1Yr1EOQt0eL+Rxg
         biqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774573614; x=1775178414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnHkamm+AEobpA8psr45RG6jMwGE1Y1ScbSXU6OCnyU=;
        b=cYL8cSf8NDB0HIRMHK4tAVG03Ua0EQnoUA01/dFQOnZPLqMoShmKMGruN+aMrYYtEp
         4ZbB9vLpk36qoIpjixi01Qg91rrF1GfkGBVOJSA9j0VhKca+cJnK6uKzeV305tYZFFqD
         jrOi4AbHQhpjC4MBYDC6jXgWbkujta7SSQ5LN+yRr11Cxf1iny012RHgPBI8iaqrfk9q
         RLSPFP/hzk05SX3kP1A1Rsnsx/HV4DINpDS25aIHT6oCcUopV1gRVSntM1DJzbqiXZFE
         iXtopPIeAGyYBmm26xAxDJ92j9KLM5NY92jzoAHSznQ0wx8UTlj7D/fRHGg/NFVbnoJ0
         5F/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774573614; x=1775178414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NnHkamm+AEobpA8psr45RG6jMwGE1Y1ScbSXU6OCnyU=;
        b=bEqW5ipmLmaf7+x/aKr9H1fKogRJnW3HJZPxrG9axgtC63KJ0FUUdsFvmGcHM4TT7k
         05/bjLqwZYRYYaLM1UwpE+ZFSdLme+cbyO6+PUUauQWZtpUKod1ui0wT725AWbTcE2q4
         cDi/zApMmPYZA5wjVUmlRdP3RSrc2s81j/G6wWolsqgwCc+zjvaRYp6L3bVPJlO277Eb
         du3T9HJoFiXBIrn49dCkU8/qQRtzLhsyzOmb4M0UX0R/8O6VE5q9Asem4CMferjOcD41
         Jyw3kWAe2VE8YnOalFuvkZ+0Fkw38ICE7ge6EpnImWHj96TAYD6mInM9B2F0DxGjMrmb
         bqeA==
X-Gm-Message-State: AOJu0Yy8i16lKfgDXrUf74IhZO+Lp8lRIz1jtcTAv83ppPjsb2mvkeNo
	em1yby+uMCrEYsrX3Qp9x9Sh/RQSKkWESwTnRV9RRaH2HjnkW8x+Gq6bppP3Xz+FBKrz8ujUMZQ
	J6Wuf3B4yQncCTRSz0RVNt3Muf7Rp120+jfIWoA48
X-Gm-Gg: ATEYQzzKmCK+ofxdvaI0+ln0jCQwOPihdzMYJJsIXUEzQnTz1nU9/8etuAih0dFvAbS
	pYxiEVVfgyXLXLIvgXI32Vq+yDJ3QXnZXksaA0ImKQGod4ZjDdkbRcIY/iDDa+tKemCMmEbT3nD
	zvMGB2mnmnVmV5GCwzRuiH99DtcLuRbFL5mBJgfOscY/HJDGd917V+2WKlxEavZtHDPP2D7VmqG
	4x8C3RvjW7dzUm2KJTuWfKnaPzBagTix6etsQoX2LZ60BwLcHxsDW9YVNaoNmvN5h9mDa2X9HhO
	ZbPcvws=
X-Received: by 2002:a17:903:4407:b0:2b0:6621:cedd with SMTP id
 d9443c01a7336-2b0cdd31a51mr5581795ad.49.1774573613689; Thu, 26 Mar 2026
 18:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318184400.3502908-1-song@kernel.org> <CAPhsuW5h=-BVp6g2UtHTUO8PQtbiSmqDrn0BT3rbdN4BkhQpeA@mail.gmail.com>
In-Reply-To: <CAPhsuW5h=-BVp6g2UtHTUO8PQtbiSmqDrn0BT3rbdN4BkhQpeA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 26 Mar 2026 21:06:42 -0400
X-Gm-Features: AQROBzBKwxHMqZrCazbp_EEoFhocvn47dYCOH9CjcWVrjXYp2B_xhHc7YALOkis
Message-ID: <CAHC9VhQUU9L9OTtyo+2mdi0P5jCk1RXnJBxT1+YUyywMSfLuPg@mail.gmail.com>
Subject: Re: [PATCH 0/7] lsm: Replace security_sb_mount with granular mount hooks
To: Song Liu <song@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com, 
	john.johansen@canonical.com, mic@digikod.net, jmorris@namei.org, 
	serge@hallyn.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, gnoack@google.com, 
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 8:31=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Hi folks, especially SELinux, AppArmor, and LandLock maintainers,
>
> Could you please share your comments on this set?

I think we are all aware of this patchset, but most of us are fairly
busy at the moment.  This patchset is in my queue to review, but it
isn't something I'm going to be able to review this week.

> If there are no issues with these changes, can we land the set in 7.1
> kernels?

Given that we are near the end of -rc5, that is highly unlikely.

https://github.com/LinuxSecurityModule/kernel?tab=3Dreadme-ov-file#kernel-d=
evelopment-process

--=20
paul-moore.com
