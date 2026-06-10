Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197EB331EB2
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104878; cv=pass; b=Hhau8AsUI7ALsDhxgiv6fHaa6QZpa5mohZVbA81BF8MIr6e9KD9iIvE99ejsx0KdAILRbwCMMKC27EwXUARkh3Oo9FAnFjL65dvcAy5p3ygE62NjAZwA9briSCH8TownENcOfF6kFONQ6eq1TtkFrPBbQb46qd0h44l+cwzDW5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104878; c=relaxed/simple;
	bh=TtHQLoifPt3NcxmLT9e1RJEkX1K3ehp5cC2XJqGznqQ=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDRaSBa5Mcna8BxdJw4AbNalzgcDQUJMFhgCZcBGBMTjntGqwAMnqHOkxH6VHymMAAEP7u/6hB58NXOrO8xSM8w2gNM2YeBU6tKETI2EQK8eL3mTghn+5gpJuXZquJE7a2nEHhsCbUpDn83HKebY9Ix6hsRz+rz+1IcOJHT01V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=psJCRdF9; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="psJCRdF9"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-43fc82b52afso4478084fac.1
        for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 08:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781104875; cv=none;
        d=google.com; s=arc-20240605;
        b=dtJcgs1FzB2vOWqAjsvPoAqcHssbQPlQMl4KUnxQtgjB4yq+i3BQzElZ8rMFeprCLJ
         8QbJcODFbhp3WJvUAAqbz/kt8VBxP4DmsXomwHwOyz8OFElhLq2UzVWPjzbvQMMHGNo/
         CATCS3TUndylNwMxGij8+SKei81vkIp/h+2tMy2O6nOtM219T6Sg6rFJO5LE8QkFpojv
         AzJP7lAOpTZhJC+mn0yNbPi0g5UXf27GUX4pY6PRH+/Xqt9np6j33OAmaVGIoenolPMA
         lgpez4l6FFinKLb62xJrgylbwk1Cks4Uk6UJf+/W/vv4nojxegnz18avi4gwIE7dI2GN
         N50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=TtHQLoifPt3NcxmLT9e1RJEkX1K3ehp5cC2XJqGznqQ=;
        fh=UqgWmOhbuXN9PjqHNggsf9pD1KkvTqIaAR1dY+AvXYI=;
        b=OJkrvz7lRbPUEwdp5NzKcMtMFGTfCmZ9Drmm8niYxX4Dya3eH4T6BnrYtNn0ZBSJdY
         nyX64Zw/xC/1zV6NGn3LceSjKJ2YlA1Bj2BbUfpfO3B+D32/ChXn8wqDAPgPt1xvSxp/
         pQ03fO8nN2Uu4VCLp6nNlAHwJofg+S4LZT35V1jhvp7LSXqc1OOdLo1qP+ohNuk8wbr/
         0FmLaj7Q6SKgwZAdEqpW7Pv4HC82YYxqrbstmuOY4h5DXLlEctcUB2QMb1n/r8QetzgC
         QJKikdym1S2g/s+gtq4X9t4FcavihC6tszLQF2FJGbPTLe6ngQMbW2hTVwLqaILV7TBp
         7HBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781104875; x=1781709675; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=TtHQLoifPt3NcxmLT9e1RJEkX1K3ehp5cC2XJqGznqQ=;
        b=psJCRdF9EQXj29poYT7gXB9PXZ0BAs7z+LzdrzPpm5Ak7GDUD4xyyiEzs4+Q6zJZt0
         +6aPnr7CLXdLj3hz7r/5hiZGO5h0IjYddzVtG0wYM9ZSrsQiNZ6zyOKDF+eTyNVsparW
         iNexIdgkD/7eVLrmVVJAI3x3wKLWjGJE1kn8PETqC3LL1yLFNw7uoqyECGX9W0RG7ywl
         Q4q2id3dI0/fzUpxSJdElMQZWJZ4Wgq4kEb2wwvDdUzOd5Wi1WPAI+wJwtU3zpcGu0Ec
         E5eROjh9pwk81CZ8E7WXqaGeEcCQopK2548q1DtrffPBevLj9OERGpQxGQ11UcIv9PRM
         QKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104875; x=1781709675;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtHQLoifPt3NcxmLT9e1RJEkX1K3ehp5cC2XJqGznqQ=;
        b=gfJQUBsPBlhwZZcUHMi6mfCSPZZyLViRk29fw+5MrofANOu+0W/HQaRWQP0cGn7z74
         l/UB40l8bqIDoMzQRUqmSXVixOh0/OQO+HXsNbA8cYoqMEhnSRp4yom4uu+1Z/yWPy1C
         yIxBOkCyfccoaLX6YnovPr+FX+WuYhTkBbYxGfhIlvJmNSUiev9I54tcQ1Zi6RnHlQNO
         DZIJy3vkutIbTNc95qLUjwAkcuBWt+2jmdC1PW1zEtWOmoLs+DqyYiacFQ/y6hjQqLiG
         XijfvBsoXJi6CuGWnSSxYwteTq5YnUYoSVXyE/Iu0GN041tiDODDKd/YQSi5/5BxqPPv
         dLJw==
X-Forwarded-Encrypted: i=1; AFNElJ9zKLbaPVfXR5bfuoDNTXRQ4RwARm7a6+OYG5qIOkOT22OhQBk5uRrIgJ2cRtMS1lL7eCvEGPestZ8bOI1loWfqS5i4W+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtPOVYZrPFNyc7M1MNf5xa/t1vz+rBgWSM8tU8Mtyf4GMtRtd0
	rlpegjvDBQOrkF4jaxV+FziaqDHIm/ar/mhEgptWTeSF9D1peAOVNMFbaNYZaE8hbwJxeO7fOzE
	ijW7UUmTyvgzmZdDl2P625/4amrDlYvKoytPI
X-Gm-Gg: Acq92OFW3yRV9X0k/mHDEVpOwegj6tilxoFS8SIBn0QY2PtrEIPO9pUPnULaUAwmj5p
	NaAg0iTd8O0bq3U2Xjr2KVXNFyQcV2M74iqKQYrvCb6GHjZLxsMySDhTPrtS2Ay355krCNRSl0D
	9ZqMFbaeJ9CF0FiWyw9mJpOS5uSsejodm4586Y9MxnNchE2ubrMcPM7tpo9AbbrohYsLHLc/ysd
	CmyaIiuI+gbueTl//wzRXMO7pFh7OPcl+JRxAe7bhRX1HxqlCUFbyKS8tRGG0sstEqUJ89PvhtN
	LcRcN+cAj7lrVecVPFVT1QlO816sWCnBmtrxLszaq7vg9kFzwk+FT/5I0EN26fj8iPCrj3Uogv7
	59w==
X-Received: by 2002:a05:6820:1611:b0:69e:428d:136d with SMTP id
 006d021491bc7-69e68b4d980mr14150343eaf.19.1781104874827; Wed, 10 Jun 2026
 08:21:14 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 10 Jun 2026 10:21:13 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 10 Jun 2026 10:21:13 -0500
In-Reply-To: <aik5YaJhjRuOKE7I@kernel.org>
References: <20260526024838.3368409-1-eeesssooo020@gmail.com>
 <aiYxqTyfHwrDOTCs@kernel.org> <aiYynOxFk3LuK4LA@kernel.org>
 <aiZTIzGg_peDVo1M@kernel.org> <aiZWPSJZyFq4nmxf@kernel.org> <aik5YaJhjRuOKE7I@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: eee sss <eeesssooo020@gmail.com>
Date: Wed, 10 Jun 2026 10:21:13 -0500
X-Gm-Features: AVVi8CfC8AQgLb_bEt_ndD4zhPQKCDXtCnb5DgT1cKQL4HY7OZ04EqHMa4bFBy0
Message-ID: <CA+TOyfjifw5yiZwUmd3y7t227cTMpXxT_JNe0FSO-NYzhqE75Q@mail.gmail.com>
Subject: Re: [PATCH] keys: Pin request_key_auth payload in instantiate paths
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"

Thanks, Jarkko. Sorry for the delayed response.

I checked the commit in for-next-keys. The updated commit message and the
cleanup look good to me.

Best,
Shaomin

On Wed, 10 Jun 2026 13:16:01 +0300, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> On Mon, Jun 08, 2026 at 08:42:21AM +0300, Jarkko Sakkinen wrote:
> > On Mon, Jun 08, 2026 at 08:29:11AM +0300, Jarkko Sakkinen wrote:
> > > On Mon, Jun 08, 2026 at 06:10:23AM +0300, Jarkko Sakkinen wrote:
> > > > On Mon, Jun 08, 2026 at 06:06:21AM +0300, Jarkko Sakkinen wrote:
> > > > > On Tue, May 26, 2026 at 10:48:38AM +0800, Shaomin Chen wrote:
> > > > > > keyctl_instantiate_key_common() reads request_key_auth from the assumed
> > > > > > auth key before copying an instantiation payload from userspace. The copy
> > > > > > can fault and sleep. If the request completes and revokes the auth key in
> > > > > > that window, the auth payload can be detached and freed before the
> > > > > > instantiate path uses it again.
> > > > > >
> > > > > > A request-key helper reproducer can trigger this race. One helper child
> > > > > > blocks in KEYCTL_INSTANTIATE_IOV while the original helper instantiates the
> > > > > > requested key and returns. KASAN then reports a use-after-free from the
> > > > > > stale request_key_auth payload in keyctl_instantiate_key_common().
> > > > > >
> > > > > > Give request_key_auth payloads a refcount. Take a payload reference while
> > > > >
> > > > > Please, name concrete things accurately. I.e. 'usage' in this case. If
> > > > > you have a name, use it instead of obfuscating generalizations.
> > > > >
> > > > > > authkey->sem stabilizes the payload and revocation state. Hold that
> > > > > > reference across the instantiate and reject paths. Drop the auth key
> > > > > > owning reference from revoke and destroy.
> > > > > >
> > > > > > Reported-by: Shaomin Chen <eeesssooo020@gmail.com>
> > > > > > Closes: https://lore.kernel.org/r/20260519144403.436694-1-eeesssooo020@gmail.com
> > > > > > Signed-off-by: Shaomin Chen <eeesssooo020@gmail.com>
> > > > > > ---
> > > > > > include/keys/request_key_auth-type.h | 2 ++
> > > > > > security/keys/internal.h | 2 ++
> > > > > > security/keys/keyctl.c | 24 +++++++++++++++-----
> > > > > > security/keys/request_key_auth.c | 33 ++++++++++++++++++++++++++--
> > > > > > 4 files changed, 53 insertions(+), 8 deletions(-)
> > > > >
> > > > > So first, couple of things.
> > > > >
> > > > > I'm not going to test not that well documented involving OOT driver.
> > > >
> > > > Oops, sorry typo. "not that well documented reproducer" :-)
> > > >
> > > > But it is cool we just then need to draw the picture.
> > >
> > > I think I got this:
> > >
> > > A: request_key() B: KEYCTL_INSTANTIATE_IOV
> > > ---------------- -------------------------
> > > create auth key
> > > store rka in auth key
> > > wait for helper
> > > get auth key
> > > load rka from auth key
> > > copy user payload
> > > sleep on #PF
> > > helper completed
> > > detach and free rka
> > > destroy auth key
> > > wake up
> > > use rka->target_key
> > > **USE-AFTER-FREE**
> > >
> > > So nothing really complicated here, is there?
> >
> > Send v2 with the code changes that I proposed as we want to the change
> > as ergonomic as possible.
> >
> > Use this as the commit message:
> >
> > keys: Pin request_key_auth payload in instantiate paths
> >
> > A: request_key() B: KEYCTL_INSTANTIATE_IOV
> > ---------------- -------------------------
> > create auth key
> > store rka in auth key
> > wait for helper
> > get auth key
> > load rka from auth key
> > copy user payload
> > sleep on #PF
> >
> > helper completed
> > detach and free rka
> > destroy auth key
> > wake up
> > use rka->target_key
> > **USE-AFTER-FREE**
> >
> > Give request_key_auth payloads a refcount. Take a payload reference while
> > authkey->sem stabilizes the payload and revocation state. Hold that
> > reference across the instantiate and reject paths. Drop the auth key
> > owning reference from revoke and destroy.
> >
> > [jarkko: Replaced the first two paragraphs of text with a concurrency scenario.]
> >
> > And it includes also the remark at the end.
> >
> > BR, Jarkko
>
> Nothing heard so I pushed:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?h=for-next-keys&id=9feb0bb3468e863b2b82a2eabfaeec4c7c44b90c
>
> It has the commit message change.
>
> BR, Jarkko
