Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B0B2F28FC
	for <linux-security-module@vger.kernel.org>; Thu, 19 Mar 2026 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773944540; cv=pass; b=ftHCnPtZxxIxB8ghW7yAmYJEe8KI+vWevv6z6lofxeLjScraNogOqF3BqsfZvZ0fgTt/+UaoGi4lu1nn/ertPUklTDn75v250HrvJvDCm/ZQjFPAwTGuegrr6jdxGLybIs/Q142BhTIOSbhpCJgIWY8AE0xFiie1N4vsdMArCfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773944540; c=relaxed/simple;
	bh=jQglwnXRYkLRXqDE9gqwJFjVbBcRl+Tw0aJqtzOAowk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ir5K+Adoy0REz4tADB7jalcc8XTDaaKdiT+/u4LCcSNKLgwiANkYrmOTk7t75LgJx0P0HKaEjDORKBVvVFk+f5xiwE8zlaZI21A4sxcr6//LNzo13UdlfQhGyL38qc8OeUNINhZTPl9pC+zgTjb5fjPGgkEEqoMrBnclNzDSioo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4m4zjk5; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4m4zjk5"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c7413a0e5a0so703888a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 19 Mar 2026 11:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773944539; cv=none;
        d=google.com; s=arc-20240605;
        b=jJZ96T9Kxs3kM2jHkRGO88MfjIYxoXJbJjpaXHbTxA5mCEPFIi4IGvtfkPCJL3A7Ha
         b9dphNXrWgOfp5YrXOUo6gPnjp+NX7LjDPjD4jLc8uTxhWVc1PCvaMzxhUyz3ld/NNbf
         MsfM0jpL6UBC+H/bSJm002t94VdUaBaLttK19P685BE81YLEf4z8yyWk9JtNxcCX44j5
         gNiVueMNW4f0QXQnDRJSh8oOKxWZ1fG7xO9oDaaryXWck5QaIRUO0rqWYKFUPS5Cc7nZ
         WrXHebrs+t+v18RHOORtGR18aFKTxagQikSGYdFl2VeQkqBMUNpCLIH7HlemMUr06aSp
         /G3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wGtVnWtsfaGgBIbYEDL4O4rFQxf4WvyYRQa+7HbQ8SM=;
        fh=mXsZpKJ3oPUMO1yrwDSgwq+96/zNzHSzGs2wFi1+HWo=;
        b=fArkSjxTF14HgH3iVVe3+vPWTYDbCIqXlYAiPIHOVgczPYFLiWxM69IOFAoaFZSfiK
         nJGd30YhpQREPFa6IOzznMD2Q0yKLHl4+GK4sXw5jWIhWxnE7B7F+qhuHNuVzu3Tw7UT
         T2uMZfRHfeI7wVkXu37n+PRQz+ooRp3tIDVBKODEhSu1tnHNUfMrFMhKaIWnlJUSSEbU
         FnZ8ao+9mUgah0rncOdJcH6UgEXFtC4XT7a35vl3g+ZnGZgs/2vm8YX3+rE/0NpupCLB
         YLxKzoBLflm5alYJYXRtLjW7Bml6i0FghgJDZrpdFEcLImY4wZYqh4b3WIi4AVSv3Tz2
         W4EA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773944539; x=1774549339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGtVnWtsfaGgBIbYEDL4O4rFQxf4WvyYRQa+7HbQ8SM=;
        b=g4m4zjk5KfW5upeQHVL7dubvrtcHBsZCwFfl4lgYdSHOWEJiHsSTE9b+s6PPxON+I5
         jB7AWH3W0ibhQii0iu3xkMsavz7KV5S28tjXoMH4zATiG+E6XU318VBi0Y1P8b7IL/E6
         krb22YbqCkVhMPP4vSXaeXGp+BTmmAQ7Z/bd+5xR7Aglnv2IKpgG/R8YeHd+RwZ/bEis
         WVryl4mQsvG4e5HQfIl9mo0oIlHIAVesuCUB6YYthMK7bXwLKNOcKciqzRcEnfz5D4mt
         ++m5e+M3ct2OEPJnNtsuWRlS/YlivmZ9kY6zDlx5ZqsOQ0chr4X9kvoJzX8U6xbruLvm
         z9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773944539; x=1774549339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wGtVnWtsfaGgBIbYEDL4O4rFQxf4WvyYRQa+7HbQ8SM=;
        b=H7MXdtlBWqiyteQm5ykALYH57Eb7dz3PpW4b8++94eoVXcfV0+Gd5rr14VHu2vGGhj
         FBvSpOvI0mg2cVXTNAjHcRj1HK/gcpvkQZag1VynM/vjosf33Hx4k/3gnVO6B7ASZc5u
         9l4RAz3Ccfq1KRdZYMEn5m79+ivtthUutG6VI3EIHiSKetSyuKPpEWxePMyedCI4ZFOT
         Y5Vgya6fGPKfZQ6WIWbrG4FAnANt8PKaArfHGvjpC/UoWGE8dwALGKtUEzWHw7KRcPpO
         OYtAz4WZnIfOmZLK/vtQ6jyStHDlWAmOzOTKxTpEqb92jjaxjbRPOZt7jYzmX1mZXJ00
         XDXA==
X-Forwarded-Encrypted: i=1; AJvYcCXlalaE8haOz5wvtbQu6bNWG8WWvq5xLd8Tx/27UgYObTOmhaPvX5S8bYg1ZIFTIpXDAqiVLy1oE/aXX8NjTTei+5n06s8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuihPgan1W1DCBRzpTFKI3LF+Lz6P2lX3enWt+igSd1zftzLk1
	GKduJqvmUeKl4AMOfcH8o50jDaldPjRhEKmdZhVKUsNJFEpYcpUveIMHZTRbVRcQnL24zLXkyMA
	H0hM9FFlZjxKZMbJIxTO/7+xFTNRj804=
X-Gm-Gg: ATEYQzwNDhaZW/FA7jCqrkXoe/AvWt/5JN0v9cj9D3qLlU5xkIpQESEXRS8zLvWmYJ2
	n9m/zeiZUd871FILTJrVPXPPzkwDZvSY56Ea3HpYMGEZwLbOpEt5O2Q2djDF7o9XzlxNcfshpI8
	1wZ++twXRXPxPO5Ynbesi+nOX2c7pxn5DzdP5tDwW+a8sB08AbsKfIkSiJTWqDx4iYUe8hoeCTE
	MmapFhGO+jgZhgqbrmETw/VH6Er4a5WhGneOGFwJjJkWfTVwE7pA4GJzF21ILBl8PizlLQk4khO
	2OC2H84=
X-Received: by 2002:a05:6a21:6d94:b0:394:427b:eab with SMTP id
 adf61e73a8af0-39bce9de099mr348079637.11.1773944538940; Thu, 19 Mar 2026
 11:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <df35542e-d58f-47db-8a4f-92698281a69a@schaufler-ca.com>
 <20260319022208.69924-1-yangfeng59949@163.com> <80ff003b-51fd-4ec8-9505-dfc1c5890ced@schaufler-ca.com>
In-Reply-To: <80ff003b-51fd-4ec8-9505-dfc1c5890ced@schaufler-ca.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 19 Mar 2026 14:22:06 -0400
X-Gm-Features: AaiRm524MDUd0vlJT7wV4jxy_l7-1kC_j1FcxEAdzOxEKKMOQuBRx9ObpyBl6Go
Message-ID: <CAEjxPJ5aA01in+Z1yLF1cwe-3uqL_E8SKGK4J294D5eRG5__5Q@mail.gmail.com>
Subject: Re: [PATCH] lsm: Fix the crash issue in xfrm_decode_session
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Feng Yang <yangfeng59949@163.com>, jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 1:52=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 3/18/2026 7:22 PM, Feng Yang wrote:
> > On Wed, 18 Mar 2026 10:09:47 -0700, Casey Schaufler wrote:
> >> On 3/17/2026 11:19 PM, Feng Yang wrote:
> >>> From: Feng Yang <yangfeng@kylinos.cn>
> >>>
> >>> After hooking the following BPF program:
> >>> SEC("lsm/xfrm_decode_session")
> >>> int BPF_PROG(lsm_hook_xfrm_decode_session, struct sk_buff *skb, u32 *=
secid, int ckall)
> >>> {
> >>>     return 1; // Any non-zero value
> >>> }
> >>> Subsequent packet transmission triggers will cause a kernel panic:
> >> LSM hooks that use or provide secids cannot be stacked. That is,
> >> you can't provide a BPF LSM hook and an SELinux LSM hook and expect
> >> correct behavior. Your proposed "fix" removes a legitimate check.
> > I'm very sorry, I didn't quite understand what you meant.
> >
> > Maybe my commit message wasn't clear. I only used a BPF LSM hook withou=
t SELinux stacking enabled.
>
> Do i understand correctly that you do not have SELinux enabled?
>
> > Therefore, is it the expected behavior that simply using
> > SEC("lsm/xfrm_decode_session")
> > int BPF_PROG(lsm_hook_xfrm_decode_session, struct sk_buff *skb, u32 *se=
cid, int ckall) {
> >     return -1;
> > }
> > would cause a kernel panic?
>
> Yes. As the infrastructure is written, any return other than 0 is erroneo=
us.
> You will need to query the SELinux developers about why they decided to
> implement the xfrm handling in this way.

Looks like this BUG_ON() has just been preserved since first being
introduced by:
https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/=
?id=3Dbeb8d13bed80f8388f1a9a107d07ddd342e627e8

I think we can remove it at this point - it evidently doesn't ever
trigger for SELinux or we would have seen it by now and it is
definitely unsafe for BPF LSM.
